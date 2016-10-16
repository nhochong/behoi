<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: AdminSettingsController.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Classified_AdminSettingsController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('classified_admin_main', array(), 'classified_admin_main_settings');

    $this->view->form = $form = new Classified_Form_Admin_Global();

    if( $this->getRequest()->isPost()&& $form->isValid($this->getRequest()->getPost()))
    {
      $values = $form->getValues();

      foreach ($values as $key => $value){
        Engine_Api::_()->getApi('settings', 'core')->setSetting($key, $value);
      }
      
      $form->addNotice('Your changes have been saved.');
    }
  }

  public function categoriesAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('classified_admin_main', array(), 'classified_admin_main_categories');

	$table = Engine_Api::_()->getDbtable('categories', 'classified');
	$select = $table->select();
	
	//parent
	$this->view->parent_id = $parent_id = $this->_getParam('parent_id', 0);
	$select = $select->where('parent_id = ?', $parent_id);
	
    $this->view->categories = $table->fetchAll($select);
  }

  public function addCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');

    // Generate and assign form
    $form = $this->view->form = new Classified_Form_Admin_Category();
    $form->setAction($this->getFrontController()->getRouter()->assemble(array()));
	
	//parent
	$parent_id = $this->_getParam('parent_id', 0);
    // Check post
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {
      // we will add the category
      $values = $form->getValues();

      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        // add category to the database
        // Transaction
        $table = Engine_Api::_()->getDbtable('categories', 'classified');
        $user = Engine_Api::_()->user()->getViewer();

        // insert the classified category entry into the database
        $row = $table->createRow();
        $row->user_id   =  $user->getIdentity();
        $row->category_name = $values["label"];
        $row->code = $values["code"];
        $row->parent_id = $parent_id;
        $row->save();
		
		if(!empty($values['photo'])){
			$row->setPhoto($form->photo);
		}

        // change the category of all the classifieds using that category

        $db->commit();
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }
      $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => 10,
          'parentRefresh'=> 10,
          'messages' => array('')
      ));
    }

    // Output
    $this->renderScript('admin-settings/form.tpl');
  }

  public function deleteCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $this->view->classified_id = $id = $this->_getParam('id');

    // Must have an id
    if( !($id = $this->_getParam('id')) ) {
      throw new Zend_Exception('No identifier specified');
    }

    $categoryTable = Engine_Api::_()->getDbtable('categories', 'classified');
    $category = $categoryTable->find($id)->current();
    
    // Check post
    if( $this->getRequest()->isPost())
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        // go through logs and see which classified used this category and set it to ZERO
        $classifiedTable = Engine_Api::_()->getDbtable('classifieds', 'classified');
        $classifiedTable->update(array(
          'category_id' => 0,
        ), array(
          'category_id = ?' => $category->category_id,
        ));
        
        // delete the classified category in the database
        $category->delete();

        $db->commit();
      } catch( Exception $e ) {
        $db->rollBack();
        throw $e;
      }
      return $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => 10,
          'parentRefresh'=> 10,
          'messages' => array('')
      ));
    }

    // Output
    $this->renderScript('admin-settings/delete.tpl');
  }

  public function editCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $form = $this->view->form = new Classified_Form_Admin_Category();
    $form->setAction($this->getFrontController()->getRouter()->assemble(array()));

    // Must have an id
    if( !($id = $this->_getParam('id')) ) {
      throw new Zend_Exception('No identifier specified');
    }

    $categoryTable = Engine_Api::_()->getDbtable('categories', 'classified');
    $category = $categoryTable->find($id)->current();

    // Generate and assign form
    $form->setField($category);
    
    // Check post
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) ) {
      // Ok, we're good to add field
      $values = $form->getValues();

      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        $category->category_name = $values["label"];
        $category->code = $values["code"];
        $category->save();
        
		if(!empty($values['photo'])){
			$category->setPhoto($form->photo);
		}
		
        $db->commit();
      } catch( Exception $e ) {
        $db->rollBack();
        throw $e;
      }
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => 10,
        'parentRefresh'=> 10,
        'messages' => array('')
      ));
    }

    // Output
    $this->renderScript('admin-settings/form.tpl');
  }
  
	/*----- Set HOT category Function -----*/
	public function hotAction()
	{
      //Get params
      $category_id = $this->_getParam('category_id'); 
      $hot = $this->_getParam('hot');

      //Get blog need to set featured
      $table = Engine_Api::_()->getItemTable('classified_category');
      $select = $table->select()->where("category_id = ?",$category_id); 
      $category = $table->fetchRow($select);

      //Set featured/unfeatured
      if($category){
		$category->is_hot =  $hot;
		$category->save();
      }
	}
}