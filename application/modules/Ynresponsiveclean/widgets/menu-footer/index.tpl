<div class="photo-footer-menu">
	<div class="container clearfix">
	    <div class="cus-footer pull-left col-sm-3">
	        <div class="title"><?php echo $this->translate('Kết nối với behoi.com') ?></div>
			<div class="content social-connect">
				<ul>
					<li><a href="javascript:void(0)"><img src="<?php echo $this->baseUrl() . '/application/themes/ynresponsive1/images/social/facebook.png'?>" /></a></li>
					<li><a href="javascript:void(0)"><img src="<?php echo $this->baseUrl() . '/application/themes/ynresponsive1/images/social/twitter.png'?>" /></a></li>
					<li><a href="javascript:void(0)"><img src="<?php echo $this->baseUrl() . '/application/themes/ynresponsive1/images/social/google+.png'?>" /></a></li>
					<li><a href="javascript:void(0)"><img src="<?php echo $this->baseUrl() . '/application/themes/ynresponsive1/images/social/you_tube.png'?>" /></a></li>
				</ul>
			</div>
	    </div>
		
		<div class="cus-footer pull-left col-sm-3">
			<div class="title"><?php echo $this->translate('Giới thiệu') ?></div>
			<div class="content">
				<div class="about-us"><a href="<?php echo $this->baseUrl() . '/about-us'?>"><?php echo $this->translate('Về chúng tôi');?></a></div>
				<div class="contact-us"><a href="<?php echo $this->baseUrl() . '/help/contact'?>"><?php echo $this->translate('Liên hệ');?></a></div>
			</div>
	    </div>
		
		<div class="cus-footer pull-left col-sm-2">
	        <div class="title"><?php echo $this->translate('Sản phầm') ?></div>
			<div class="content">
				<div class="forum-behoi"><a href="<?php echo $this->baseUrl()?>"><?php echo $this->translate('Diễn đàn');?></a></div>
				<div class="deal-hot"><a href="javascript:void(0)"><?php echo $this->translate('Deal HOT');?></a></div>
			</div>
	    </div>

	    <div class="menu-mini-footer pull-right subscribe_form col-sm-4">
	      	<div class="title"><?php echo $this->translate('Đăng ký nhận bản tin khuyến mãi') ?></div>
			<div class="content">
				<input type="text" id="subscribe_input" placeholder="NHẬP EMAIL CỦA BẠN"/>
				<button id="subscribe_button"><?php echo $this->translate('Đăng ký');?></button>
			</div>
	   	</div>
    </div>

    <div class="wrap-scroll">
        <button class="scrollTop"><i class="fa fa-arrow-up"></i></button>
    </div>
</div>

<script>
	(function( $ ) {
	  $(function() {
		$(".scrollTop").on('click', function(){
			var body = $("html, body");
			body.animate({scrollTop:0}, '500', 'swing');
		});
	  });
	})(jQuery);
</script>


