<?php

class Question_ModerationController extends Core_Controller_Action_User {

    protected $_question;

    public function  init() {
        parent::init();
        if (!$this->_helper->requireAuth()->setAuthParams('question', null, 'moderation')->isValid())
            return;
        $question_id = (int) $this->_getParam('question_id');
        if (!empty ($question_id)) {
            $question = Engine_Api::_()->getItem('question', $question_id);
            if ( $question instanceof Question_Model_Question ) {
                Engine_Api::_()->core()->setSubject($question);
            }
        }
        if (!$this->_helper->requireSubject('question')->isValid()) return;
        $this->view->question = $this->_question = $question;
    }

    public function indexAction() {
        $answer_param = array('question_id' => $this->_question->question_id);
        $this->view->paginator = $paginator = Engine_Api::_()->question()->getAnswerPaginator($answer_param);
        $this->view->categories = $categories = Engine_Api::_()->question()->getCategories();
        $this->view->files = $this->_question->getFiles();
        $this->view->isEnabledCategories = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_category', 1);
    }

    public function editAction() {
        $this->view->form = $form = new Question_Form_Create();
        $form->setDescription(Zend_Registry::get('Zend_Translate')->_(''))
             ->setTitle('Edit Question')
             ->populate($this->_question->toArray());
        if (Engine_Api::_()->getApi('settings', 'core')->getSetting('question_tags', 0)) {
            $tagStr = '';
            foreach( $this->_question->tags()->getTagMaps() as $tagMap ) {
                $tag = $tagMap->getTag();
                if( !isset($tag->text) ) continue;
                if( '' !== $tagStr ) $tagStr .= ', ';
                $tagStr .= $tag->text;
            }
            $form->whtags->setValue($tagStr);
        }
        $auth = Engine_Api::_()->authorization()->context;
        $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');

        foreach( $roles as $role ) {
            if ($form->auth_view){
                if( $auth->isAllowed($this->_question, $role, 'view') ) {
                 $form->auth_view->setValue($role);
                }
            }

            if ($form->auth_answer){
                if( $auth->isAllowed($this->_question, $role, 'answer') ) {
                  $form->auth_answer->setValue($role);
                }
            }
        }
        $files_q = $this->_question->getFiles();
        if (is_array($files_q)) {
            $form->setFiles($files_q);
        }
        $form->submit->setLabel('Save Question');
        $viewer = Engine_Api::_()->user()->getViewer();
        if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) ) {
            $values = $form->getValues();
            $db = Engine_Db_Table::getDefaultAdapter();
            $db->beginTransaction();
            try
            {
                $this->_question->setFromArray($values);
                $this->_question->save();
                // Add tags
                if (Engine_Api::_()->getApi('settings', 'core')->getSetting('question_tags', 0)) {
                    $tags = array_filter(preg_split('/[,]+/', $values['whtags']), "trim");
                    $this->_question->tags()->setTagMaps($viewer, $tags);
                }
                // Auth
                $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');

                if( empty($values['auth_view']) ) {
                  $values['auth_view'] = 'everyone';
                }

                $viewMax = array_search($values['auth_view'], $roles);

                foreach( $roles as $i => $role ) {
                  $auth->setAllowed($this->_question, $role, 'view', ($i <= $viewMax));
                }

                $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered');

                if( empty($values['auth_answer']) ) {
                  $values['auth_answer'] = 'registered';
                }

                $answerMax = array_search($values['auth_answer'], $roles);

                foreach( $roles as $i => $role ) {
                  $auth->setAllowed($this->_question, $role, 'answer', ($i <= $answerMax));
                }
                
                $action = Engine_Api::_()->getDbtable('actions', 'activity')->getActionsByObject($this->_question);
                
                $actionTable = Engine_Api::_()->getDbtable('actions', 'activity');
                foreach( $actionTable->getActionsByObject($this->_question) as $action ) {
                    $actionTable->resetActivityBindings($action);
                }
                $tableStorage = Engine_Api::_()->getItemTable('storage_file');
                $tableStorage->update(array('parent_id' => 0), array('parent_id = ?' => $this->_question->question_id));
                if ($this->_helper->requireAuth()->setAuthParams('question', null, 'max_files')->isValid()) {
                    $tmp_files = $this->getRequest()->getPost('files', false);
                    $max_files = unserialize(Engine_Api::_()->authorization()->getPermission($viewer->level_id, 'question', 'max_files'));
                    if (is_array($tmp_files) and  count($tmp_files)) {
                        $save_file_data = array('parent_id' => $this->_question->question_id);
                        $where_str = new Zend_Db_Expr(implode(',', array_slice($tmp_files, 0, $max_files)));
                        $where_files = array("file_id IN (?) or parent_file_id IN (?)" => $where_str);
                        $tableStorage->update($save_file_data, $where_files);
                    }
                }
                $db->commit();
            }
            catch( Exception $e )
            {
              $db->rollBack();
              throw $e;
            }
            return $this->_helper->redirector->gotoRouteAndExit(array('action' => 'index'));
        }
  }
}
