<?php

class Question_Plugin_Task_Maintenance_RebuildRating extends Core_Plugin_Task_Abstract {

    public function execute() {
        if (!Engine_Api::_()->getDbtable('ratings', 'question')->update_user_ratings()) {
            throw new Engine_Exception('Base error. Update Rating is not finished.');
        }
        if (!Engine_Api::_()->getDbtable('mratings', 'question')->update_user_ratings()) {
            throw new Engine_Exception('Base error. Update Rating is not finished.');
        }
        $settings = Engine_Api::_()->getApi('settings', 'core');
        $settings->setSetting('need_qarating_update', 0);
        $settings->setSetting('time_qarating_update', time());
        $storage = Engine_Api::_()->getItemTable('storage_file');
        $files = $storage->fetchAll(array('parent_type = ?' => 'question',
            'parent_id = ?' => 0,
            'type IS NULL'));
        foreach ($files as $file) {
            $file_thumb = $storage->fetchRow(array('parent_file_id = ?' => $file->file_id));
            if ($file_thumb !== null)
                $file_thumb->remove();
            $file->remove();
        }
    }

}
