<?php

class Question_Widget_ListRecentQuestionsController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        $values = array();
        $category = $this->_getParam('category', '');
        if (!empty($category)) {
            $values['category'] = $category;
        }
        $this->view->paginator = $paginator = Engine_Api::_()->question()->getQuestionPaginator($values);
        $paginator->setItemCountPerPage($this->_getParam('show_num_r_q', 5));

        if ($paginator->count() <= 0) {
            return $this->setNoRender();
        }
        $this->view->isEnabledCategories = $isEnabledCategories = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_category', 1);
        if ($isEnabledCategories)
            $this->view->categories = Engine_Api::_()->question()->getCategories();
    }

}