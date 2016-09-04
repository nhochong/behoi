<?php

class Question_AdminLevelController extends Question_controllers_AdminController
{
  public function indexAction()
  {
 
    // Make navigation
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
                                                           ->getNavigation('question_admin_main', array(), 'question_admin_main_level');
    $level_id = $this->_getParam('level_id');
    // Make form
    $this->view->form = $form = new Question_Form_Admin_Level(array('public'=>($level_id == Engine_Api::_()->getDbtable('levels', 'authorization')->getPublicLevel()->level_id)));
    
    if( !$this->getRequest()->isPost() )
    {
      if( null !== $level_id )
      {
        $permissionTable = Engine_Api::_()->getDbtable('permissions', 'authorization');
        $select = $permissionTable->select()->where('level_id = ?', $level_id)->where('type = ?', 'question');
        $level_permissions = $permissionTable->fetchAll($select);
        $settings = array();
        
        foreach( $level_permissions as $question_permission )
        {
          if(!empty($question_permission->params)){
            $settings[$question_permission->name] = ($question_permission->name != 'max_answers') ? unserialize($question_permission->params) : (int) $question_permission->params;
          }
          else $settings[$question_permission->name] =  $question_permission->value;
        }

        $settings = array_merge($settings, array(
          'level_id' => $level_id
        ));

        $form->populate($settings);
      }
      
      return;
    }

    // Process form
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {
      $level_id = $this->_getParam('level_id');
      $values = $form->getValues();
      $permissionTable = Engine_Api::_()->getDbtable('permissions', 'authorization');
      $select = $permissionTable->select()->where('level_id = ?', $level_id)->where('type = ?', 'question');
      $level_permissions = $permissionTable->fetchAll($select);
      
      foreach ($values as $key => $value){
              
        $select = $permissionTable->select()->where('level_id = ?', $level_id)->where('type = ?', 'question')->where('name = ?', $key);
        $level_permission = $permissionTable->fetchRow($select);

        if($level_permission){
          if ($value == 'none') $value = 0;
          if ($key == 'max_files') {
              $level_permission->value = ($value) ? 1 : 0;
              $level_permission->params =  ($value) ? serialize($value) : null;
          }
          elseif($value!="0" && $value !="1" && $value !="2"){
            $level_permission->value = 1;
            $level_permission->params =  ($key != 'max_answers') ? serialize($value) : $value;
          }
          else {
            $level_permission->value = $value;
            $level_permission->params = null;
          }

          $level_permission->save();
        }
        else {
          $permission = $permissionTable->createRow();
          $permission->level_id = $level_id;
          $permission->name = $key;
          $permission->type = 'question';
          if ($key == 'max_files') {
              $permission->value = $value;
          }
          elseif($value!="0" && $value !="1" && $value !="2"){
            $permission->value = 1;
            $permission->params = ($key != 'max_answers') ? serialize($value) : $value ;
          }
          else $permission->value = $value;

          $permission->save();
        }
      }
    }
  }
}