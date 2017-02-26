<?php if (!$this->identity) $this->identity = 0; ?>
<?php echo $this->partial('_viewModeChooser.tpl', 'experience', array(
    'identity' => $this->identity,
    'mode_enabled' => $this->mode_enabled
)); ?>
<ul class="experience-mode-views clearfix" id="experience-content-mode-views-<?php echo $this->identity?>">
  <?php foreach ($this->paginator as $item)
  		if ($item->checkPermission())
		{
			echo $this->partial('_listItem.tpl', 'experience', array('item' => $item, 'type' => 'new'));
			echo $this->partial('_gridItem.tpl', 'experience', array('item' => $item, 'type' => 'new'));
		}
   ?>
</ul>

<?php if($this->paginator->getTotalItemCount() > $this->items_per_page):?>
  <?php echo $this->htmlLink($this->url(array('user_id' => Engine_Api::_()->core()->getSubject()->getIdentity()), 'experience_view'), $this->translate('View All Entries'), array('class' => 'buttonlink icon_experience_viewall')) ?>
<?php endif;?>


<script type="text/javascript">
  window.addEvent('domready', function(){
      experienceRenderViewMode(<?php echo $this->identity?>, '<?php echo $this->view_mode ?>', <?php echo json_encode($this->mode_enabled) ?>);
  });
</script>