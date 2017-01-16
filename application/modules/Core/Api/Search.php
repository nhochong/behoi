<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Search.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Api_Search extends Core_Api_Abstract
{
  protected $_types;
  
  public function index(Core_Model_Item_Abstract $item)
  {
    // Check if not search allowed
    if( isset($item->search) && !$item->search )
    {
      return false;
    }

    // Get info
    $type = $item->getType();
    $id = $item->getIdentity();
    $title = substr(trim($item->getTitle()), 0, 255);
    $description = substr(trim($item->getDescription()), 0, 255);
    $keywords = substr(trim($item->getKeywords()), 0, 255);
    $hiddenText = substr(trim($item->getHiddenSearchData()), 0, 255);
    
    // Ignore if no title and no description
    if( !$title && !$description )
    {
      return false;
    }

    // Check if already indexed
    $table = Engine_Api::_()->getDbtable('search', 'core');
    $select = $table->select()
      ->where('type = ?', $type)
      ->where('id = ?', $id)
      ->limit(1);

    $row = $table->fetchRow($select);

    if( null === $row )
    {
      $row = $table->createRow();
      $row->type = $type;
      $row->id = $id;
    }

    $row->title = $title;
    $row->description = $description;
    $row->keywords = $keywords;
    $row->hidden = $hiddenText;
    $row->save();
  }

  public function unindex(Core_Model_Item_Abstract $item)
  {
    $table = Engine_Api::_()->getDbtable('search', 'core');

    $table->delete(array(
      'type = ?' => $item->getType(),
      'id = ?' => $item->getIdentity(),
    ));

    return $this;
  }

  public function getPaginator($text, $type = null)
  {
	  $table = Engine_Api::_()->getDbtable('search', 'core');
	  $select = $this->getSelect($text, $type); 
	  $items = $table->fetchAll($select);
	  $result = array();
	  foreach($items as $item){
		$object = Engine_Api::_()->getItem($item->type, $item->id);
		if( !$object ) continue;
		if($item->type == 'classified' && $object->enabled == false) continue;
		if($item->type == 'blog' && $object->is_approved == false) continue;
		$result[] = $item;
	  }
    return Zend_Paginator::factory($result);
  }

  public function getSelect($text, $type = null)
  {
    // Build base query
    $table = Engine_Api::_()->getDbtable('search', 'core');
    $db = $table->getAdapter();
    $select = $table->select()
	  ->where("`title` Like ? or `description` Like ? or `keywords` Like ? or `hidden` Like ?", "%" . $text . "%");
      //->where(new Zend_Db_Expr($db->quoteInto('MATCH(`title`, `description`, `keywords`, `hidden`) AGAINST (? IN BOOLEAN MODE)', $text)))
      //->order(new Zend_Db_Expr($db->quoteInto('MATCH(`title`, `description`, `keywords`, `hidden`) AGAINST (?) DESC', $text)));

    // Filter by item types
    //$availableTypes = Engine_Api::_()->getItemTypes();
    $availableTypes = array(
		'album',
		'classified',
		'blog',
		'question',
		'answer',
		'user',
	);
    if( $type && in_array($type, $availableTypes) ) {
      $select->where('type = ?', $type);
    } else {
      $select->where('type IN(?)', $availableTypes);
    }
	echo $select;
    return $select;
  }

  public function getAvailableTypes()
  {
    if( null === $this->_types ) {
      // $this->_types = Engine_Api::_()->getDbtable('search', 'core')->getAdapter()
        // ->query('SELECT DISTINCT `type` FROM `engine4_core_search`')
        // ->fetchAll(Zend_Db::FETCH_COLUMN);
      // $this->_types = array_intersect($this->_types, Engine_Api::_()->getItemTypes());
	  $this->_types = array(
		'ALBUM',
		'BLOG',
		'CLASSIFIED',
		'QUESTION',
		'USER',
	  );
    }

    return $this->_types;
  }
}