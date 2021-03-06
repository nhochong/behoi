<?php
class Experience_Widget_NewExperiencesController extends Engine_Content_Widget_Abstract {
	public function indexAction() {
		//Get number of experiences display
		if ($this -> _getParam('max') != '' && $this -> _getParam('max') >= 0) {
			$limitNblog = $this -> _getParam('max');
		} else {
			$limitNblog = 6;
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
		//List params for getting new experiences
		$params = array();
		$params['visible'] = 1;
		$params['draft'] = 0;
		$params['is_approved'] = 1;
		$params['orderby'] = 'creation_date';
		$params['limit'] = $limitNblog;
		//Select experiences
		$table = Engine_Api::_() -> getItemTable('experience');
		$select = Engine_Api::_() -> experience() -> getExperiencesSelect($params);
		$this -> view -> experiences = $experiences = $table -> fetchAll($select);
		$this -> view -> limit = $limitNblog;
		if(!count($experiences))
		{
			return $this -> setNoRender();
		}
	}

}
