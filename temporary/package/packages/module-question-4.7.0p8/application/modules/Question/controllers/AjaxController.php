<?php

class Question_AjaxController extends Core_Controller_Action_Standard {
    /*
     * User_Model_User
     */

    protected $_viewer;
    protected $_question;

    public function init() {
        parent::init();
        $this->_helper->layout->disableLayout(true);
        if (!$this->getRequest()->isPost()) {
            return $this->_answerError("Invalid Data.");
        }
        $check_user = $this->_helper->requireUser()->setNoForward();
        if (!$check_user->isValid())
            return $this->_answerError("You must login.");

        $this->_viewer = Engine_Api::_()->user()->getViewer();
        $question_id = (int) $this->_getParam('question_id');
        if (!empty($question_id)) {
            $question_item = Engine_Api::_()->getItem('question', $question_id);
            if ($question_item === null)
                return $this->_answerError("Question wasn't found.");
            else
                $this->_question = $question_item;
        }
    }

    public function voiteAction() {

        if ($this->_getParam('task') != 'voite')
            return $this->_answerError("Invalid Task.");

        $user_id = $this->_viewer->getIdentity();

        $voite = $this->_getParam('voite');
        $answer_id = $this->_getParam('answer_id');
        $answer_item = Engine_Api::_()->getItem('answer', $answer_id);

        if ($answer_item === null)
            return $this->_answerError("Answer wasn't found.");

        $table = Engine_Api::_()->getDbtable('votes', 'question');
        $db = $table->getAdapter();
        $db->beginTransaction();

        try {
            $voteRow = $table->createRow();
            $voteRow->answer_id = $answer_id;
            $voteRow->user_id = $user_id;

            if ($voite == '+')
                $voteRow->vote_for = 1;
            else if ($voite == '-')
                $voteRow->vote_against = 1;
            $voteRow->save();
            $db->commit();
        } catch (Exception $e) {
            $db->rollBack();
            $reload = ($e->getCode() == 1062);

            return $this->_answerError("Database Error.", $reload, $e);
        }
        if ($voite == '+')
            $type_vote = 'vote+';
        else if ($voite == '-')
            $type_vote = 'vote-';

        try {
            Engine_Api::_()->question()->setrating($type_vote, $answer_item->getOwner()->getIdentity());
        } catch (Exception $e) {
            
        }

        return $this->_answer(array('user_id' => $answer_item->getOwner()->getIdentity(),
                    'points' => Engine_Api::_()->question()->get_user_points($answer_item->getOwner()->getIdentity()),
                    'sum' => $answer_item->getVotes('all')));
    }

    public function qvoiteAction() {
        if ($this->_getParam('task') != 'voite')
            return $this->_answerError("Invalid Task.");

        $user_id = $this->_viewer->getIdentity();

        $voite = $this->_getParam('voite');
        $question_id = $this->_getParam('question_id');
        $question_item = Engine_Api::_()->getItem('question', $question_id);
        if ($question_item === null)
            return $this->_answerError("Question wasn't found.");

        $table = Engine_Api::_()->getDbtable('qvotes', 'question');
        $db = $table->getAdapter();
        $db->beginTransaction();

        try {
            $voteRow = $table->createRow();
            $voteRow->question_id = $question_id;
            $voteRow->user_id = $user_id;

            if ($voite == '+')
                $voteRow->vote_for = 1;
            else if ($voite == '-')
                $voteRow->vote_against = 1;
            $voteRow->save();
            $db->commit();
        } catch (Exception $e) {
            $db->rollBack();
            $reload = ($e->getCode() == 1062);
            return $this->_answerError("Database Error.", $reload, $e);
        }
        if ($voite == '+')
            $type_vote = 'vote+';
        else if ($voite == '-')
            $type_vote = 'vote-';
        try {
            Engine_Api::_()->question()->setrating($type_vote, $question_item->getOwner()->getIdentity());
        } catch (Exception $e) {
            
        }
        return $this->_answer(array('user_id' => $question_item->getOwner()->getIdentity(),
                    'points' => Engine_Api::_()->question()->get_user_points($question_item->getOwner()->getIdentity()),
                    'sum' => $question_item->getVotes('all')));
    }

    public function subscribertoggleAction() {
        if (!$this->_questionIsValid())
            return;
        $question_item = $this->_question;
        try {
            $result = $question_item->subscribertoggle($this->_viewer);
            $result_text = ($result) ? $this->view->translate("Unsubscribe") : $this->view->translate("Subscribe");
            return $this->_answer(array('toggle' => $result,
                        'result_text' => $result_text));
        } catch (Exception $e) {
            $message = ($e->getCode() == 1452) ? "User is wrong." : "Database Error.";
            return $this->_answerError($message, false, $e);
        }
    }

    public function uploadimageAction() {

        $translate = Zend_Registry::get('Zend_Translate');

        if (!$this->_helper->requireAuth()->setAuthParams('question', null, 'max_files')->isValid()) {
            return $this->_answerError('Upload files not allowed.');
        }
        if (!$this->getRequest()->isPost()) {
            return $this->_answerError('Invalid request method');
        }

        $values = $this->getRequest()->getPost();

        if (empty($values['Filename'])) {
            return $this->_answerError('No file');
        }
        if (!isset($_FILES['Filedata']) || !is_uploaded_file($_FILES['Filedata']['tmp_name'])) {
            return $this->_answerError('Invalid Upload or file too large');
        }
        if (!preg_match('/\.(jpg|jpeg|gif|png)$/', strtolower($_FILES['Filedata']['name']))) {
            return $this->_answerError('Invalid file type');
        }

        try {
            $image_id = Engine_Api::_()->question()->createImage($_FILES['Filedata']);
            $image_thumb = Engine_Api::_()->getApi('storage', 'storage')->get($image_id, 'thumb.normal')->map();

            $this->_helper->json(array('status' => true,
                'name' => $_FILES['Filedata']['name'],
                'image_id' => $image_id,
                'image_thumb' => $image_thumb));
        } catch (Exception $e) {
            return $this->_answerError($e->getMessage());
        }
    }

