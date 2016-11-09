<?php

class Classified_Widget_BrowseClassifiedsController extends Engine_Content_Widget_Abstract {
    public function indexAction() {
		$request = Zend_Controller_Front::getInstance()->getRequest();
		$values = $request -> getParams();
		$values['enabled'] = 1;
		$values['recursive'] = 1;
		$this->view->formValues = $values;
		// Get paginator
		$this->view->paginator = $paginator = Engine_Api::_()->getItemTable('classified')->getClassifiedsPaginator($values);
		// Set item count per page and current page number
		$paginator->setItemCountPerPage($this->_getParam('itemCountPerPage', 20));
		$paginator->setCurrentPageNumber($request -> getParam('page', 1));

		// Add fields view helper path
		$view = $this->view;
		$view->addHelperPath(APPLICATION_PATH . '/application/modules/Fields/View/Helper', 'Fields_View_Helper');
    }

}
