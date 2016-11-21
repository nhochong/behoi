<div class="featured_blogs_entrylist">
	<?php
		foreach ($this->blogs as $blog):
	?>
		<div class="col-md-6">
			<div class='featured_blogs_browse_photo'>
				<?php echo $this->htmlLink($blog->getHref(), '', array('style' => 'background-image: url("' . $blog->getPhotoUrl('thumb.main') . '")')) ?>
			</div>
			<div class='featured_blogs_browse_info'>
				<div class='featured_blogs_browse_info_title'>
					<b><?php echo $this->htmlLink($blog->getHref(), $blog->getTitle()) ?></b>
				</div>
				<div class='featured_blogs_browse_info_category'>
					<div>
						<?php echo $this->translate('Topic')?>
						<b><?php echo $blog->getCategory()->getTitle();?></b>
					</div>
					<div><?php echo date('F j, Y', strtotime($blog->creation_date));?></div>
				</div>
				<div class='featured_blogs_browse_info_description'>
					<?php echo Engine_Api::_()->ynblog()->subPhrase($blog->getDescription(), 100) ?>
				</div>
			</div>
		</div>
	<?php endforeach; ?>
</div>
<div class="see_all"><?php echo $this->htmlLink(array('route' => 'blog_general'), $this->translate('see all')) ?></div>

<style type="text/css">
	.featured_blogs_entrylist > div {
		height: 160px;
		margin-bottom: 40px;
		padding-left: 0px;
	}
	.featured_blogs_entrylist > div .featured_blogs_browse_photo {
		float: left;
		height: 160px;
		width: 200px;
		border: 1px solid #7c8082;
		margin-right: 10px;
		overflow: hidden;
		text-align: center;
	}
	.featured_blogs_entrylist > div .featured_blogs_browse_photo > a {
		background-size: cover!important;
		display: block;
		height: 100%;
	}
	.featured_blogs_browse_info {
		overflow: hidden;
	}
	.layout_featured_blogs_landing .featured_blogs_browse_info_title {
		font-size: 16px;
	}
	.layout_featured_blogs_landing .featured_blogs_browse_info_title a {
		color: #EF5125;
		font-weight: 600;
	}
	.layout_featured_blogs_landing .readmore {
		font-size: 12px;
	}
	.layout_featured_blogs_landing .readmore a {
		color: #EF5125;
	}
</style>
