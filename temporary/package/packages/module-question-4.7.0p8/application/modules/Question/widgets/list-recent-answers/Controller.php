<?php

class Question_Widget_ListRecentAnswersController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        $table = Engine_Api::_()->getDbtable('answers', 'question');
        $select_answer = $table->select()
                ->order('creation_date DESC')
                ->limit($this->_getParam('show_num_r_a', 5));

        $paginator = $table->fetchAll($select_answer);

        if ($paginator->count() <= 0) {
            return $this->setNoRender();
        }

        $this->view->paginator = $paginator;
    }

}