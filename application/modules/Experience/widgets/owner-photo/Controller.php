<?php
class Experience_Widget_OwnerPhotoController extends Engine_Content_Widget_Abstract
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
  }
}
