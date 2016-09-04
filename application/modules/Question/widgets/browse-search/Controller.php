<?php

class Question_Widget_BrowseSearchController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        // Make form
        $this->view->form = $form = Question_Form_Search::getInstance();
    }

}
