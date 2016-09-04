<?php

class Question_Widget_RatingUserSearchController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        // Make form
        $this->view->form = Question_Form_Rating::getInstance();
    }

}
