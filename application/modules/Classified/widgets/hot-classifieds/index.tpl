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

<style type="text/css">
	.classified_entrylist > div {
		height: 160px;
		margin-bottom: 40px;
		padding-left: 0px;
	}
	.classified_entrylist > div .classified_category_browse_photo {
		float: left;
		height: 160px;
		width: 200px;
		border: 1px solid #7c8082;
		margin-right: 10px;
		overflow: hidden;
		text-align: center;
	}
	.classified_entrylist > div .classified_category_browse_photo > a {
		background-size: cover!important;
		display: block;
		height: 100%;
	}
	.classified_category_browse_info {
		overflow: hidden;
	}
	.layout_classified_hot_categories .classified_category_browse_info_title {
		font-size: 16px;
	}
	.layout_classified_hot_categories .classified_category_browse_info_title a {
		color: #EF5125;
		font-weight: 600;
	}
	.layout_classified_hot_categories .readmore {
		font-size: 12px;
	}
	.layout_classified_hot_categories .readmore a {
		color: #EF5125;
	}
</style>
