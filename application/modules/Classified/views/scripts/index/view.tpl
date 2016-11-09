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
  <?php echo $this->partial('_category_breadcrumbs.tpl', 'classified', array('category' => $this->classified->getCategory()));?>
  <ul class='classifieds_entrylist'>
    <li>
      <?php if ($this->classified->closed == 1):?>
        <div class="tip">
          <span>
            <?php echo $this->translate('This classified listing has been closed by the poster.');?>
          </span>
        </div>
      <?php endif; ?>
      <div class="classified_entrylist_entry_body">
        <?php echo nl2br($this->classified->body) ?>
      </div>
        <ul class='classified_thumbs'>
          <?php if($this->main_photo):?>
            <li>
              <div class="classifieds_thumbs_description">
                <?php if( '' != $this->main_photo->getDescription() ): ?>
                  <?php echo $this->string()->chunk($this->main_photo->getDescription(), 100) ?>
                <?php endif; ?>
              </div>
              <?php echo $this->htmlImage($this->main_photo->getPhotoUrl(), $this->main_photo->getTitle(), array(
                'id' => 'media_photo'
              )); ?>
            </li>
          <?php endif; ?>

          <?php foreach( $this->paginator as $photo ): ?>
            <?php if($this->classified->photo_id != $photo->file_id):?>
              <li>
                <div class="classifieds_thumbs_description">
                  <?php if( '' != $photo->getDescription() ): ?>
                    <?php echo $this->string()->chunk($photo->getDescription(), 100) ?>
                  <?php endif; ?>
                </div>
                <?php echo $this->htmlImage($photo->getPhotoUrl(), $photo->getTitle(), array(
                  'id' => 'media_photo'
                )); ?>
              </li>
            <?php endif; ?>
          <?php endforeach;?>
        </ul>
		<ul class="qa-further-info">
			<li>
				<h2 class="" id="classfied_detail_exploration">Exploration</h2>
				<div class="text" style="display: none;" id="classfied_detail_exploration_content">
					<?php echo nl2br($this->classified->more_info)?>
				</div>
			</li>
			<li>
				<h2 class="" id="classfied_detail_source">Sources &amp; links</h2>
				<div class="text" style="display: none;" id="classfied_detail_source_content">
					<ul class="source-and-links">
						<li>
							<a class="source-link" href="http://www.madsci.org/posts/archives/2000-09/967827843.Zo.r.html" target="_blank">Onken, Michael. “Re: Do animals have navels?” 1 Sep. 2000. MadSci Network. 24 Oct. 2010</a>
						</li>
						<li>
							<a class="source-link" href="http://www.abc.net.au/science/k2/lint/facts.htm#animals" target="_blank">“Animals and bellybuttons.” Bellybutton Facts ”“ Bellybutton Lint. Australian Broadcasting Corporation: Science. 24 Oct. 2010</a>
						</li>
						<li>
							<a class="source-link" href="http://findarticles.com/p/articles/mi_m0EPG/is_n5_v29/ai_16885936/" target="_blank">"Scarlett, do animals have bellybuttons? - question and answer". Ranger Rick. FindArticles.com. 24 Oct, 2010. </a>
						</li>
					</ul>
				</div>
			</li>
		</ul>
    </li>
  </ul>
</div>

<script type="text/javascript">
  $$('.core_main_classified').getParent().addClass('active');
  $('classfied_detail_exploration').addEvent('click', function(){
	  $('classfied_detail_exploration_content').toggle();
  });
  $('classfied_detail_source').addEvent('click', function(){
	  $('classfied_detail_source_content').toggle();
  });
  
</script>
