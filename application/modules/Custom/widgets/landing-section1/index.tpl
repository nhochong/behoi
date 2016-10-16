<style type="text/css">
	#section-access {
		background: url('<?php echo $this->baseUrl(); ?>/application/themes/ynresponsive1/images/custom/bg-1.jpg') no-repeat top center/cover transparent;
		position: relative;
	}
	#section-access .wrap-info {
		position: absolute;
		bottom: 25%;
		left: 0;
		width: 100%;
		padding: 0 50px;
		box-sizing: border-box;
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
	}
	#section-access h1 {
		color: #FFF;
		line-height: 50px;
		margin-bottom: 20px;
	}
	#section-access h1 span {
		display: block;
		font-weight: 300;
	}
	#section-access .orange {
		color: #f79230;
		font-weight: 600;
	}
	#section-access .get-access form {
		display: inline-block;
		overflow: hidden;
		width: 100%;
		max-width: 35%;
	}
	#section-access .info-button {
		float: right;
	}
	#section-access .info-button button {
		font-size: 13px;
		padding: .5em 1em;
		width: 100%;
		border: 1px solid transparent;
		background-color: #f79230;
		text-transform: uppercase;
		border-radius: 0 5px 5px 0;
		height: 32px;
	}
	#section-access .info-form {
		overflow: hidden;
	}
	#section-access input[type="email"] {
		width: 100%;
		max-width: 100%;
		border-radius: 5px 0 0 5px;
		font-size: 12px;
		height: 32px;
		border: 0;
		padding-left: 10px;
		padding-right: 10px;
	}
	.moveNext {
		position: absolute;
	    bottom: 10px;
	    width: 100%;
	    text-align: center;
	}
	.moveNext .icon {
		display: inline-block;
	    color: #FFF;
	    font-size: 72px;
	    line-height: 1;
	    cursor: pointer;
	}
	@media (max-width: 991px) {  
		#section-access .get-access form {
			max-width: 75%;
		}
	}
	@media (max-width: 767px) {  
		#section-access .get-access form {
			max-width: 90%;
		}
		#section-access .wrap-info {
			padding: 0 20px;
		}
	}
	@media (max-width: 480px) {  
		#section-access .get-access form {
			max-width: 100%;
		}
	}
</style>
<div class="section-info" id="section-access">
	<div class="wrap-info">
		<div class="text text-center">
			<h1>
				<span><?php echo $this->translate('we only have one life to live, be faceless...'); ?></span>
				<span class="orange">
					<?php echo $this->translate('LIVE FREE!'); ?>
				</span>
			</h1>
		</div>
		<div class="get-access text-center">
			<form>
				<div class="info-button">
					<button type="submit"><?php echo $this->translate('Get early access'); ?></button>
				</div>
				<div class="info-form">
					<input type="email" placeholder="<?php echo $this->translate('Your Email'); ?>" class="form-control" />
				</div>
			</form>
		</div>
	</div>
	<div class="moveNext">
		<span class="icon" id="accessNext">
			<i class="fa fa-angle-down"></i>
		</span>
	</div>
</div>

<script type="text/javascript">
	window.addEvent('domready', function(){
		var wHeight;
		wHeight = window.innerHeight;
		
		$('section-access').setStyle('height', wHeight);
		
		$('accessNext').addEvent('click', function(){
			var myFx = new Fx.Scroll(window).toElement($('section-intro'), 'y');
		});

		window.onresize = function() {
			wHeight = window.innerHeight;
			$('section-access').setStyle('height', wHeight);
		}
	});
</script>