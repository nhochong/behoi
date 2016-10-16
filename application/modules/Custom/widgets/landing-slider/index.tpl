<?php
/**
 * SocialEngine
 *
 * @category   Application_Widget
 * @package    Branding
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Charlotte
 */
?>

<?php
$this->headLink()
          ->prependStylesheet($this->baseUrl() . '/application/css.php?request=application/modules/Ynresponsive1/externals/styles/jquery.bxslider.css');
$this->headScript()
        ->appendFile($this->baseUrl() . '/application/modules/Ynresponsive1/externals/scripts/jquery.bxslider.min.js')
;
?>
<div class="bxSlider" >
	<ul class="slides" id="landing-sliders">
		<?php foreach ($this->slides as $slide):?>
			<li><div class="overflow-hidden" style="height:300px"><span style="background-image: url('<?php echo $slide->getPhotoUrl()?>')"></span></div></li>
		<?php endforeach;?>
	</ul>
</div>
<script type="text/javascript">
    jQuery.noConflict();
    en4.core.runonce.add(function(){
        jQuery('#landing-sliders').bxSlider({
            auto: true,
            touchEnabled:false,
			controls: false,
        });
    });
</script>