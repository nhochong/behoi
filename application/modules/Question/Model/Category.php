<?php

class Question_Model_Category extends Core_Model_Item_Abstract {

    public function getTable() {
        if (is_null($this->_table)) {
            $this->_table = Engine_Api::_()->getDbtable('categories', 'question');
        }

        return $this->_table;
    }

}