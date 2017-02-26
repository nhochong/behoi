<?php if (!$this->identity) $this->identity = 0; ?>
<?php echo $this->partial('_viewModeChooser.tpl', 'experience', array(
    'identity' => $this->identity,
    'mode_enabled' => $this->mode_enabled
)); ?>
<ul class="experience-mode-views clearfix" id="experience-content-mode-views-<?php echo $this->identity?>">
  <?php 
  	foreach( $this->experiences as $item )
    {
  		if ($item->checkPermission())
		{
			echo $this->partial('_listItem.tpl', 'experience', array('item' => $item, 'type' => 'comment'));
			echo $this->partial('_gridItem.tpl', 'experience', array('item' => $item, 'type' => 'comment'));
		}
	}
  	?>
    <?php if(count($this->experiences) == $this->limit): ?>
        <li>
          <div class="experience-more clearfix">
              <a href="<?php echo $this->url(array(),'default'); ?>experiences/listing/orderby/comment_count" >
                <?php echo $this->translate('View all');?>
              </a>
          </div>
        </li>
    <?php endif; ?>
</ul>


<script type="text/javascript">
  window.addEvent('domready', function(){
      experienceRenderViewMode(<?php echo $this->identity?>, '<?php echo $this->view_mode ?>', <?php echo json_encode($this->mode_enabled) ?>);
  });
</script>