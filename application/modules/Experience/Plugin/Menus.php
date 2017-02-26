<?php
class Experience_Plugin_Menus
{
  public function canCreateExperiences()
  {
    // Must be logged in
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !$viewer || !$viewer->getIdentity() ) {
      return false;
    }

    // Must be able to create experiences
    if( !Engine_Api::_()->authorization()->isAllowed('experience', $viewer, 'create') ) {
      return false;
    }

    return true;
  }

  public function canViewExperiences()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    // Must be able to view experiences
    if( !Engine_Api::_()->authorization()->isAllowed('experience', $viewer, 'view') ) {
      return false;
    }

    return true;
  }

  public function canExportExperiences()
  {
    // Must be logged in
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !$viewer || !$viewer->getIdentity() ||  !$viewer->isAdminOnly()) {
      return false;
    }

    return true;
  }
  public function onMenuInitialize_ExperienceQuickStyle($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $request = Zend_Controller_Front::getInstance()->getRequest();
    
    if( $request->getParam('module') != 'experience' || $request->getParam('action') != 'manage' ) {
      return false;
    }
    
    // Must be able to style experiences
    if( !Engine_Api::_()->authorization()->isAllowed('experience', $viewer, 'style') ) {
      return false;
    }

    return true;
  }

  public function onMenuInitialize_ExperienceGutterList($row)
  {
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return false;
    }

    $subject = Engine_Api::_()->core()->getSubject();
    if( $subject instanceof User_Model_User ) {
      $user_id = $subject->getIdentity();
    } else if( $subject instanceof Experience_Model_Experience ) {
      $user_id = $subject->owner_id;
    } else {
      return false;
    }

    // Modify params
    $params = $row->params;
    $params['params']['user_id'] = $user_id;
    return $params;
  }

  public function onMenuInitialize_ExperienceGutterShare($row)
  {
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return false;
    }
    
    // Modify params
    $subject = Engine_Api::_()->core()->getSubject();
    $params = $row->params;
    $params['params']['type'] = $subject->getType();
    $params['params']['id'] = $subject->getIdentity();
    $params['params']['format'] ='smoothbox';
    return $params;
  }

  public function onMenuInitialize_ExperienceGutterReport($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !$viewer->getIdentity() ) {
      return false;
    }

    if( !Engine_Api::_()->core()->hasSubject() ) {
      return false;
    }

    $subject = Engine_Api::_()->core()->getSubject();
    if( ($subject instanceof Experience_Model_Experience) &&
        $subject->owner_id == $viewer->getIdentity() ) {
      return false;
    } else if( $subject instanceof User_Model_User &&
        $subject->getIdentity() == $viewer->getIdentity() ) {
      return false;
    }

    // Modify params
    $subject = Engine_Api::_()->core()->getSubject();
    $params = $row->params;
    $params['params']['subject'] = $subject->getGuid();
    return $params;
  }

  public function onMenuInitialize_ExperienceGutterSubscribe($row)
  {
    // Check viewer
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !$viewer->getIdentity() ) {
      return false;
    }

    // Check subject
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return false;
    }

    $subject = Engine_Api::_()->core()->getSubject();
    if( $subject instanceof Experience_Model_Experience ) {
      $owner = $subject->getOwner('user');
    } else if( $subject instanceof User_Model_User ) {
      $owner = $subject;
    } else {
      return false;
    }

    if( $owner->getIdentity() == $viewer->getIdentity() ) {
      return false;
    }

    // Modify params
    $params = $row->params;
    $subscriptionTable = Engine_Api::_()->getDbtable('subscriptions', 'experience');
    if( !$subscriptionTable->checkSubscription($owner, $viewer) ) {
      $params['label'] = 'Subscribe';
      $params['params']['user_id'] = $owner->getIdentity();
      $params['action'] = 'add';
      $params['class'] = 'buttonlink smoothbox icon_experience_subscribe';
    } else {
      $params['label'] = 'Unsubscribe';
      $params['params']['user_id'] = $owner->getIdentity();
      $params['action'] = 'remove';
      $params['class'] = 'buttonlink smoothbox icon_experience_unsubscribe';
    }

    return $params;
  }
  
  public function onMenuInitialize_ExperienceGutterCreate($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $request = Zend_Controller_Front::getInstance()->getRequest();
    $owner = Engine_Api::_()->getItem('user', $request->getParam('user_id'));

    if( $viewer->getIdentity() != $owner->getIdentity() ) {
      return false;
    }

    if( !Engine_Api::_()->authorization()->isAllowed('experience', $viewer, 'create') ) {
      return false;
    }

    return true;
  }

  public function onMenuInitialize_ExperienceGutterEdit($row)
  {
    if( !Engine_Api::_()->core()->hasSubject('experience') ) {
      return false;
    }

    $viewer = Engine_Api::_()->user()->getViewer();
    $experience = Engine_Api::_()->core()->getSubject('experience');
    
    if( !$experience->authorization()->isAllowed($viewer, 'edit') ) {
      return false;
    }

    // Modify params
    $params = $row->params;
    $params['params']['experience_id'] = $experience->getIdentity();
    return $params;
  }

  public function onMenuInitialize_ExperienceGutterDelete($row)
  {
    if( !Engine_Api::_()->core()->hasSubject('experience') ) {
      return false;
    }

    $viewer = Engine_Api::_()->user()->getViewer();
    $experience = Engine_Api::_()->core()->getSubject('experience');

    if( !$experience->authorization()->isAllowed($viewer, 'delete') ) {
      return false;
    }

    // Modify params
    $params = $row->params;
    $params['params']['experience_id'] = $experience->getIdentity();
    return $params;
  }

  public function onMenuInitialize_ExperienceGutterStyle($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $request = Zend_Controller_Front::getInstance()->getRequest();
    $owner = Engine_Api::_()->getItem('user', $request->getParam('user_id'));

    if( $viewer->getIdentity() != $owner->getIdentity() ) {
      return false;
    }

    if( !Engine_Api::_()->authorization()->isAllowed('experience', $viewer, 'style') ) {
      return false;
    }

    return true;
  }
 
}