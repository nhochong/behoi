<?php

class Question_Widget_UpdateRatingsController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        if (!Zend_Controller_Action_HelperBroker::getStaticHelper('RequireAuth')->setAuthParams('question', null, 'update_ratings')->setNoForward()->isValid())
            return $this->setNoRender();
    }

}

