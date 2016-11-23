<?php

class Classified_Widget_RelatedClassifiedsController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        if (!Engine_Api::_()->core()->hasSubject()) {
            return $this->setNoRender();
        }
        $num_of_classifieds = $this->_getParam('num_of_classifieds', 3);
        $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
        $subject = Engine_Api::_()->core()->getSubject();

        $classified = $subject;
        $category = Engine_Api::_()->getItem('classified_category', $classified->category_id);
        if ($category) {
            $table = Engine_Api::_()->getItemTable('classified');
            $tableName = $table -> info('name');
			$select = $table->select()->from("$tableName", array("$tableName.*"));
            $select
                ->where('classified_id <> ?', $classified->getIdentity())
                ->where('category_id = ?', $category->getIdentity())
                ->where('enabled = ?', 1)
                ->order(new Zend_Db_Expr(('rand()')))
                ->limit($num_of_classifieds);
            $classifiedsSameCategory = $table->fetchAll($select);
        } else {
            $classifiedsSameCategory = array();
        }
        if (count($classifiedsSameCategory) == 0) {
            $this->setNoRender(true);
        }
        $this->view->classifieds = $classifiedsSameCategory;
    }
}
