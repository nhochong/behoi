<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: AdminManageController.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Classified_AdminManageController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('classified_admin_main', array(), 'classified_admin_main_manage');

    if ($this->getRequest()->isPost()) {
      $values = $this->getRequest()->getPost();
      foreach ($values as $key => $value) {
        if ($key == 'delete_' . $value) {
          $classified = Engine_Api::_()->getItem('classified', $value);
          $classified->delete();
        }
      }
    }

    $page=$this->_getParam('page',1);
    $this->view->paginator = Engine_Api::_()->getItemTable('classified')->getClassifiedsPaginator(array(
      'orderby' => 'classified_id',
    ));
    $this->view->paginator->setItemCountPerPage(25);
    $this->view->paginator->setCurrentPageNumber($page);
  }

  public function deleteAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->classified_id=$id;
    // Check post
    if( $this->getRequest()->isPost())
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();


      try
      {
        $classified = Engine_Api::_()->getItem('classified', $id);
        // delete the classified listing the database
        $classified->delete();
        $db->commit();
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => 10,
          'parentRefresh'=> 10,
          'messages' => array('')
      ));
    }

    // Output
    $this->renderScript('admin-manage/delete.tpl');
  }
  
	public function importAction()
    {
        $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
                ->getNavigation('classified_admin_main', array(), 'classified_admin_main_manage');
        
        $categoryTable = Engine_Api::_() -> getItemTable('classified_category');
        $this->view->categories = $categories = $categoryTable -> getCategoriesAssoc();
		
        if (!$this->getRequest()->isPost()) {
            return;
        }
        $viewer = Engine_Api::_()->user()->getViewer();

        $allparams = $this->_getAllParams();
        $api = Engine_Api::_()->getApi('core', 'classified');
        $import_result = $api->uploadImportFile();
        $classifiedTable = Engine_Api::_() -> getItemTable('classified');

        if (count($import_result)) {
            unset($import_result[1]);
            $db = Engine_Db_Table::getDefaultAdapter();
            $db->beginTransaction();
            try {
                foreach ($import_result as $key => $item) {
					if(empty($item['B'])) continue;
					$category = $categoryTable->getCaterogyByCode($item['B']);
					if(!$category) continue;
					$row = $classifiedTable->fetchRow($classifiedTable->select()->where('title = ?', $item['C'])->where('category_id = ?', $category->getIdentity()));
					if(!$row){
						$row = $classifiedTable->createRow();
					}
					$row->title = $item['C'];
					$row->body = $item['D'] ? $item['D'] : '';
					$row->owner_id = 1;
					$row->category_id = $category->getIdentity();
					$row->more_info = $item['E'];
					$row->save();
				}
				$db->commit();
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }
			return $this->_forward('success' ,'utility', 'core', array(
				'parentRefresh' => true,
				'messages' => Array(Zend_Registry::get('Zend_Translate')->_('Import success.'))
			));
        }
    }
}