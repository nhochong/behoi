<script type="text/javascript">
  var pageAction =function(page){
    $('page').value = page;
    $('experience_filter_form').submit();
  }
</script>
<?php if( $this->paginator->getTotalItemCount() > 0 ): ?>

<div class="experience-choose-view-mode experience-listing-count">
  <div id="experience-total-item-count"><span><?php echo $this->paginator->getTotalItemCount();?></span><?php echo $this->translate(array(" experience", " experiences",$this->paginator->getTotalItemCount()),$this->paginator->getTotalItemCount()) ?></div>
  <div id="experience-view-mode-button-<?php echo $this -> identity;?>" class="experience-modeview-button">
    <span class="experience-btn-list-view" rel="experience_list-view" ><i class="fa fa-th-list"></i></span>
    <span class="experience-btn-grid-view" rel="experience_grid-view" ><i class="fa fa-th"></i></span>
  </div>
</div>

<ul class="experience-mode-views clearfix" id="experience-content-mode-views-<?php echo $this->identity?>">
  <?php foreach ($this->paginator as $item)
  		{
	         if($item->authorization()->isAllowed(null,'view'))
			 {
			 	echo $this->partial('_listItem.tpl', 'experience', array('item' => $item, 'type' => 'view'));
				echo $this->partial('_gridItem.tpl', 'experience', array('item' => $item, 'type' => 'view'));
			 } 
		}?>
  </ul>

<?php elseif( $this->category || $this->tag ): ?>
  <div class="tip">
    <span>
      <?php echo $this->translate('No one has not published any experience entries with that criteria.'); ?>
    </span>
  </div>

<?php else: ?>
  <div class="tip">
    <span>
      <?php echo $this->translate('No one has written any experience entries yet.'); ?>
    </span>
  </div>
<?php endif; ?>

 <?php echo $this->paginationControl($this->paginator, null, null, array(
    'pageAsQuery' => true,
    'query' => $this->formValues,
  )); ?>


<script type="text/javascript">
  window.addEvent('domready', function(){
    renderViewMode<?php echo $this->identity?>();
  });

  function renderViewMode<?php echo $this->identity?>() {
    var myCookieViewMode = getCookie('experience-modeview-<?php echo $this -> identity; ?>');
      if ( myCookieViewMode == '') {
          myCookieViewMode = 'experience_list-view';
      }
      
      $$('#experience-view-mode-button-<?php echo $this -> identity;?> > span[rel='+myCookieViewMode+']').addClass('active');
      $$('#experience-content-mode-views-<?php echo $this->identity ?>').addClass(myCookieViewMode);
      
      // Set click viewMode
      $$('#experience-view-mode-button-<?php echo $this -> identity;?> > span').addEvent('click', function(){
          var viewmode = this.get('rel');
          var content = $('experience-content-mode-views-<?php echo $this->identity?>');

          setCookie('experience-modeview-<?php echo $this -> identity; ?>', viewmode, 1);

          // set class active
          $$('#experience-view-mode-button-<?php echo $this -> identity;?> > span').removeClass('active');
          this.addClass('active');

          content
              .removeClass('experience_list-view')
              .removeClass('experience_grid-view');

          content.addClass( viewmode );
      });
  }
</script>