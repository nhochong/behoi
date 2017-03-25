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
						<?php echo $this->translate('Chủ đề')?>
						<b><?php echo $blog->getCategory()->getTitle();?></b>
					</div>
					<div><?php echo $this->locale()->toDate(strtotime($blog->creation_date), array('format' => 'd/MM/y'));?></div>
				</div>
				<div class='featured_blogs_browse_info_description'>
					<?php echo Engine_Api::_()->ynblog()->subPhrase($blog->getDescription(), 200) ?>
				</div>
			</div>
		</div>
	<?php endforeach; ?>
	<div class="see_all"><?php echo $this->htmlLink(array('route' => 'blog_general'), $this->translate('>>> Xem tất cả')) ?></div>
</div>
