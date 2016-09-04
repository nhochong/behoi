<?php

class Ynlistings_Widget_BrowseSearchController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        $request = Zend_Controller_Front::getInstance()->getRequest();
        $view = Zend_Registry::get('Zend_View');
        $location = $request -> getParam('location', '');
        $this->view->form = $form = new Ynlistings_Form_Search(array(
            'type' => 'ynlistings_listing',
            'location' => $location
        ));
        $categories = Engine_Api::_()->getItemTable('ynlistings_category')->getCategories();
        unset($categories[0]);
        if (count($categories) > 0) {
            foreach ($categories as $category) {
                $form->category->addMultiOption($category['option_id'], str_repeat("-- ", $category['level'] - 1) . $view->translate($category['title']));
            }
        }
        $module = $request->getParam('module');
        $controller = $request->getParam('controller');
        $action = $request->getParam('action');
        $forwardListing = true;
        if ($module == 'ynlistings') {
            if ($controller == 'index' && ($action == 'manage' || $action == 'browse')) {
                $forwardListing = false;
            }
            if ($action != 'manage') {
                $form->removeElement('status');
            }
        }
        if ($forwardListing) {
            $form->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'browse'), 'ynlistings_general', true));
        }
        $form->isValid($request->getParams());
        $this->view->topLevelId = $form->getTopLevelId();
        $this->view->topLevelValue = $form->getTopLevelValue();
    }
}