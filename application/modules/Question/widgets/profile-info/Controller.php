<?php

class Question_Widget_ProfileInfoController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        // Don't render this if not authorized
        $viewer = Engine_Api::_()->user()->getViewer();
        if (!Engine_Api::_()->core()->hasSubject()) {
            return $this->setNoRender();
        }

        // Get subject and check auth
        $subject = Engine_Api::_()->core()->getSubject('user');
        if (!$subject->authorization()->isAllowed($viewer, 'view')) {
            return $this->setNoRender();
        }

        $subject = Engine_Api::_()->core()->getSubject();
        $this->view->rating = Engine_Api::_()->getDbtable('ratings', 'question')->findRow($subject->getIdentity());
    }

}