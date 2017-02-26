<?php

class Experience_Widget_RandomExperiencesController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        $num_of_experiences = $this->_getParam('num_of_experiences', 3);
		$table = Engine_Api::_()->getItemTable('experience');
		$tableName = $table -> info('name');
		$select = $table->select()
						->where('is_approved = ?', 1)
						->order(new Zend_Db_Expr(('rand()')))
						->limit($num_of_experiences);
		$experiences = $table->fetchAll($select);
        if (count($experiences) == 0) {
            $this->setNoRender(true);
        }
        $this->view->experiences = $experiences;
    }
}
