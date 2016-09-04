<?php

class Question_Widget_ListTopUsersController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        $period = ($this->_getParam('top_period', 'all') == 'month') ? 'mratings' : 'ratings';
        $table = Engine_Api::_()->getDbtable($period, 'question');
        $select = Engine_Api::_()->question()->getRatingSelect(array('period' => $this->_getParam('top_period', 'all')))->limit($this->_getParam('num_items', 4));

        $users = $table->fetchAll($select);

        if (count($users) < 1) {
            return $this->setNoRender();
        }

        $this->view->users = $users;
    }

}

