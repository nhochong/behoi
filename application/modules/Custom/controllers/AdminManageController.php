<?php
class Custom_AdminManageController extends Core_Controller_Action_Admin{
  
   public function indexAction(){
   	//Todo
   	$this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('custom_admin_main', array(), 'custom_admin_main_manage');
     
    $page = $this->_getParam('page',1);
    $this->view->paginator = Engine_Api::_()->getItemTable('slider')->getSlidersPaginator(array(
      'orderby' => 'slider_id',
    ));
    $this->view->paginator->setItemCountPerPage(25);
    $this->view->paginator->setCurrentPageNumber($page);
  }

  public function slidersAction(){
   
     // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');

    // Generate and assign form
    $form = $this->view->form = new Custom_Form_Admin_Sliders();
    $form->setAction($this->view->url(array()));
    
    // Check post
    if( !$this->getRequest()->isPost()) {
      return;
    }
    
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }
 
    // Process
      $values = $form->getValues();
      $table = Engine_Api::_() -> getDbTable('sliders', 'custom');
        $db = $table->getAdapter();
       // $db = Engine_Db_Table::getDefaultAdapter();
        $db -> beginTransaction();
       try {
             $values = array_merge($form->getValues()); 
             $slider = $table->createRow();
             $slider->setFromArray($values);
             $slider->save();
              if(!empty($values['photo'])){
                  $slider->setPhoto($form->photo);
            }
       // Commit
      $db ->commit();
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

   public function deleteAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->slider_id=$id;
    // Check post
    if( $this->getRequest()->isPost() )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();
      try
      {
        $slider = Engine_Api::_()->getItem('slider', $id);
        // delete the slider entry into the database     
        $slider->delete();
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
  }

  public function editAction(){
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $slider_id = $this->_getParam('id');
    
    $this->view->slider_id =  $id;
    $slidersTable = Engine_Api::_()->getDbtable('sliders', 'custom');
    $slider = $slidersTable->find($slider_id)->current();
   
    if(!$slider ) {
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => 10,
        'parentRefresh'=> 10,
        'messages' => array('')
      ));
    } else {
      $slider_id = $slider->getIdentity();
    } 

    $form = $this->view->form = new Custom_Form_Admin_Sliders();
    $form->setAction($this->getFrontController()->getRouter()->assemble(array()));
    $form->populate($slider->toArray());
   
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    
    if( !$form->isValid($this->getRequest()->getPost()) ) {
     
      return;
    }
    
    // Process
    $values = $form->getValues();
    $table = Engine_Api::_() -> getDbTable('sliders', 'custom');
        $db = $table->getAdapter();
        $db -> beginTransaction();
       try {
             $values = array_merge($form->getValues()); 
             $slider->setFromArray($values);
             $slider->save();
              if(!empty($values['photo'])){
                  $slider->setPhoto($form->photo);
            }
       // Commit
      $db ->commit();
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
  
	public function settingsAction(){
		$this->view->form = $form = new Custom_Form_Admin_Settings();

		$form->populate(array(
			'about_us' => Engine_Api::_()->getApi('settings', 'core')->getSetting('custom.about_us')
		));
		
		// Check post/valid
		if( !$this->getRequest()->isPost() ) {
		  return;
		}
		if( !$form->isValid($this->getRequest()->getPost()) ) {
		  return;
		}

		// Process form
		$values = $form->getValues();

		// Save settings
		Engine_Api::_()->getApi('settings', 'core')->setSetting('custom.about_us', $values['about_us']);
		
		$form->addNotice('Your changes have been saved.');
	}
}
