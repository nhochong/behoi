<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9966 2013-03-19 00:00:35Z john $
 * @author     John Boehr <john@socialengine.com>
 */

/**
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Classified_Widget_BrowseMenuController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Get navigation
    $this->view->navigation = Engine_Api::_()
      ->getApi('menus', 'core')
      ->getNavigation('classified_main', array());
    if( count($this->view->navigation) == 1 ) {
      $this->view->navigation = null;
    }
	
	// Must be logged in
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !$viewer || !$viewer->getIdentity() ) {
      return $this->setNoRender(true);
    }

    // Must be able to create classifieds
    if( !Engine_Api::_()->authorization()->isAllowed('classified', $viewer, 'create') ) {
      return $this->setNoRender(true);
    }
  }
}
