<div id="myCarousel" class="carousel slide" data-ride="carousel">
	<!-- Wrapper for slides -->
	<div class="carousel-inner" role="listbox">
		<?php $index = 0;?>
		<?php foreach ($this->categories as $category) :?>
			<div class="item <?php if($index++ == 0) echo "active"?>">
				<img src="<?php echo $category->getPhotoUrl()?>" />
				<div class="title"><?php echo $category->getTitle()?></div>
			</div>
		<?php endforeach;?>
	</div>
	
	<!-- Left and right controls -->
	<a data-slide="prev" href="#myCarousel" class="left carousel-control">‹</a>
    <a data-slide="next" href="#myCarousel" class="right carousel-control">›</a>
</div>
<style>
	.carousel-inner > .item > img,
	.carousel-inner > .item > a > img {
		width: 100%;
		margin: auto;
	}
	.generic_layout_container.layout_classified_browse_category_slide > div + div {
		height: 190px !important;
	}
	.carousel.slide {
		margin: 0px !important;
	}
	.carousel-inner div.title {
		line-height: 16px;
		text-align: center;
		color: #72c02c;
		font-weight: bold;
		margin-top: 10px;
	}
</style>