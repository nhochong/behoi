<?php
class Experience_ExperienceController extends Core_Controller_Action_Standard
{
  public function init()
  {
    // Get viewer
    $viewer = Engine_Api::_()->user()->getViewer();
    
    // only show to member_level if authorized
    if( !$this->_helper->requireAuth()->setAuthParams('experience', $viewer, 'view')->isValid() ) {
      return;
    }

    // Get subject
    if( ($experience_id = $this->_getParam('experience_id',  $this->_getParam('id'))) &&
        ($experience = Engine_Api::_()->getItem('experience')) instanceof Experience_Model_Experience ) {
      Engine_Api::_()->core()->setSubject($experience);
    } else {
      $experience = null;
    }

    // Must have a subject
    if( !$this->_helper->requireSubject()->isValid() ) {
      return;
    }

    // Must be allowed to view this experience
    if( !$this->_helper->requireAuth()->setAuthParams($experience, $viewer, 'view')->isValid() ) {
      return;
    }
  }
}