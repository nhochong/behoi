
<div id='basic-slideshow' class='slideshow'>
	<?php foreach ($this->slides as $slide):?>
		<div class="bgItem" style="background-image: url('<?php echo $slide->getPhotoUrl()?>'); ">
			<div class="information">
				<div class="container">
				    <p class ="title">
				    	<span><?php echo nl2br($slide->getTitle());?></span>
				    </p>
					<p class="description">
	                   	<span><?php echo nl2br($slide->getDescription());?></span>
						<a href="<?php echo $slide->getLinkUrl(); ?>" target="_blank">
					     	<u>LEARN MORE!</u>
					   	</a>
					</p>
				</div>
			</div>
		</div>
	<?php endforeach;?>
</div>
<script type="text/javascript">
	window.addEvent('domready', function(){
		var basic = new SlideShow('basic-slideshow', {
			autoplay: true,
			delay: 5000,
			//transition: 'pushLeft'
		});
	})
</script>
<style type="text/css">
	#basic-slideshow {
		position: relative;
	}
	#basic-slideshow .container {
		position: static;
		line-height: normal;
	}
	#basic-slideshow  .bgItem {
		background-size: cover;
	}
	#basic-slideshow .container > p {
		position: relative;
		font-family: 'Futura_Medium';
	    top: 80%;
	    text-align: left;
	    transform: translateY(-80%);
	    -webkit-transform: translateY(-80%);
	    -moz-transform: translateY(-80%);
	    -ms-transform: translateY(-80%);
	    -o-transform: translateY(-80%);
	}
	#basic-slideshow .container > p.title {
		float: left;
		font-size: 72px;
		max-width: 375px;
		padding: 15px 50px;
		background: url('<?php echo $this->baseUrl(); ?>/application/themes/ynresponsive1/images/custom/chat.png') no-repeat center center transparent;
		background-size: contain;
		line-height: 1;
		text-transform: uppercase;
		height: 240px;
		z-index: 2;
	}
	#basic-slideshow .container > p.description { 
		overflow: hidden;
	    left: -40px;
	    padding: 20px 50px;
	    font-size: 24px;
	    background-color: rgba(10,2,3,.72);
	    min-height: 240px;
	    line-height: 36px;
	}
	#basic-slideshow .container > p.description a {
		color: #6acf4c;
	}
	@media (max-width: 767px) {  
		#basic-slideshow .container > p.title {
			display: none;
		}
		#basic-slideshow .container > p.description { 
			left: 0;
		}	
	}
</style>
