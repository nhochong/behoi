<script type="text/javascript">
var categoryAction = function(category){
    $('category').value = category;
    $('experience_filter_form').submit();
  }
var tagAction =function(tag){
    $('tag').value = tag;
    $('experience_filter_form').submit();
  }
</script>
<style>
  pre {
    white-space: normal;
  }
</style>

<?php 
   $photoUrl = $this-> experience ->getPhotoUrl();
   if (!$photoUrl)  $photoUrl = $this->baseUrl().'/application/modules/Experience/externals/images/nophoto_experience_thumb_main.png';
?>
<div class="experience-detail-thumb">
  <div class="experience-detail-thumb-bg" style="background-image: url(<?php echo $photoUrl ?>)"></div>

  <div class="experience-detail-thumb-info">
        <?php if( $this->category ): ?>

        <span>
          <a href='<?php echo $this->url(array('user_id'=>$this->experience->owner_id,'category'=>$this->category->category_id,'sort'=>'recent'),'experience_view',true);?>'>
            <?php echo '<i class="fa fa-folder-open"></i>'.$this->translate($this->category->category_name) ?>
          </a>
        </span>
        <?php endif; ?>

      <span>
        <?php echo '<i class="fa fa-eye"></i>'.$this->translate(array('%s view', '%s views', $this->experience->view_count), $this->locale()->toNumber($this->experience->view_count)) ?>
      </span>

      <?php 
        $creation_date = strtotime($this -> experience -> creation_date);
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
        <span>
          <i class="fa fa-clock-o"></i><?php echo $month?> <?php echo $day?>, <?php echo $year?>
        </span>
  </div>
</div>

<div class="experience-detail-title">
  <?php echo $this->experience->getTitle() ?>
</div>

<div class='experience-experience-detail'>

    <div class="experience_entrylist_entry_body rich_content_body">
      <?php echo $this->experience->body ?>
    </div>

    <br/>
    <div class="experience_detail_tags">
      <?php if (count($this->blogTags )):?>
        <i class="fa fa-tags"></i> <?php echo $this->translate('Tags: ') ?>
        <?php foreach ($this->blogTags as $tag): ?>
          <a href='javascript:void(0);' onclick='javascript:tagAction(<?php echo $tag->getTag()->tag_id; ?>);'>#<?php echo $tag->getTag()->text?></a>&nbsp;
        <?php endforeach; ?>
      <?php endif; ?>
    </div>
</div>
<br/>


 <!-- Add-This Button BEGIN -->
<div class="addthis_toolbox addthis_default_style">
   <a class="addthis_button_google_plusone addthis_32x32_style"></a>
   <a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
   <a class="addthis_counter addthis_pill_style"></a>
</div>

<?php $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";?>
 <script type="text/javascript">var addthis_config = {"data_track_clickback":true};</script>
 <script type="text/javascript" src="<?php echo $protocol?>s7.addthis.com/js/250/addthis_widget.js#pubid=<?php echo Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.pubid');?>"></script>
 <!-- Add-This Button END -->
