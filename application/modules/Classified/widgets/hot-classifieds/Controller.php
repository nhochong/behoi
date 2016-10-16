<?php

class Classified_Widget_HotClassifiedsController extends Engine_Content_Widget_Abstract {
    public function indexAction() {
		$this->view->hotCategories = $hotCategories = Engine_Api::_()->getDbTable('categories', 'classified')->getHotCategories();
    }

}
