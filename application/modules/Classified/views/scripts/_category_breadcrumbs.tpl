<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: _FancyUpload.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     HungNT
 */
?>
<?php 
	$categories = $this->categories;
	$isMulti = false;
	if(count($categories) > 1){
		$isMulti = true;	
	}
	
	if(!$isMulti){
		$category = $categories[0];
		$parent = null;
		$child = null;
		$isParent = ($category->parent_id == 0) ? true: false;//var_dump($isParent);die;
		if($isParent){
			$parent = $category;
		}else{
			$parent = Engine_Api::_()->getItem('classified_category', $category->parent_id);
			$child = $category;
		}
	}
?>
<div class="classifieds_browse_info_category icon">
	<?php if(!$isMulti):?>
		<?php echo $this->htmlLink($parent->getHref(), $this -> translate($parent->getTitle()))?>
		<?php if(!$isParent):?>
			&rarr;
			<?php echo $this->htmlLink($child->getHref(), $this -> translate($child->getTitle()))?>
		<?php endif;?>
	<?php else:?>
		<?php echo $this->htmlLink($categories[0]->getHref(), $this -> translate($categories[0]->getTitle()))?>
		<?php foreach($categories as $index => $value): if($index == 0) continue;?>
			-
			<?php echo $this->htmlLink($value->getHref(), $this -> translate($value->getTitle()))?>
		<?php endforeach;?>
	<?php endif;?>
</div>
