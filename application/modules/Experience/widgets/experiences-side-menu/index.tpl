<script type="text/javascript">
 <?php if($this->experience):?>
  function become()
  {
     var request = new Request.JSON({
            'method' : 'post',
            'url' :  '<?php echo $this->url(array('action' => 'become'), 'experience_general') ?>',
            'data' : {
                'experience_id' : <?php echo $this->experience->experience_id; ?>

            },
            'onComplete':function(responseObject)
            {
                $('become_count').innerHTML =  <?php echo $this->experience->become_count; ?> +1 ;
                $('btnBecome').innerHTML = "";
            }
        });
        request.send();
  }
  <?php endif;?>
</script>
<div class="experiences_gutter_options" >
  <ul>
      <?php
        /*--- Render the menu ---*/
        echo $this->navigation()
          ->menu()
          ->setContainer($this->gutterNavigation)
          ->setUlClass('navigation')
          ->render();
      ?>
      <?php if($this->experience && $this->viewer->getIdentity() > 0): ?>
          <?php if(Experience_Api_Core::checkUserBecome($this->viewer->getIdentity(),$this->experience->experience_id)): ?>
              <li id="btnBecome">
                  <a class="buttonlink icon_experience_become" onclick="this.disabled=true; become();" href="javascript:;">
                    <?php echo $this->translate('Become Member');?>
                  </a>
              </li>
          <?php endif; ?>
      <?php endif; ?>
  </ul>
</div>

<?php if($this->experience):?>
  <div class="experience_count_member" style="padding:5px 2px 5px 4px;"><span style="font-weight: bold"><?php echo $this->translate('Members');?>:</span> <span id = "become_count"><?php echo $this->experience->become_count?></span> <?php echo $this->translate('member(s)'); ?></div>
<?php $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";?>
<?php $url = $protocol.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']; ?>
 <div style="display: inline; float: left; width: 100%;margin-top:5px;">
        <div class="chartblock chartblock-orange">
            <p><?php echo $this->translate('Shares');?> <span title="<?php echo $this -> translate("Total shares for this time period");?>" class="q ">?</span></p>
            <h4 class=""><?php $shares = Experience_Api_Addthis::widget('shares',$url);  ?></h4>
        </div>
        <div class="chartblock chartblock-blue">
            <p><?php echo $this->translate('Clicks');?> <span title="<?php echo $this -> translate("Total traffic back from shares for this time period");?>" class="q ">?</span></p>
            <h4 class=""><?php $clicks = Experience_Api_Addthis::widget('clicks',$url); ?></h4>
        </div>
        <div class="chartblock chartblock-dark">
            <p><?php echo $this->translate('Viral Lift');?> <span title="<?php echo $this -> translate("Percentage increase in traffic due to shares and clicks");?>" class="q ">?</span></p>
            <h4><?php echo ($shares!=0)?round(($clicks*100)/$shares,2):'0'; ?>%</h4>
        </div>
    </div>

<!-- AddThis Button BEGIN -->
<div>
    <div class="addthis_toolbox addthis_default_style ">
    <a class="addthis_button_preferred_1"></a>
    <a class="addthis_button_preferred_2"></a>
    <a class="addthis_button_preferred_3"></a>
    <a class="addthis_button_preferred_4"></a>
    <a class="addthis_button_compact"></a>
    <a class="addthis_counter addthis_bubble_style"></a>
    </div>
</div>
<script type="text/javascript">var addthis_config = {"data_track_clickback":true};</script>
<script type="text/javascript" src="<?php echo $protocol?>s7.addthis.com/js/250/addthis_widget.js#pubid=<?php echo Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.pubid');?>"></script>
<!-- AddThis Button END -->
<?php endif;?>