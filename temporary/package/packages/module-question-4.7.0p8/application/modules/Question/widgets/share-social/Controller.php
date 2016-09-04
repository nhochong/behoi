<?php

class Question_Widget_ShareSocialController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        // Get subject and check auth
        if (!Engine_Api::_()->core()->hasSubject('question')) {
            return $this->setNoRender();
        }
        $subject = Engine_Api::_()->core()->getSubject('question');
        if ($subject instanceof Question_Model_Question)
            $this->view->question = $subject;
        else
            return $this->setNoRender();
    }

}