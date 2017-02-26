<?php
class Experience_Widget_ExperiencesSideMenuController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Only experience or user as subject
    if( Engine_Api::_()->core()->hasSubject('experience') ) {
      $this->view->experience = $experience = Engine_Api::_()->core()->getSubject('experience');
      $this->view->owner = $owner = $experience->getOwner();
    } else if( Engine_Api::_()->core()->hasSubject('user') ) {
      $this->view->experience = null;
      $this->view->owner = $owner = Engine_Api::_()->core()->getSubject('user');
    } else {
      return $this->setNoRender();
    }

    //Get viewer
    $this->view->viewer = Engine_Api::_()->user()->getViewer();
    // Get navigation
    $this->view->gutterNavigation = $gutterNavigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('experience_gutter');
  }
}
