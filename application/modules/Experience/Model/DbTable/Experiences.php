<?php
class Experience_Model_DbTable_Experiences extends Engine_Db_Table {
    /*----- Properties -----*/
    protected $_rowClass = "Experience_Model_Experience";

    /*----- Checking Maximum Number Of Experiences -----*/
    public function checkMaxExperiences($user = NULL) {
        //Get user and maximum number of experiences
        if(!$user)
            $user = Engine_Api::_() -> user() -> getViewer();

        $permission_table = Engine_Api::_() -> getDbtable('permissions', 'authorization');
        $select = $permission_table -> select() -> where("type = 'experience'") -> where("level_id = ?", $user -> level_id) -> where("name = 'max'");
        $max_allowed = $permission_table -> fetchRow($select);
        $max_experiences = Engine_Api::_() -> authorization() -> getAdapter('levels') -> getAllowed('experience', $user, 'max');

        //Check when user set max experience equal 3
        if ($max_experiences == "") {
            if (!empty($max_allowed))
                $max_experiences = $max_allowed['value'];
        }
        return $max_experiences;
    }

    /*----- Count Number of Experiences Function -----*/
    public function getCountExperience($user) {
        $select = $this -> select() -> where('owner_id = ?', $user -> getIdentity());
        return count($this -> fetchAll($select));
    }

}
?>
