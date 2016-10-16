<style type="text/css">
	#section-intro {
		background-color: #FFF;
		padding-bottom: 70px;
		position: relative;
	}
	#section-intro .images img {
		max-width: 100%;
	}
	#section-intro .intro-text {
		margin: 30px 10px 20px;
	}
	#section-intro .intro-text p {
		font-size: 24px;
		text-transform: uppercase;
		line-height: 32px;
		color: #248285;
	}
	#section-intro .intro-button .button-link {
		color: #FFF;
		background-color: #248285;
		padding: 10px 20px;
		text-transform: uppercase;
		font-weight: bold;
		display: inline-block;
		margin-bottom: 40px;
	}
	#section-intro .item .title-col {
		overflow: hidden;
		margin-bottom: 10px;
	}
	#section-intro .item .title-col img {
		float: left;
		margin-right: 10px;
		max-height: 36px;
	}
	#section-intro .item .title-col h3 {
		font-size: 24px;
		font-weight: normal;
		line-height: 36px;
		overflow: hidden;
		margin: 0;
		text-transform: uppercase;
	}
	#section-intro .item .content-col p {
		font-size: 16px;
		text-transform: uppercase;
		font-weight: 300;
		line-height: 26px;
	}
	#section-intro .connect-item * {
		color: #267761;
	}
	#section-intro .communicate-item * {
		color: #2c6b37;
	}
	#section-intro .share-item * {
		color: #834478;
	}
	.moveNext {
		position: absolute;
	    bottom: 10px;
	    width: 100%;
	    text-align: center;
	}
	.moveNext #infoNext.icon {
		display: inline-block;
	    color: #3e8985;
	    font-size: 72px;
	    line-height: 1;
	    cursor: pointer;
	}
</style>
<div class="section-info" id="section-intro">
	<div class="images">
		<img src="<?php echo $this->baseUrl(); ?>/application/themes/ynresponsive1/images/custom/bg-2.jpg" />
	</div>
	<div class="container">
		<div class="row">
			<div class="text-center intro-text">
				<p>
					<?php echo $this->translate("Share your story and enrich your understanding of one of humanity's oldest 
					medicines on the first social networking site dedicated to connecting people who love, grow, use, 
					or are curious about cannabis."); ?>
				</p>
			</div>
			<div class="text-center intro-button">
				<a href="" class="button-link">
					<?php echo $this->translate('Sign up for beta'); ?>
				</a>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-xs-12 col-lg-4 col-sm-4 item connect-item">
				<div class="title-col">
					<img src="<?php echo $this->baseUrl(); ?>/application/themes/ynresponsive1/images/custom/title-connect.png" />
					<h3><?php echo $this->translate('Connect'); ?></h3>
				</div>
				<div class="content-col">
					<p>
						<?php echo $this->translate("Meet people just like you from around the world to share 
						techniques, recipes, and their life's experiences with cannabis."); ?>
					</p>
				</div>
			</div>
			
			<div class="col-md-4 col-xs-12 col-lg-4 col-sm-4 item communicate-item">
				<div class="title-col">
					<img src="<?php echo $this->baseUrl(); ?>/application/themes/ynresponsive1/images/custom/title-communicate.png" />
					<h3><?php echo $this->translate('COMMUNICATE'); ?></h3>
				</div>
				<div class="content-col">
					<p>
						<?php echo $this->translate("Join others in the Cannabis Connection and chat 
						about growing for the first time; what strain another patient used; 
						or spark up a conversation in the Toker's Lounge."); ?>
					</p>
				</div>
			</div>
			
			<div class="col-md-4 col-xs-12 col-lg-4 col-sm-4 item share-item">
				<div class="title-col">
					<img src="<?php echo $this->baseUrl(); ?>/application/themes/ynresponsive1/images/custom/title-share.png" />
					<h3><?php echo $this->translate('Share'); ?></h3>
				</div>
				<div class="content-col">
					<p>
						<?php echo $this->translate("SHARE WITH OTHER MEMBERS YOUR
						LIFE'S EXPERIENCES WITH CANNABIS
						BY POSTING MICROBLOGS, AUDIO
						BLOGS, VIDEOS, PICTURES AND MORE."); ?>
					</p>
				</div>
			</div>
		</div>
	</div>
	<div class="moveNext">
		<span class="icon" id="infoNext">
			<i class="fa fa-angle-down"></i>
		</span>
	</div>
</div>
<script type="text/javascript">
	window.addEvent('domready', function(){
		$('infoNext').addEvent('click', function(){
			var myFx = new Fx.Scroll(window).toElement($('basic-slideshow'), 'y');
		});

	});
</script>