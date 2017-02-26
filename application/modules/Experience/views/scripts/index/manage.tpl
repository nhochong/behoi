<script type="text/javascript">
  var pageAction =function(page){
    $('page').value = page;
    $('experience_filter_form').submit();
  }
</script>

<div class='layout_right'>
  <?php echo $this->form->render($this) ?>

  <?php if( count($this->quickNavigation) > 0 ): ?>
    <div class="experiences_gutter_options" >
      <?php
        /*---- Render the menu ----*/
        echo $this->navigation()
          ->menu()
          ->setContainer($this->quickNavigation)
          ->render();
      ?>
    </div>
  <?php endif; ?>
</div>

<div class='layout_middle'>
  <?php if( $this->paginator->getTotalItemCount() > 0 ): ?>
    

    <ul class="experience-mode-views clearfix" id="experience-my-entries">
      <?php foreach( $this->paginator as $item ): ?>
        <?php 
           $photoUrl = $item -> getPhotoUrl();
           if (!$photoUrl)  $photoUrl = $this->baseUrl().'/application/modules/Experience/externals/images/nophoto_experience_thumb_profile.png';
        ?>
        <li class="experience_listview_mode clearfix">

          <div class="experience-thumb clearfix">
              <?php 
                $creation_date = strtotime($item -> creation_date);
                $oldTz = date_default_timezone_get();
                if($this->viewer() && $this->viewer()->getIdentity())
                {
                   date_default_timezone_set($this -> viewer() -> timezone);
                }
                else 
                {
                   date_default_timezone_set( $this->locale() -> getTimezone());
                }
                $day = date("d", $creation_date); 
                $month = date("M", $creation_date);
                $year = date("Y", $creation_date);
                date_default_timezone_set($oldTz);
             ?>
             <div class="experience-mdy-listview">
                <span class="experience-mdy-day"><?php echo $day?></span>
                <span class="experience-mdy-month"><?php echo $month?></span>
                <span class="experience-mdy-year"><?php echo $year?></span>
             </div>
            <a href="<?php echo $item ->getHref(); ?>" style="width: calc(100% - 70px) ;background-image: url(<?php echo $photoUrl; ?>)">
            </a>
          </div>

          <div class="experience-info">
            <div class="experience-title-desc">
              <div class="experience-title">
                <?php echo $this->htmlLink($item->getHref(), $item->getTitle()) ?>
              </div>

              <div class="experience-description">
                <?php echo strip_tags($item -> body);?>
              </div>
              
            </div>

            <div class="experience-stats">
              <span>
                <i class="fa fa-eye"></i>
                <?php echo $this -> translate(array('%s view', '%s view', $item -> view_count), $this->locale()->toNumber($item->view_count));?>
              </span>

              <?php $status = $item->getStatus();?>
                <span class ="experiences_browse_info_status_<?php echo $status['type'];?> experience_status">
                   <?php echo $this->translate($status['condition']);?>
                </span>
            </div>
          </div>

          <div class='experience_myentries_options'>
            <span>
              <?php
              echo $this->htmlLink(array(
                'route' => 'experience_specific',
                'action' => 'edit',
                'experience_id' => $item->getIdentity(),
                'reset' => true,
              ), '<i class="fa fa-pencil-square-o"></i>'.$this->translate('Edit Entry'), array(
                'class' => 'experience_btn_edit',
              ));?>
            </span>

            <span>
              <?php
              echo $this->htmlLink(array(
                  'route' => 'experience_specific',
                  'action' => 'delete',
                  'experience_id' => $item->getIdentity(),
                  'format' => 'smoothbox'
                  ), '<i class="fa fa-trash"></i>'.$this->translate('Delete Entry'), array(
                'class' => 'smoothbox experience_btn_delete'
              ));?>
            </span>
          </div>



        </li>
      <?php endforeach; ?>
    </ul>


  <?php elseif($this->search): ?>
    <div class="tip">
      <span>
        <?php echo $this->translate('You do not have any experience entries that match your search criteria.');?>
      </span>
    </div>
  <?php else: ?>
    <div class="tip">
      <span>
        <?php echo $this->translate('You do not have any experience entries.');?>
        <?php if( $this->canCreate ): ?>
          <?php echo $this->translate('Get started by %1$swriting%2$s a new entry.', '<a href="'.$this->url(array('action' => 'create'), 'experience_general').'">', '</a>'); ?>
        <?php endif; ?>
      </span>
    </div>
  <?php endif; ?>

  <?php echo $this->paginationControl($this->paginator, null, null, array(
    'pageAsQuery' => true,
    'query' => $this->formValues,
  )); ?>

</div>