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
	$category = $this->category;
	$parent = null;
	$child = null;
	$isParent = ($category->parent_id == 0) ? true: false;//var_dump($isParent);die;
	if($isParent){
		$parent = $category;
	}else{
		$parent = Engine_Api::_()->getItem('classified_category', $category->parent_id);
		$child = $category;
	}
?>
<div class="classifieds_browse_info_category icon">
	<?php echo $this->htmlLink($parent->getHref(), $this -> translate($parent->getTitle()))?>
	<?php if(!$isParent):?>
		&rarr;
		<?php echo $this->htmlLink($child->getHref(), $this -> translate($child->getTitle()))?>
	<?php endif?>
</div>
