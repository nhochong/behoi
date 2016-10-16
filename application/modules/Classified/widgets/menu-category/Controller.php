<?php

class Classified_Widget_MenuCategoryController extends Engine_Content_Widget_Abstract {
    
    public function indexAction() {
        
        $table = Engine_Api::_()->getItemTable('classified_category');
        
        $select = $table->select()->where('parent_id = ?', 0);

        $categories = $table->fetchAll($select);
        
        if (count($categories) == 0) {
            $this->setNoRender(true);
        }

        $this->view->categories = $categories;
    }
}