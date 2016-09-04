<?php

class Question_Model_Mrating extends Core_Model_Item_Abstract {

    protected $_type = 'question_mrating';
    protected $_parent_type = 'user';
    protected $_parent_is_owner = true;
    protected $_searchColumns = array();
    protected $_owner;
    public $owner_id;

    public function getOwner($recurseType = null) {
        if ($this->_owner === null) {
            $this->owner_id = $this->mrating_id;
            $this->_owner = parent::getOwner($recurseType);
        }
        return $this->_owner;
    }

}