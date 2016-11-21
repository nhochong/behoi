<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Classified_Widget_ListPopularClassifiedsController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Should we consider views or comments popular?
    $popularType = $this->_getParam('popularType', 'view');
    if( !in_array($popularType, array('comment', 'view')) ) {
      $popularType = 'view';
    }
    $this->view->popularType = $popularType;
    $this->view->popularCol = $popularCol = $popularType . '_count';
    
    // Get paginator
    $table = Engine_Api::_()->getItemTable('classified');
    $select = $table->select()
	  ->where('enabled = ?', 1)
      ->where('search = ?', 1)
      ->order($popularCol . ' DESC');
    $this->view->paginator = $paginator = Zend_Paginator::factory($select);

    // Set item count per page and current page number
    $paginator->setItemCountPerPage($this->_getParam('itemCountPerPage', 10));
    $paginator->setCurrentPageNumber($this->_getParam('page', 1));

    // Hide if nothing to show
    if( $paginator->getTotalItemCount() <= 0 ) {
      return $this->setNoRender();
    }
    
    // Add fields view helper path
    $view = $this->view;
    $view->addHelperPath(APPLICATION_PATH . '/application/modules/Fields/View/Helper', 'Fields_View_Helper');
  }
}