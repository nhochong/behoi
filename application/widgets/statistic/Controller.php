<?php
/**
 * SocialEngine
 *
 * @category   Application_Widget
 * @package    Clock
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Widget
 * @package    Clock
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Widget_StatisticController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		$this->view->number_of_users = count(Engine_Api::_()->getItemTable('user')->fetchAll());
		$this->view->number_of_classified = count(Engine_Api::_()->getItemTable('classified')->fetchAll());
		$this->view->number_of_topic = count(Engine_Api::_()->getItemTable('question')->fetchAll());
		$this->view->number_of_reply = count(Engine_Api::_()->getItemTable('answer')->fetchAll());
		
		// Get online users
		$table = Engine_Api::_()->getItemTable('user');
		$onlineTable = Engine_Api::_()->getDbtable('online', 'user');
		
		$tableName = $table->info('name');
		$onlineTableName = $onlineTable->info('name');

		$this->view->onlineUserCount = $onlineUserCount = $table->select()
		  ->from($tableName, new Zend_Db_Expr('COUNT(*) as count'))
		  ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
		  ->where($onlineTableName.'.user_id > ?', 0)
		  ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
		  ->where($tableName.'.search = ?', 1)
		  ->where($tableName.'.enabled = ?', 1)
		  ->order($onlineTableName.'.active DESC')
		  ->group($onlineTableName.'.user_id')
		  ->query()
		  ->fetchColumn();
		$this->view->onlineUserCount = $onlineUserCount ? $onlineUserCount : 0;

		// Guests online
		$this->view->guestCount = $guestCount = $onlineTable->select()
			->from($onlineTable, new Zend_Db_Expr('COUNT(*) as count'))
			->where('user_id = ?', 0)
			->where('active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
			->query()
			->fetchColumn();
			;
		$this->view->guestCount = $guestCount ? $guestCount : 0;
	}
}