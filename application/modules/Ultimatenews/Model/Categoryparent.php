<?php
class Ultimatenews_Model_Categoryparent extends Core_Model_Item_Abstract
{
	protected $_searchTriggers = false;
	  
	public function getHref($params = array()) {
		$slug = $this -> getSlug();
		$params = array_merge(array('route' => 'ultimatenews_categoryparent', 'action' => 'contents', 'categoryparent' => $this -> category_id, 'slug' => $slug), $params);
		$route = $params['route'];
		$reset = $params['reset'];
		unset($params['route']);
		unset($params['reset']);
		return Zend_Controller_Front::getInstance() -> getRouter() -> assemble($params, $route, $reset);

	}
	
	// public function getSlug($str = NULL, $maxstrlen = 64) 
	// {
		// $str = $this -> getTitle();
		// if (strlen($str) > 32) {
			// $str = Engine_String::substr($str, 0, 32) . '...';
		// }
		// $str = preg_replace('/([a-z])([A-Z])/', '$1 $2', $str);
		// $str = strtolower($str);
		// $str = preg_replace('/[^a-z0-9-]+/i', '-', $str);
		// $str = preg_replace('/-+/', '-', $str);
		// $str = trim($str, '-');
		// if (!$str) {
			// $str = '-';
		// }
		// return $str;
	// }
	
	public function getTitle(){
		return $this->category_name;
	}
}
?>