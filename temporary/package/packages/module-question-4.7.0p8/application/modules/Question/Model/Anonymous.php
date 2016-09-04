<?php

class Question_Model_Anonymous extends User_Model_User {

    public $displayname = 'Anonymous';
    public $username = 'Anonymous';

    public function __construct($config = array()) {
        
    }

    public function getIdentity() {
        return '1';
    }

    public function getTitle() {
        return Zend_Registry::get('Zend_Translate')->_($this->displayname);
    }

    public function getDescription() {
        return '';
    }

    public function getHref() {
        return 'javascript:void(0);';
    }

    public function getPhotoUrl($type = null) {
        if (file_exists("application/modules/Question/externals/images/anonymous_user_{$type}.png")) {
            return "application/modules/Question/externals/images/anonymous_user_{$type}.png";
        }
        return "application/modules/Question/externals/images/anonymous_user_thumb_icon.png";
    }

    public function __toString() {
        return $this->getTitle();
    }

    public function toString($attribs = array()) {
        return (string) $this;
    }

}