<?php
class Experience_AdminSettingsController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('experience_admin_main', array(), 'experience_admin_main_settings');

    $this->view->form  = $form = new Experience_Form_Admin_Global();
    
    if( $this->getRequest()->isPost() && $form->isValid($this->_getAllParams()) )
    {
      $values = $form->getValues();

      foreach ($values as $key => $value){
        Engine_Api::_()->getApi('settings', 'core')->setSetting($key, $value);
      }
       $form->addNotice(Zend_Registry::get('Zend_Translate')->_('Your changes have been saved.'));
    }
  }

  public function categoriesAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('experience_admin_main', array(), 'experience_admin_main_categories');

    $this->view->categories = Engine_Api::_()->getItemTable('experience_category')->getCategories();
  }

  
  public function addCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');

    // Generate and assign form
    $form = $this->view->form = new Experience_Form_Admin_Category();
    $form->setAction($this->getFrontController()->getRouter()->assemble(array()));
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
        $table = Engine_Api::_()->getItemTable('experience_category');

        // insert the experience entry into the database
        $row = $table->createRow();
        $row->user_id   =  1;
        $row->category_name = $values["label"];
        $row->meta_description = $values["meta_description"];
        $row->save();

        // change the category of all the experiences using that category

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
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('The category was added successfully.'))
      ));
    }

    // Output
    $this->renderScript('admin-settings/form.tpl');
  }

  public function deleteCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->experience_id=$id;
    // Check post
    if( $this->getRequest()->isPost())
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        // go through logs and see which experience used this $id and set it to ZERO
        $experienceTable = Engine_Api::_()->getItemtable('experience');
        $select = $experienceTable->select()->where('category_id = ?', $id);
        $experiences = $experienceTable->fetchAll($select);


        // create permissions
        foreach( $experiences as $experience )
        {
          //this is not working
          $experience->category_id = 0;
          $experience->save();
        }

        $row = Engine_Api::_()->getItemTable('experience_category')->getCategory($id);
        // delete the experience entry into the database
        $row->delete();

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
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('The category was deleted successfully.'))
      ));
    }

    // Output
    $this->renderScript('admin-settings/delete.tpl');
  }

  public function editCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $form = $this->view->form = new Experience_Form_Admin_Category();
    $form->setAction($this->getFrontController()->getRouter()->assemble(array()));

    // Check post
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {
      // Ok, we're good to add field
      $values = $form->getValues();

      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        // edit category in the database
        // Transaction
        $row = Engine_Api::_()->getItemTable('experience_category')->getCategory($values["id"]);

        $row->category_name = $values["label"];
        $row->meta_description = $values["meta_description"];
        $row->save();
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
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('The category was modified successfully.'))
      ));
    }

    // Must have an id
    if( !($id = $this->_getParam('id')) )
    {
      die(Zend_Registry::get('Zend_Translate')->_('No identifier specified'));
    }

    // Generate and assign form
    $category = Engine_Api::_()->getItemTable('experience_category')->getCategory($id);
    $form->setField($category);

    // Output
    $this->renderScript('admin-settings/form.tpl');
  
  }
}