<?php
class Experience_Widget_ViewByDateExperiencesController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
  {
      if(Engine_Api::_()->core()->hasSubject('user')){
        $user = Engine_Api::_()->core()->getSubject('user');
        $url_string = "experiences/".$user->getIdentity();
      }
      else if( Engine_Api::_()->core()->hasSubject('experience') ) {
        $experience = Engine_Api::_()->core()->getSubject('experience');
        $user = $experience->getOwner();
        $url_string = "experiences/".$user->getIdentity();
     }
     else{
       $url_string = "experiences/listing";
      }
      $this->view->url_string = $url_string;
  }
}