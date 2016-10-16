<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Category.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Classified_Model_Category extends Core_Model_Item_Abstract
{
	protected $_searchTriggers = false;
  
	public function getHref($params = array())
    {
		$slug = $this->getSlug();
        $params = array_merge(array(
            'route' => 'classified_general',
            'controller' => 'index',
            'action' => 'browse',
            'category' => $this->getIdentity(),
			'slug' => $slug,
        ),
            $params);
        $route = $params['route'];
        unset($params['route']);
        return Zend_Controller_Front::getInstance()->getRouter()
            ->assemble($params, $route, true);
    }
	
	public function getTitle()
	{
		return $this->category_name;
	}
  
	public function getUsedCount()
	{
		$classifiedTable = Engine_Api::_()->getItemTable('classified');
		return $classifiedTable->select()
			->from($classifiedTable, new Zend_Db_Expr('COUNT(classified_id)'))
			->where('category_id = ?', $this->category_id)
			->query()
			->fetchColumn();
	}

	public function isOwner($owner)
	{
		return false;
	}

	public function getOwner()
	{
		return $this;
	}
  
	public function getSubCategory()
	{
		$table = Engine_Api::_()->getDbtable('categories', 'classified');
		$select = $table->select();
		
		//parent
		$select = $select->where('parent_id = ?', $this->getIdentity());
		return $table->fetchAll($select);
	}
	
	public function getSubCategoryCount(){
		$categories = $this->getSubCategory();
		return count($categories);
	}
	
	public function getSubCategoryIds()
	{
		$categories = $this->getSubCategory();
		$ids = array();
		foreach($categories as $category){
			$ids[] = $category->getIdentity();
		}
		return $ids;
	}
	
	public function setPhoto($photo)
	{
		if ($photo instanceof Zend_Form_Element_File)
		{
			$file = $photo -> getFileName();
		}
		else
		if (is_array($photo) && !empty($photo['tmp_name']))
		{
			$file = $photo['tmp_name'];
		}
		else
		if (is_string($photo) && file_exists($photo))
		{
			$file = $photo;
		}
		else
		{
			throw new Exception('invalid argument passed to setPhoto');
		}

		$name = basename($file);
		$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
		$params = array(
			'parent_type' => 'classified_category',
			'parent_id' => $this -> getIdentity()
		);

		// Save
		$storage = Engine_Api::_() -> storage();

		// Resize image (main)
		$image = Engine_Image::factory();
		$image -> open($file) -> write($path . '/m_' . $name) -> destroy();

		// Resize image (profile)
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(200, 400) -> write($path . '/p_' . $name) -> destroy();

		// Resize image (normal)
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(140, 160) -> write($path . '/in_' . $name) -> destroy();

		// Resize image (icon)
		$image = Engine_Image::factory();
		$image -> open($file);

		$size = min($image -> height, $image -> width);
		$x = ($image -> width - $size) / 2;
		$y = ($image -> height - $size) / 2;

		$image -> resample($x, $y, $size, $size, 48, 48) -> write($path . '/is_' . $name) -> destroy();

		// Store
		$iMain = $storage -> create($path . '/m_' . $name, $params);
		$iProfile = $storage -> create($path . '/p_' . $name, $params);
		$iIconNormal = $storage -> create($path . '/in_' . $name, $params);
		$iSquare = $storage -> create($path . '/is_' . $name, $params);

		$iMain -> bridge($iProfile, 'thumb.profile');
		$iMain -> bridge($iIconNormal, 'thumb.normal');
		$iMain -> bridge($iSquare, 'thumb.icon');

		// Remove temp files
		@unlink($path . '/p_' . $name);
		@unlink($path . '/m_' . $name);
		@unlink($path . '/in_' . $name);
		@unlink($path . '/is_' . $name);

		// Update row
		$this -> photo_id = $iMain -> file_id;
		$this -> save();
		return $this;
	}
	
	public function getPhotoUrl($type = null){
		if(!empty($this->photo_id)){
			return parent::getPhotoUrl($type);
		}
		return 'application/modules/Core/externals/images/nophoto_available.png';
	}
}
