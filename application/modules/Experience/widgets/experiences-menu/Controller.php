<?php
class Experience_Widget_ExperiencesMenuController extends Engine_Content_Widget_Abstract
{
  protected $_navigation;
  public function indexAction()
  {
    //Get main navigation
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('experience_main');
    // Get quick navigation
    $this->view->quickNavigation = $quickNavigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('experience_quick');
  }
}