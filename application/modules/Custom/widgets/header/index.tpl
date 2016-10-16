<style type="text/css">
	.navbar-brand img {
		max-height: 75px;
	}
	.navbar-inverse {
		background-color: rgba(0,0,0,0.3);
		border: 0;
	}
	#navbar .navbar-nav {
		font-size: 16px;
    	margin: 28px 0;
	}
	#navbar .navbar-nav li a {
		color: #FFF;
		text-shadow: 0 1px 1px #333;
	}
	.layout_main .layout_middle {
		padding-top: 0;
	}
    @media (max-width: 1199px) {
    	.container {
    		max-width: 100%!important;
    	}
    }
    @media (max-width: 991px) { 
    	.navbar-collapse.collapse {
    		display: none!important;
    	}
    	.navbar-collapse.collapse.in {
    		display: block!important;
    	}
    	#navbar .navbar-nav {
    		width: 100%;
    		text-align: center;
    	}
    	.navbar-toggle {
    		display: block;
    		margin-top: 35px;
    	}
    	.container>.navbar-header {
    		width: 100%;
    	}
    }
    @media (max-width: 767px) {
    	.generic_layout_container.layout_middle {
    		margin-top: 0;
    	}
    	.navbar-collapse.collapse {
    		background-color: rgba(10,3,2,.72);
    	}
    }
</style>

<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
	            <span class="sr-only">Toggle navigation</span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
          	</button>
          	<a class="navbar-brand">
          		<img src="<?php echo $this->baseUrl(); ?>\application\themes\modern\images\logo.png" alt="Logo"/>
          	</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav pull-right">
				<li>
					<a href ="#">
						<?php echo $this->translate('CANNIBUS CONNECTION');?>
					</a>
				</li>
		     	<li>
		     		<a href ="#">
		     			<?php echo $this->translate('FACELESS THREADS');?>
		     		</a>
		     	</li>
		      	<li>
		      		<a href ="search">
		      			<?php echo $this->translate('SEARCH');?>
		      		</a>
		      	</li>
		      	<li>
		      		<a href ="#">
		      			<?php echo $this->translate('NEW/INFO');?>
		      		</a>
		      	</li>
		     	<li>
		     		<a href ="<?php echo $this->url(array(), 'user_login', true); ?>">
		     			<?php echo $this->translate('LOG IN');?>
		     		</a>
		     	</li>
		      	<li>
		      		<a href ="<?php echo $this->url(array(), 'user_signup', true); ?>">
		      			<?php echo $this->translate('SIGN UP');?>
		      		</a>
		      	</li>
			</ul>
		</div>
	</div>
</nav>

<!--
<div class="main">
	<div class="logo-header">
		<a href="#">
			<img src="<?php echo $this->baseUrl(); ?>\application\themes\modern\images\logo.png" alt="Logo"/>
		</a>
	</div>
	<ul class = "headerlanding" >
	      <li><a href ="#"><?php echo $this->translate('CANNIBUS CONNECTION');?></a></li>
	      <li><a href ="#"><?php echo $this->translate('FACELESS THREADS');?></a></li>
	      <li><a href ="search"><?php echo $this->translate('SEARCH');?></a></li>
	      <li><a href ="#"><?php echo $this->translate('NEW/INFO');?></a></li>
	      <li><a href ="<?php echo $this->url(array(), 'user_login', true); ?>"><?php echo $this->translate('LOG IN');?></a></li>
	      <li><a href ="<?php echo $this->url(array(), 'user_signup', true); ?>"><?php echo $this->translate('SIGN UP');?></a></li>
	</ul>
</div>-->


