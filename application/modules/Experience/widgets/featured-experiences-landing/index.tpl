<div class="featured_experiences_entrylist">
	<?php
		foreach ($this->experiences as $experience):
	?>
		<div class="col-md-6">
			<div class='featured_experiences_browse_photo'>
				<?php echo $this->htmlLink($experience->getHref(), '', array('style' => 'background-image: url("' . $experience->getPhotoUrl('thumb.main') . '")')) ?>
			</div>
			<div class='featured_experiences_browse_info'>
				<div class='featured_experiences_browse_info_title'>
					<b><?php echo $this->htmlLink($experience->getHref(), $experience->getTitle()) ?></b>
				</div>
				<div class='featured_experiences_browse_info_category'>
					<div>
						<?php echo $this->translate('Chủ đề')?>
						<b><?php echo $experience->getCategory()->getTitle();?></b>
					</div>
					<div><?php echo $this->locale()->toDate(strtotime($experience->creation_date), array('format' => 'd/MM/y'));?></div>
				</div>
				<div class='featured_experiences_browse_info_description'>
					<?php echo Engine_Api::_()->experience()->subPhrase($experience->getDescription(), 200) ?>
				</div>
			</div>
		</div>
	<?php endforeach; ?>
	<div class="see_all"><?php echo $this->htmlLink(array('route' => 'experience_general'), $this->translate('>>> Xem tất cả')) ?></div>
</div>

<style type="text/css">
	.featured_experiences_entrylist > div {
		height: 160px;
		margin-bottom: 40px;
		padding-left: 0px;
	}
	.featured_experiences_entrylist > div .featured_experiences_browse_photo {
		float: left;
		height: 160px;
		width: 200px;
		border: 1px solid #7c8082;
		margin-right: 10px;
		overflow: hidden;
		text-align: center;
	}
	.featured_experiences_entrylist > div .featured_experiences_browse_photo > a {
		background-size: cover!important;
		display: block;
		height: 100%;
	}
	.featured_experiences_browse_info {
		overflow: hidden;
	}
	.layout_featured_experiences_landing .featured_experiences_browse_info_title {
		font-size: 16px;
	}
	.layout_featured_experiences_landing .featured_experiences_browse_info_title a {
		color: #EF5125;
		font-weight: 600;
	}
	.layout_featured_experiences_landing .readmore {
		font-size: 12px;
	}
	.layout_featured_experiences_landing .readmore a {
		color: #EF5125;
	}
</style>
