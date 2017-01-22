<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: SearchController.php 9906 2013-02-14 02:54:51Z shaun $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_SearchController extends Core_Controller_Action_Standard
{
  public function indexAction()
  {
    $searchApi = Engine_Api::_()->getApi('search', 'core');

    // check public settings
    $require_check = Engine_Api::_()->getApi('settings', 'core')->core_general_search;
    if( !$require_check ) {
      if( !$this->_helper->requireUser()->isValid() ) return;
    }

    // Prepare form
    $this->view->form = $form = new Core_Form_Search();

    // Get available types
    $availableTypes = $searchApi->getAvailableTypes();
    if( is_array($availableTypes) && count($availableTypes) > 0 ) {
      $options = array();
      foreach( $availableTypes as $index => $type ) {
        $options[$type] = strtoupper('ITEM_TYPE_' . $type);
      }
      $form->type->addMultiOptions($options);
    } else {
      $form->removeElement('type');
    }

    // Check form validity?
    $values = array();
    if( $form->isValid($this->_getAllParams()) ) {
      $values = $form->getValues();
    }
    
    $this->view->query = $query = (string) @$values['query'];
    $this->view->type = $type = (string) @$values['type'];
    $this->view->page = $page = (int) $this->_getParam('page');
    if( $query ) {
      $this->view->paginator = $searchApi->getPaginator($query, $type);
      $this->view->paginator->setCurrentPageNumber($page);
    }
    
    // Render the page
    $this->_helper->content
      // ->setNoRender()
      ->setEnabled();
  }
  
	public function reindexAction(){
		$type = $this->_getParam('type', null);
		$arrTables = array();
		
		if(!empty($type)){
			if( !Engine_Api::_()->hasItemType($type) ) {
				die('Not Found.');
			}
			$arrTables[] = $type;
		}else{
			$arrTables = array(
				'blog',
				'classified',
				'question',
				'user'
			);
		}
		
		$searchTables = Engine_Api::_()->getDbtable('search', 'core');
		foreach($arrTables as $table){
			// Remove relate data
			$searchTables->delete(array(
				'type = ?' => $type
			));
			
			// Reindex
			$table = Engine_Api::_()->getItemTable($table);
			$rows = $table->fetchAll();
			foreach($rows as $row){
				// Search indexer
				if( $row->isSearchable()) {
					// Index
					Engine_Api::_()->getApi('search', 'core')->index($row);
				}
			}
		}
		
		die('Finished.');
	}
}