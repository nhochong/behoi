<?php if (count($this->mode_enabled) > 1): ?>
<div class="experience-choose-view-mode">
    <div id="experience-view-mode-button-<?php echo $this -> identity;?>" class="experience-modeview-button">
        <?php if(in_array('list', $this -> mode_enabled)):?>
            <span class="experience-btn-list-view" rel="experience_list-view" ><i class="fa fa-th-list"></i></span>
        <?php endif; ?>
        <?php if(in_array('grid', $this -> mode_enabled)):?>
            <span class="experience-btn-grid-view" rel="experience_grid-view" ><i class="fa fa-th"></i></span>
        <?php endif; ?>
    </div>
</div>
<?php endif; ?>