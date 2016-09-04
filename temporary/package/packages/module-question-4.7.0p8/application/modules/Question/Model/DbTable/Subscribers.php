<?php

class Question_Model_DbTable_Subscribers extends Engine_Db_Table {

    protected $_rowClass = 'Question_Model_Subscriber';

    public function isSubscriber($user_id, $question_id, Question_Model_Subscriber &$subscriber = NULL) {
        if (!is_int($user_id) or empty($user_id))
            throw new Engine_Exception("Incorrect user_id.");
        if (!is_int($question_id) or empty($question_id))
            throw new Engine_Exception("Incorrect question_id.");
        $subscriber = $this->fetchRow(array("question_id = ?" => $question_id,
            "user_id = ?" => $user_id));
        return (bool) $subscriber;
    }

    public function subscribertoggle($user_id, $question_id) {
        if (!is_int($user_id) or empty($user_id))
            throw new Engine_Exception("Incorrect user_id.");
        if (!is_int($question_id) or empty($question_id))
            throw new Engine_Exception("Incorrect question_id.");

        if ($this->isSubscriber($user_id, $question_id, $subscriber)) {
            $subscriber->delete();
            return false;
        } else {
            $this->createRow(array("question_id" => $question_id,
                "user_id" => $user_id,
                "hash" => md5(rand(1, 10000) . time() . rand(20000, 100000))))->save();
            return true;
        }
    }

    public function get_subscribers($question_id) {
        $userTable = Engine_Api::_()->getItemTable('user');
        $select = $userTable->select()->from($userTable->info('name'), array('*', 'hash' => new Zend_Db_Expr($this->info('name') . '.hash')))
                ->joinLeftUsing($this->info('name'), 'user_id', array())
                ->where("question_id = ?", $question_id);
        return $userTable->fetchAll($select);
    }

}