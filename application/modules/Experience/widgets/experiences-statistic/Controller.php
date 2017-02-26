<?php
class Experience_Widget_ExperiencesStatisticController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
  {
       //Get table and table info
       $table  = Engine_Api::_()->getItemTable('experience');
       $name = $table->info('name');

       //Count experiences
       $select = $table->select()->from($name, 'COUNT(*) AS count');
       $this->view->count_experiences =  $select->query()->fetchColumn(0);

       //Count bloggers
       $select = $table->select()->from($name,'owner_id')->distinct();
       $this->view->count_bloggers =  count($table->fetchAll($select));
  }
}