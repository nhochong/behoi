<?php
class Experience_Widget_TopExperiencesController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
  {
    //Get number of experiences display
    if($this->_getParam('max') != '' && $this->_getParam('max') >= 0){
       $limit = $this->_getParam('max');
    }else{
       $limit = 6;
    }

      $view_mode = $this->_getParam('view_mode', 'list');
      $mode_enabled = array();
      if ($this->_getParam('mode_grid', 0))
      {
        $mode_enabled[] = 'grid';
      }
      if ($this->_getParam('mode_list', 0))
      {
        $mode_enabled[] = 'list';
      }
      if(!in_array($view_mode, $mode_enabled) && $mode_enabled)
      {
        $view_mode = $mode_enabled[0];
      }
      $this -> view -> mode_enabled = $mode_enabled;
      $this -> view -> view_mode = $view_mode;
    //Select experiences
    $btable = Engine_Api::_()->getItemTable('experience');
    $ltable  = Engine_Api::_()->getDbtable('likes', 'core');
    $bName = $btable->info('name');
    $lName = $ltable->info('name');
    
    $select = $btable->select()
    				 ->from($bName)
					 -> setIntegrityCheck(FALSE)
                     ->joinLeft($lName, "resource_id = experience_id", "COUNT(resource_id) as total_like")
                     ->where("resource_type  LIKE 'experience'")
                     ->group("resource_id")
                     ->where("search = 1")
                     ->where("draft = 0")
                     ->where("is_approved = 1")
                     ->order("Count(resource_id) DESC")
                     ->limit($limit);
    $this->view->experiences = $experiences = $btable->fetchAll($select);
    $this->view->limit = $limit;
	if(!count($experiences))
	{
		return $this -> setNoRender();
	}
  }
}