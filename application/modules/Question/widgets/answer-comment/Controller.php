<?php

class Question_Widget_AnswerCommentController extends Engine_Content_Widget_Abstract {

    public function listAction() {

        $viewer = Engine_Api::_()->user()->getViewer();
        $type = 'answer';
        $identity = $this->_getParam('id');
        $ItemCountPerPage = $this->_getParam('ItemCountPerPage', 5);
        if ($type && $identity) {
            $subject = Engine_Api::_()->getItem($type, $identity);
        }

        // Perms
        $requireAuth = Zend_Controller_Action_HelperBroker::getStaticHelper('RequireAuth');
        $this->view->canComment = $canComment = $requireAuth->setAuthParams('question', null, 'comment_answer')->setNoForward()->isValid();
        $this->view->canDelete = $subject->getQuestion()->User_can($viewer, 'delcom');

        // Comments
        // If has a page, display oldest to newest
        if (null !== ( $page = $this->_getParam('page'))) {
            $commentSelect = $subject->comments()->getCommentSelect();
            $commentSelect->order('creation_date ASC');
            $comments = Zend_Paginator::factory($commentSelect);
            $comments->setCurrentPageNumber($page);
            $comments->setItemCountPerPage($ItemCountPerPage);
            $this->view->comments = $comments;
            $this->view->page = $page;
        }

        // If not has a page, show the
        else {
            $commentSelect = $subject->comments()->getCommentSelect();
            $commentSelect->order('creation_date DESC');
            $t = $commentSelect->__toString();
            $comments = Zend_Paginator::factory($commentSelect);
            $comments->setCurrentPageNumber(1);
            $comments->setItemCountPerPage($ItemCountPerPage - 1);
            $this->view->comments = $comments;
            $this->view->page = $page;
        }
        if ($viewer->getIdentity() && $canComment) {
            $this->view->form = $form = new Core_Form_Comment_Create();
            $form->populate(array(
                'identity' => $subject->getIdentity(),
                'type' => $subject->getType(),
            ));
        }
        if (empty($form) and $comments->getTotalItemCount() == 0) {
            return $this->setNoRender();
        }
        $this->view->item_id = $subject->getIdentity();
        $this->view->subject = $subject;
    }

    public function renderScript() {
        if (($path = $this->_getParam('scriptPath', false))) {
            return $this->getView()->render($path);
        } else {
            return parent::renderScript();
        }
    }

}

