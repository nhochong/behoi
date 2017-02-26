<?php
class Experience_Widget_ExperienceCategoriesController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
  {
      $params = array();
      if(Engine_Api::_()->core()->hasSubject('user')){
        $user =  Engine_Api::_()->core()->getSubject('user');
        $params['mode'] = '1';
        $params['user_id']  = $user->getIdentity();
        $categories = Engine_Api::_()->getItemTable('experience_category')->getUserCategories($user->getIdentity());
      }
      else if(Engine_Api::_()->core()->hasSubject('experience')){
        $experience =  Engine_Api::_()->core()->getSubject('experience');
        $user = $experience->getOwner();
        $params['mode'] = '1';
        $params['user_id']  = $user->getIdentity();
        $categories = Engine_Api::_()->getItemTable('experience_category')->getUserCategories($user->getIdentity());
      }
      else{
        $params['mode'] = '0';
        $categories = Engine_Api::_()->getItemtable('experience_category')->getCategories();
      }
      $this->view->params = $params;
      $this->view->categories = $categories;
  }
}