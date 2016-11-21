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
		$this->view->number_of_topic = 123;//count(Engine_Api::_()->getItemTable('user')->fetchAll());
		$this->view->number_of_reply = 123123;//count(Engine_Api::_()->getItemTable('user')->fetchAll());
	}
}