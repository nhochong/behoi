<?php

class Question_Plugin_Core {

    public function onStatistics($event) {
        $table = Engine_Api::_()->getDbTable('questions', 'question');
        $select = new Zend_Db_Select($table->getAdapter());
        $select->from($table->info('name'), 'COUNT(*) AS count');
        $event->addResponse($select->query()->fetchColumn(0), 'question');

        $table = Engine_Api::_()->getDbTable('answers', 'question');
        $select = new Zend_Db_Select($table->getAdapter());
        $select->from($table->info('name'), 'COUNT(*) AS count');
        $event->addResponse($select->query()->fetchColumn(0), 'answer');
    }

    public function onUserDeleteBefore($event) {
        $payload = $event->getPayload();
        if ($payload instanceof User_Model_User) {
            $user_id = $payload->getIdentity();
            $where = array('user_id = ?' => $user_id);

            // Delete votes
            Engine_Api::_()->getDbtable('votes', 'question')->delete($where);

            // Delete rating
            Engine_Api::_()->getDbtable('ratings', 'question')->delete(array('rating_id = ?' => $user_id));

            // Delete answers
            Engine_Api::_()->getDbtable('answers', 'question')->delete($where);

            // Delete questions
            Engine_Api::_()->getDbtable('questions', 'question')->delete($where);

            Engine_Api::_()->getDbtable('ratings', 'question')->update_user_ratings();
            $settings = Engine_Api::_()->getApi('settings', 'core');
            $settings->setSetting('need_qarating_update', 0);
            $settings->setSetting('time_qarating_update', time());
        }
    }

    public function getActivity($event) {
        // Detect viewer and subject
        $payload = $event->getPayload();

        if (!($payload instanceof User_Model_User )) {
            $event->addResponse(array(
                'type' => 'question_anonymous'
            ));
        }
    }

}