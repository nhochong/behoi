<?php

class Question_Model_DbTable_Votes extends Engine_Db_Table {

    protected $_rowClass = 'Question_Model_Vote';

    public function getvotes($answer_id) {
        if (!is_int($answer_id))
            throw new Engine_Exception('Invalid argument passed to getvotes(). Argument may be integer.');
        $rName = $this->info('name');
        $primaryKey = current($this->info('primary'));
        $cols = $this->info('cols');
        foreach ($cols as $col) {
            if ($col == 'user_id')
                continue;
            if ($col == $primaryKey)
                continue;
            if (strpos($col, '_id')) {
                $obj_key_id = $col;
                break;
            }
        }
        if (empty($obj_key_id))
            throw new Engine_Exception('Object Key ID failure.');
        $select = $this->select()
                ->from(array('tmp' => $rName), array($primaryKey => $primaryKey,
                    'vote_for' => 'SUM(vote_for)',
                    'vote_against' => 'SUM(vote_against)'))
                ->where($obj_key_id . ' = ?', $answer_id)
                ->group($obj_key_id)
                ->limit(1);
        $votes = $this->fetchRow($select);
        if ($votes === null) {
            $data = array('vote_for' => 0,
                'vote_against' => 0);
            $votes = $this->createRow($data);
        }
        return $votes;
    }

}