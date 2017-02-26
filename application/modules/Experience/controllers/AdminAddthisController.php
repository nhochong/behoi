<?php
class Experience_AdminAddthisController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('experience_admin_main', array(), 'experience_admin_main_addthis');
    $this->view->form  = $form = new Experience_Form_Admin_Addthis();
    if( $this->getRequest()->isPost() && $form->isValid($this->_getAllParams()) )
    {
      $values = $form->getValues();
      foreach ($values as $key => $value){
          Engine_Api::_()->getApi('settings', 'core')->setSetting($key, $value);
      }
      $form->addNotice(Zend_Registry::get('Zend_Translate')->_('Your changes have been saved.'));
    }   
  }
}