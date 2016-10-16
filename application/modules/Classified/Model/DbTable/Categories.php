<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Categories.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Classified_Model_DbTable_Categories extends Engine_Db_Table
{
    protected $_rowClass = 'Classified_Model_Category';
    
    public function getParentCategories(){
		$select = $this->select();
		//parent
		$select = $select->where('parent_id = 0');
		return $this->fetchAll($select);
	}
	
    public function getCategoriesAssoc()
    {
        $parents = $this->getParentCategories();
        
        $data = array();
        foreach ($parents as $parent) {
			$data[$parent->getIdentity()] = $parent->getTitle();
			$childs = $parent->getSubCategory();
			foreach($childs as $child){
				$data[$child->getIdentity()] = "== " . $child->getTitle();
			}
        }
        
        return $data;
    }
    
    public function getUserCategoriesAssoc($user)
    {
        if ($user instanceof User_Model_User) {
            $user = $user->getIdentity();
        } else if (!is_numeric($user)) {
            return array();
        }
        
        $stmt = $this->getAdapter()->select()->from('engine4_classified_categories', array(
            'category_id',
            'category_name'
        ))->joinLeft('engine4_classified_classifieds', "engine4_classified_classifieds.category_id = engine4_classified_categories.category_id")->group("engine4_classified_categories.category_id")->where('engine4_classified_classifieds.owner_id = ?', $user)->where('engine4_classified_classifieds.draft = ?', "0")->order('category_name ASC')->query();
        
        $data = array();
        foreach ($stmt->fetchAll() as $category) {
            $data[$category['category_id']] = $category['category_name'];
        }
        
        return $data;
    }
	
	public function getHotCategories(){
		$select = $this->select();
		//parent
		$select = $select->where('is_hot = 1');
		return $this->fetchAll($select);
	}
}