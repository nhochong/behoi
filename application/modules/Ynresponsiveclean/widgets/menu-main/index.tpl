<?php
/**
 * SocialEngine
 *
 * @category   Application_Themes
 * @package    Template
 * @copyright  Copyright YouNet Company
 */
?>
<script type="text/javascript">
	en4.core.runonce.add(function(){
		if($('global_search_field')){
			new OverText($('global_search_field'), {
				poll: true,
				pollInterval: 500,
				positionOptions: {
					position: ( en4.orientation == 'rtl' ? 'upperRight' : 'upperLeft' ),
					edge: ( en4.orientation == 'rtl' ? 'upperRight' : 'upperLeft' ),
					offset: {
						x: ( en4.orientation == 'rtl' ? -4 : 4 ),
						y: 2
					}
				}
			});
		}
	});
</script>
<nav class="navbar navbar-default" role="navigation">
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex8-collapse">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
	<div class="ybo_logo">
		<?php
		$title = Engine_Api::_()->getApi('settings', 'core')->getSetting('core_general_site_title', $this->translate('_SITE_TITLE'));
		
		$logo  = $this->logo ?$this->layout()->staticBaseUrl .'application/themes/'.YNRESPONSIVE_ACTIVE.'/images/logo.png': false;
    
		$route = $this->viewer()->getIdentity()
					 ? array('route'=>'user_general', 'action'=>'home')
					 : array('route'=>'default');
		
		echo ($logo)
			 ? $this->htmlLink($route, $this->htmlImage($logo, array('alt'=>$title, 'class' => 'navbar-brand')))
			 : $this->htmlLink($route, $title, array('class' => 'navbar-brand'));
		?>
	</div>
  </div>
  
  <!-- Global search -->
  <div id="global_search_form_container">
	<form id="global_search_form" action="<?php echo $this->url(array('controller' => 'search'), 'default', true) ?>" method="get">
		<input type='text' <?php if($this -> width_searchbox) echo "style='width:".$this -> width_searchbox."'"; ?> class='text suggested' name='query' id='global_search_field' size='20' maxlength='100' alt='<?php echo $this->translate('Search') ?>' placeholder="<?php echo $this->translate('Tìm kiếm sản phẩm / Khuyến mãi')?>" />
		<button class="btn-submit" type="submit">Go</button>
	</form>
  </div>
  
  <!-- Domains -->
  <div class="main__sub_domain">
	<ul>
	  <li class="domain_behoi"><?php echo $this->htmlLink('javascript:void(0);', $this->translate('Bé Hỏi')) ?></li>
	  <li class="domain_khuyenmai"><?php echo $this->htmlLink('javascript:void(0);', $this->translate('Deal Hot')) ?>
	  </li>
	</ul>
  </div>

  <!-- Collect the nav links, forms, and other content for toggling -->
	<div class="collapse navbar-collapse navbar-ex8-collapse">
		<ul class="nav navbar-nav navbar-left">
			<li class="dropdown">
				<a href="<?php echo $this->url(array(), 'classified_general', true) ?>" class="dropdown-toggle"><?php echo $this -> translate("Chủ Đề");?> 
					<span class="glyphicon glyphicon-chevron-down btn-xs"></span>
				</a>
				<ul class="dropdown-menu">
					<?php foreach($this->categories as $category):?>
					<li>
						<?php echo $this->htmlLink($category->getHref(),  $category->getTitle(), array('class' => 'dropdown-toggle', 'data-toggle' => 'dropdown')); ?>
						<?php $childs = $category->getSubCategory();?>
						<?php if(count($childs)):?>
							<ul class="dropdown-menu-level-2">
							<?php foreach($childs as $child):?>
								<li><?php echo $this->htmlLink($child->getHref(),  $child->getTitle()); ?></li>
							<?php endforeach;?>
							</ul>
						<?php endif;?>
					</li>
					<?php endforeach;?>
				</ul>
			</li>
			<li><?php echo $this->htmlLink(array('route' => 'default', 'module' => 'question'), $this->translate('Diễn Đàn')) ?></li>
			<li><?php echo $this->htmlLink(array('route' => 'blog_general'), $this->translate('Tư Vấn')) ?></li>
			<li><?php echo $this->htmlLink('javascript:void(0);', $this->translate('Tags')) ?></li>
			<li><?php echo $this->htmlLink('javascript:void(0);', $this->translate('Đăng Câu Hỏi')) ?></li>
		</ul>
	</div>
  <!-- /.navbar-collapse -->
</nav>