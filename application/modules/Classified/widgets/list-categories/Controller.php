<?php

class Classified_Widget_ListCategoriesController extends Engine_Content_Widget_Abstract {
    public function indexAction() {
        $this->view->headScript()->appendFile(Zend_Registry::get('StaticBaseUrl') . 
                'application/modules/Classified/externals/scripts/collapsible.js');
				
		$table = Engine_Api::_()->getItemTable('classified_category');
        
        $select = $table->select()->where('parent_id = ?', 0);

        $this->view->categories = $categories = $table->fetchAll($select);

        if (count($categories) == 0) {
            $this->setNoRender(true);
        }
    }
}