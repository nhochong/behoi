<?php

class Question_AdminSettingsController extends Question_controllers_AdminController
{
  public function indexAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('question_admin_main', array(), 'question_admin_main_settings');

    $this->view->form = $form = new  Question_Form_Admin_Global();


    if( $this->getRequest()->isPost()&& $form->isValid($this->getRequest()->getPost()))
    {
      $values = $form->getValues();
      $setting_tmp = Engine_Api::_()->getApi('settings', 'core');
      foreach ($values as $key => $value){
        $setting_tmp->setSetting($key, $value);
      }
    }
  }

  public function categoriesAction()
  {
    $this->view->navigation = Engine_Api::_()->getApi('menus', 'core')
                                             ->getNavigation('question_admin_main', array(), 'question_admin_main_categories');
    $this->view->categories = Engine_Api::_()->question()->getCategories();
    $this->view->isEnable = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_category', 1);
  }

  
  public function addCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');

    // Generate and assign form
    $form = $this->view->form = new Question_Form_Admin_Category();
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
        $table = Engine_Api::_()->getDbtable('categories', 'question');

        $row = $table->createRow();
        $row->category_name = $values["label"];
        $row->url = $values["url"];
        $row->save();

        $db->commit();
      }

      catch( Exception $e )
      {
        $db->rollBack();
        if ($e->getCode() == 1062) {
            $form->url->addError('Duplicate entry.');
            $this->renderScript('admin-settings/form.tpl');
            return; 
        }
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
    $this->view->category_id = $id = $this->_getParam('id');
    $this->view->delete_title = 'Delete Question Category?';
    $this->view->delete_description = 'Are you sure that you want to delete this category? It will not be recoverable after being deleted.';
    // Check post
    if( $this->getRequest()->isPost())
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        $row = Engine_Api::_()->question()->getCategory($id);
       
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
          'messages' => array('')
      ));
    }

    // Output
    $this->renderScript('etc/delete.tpl');
  }

  public function editCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $form = $this->view->form = new Question_Form_Admin_Category();
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
        $row = Engine_Api::_()->question()->getCategory($values["id"]);

        $row->category_name = $values["label"];
        $row->url = $values["url"];
        $row->save();
        $db->commit();
      }

      catch( Exception $e )
      {
        $db->rollBack();
        if ($e->getCode() == 1062) {
            $form->url->addError('Duplicate entry.');
            $this->renderScript('admin-settings/form.tpl');
            return; 
        }
        throw $e;
      }
      $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => 10,
          'parentRefresh'=> 10,
          'messages' => array('')
      ));
    }

    // Must have an id
    if( !($id = $this->_getParam('id')) )
    {
      die('No identifier specified');
    }

    // Generate and assign form
    $category = Engine_Api::_()->question()->getCategory($id);
    $form->setField($category);

    // Output
    $this->renderScript('admin-settings/form.tpl');
  }

  public function orderAction() {
    if (!$this->getRequest()->isPost()) { return; }
    $table = Engine_Api::_()->getDbtable('categories', 'question');

    $params = $this->getRequest()->getParams();
    $cats = $table->fetchAll($table->select());

    foreach ($cats as $cat)
    {
      $cat->order = $this->getRequest()->getParam('step_' . $cat->category_id);
      $cat->save();
    }
    return;
  }
}