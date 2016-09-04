<?php

class Question_Model_Vote extends Core_Model_Item_Abstract {

    protected $_owner_type = 'user';
    protected $_type = 'vote';
    protected $_parent_type = 'user';
    protected $_parent_is_owner = true;
    protected $_searchColumns = array();
    protected $_all;

    public function getHref() {
        // This doesn't have a primary view page
        return null;
    }

    protected function __sumallvotes() {
        $tmp = $this->vote_for;
        $this->_all = ($this->vote_for - $this->vote_against);
        return $this;
    }

    public function __get($columnName) {
        if ($columnName == 'all') {
            if ($this->_all === null) {
                $this->__sumallvotes();
            }
            return $this->_all;
        }
        return parent::__get($columnName);
    }

}