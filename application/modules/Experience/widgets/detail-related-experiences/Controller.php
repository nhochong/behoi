<?php
class Experience_Widget_DetailRelatedExperiencesController extends Engine_Content_Widget_Abstract {
	public function indexAction() {
		if( !Engine_Api::_()->core()->hasSubject('experience') ) {
			return $this -> setNoRender();
		}
		$experience = Engine_Api::_()->core()->getSubject('experience');
		//Get number of experiences display
		if ($this -> _getParam('max') != '' && $this -> _getParam('max') >= 0) {
			$limitMVblog = $this -> _getParam('max');
		} else {
			$limitMVblog = 4;
		}

		//Select glogs
		$table = Engine_Api::_() -> getItemTable('experience');
		$name = $table -> info('name');
		$select = $table -> select() -> from($name) 
			-> order('view_count DESC') 
			-> where("search = 1") 
			-> where("draft = 0") 
			-> where('is_approved = 1') 
			-> where("category_id = ?", $experience -> category_id) 
			-> where("experience_id <> ?", $experience -> experience_id)
			-> limit($limitMVblog);

		$this -> view -> experiences = $experiences = $table -> fetchAll($select);
		if(!count($experiences))
		{
			return $this -> setNoRender();
		}
	}

}
