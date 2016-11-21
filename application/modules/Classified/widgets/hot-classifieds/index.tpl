<div class="classified_entrylist">
	<?php
		foreach ($this->hotCategories as $category):
			$classifieds = Engine_Api::_()->getDbTable('classifieds', 'classified')->getClassifieds(array('category_id' => $category->getIdentity(), 'enabled' => true, 'limit' => 5, 'recursive' => true, 'orderby' => 'view_count'));
	?>
		<div class="col-md-6">
			<div class='classified_category_browse_photo'>
				<?php $categoryPhoto = $category->getPhotoUrl('thumb.main');?>
				<?php if(empty($categoryPhoto)) $categoryPhoto = 'application/modules/Classified/externals/images/img_not_available.png'?>
				<?php echo $this->htmlLink($category->getHref(), '', array('style' => 'background-image: url("' . $categoryPhoto . '")')) ?>
			</div>
			<div class='classified_category_browse_info'>
				<div class='classified_category_browse_info_title'>
					<b><?php echo $this->htmlLink($category->getHref(), $category->getTitle()) ?></b>
					<span class="count">(<?php echo count($classifieds) ?>)</span>
					|
					<span class="see_all"><?php echo $this->htmlLink($category->getHref(), $this->translate('see all')) ?></span>
				</div>
				<ul class="classified_list">
					<?php foreach ($classifieds as $classified):?>
						<li><?php echo $this->htmlLink($classified->getHref(), Engine_Api::_()->classified()->subPhrase($classified->getTitle(), 40), array('title' => $classified->getTitle()) ) ?></li>
					<?php endforeach; ?>
				</ul>
			</div>
		</div>
	<?php endforeach; ?>
</div>
