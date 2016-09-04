<?php

class Question_Model_Rating extends Core_Model_Item_Abstract {

    protected $_type = 'question_rating';
    protected $_parent_type = 'user';
    protected $_parent_is_owner = true;
    protected $_searchColumns = array();
    protected $_owner;
    public $owner_id;

    public function getOwner($recurseType = null) {
        if ($this->_owner === null) {
            $this->owner_id = $this->rating_id;
            $this->_owner = parent::getOwner($recurseType);
        }
        return $this->_owner;
    }

}