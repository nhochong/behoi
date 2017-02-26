<script type="text/javascript">
  var pageAction =function(page){
    $('page').value = page;
    $('experience_filter_form').submit();
  }
</script>
<?php if ($this->owner): ?>
  <h2>
    <?php echo $this->owner;?>
    <?php echo $this->translate("'s Entries")?>
  </h2>
<?php endif; ?>
<?php if (!$this->identity) $this->identity = 0; ?>
<?php if( $this->paginator->getTotalItemCount() > 0 ): ?>

<div class="experience-choose-view-mode experience-listing-count">
  <div id="experience-total-item-count"><span><?php echo $this->paginator->getTotalItemCount();?></span><?php echo $this->translate(array(" experience", " experiences",$this->paginator->getTotalItemCount()),$this->paginator->getTotalItemCount()) ?></div>
  <?php echo $this->partial('_viewModeChooser.tpl', 'experience', array(
    'identity' => $this->identity,
    'mode_enabled' => $this->mode_enabled
  )); ?>
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
    experienceRenderViewMode(<?php echo $this->identity?>, '<?php echo $this->view_mode ?>', <?php echo json_encode($this->mode_enabled) ?>);
  });
</script>