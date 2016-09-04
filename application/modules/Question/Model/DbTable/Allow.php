<?php

class Question_Model_DbTable_Allow extends Authorization_Model_DbTable_Allow {

    protected static $_instance;

    public static function getInstance() {
        if (is_null(self::$_instance)) {
            self::$_instance = new self();
        }

        return self::$_instance;
    }

    public static function _() {
        $auth = Engine_Api::_()->authorization()
                        ->addAdapter(self::getInstance())
                ->question_allow;
        return $auth;
    }

    public function getAdapterName() {
        return 'question_allow';
    }

    public function getAdapterPriority() {
        return 60;
    }

    public function is_can_Answer($resource) {
        if ($resource->status != 'open') {
            switch ($resource->status) {
                case 'closed' : return 2;
                    break;
                case 'canceled' : return 3;
                    break;
            }
        }
        $user_Viewer = Engine_Api::_()->user()->getViewer();
        if (!isset($user_Viewer->level_id))
            return 1;
        $allowed_view = unserialize(Engine_Api::_()->authorization()->getPermission($user_Viewer->level_id, 'question', 'answer'));
        $user_role = ($this->is_owner($resource, $user_Viewer)) ? 'owner' : 'everyone';
        if (!is_array($allowed_view) or !in_array($user_role, $allowed_view))
            return 6;
        $resource_type = $resource->resource_type;
        if (empty($resource_type)) {
            $requireUserHelper = Zend_Controller_Action_HelperBroker::getStaticHelper('RequireAuth')->setAuthParams($resource, $user_Viewer, 'answer')
                    ->setNoForward();

            if (!$requireUserHelper->isValid())
                return 12;
        }
        $allowed_answers = Engine_Api::_()->authorization()->getPermission($user_Viewer->level_id, 'question', 'max_answers');
        if ($allowed_answers == 0)
            return 0;
        $params = array('question_id' => $resource->question_id,
            'user_id' => $user_Viewer->user_id);
        $count_answers = Engine_Api::_()->question()->getAnswerSelect($params)->query()->rowCount();
        if ($allowed_answers > $count_answers)
            return 0;
        else
            return 5;
    }

    public function can_choose_answer($resource) {
        if ($resource->status != 'open')
            return false;
        $user_Viewer = Engine_Api::_()->user()->getViewer();
        if (!isset($user_Viewer->level_id))
            return false;
        $allowed_view = unserialize(Engine_Api::_()->authorization()->getPermission($user_Viewer->level_id, 'question', 'choose_answer'));
        $user_role = ($this->is_owner($resource, $user_Viewer)) ? 'owner' : 'everyone';
        if (is_array($allowed_view) and in_array($user_role, $allowed_view))
            return true;
        else
            return false;
    }

    public function isAllowed($resource, $role, $action) {
        return Authorization_Api_Core::LEVEL_ALLOW;
    }

}