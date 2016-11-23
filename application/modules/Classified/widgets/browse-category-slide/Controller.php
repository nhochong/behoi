<?php

class Classified_Widget_BrowseCategorySlideController extends Engine_Content_Widget_Abstract {
    
    public function indexAction() {
        
        $table = Engine_Api::_()->getItemTable('classified_category');
        
        $select = $table->select()->where('parent_id <> ?', 0)->order(new Zend_Db_Expr(('rand()')));

        $categories = $table->fetchAll($select);
        
        if (count($categories) == 0) {
            $this->setNoRender(true);
        }

        $this->view->categories = $categories;
    }
}