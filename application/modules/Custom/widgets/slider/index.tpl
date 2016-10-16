
<div id='basic-slideshow' class='slideshow'>
	<?php foreach ($this->slides as $slide):?>
		<div style="background-image: url('<?php echo $slide->getPhotoUrl()?>'); ">
		</div>
	<?php endforeach;?>
</div>
<script type="text/javascript">
var basic;
document.addEvent('domready', function(){
	basic = new SlideShow('basic-slideshow', {
		autoplay: true,
		delay: 10000,
		//transition: 'pushLeft'
	});
});
</script>
