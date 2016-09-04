<?php

class Question_Model_Quser extends User_Model_User {

    protected $_shortType = 'user';
    protected $_type = 'user';
    protected $_rating;

    public function __get($columnName) {
        if (in_array($columnName, array('total_points', 'total_question', 'total_answers', 'total_best_answers'))) {
            if ($this->_rating === null) {
                $this->_rating = Engine_Api::_()->getItem('question_rating', $this->user_id);
            }
            return $this->_rating->$columnName;
        }
        return parent::__get($columnName);
    }

}