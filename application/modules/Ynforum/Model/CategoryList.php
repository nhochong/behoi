<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Forum
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: List.php 7244 2010-09-01 01:49:53Z john $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Forum
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 */
class Ynforum_Model_CategoryList extends Core_Model_List {
    protected $_owner_type = 'category';
    protected $_child_type = 'user';
    protected $_name = 'ynforum_category_lists';
    protected $_shortType = 'list';

    public function getListItemTable() {
        return Engine_Api::_()->getItemTable('ynforum_category_list_item');
    } 
}