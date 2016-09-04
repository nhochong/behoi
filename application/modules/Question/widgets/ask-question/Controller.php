<?php

class Question_Widget_AskQuestionController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        if (!Engine_Api::_()->question()->can_create_question())
            return $this->setNoRender();
    }

}