    public function commentMoveAnswersAction() {

        if (!$this->_helper->requireAuth()->setAuthParams('question', null, 'moderation')->setNoForward()->isValid())
            return $this->_answerError('Access denied');
        if (!$this->_questionIsValid())
            return;
        $table = Engine_Api::_()->getDbtable('comments', 'core');
        $select = $table->select()->where('comment_id = ?', (int) $this->_getParam('comment_id'))
                ->limit(1);
        $comment = $table->fetchRow($select);
        if ($comment == null) {
            return $this->_answerError("Comment wasn't found.");
        }
        $answerTable = Engine_Api::_()->getDbtable('answers', 'question');
        $db = Engine_Db_Table::getDefaultAdapter();
        $db->beginTransaction();
        try {
            $answerRow = $answerTable->createRow();
            $answerRow->user_id = $comment->poster_id;
            $answerRow->question_id = $this->_question->question_id;
            $answerRow->answer = $comment->body;
            $answerRow->save();
            $answerRow->creation_date = $comment->creation_date;
            $answerRow->save();
            $comment->delete();
            $db->commit();
            return $this->_answer(array());
        } catch (Exception $e) {
            $db->rollBack();
            return $this->_answerError('Error has happened', false, $e);
        }
    }

    public function commentMoveCommentsAction() {

        if (!$this->_helper->requireAuth()->setAuthParams('question', null, 'moderation')->setNoForward()->isValid())
            return $this->_answerError('Access denied');
        if (!$this->_questionIsValid())
            return;
        $table = Engine_Api::_()->getDbtable('comments', 'core');
        $select = $table->select()->where('comment_id = ?', (int) $this->_getParam('comment_id'))
                ->limit(1);
        $comment = $table->fetchRow($select);
        if ($comment == null) {
            return $this->_answerError("Comment wasn't found.");
        }

        $answer = Engine_Api::_()->getItem('answer', (int) $this->_getParam('destination_answer_id'));
        if ($answer == null) {
            return $this->_answerError("Answer wasn't found.");
        }

        $db = Engine_Db_Table::getDefaultAdapter();
        $db->beginTransaction();
        try {
            $comment->resource_id = $answer->getIdentity();
            $comment->save();
            $db->commit();
            return $this->_answer(array());
        } catch (Exception $e) {
            $db->rollBack();
            return $this->_answerError('Error has happened', false, $e);
        }
    }

    public function answerMoveCommentsAction() {

        if (!$this->_helper->requireAuth()->setAuthParams('question', null, 'moderation')->setNoForward()->isValid())
            return $this->_answerError('Access denied');
        if (!$this->_questionIsValid())
            return;

        $answer = Engine_Api::_()->getItem('answer', (int) $this->_getParam('answer_id'));
        if ($answer == null) {
            return $this->_answerError("Answer wasn't found.");
        }
        $destination_answer = Engine_Api::_()->getItem('answer', (int) $this->_getParam('destination_answer_id'));
        if ($answer == null) {
            return $this->_answerError("Answer wasn't found.");
        }
        $tableComments = Engine_Api::_()->getDbtable('comments', 'core');

        $db = Engine_Db_Table::getDefaultAdapter();
        $db->beginTransaction();
        try {
            $comments_of_answer = $tableComments->getAllComments($answer);
            if ($comments_of_answer->count()) {
                foreach ($comments_of_answer as $comment_of_answer) {
                    $comment_of_answer->resource_id = $destination_answer->getIdentity();
                    $comment_of_answer->save();
                }
            }
            $new_comment = $tableComments->addComment($destination_answer, $answer->getOwner(), strip_tags($answer->answer));

            $new_comment->creation_date = $answer->creation_date;
            $new_comment->save();
            $answer->delete();
            $db->commit();
            return $this->_answer(array());
        } catch (Exception $e) {
            $db->rollBack();
            return $this->_answerError('Error has happened', false, $e);
        }
    }

    protected function _answerError($message, $reload = false, Exception $e = NULL) {
        $json_out = array('status' => false,
            'reload' => $reload,
            'error' => Zend_Registry::get('Zend_Translate')->_($message));
        if ($e) {
            $error_code = Engine_Api::getErrorCode(true);
            $log = Zend_Registry::get('Zend_Log');
            $output = '';
            $output .= PHP_EOL . 'Error Code: ' . $error_code . PHP_EOL;
            $output .= $e->__toString();
            $log->log($output, Zend_Log::CRIT);
            $json_out['error'] .= ' ' . $this->view->translate("Please report this to your site administrator with Error Code %s", $error_code);
        }
        return $this->_helper->json($json_out);
    }

    protected function _answer(array $data) {
        return $this->_helper->json(array_merge(array('status' => true), $data));
    }

    protected function _questionIsValid() {
        if (!$this->_question) {
            $this->_answerError("Question wasn't found.");
            return false;
        }
        return true;
    }

}
