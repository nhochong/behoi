<?php

class Question_Widget_ListMostPopularQuestionsController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        $table = Engine_Api::_()->getItemTable('question');
        $select = Engine_Api::_()->question()->getQuestionSelect(array('orderby' => 'question_views'))
                ->limit($this->_getParam('show_num_pop_q', 5));

        $paginator = $table->fetchAll($select);

        if ($paginator->count() <= 0) {
            return $this->setNoRender();
        }
        $this->view->isEnabledCategories = $isEnabledCategories = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_category', 1);
        if ($isEnabledCategories)
            $this->view->categories = Engine_Api::_()->question()->getCategories();
        $this->view->paginator = $paginator;
    }

}