<?php

class Ynlistings_Widget_BrowseListingsController extends Engine_Content_Widget_Abstract {
    public function indexAction() {
		$params = $this -> _getAllParams();
        $request = Zend_Controller_Front::getInstance()->getRequest();
		$form = new Ynlistings_Form_Search(array(
			'type' => 'ynlistings_listing'
		));
		if($form->isValid($request -> getParams())) {
			$values = $form->getValues();
		} else {
			$values = array();
		}
        if (isset($values['category_id'])) {
            $category = Engine_Api::_()->getItem('ynlistings_category', $values['category_id']);
            if ($category)
                $this->view->category = $category;
        }
        if (isset($values['category'])) {
            $categoryTbl = Engine_Api::_()->getItemTable('ynlistings_category');
            $categorySelect = $categoryTbl->select()->where('option_id = ?', $values['category']);
            $category = $categoryTbl->fetchRow($categorySelect);
            if ($category)
                $this->view->category = $category;
        }
        $this -> view -> formValues = $values;
		if (Engine_Api::_()->hasModuleBootstrap('ynlocationbased')) {
			$values = Engine_Api::_()->ynlocationbased()->mergeWithCookie('ynlistings', $values);
		}
        $p_arr = array();
        foreach ($values as $k => $v) {
            $p_arr[] = $k;
            $p_arr[] = $v;
        }
        $params_str = implode('/', $p_arr);
        $this->view->params_str = $params_str;
		$mode_list = $mode_grid = $mode_pin = $mode_map = 1;
		$mode_enabled = array();
		$view_mode = 'list';
		
		if(isset($params['mode_list']))
		{
			$mode_list = $params['mode_list'];
		}
		if($mode_list)
		{
			$mode_enabled[] = 'list';
		}
		if(isset($params['mode_grid']))
		{
			$mode_grid = $params['mode_grid'];
		}
		if($mode_grid)
		{
			$mode_enabled[] = 'grid';
		}
        if(isset($params['mode_pin']))
        {
            $mode_pin = $params['mode_pin'];
        }
        if($mode_pin)
        {
            $mode_enabled[] = 'pin';
        }
		if(isset($params['mode_map']))
		{
			$mode_map = $params['mode_map'];
		}
		if($mode_map)
		{
			$mode_enabled[] = 'map';
		}
		if(isset($params['view_mode']))
		{
			$view_mode = $params['view_mode'];
		}
		
		if($mode_enabled && !in_array($view_mode, $mode_enabled))
		{
			$view_mode = $mode_enabled[0];
		}
			
		$this -> view -> mode_enabled = $mode_enabled;
		
		$class_mode = "ynlistings_list-view";
		switch ($view_mode) {
			case 'grid':
				$class_mode = "ynlistings_grid-view";
				break;
			case 'map':
				$class_mode = "ynlistings_map-view";
				break;
            case 'pin':
                $class_mode = "ynlistings_pin-view";
                break;
			default:
				$class_mode = "ynlistings_list-view";
				break;
		}
		$this -> view -> class_mode = $class_mode;
		$this -> view -> view_mode = $view_mode;
		
        $page = $values['page'];
        if (!$page) $page = 1;
	    $paginator = Engine_Api::_() -> getItemTable('ynlistings_listing') -> getListingsPaginator($values);
        $paginator -> setCurrentPageNumber($page);
        $paginator -> setItemCountPerPage($this -> _getParam('itemCountPerPage', 10));
        $this -> view -> paginator = $paginator;
    }

}
