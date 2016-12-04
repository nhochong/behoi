<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: view.tpl 9987 2013-03-20 00:58:10Z john $
 * @author     Jung
 */
?>

<?php if( !$this->classified): ?>
<?php echo $this->translate('The classified you are looking for does not exist or has been deleted.');?>
<?php return; // Do no render the rest of the script in this mode
endif; ?>

<script type="text/javascript">
  en4.core.runonce.add(function() {
    // Enable links
    $$('.classified_entrylist_entry_body').enableLinks();
  });
</script>
<div class='layout_middle'>
  <h2>
    <?php echo $this->classified->getTitle(); ?>
    <?php if( $this->classified->closed == 1 ): ?>
      <img src='<?php echo $this->layout()->staticBaseUrl ?>application/modules/Classified/externals/images/close.png' alt="<?php echo $this->translate('Closed') ?>" />
    <?php endif;?>
  </h2>
  <?php echo $this->partial('_category_breadcrumbs.tpl', 'classified', array('categories' => $this->classified->getCategories()));?>
  <ul class='classifieds_entrylist'>
    <li>
      <?php if ($this->classified->closed == 1):?>
        <div class="tip">
          <span>
            <?php echo $this->translate('This classified listing has been closed by the poster.');?>
          </span>
        </div>
      <?php endif; ?>
		<div class="classified_detail_info">
			<div class='classified_thumbs_wrapper'>
				<div class='classified_thumbs'>
					<?php echo $this->htmlImage($this->main_photo->getPhotoUrl(), $this->main_photo->getTitle(), array('id' => 'media_photo', 'alt' => $this->classified->getTitle())); ?>
				</div>
			</div>
			<div class="classified_entrylist_entry_body">
				<?php echo $this->classified->body ?>
			</div>
		</div>
		<?php if(!empty($this->classified->more_info)):?>
		<ul class="qa-further-info">
			<li>
				<h2 class="" id="classfied_detail_exploration">Exploration</h2>
				<div class="text" style="display: none;" id="classfied_detail_exploration_content">
					<?php echo $this->classified->more_info?>
				</div>
			</li>
		</ul>
		<?php endif; ?>
    </li>
  </ul>
</div>

<script type="text/javascript">
  $$('.core_main_classified').getParent().addClass('active');
  if($('classfied_detail_exploration')){
	$('classfied_detail_exploration').addEvent('click', function(){
	  $('classfied_detail_exploration_content').toggle();
	  if($('classfied_detail_exploration').hasClass('active')){
		  $('classfied_detail_exploration').removeClass('active');
	  }else{
		  $('classfied_detail_exploration').addClass('active');
	  }
	});
  }
  if($('classfied_detail_source')){
	$('classfied_detail_source').addEvent('click', function(){
	  $('classfied_detail_source_content').toggle();
	}); 
  }
</script>
