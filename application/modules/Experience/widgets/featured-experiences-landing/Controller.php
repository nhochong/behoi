<?php

class Experience_Widget_FeaturedExperiencesLandingController extends Engine_Content_Widget_Abstract {
    public function indexAction() {
		// Number of experience display
		if ($this -> _getParam('max') != '' && $this -> _getParam('max') >= 0) {
			$limitFblog = $this -> _getParam('max');
		} else {
			$limitFblog = 6;
		}

		// Get featured experiences
		$btable = Engine_Api::_() -> getItemTable('experience');
		$select = $btable -> select() -> where("search = 1") -> where("draft = 0") -> where("is_approved = 1") -> where("is_featured = 1") -> order('RAND()') -> limit($limitFblog);

		$this -> view -> experiences = $experience = $btable -> fetchAll($select);
		if(!count($experience))
		{
			return $this -> setNoRender();
		}
	}
}
