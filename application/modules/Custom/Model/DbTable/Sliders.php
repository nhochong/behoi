<?php
class Custom_Model_DbTable_Sliders extends Engine_Db_Table{
	protected $_rowClass = "Custom_Model_Slider";
	
	public function getSlidersPaginator($params = array())
  {
    $paginator = Zend_Paginator::factory($this->getSlidersSelect($params));
    if( !empty($params['page']) )
    {
      $paginator->setCurrentPageNumber($params['page']);
    }
    if( !empty($params['limit']) )
    {
      $paginator->setItemCountPerPage($params['limit']);
    }

    if( empty($params['limit']) )
    {
      $page = (int) Engine_Api::_()->getApi('settings', 'core')->getSetting('blog.page', 10);
      $paginator->setItemCountPerPage($page);
    }

    return $paginator;
  }

  public function getSlidersSelect($params = array())
  {
    $table = Engine_Api::_()->getDbtable('sliders', 'custom');
    $rName = $table->info('name');

    $select = $table->select()
      ->order( !empty($params['orderby']) ? $params['orderby'].' DESC' : $rName.'.creation_date DESC' );

     

    if( !empty($params['start_date']) )
    {
      $select->where($rName.".creation_date > ?", date('Y-m-d', $params['start_date']));
    }

    if( !empty($params['end_date']) )
    {
      $select->where($rName.".creation_date < ?", date('Y-m-d', $params['end_date']));
    }

    return $select;
  }
}