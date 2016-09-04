<?php

class Question_Widget_BrowseMenuController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        if (Engine_Api::_()->core()->hasSubject()) {
            $subject = Engine_Api::_()->core()->getSubject();
            if ($subject instanceof Question_Model_Question) {
                if ($subject->hasResource()) {
                    $this->_action = 'resource';
                    return $this->renderScript();
                }
            } else if ($subject instanceof User_Model_User) {
                $this->_action = 'user';
                return $this->renderScript();
            } else {
                $this->_action = 'subject';
                return $this->renderScript();
            }
        }
        // Get navigation
        $this->view->navigation = Engine_Api::_()->getApi('menus', 'core')->getNavigation('question_main');
    }

}
