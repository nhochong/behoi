<?php

class Ynblog_Widget_RandomBlogsController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        $num_of_blogs = $this->_getParam('num_of_blogs', 3);
		$table = Engine_Api::_()->getItemTable('blog');
		$tableName = $table -> info('name');
		$select = $table->select()
						->where('is_approved = ?', 1)
						->order(new Zend_Db_Expr(('rand()')))
						->limit($num_of_blogs);
		$blogs = $table->fetchAll($select);
        if (count($blogs) == 0) {
            $this->setNoRender(true);
        }
        $this->view->blogs = $blogs;
    }
}
