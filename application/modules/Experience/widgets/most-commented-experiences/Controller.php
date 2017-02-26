<?php
class Experience_Widget_MostCommentedExperiencesController extends Engine_Content_Widget_Abstract {
	public function indexAction() {
		//Get number of experiences display
		if ($this -> _getParam('max') != '' && $this -> _getParam('max') >= 0) {
			$limitMCblog = $this -> _getParam('max');
		} else {
			$limitMCblog = 6;
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
		//Get experiences
		$b_table = Engine_Api::_() -> getItemtable('experience');
		$bName = $b_table -> info('name');
		$select = $b_table -> select() -> from($bName) 
			-> order('comment_count DESC') 
			-> where("search = ?", "1") 
			-> where("draft = ?", "0") 
			-> where("is_approved = ?", "1") 
			-> where("comment_count > ?", "0") 
			-> limit($limitMCblog);

		$this -> view -> experiences = $experiences = $b_table -> fetchAll($select);
		$this -> view -> limit = $limitMCblog;
		if (!count($experiences)) {
			return $this -> setNoRender();
		}
	}

}
