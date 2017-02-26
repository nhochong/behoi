<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: terms.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<h2><?php echo $this->translate('Behoi.com') ?></h2>
<div class="aboutus_content">
	<?php echo Engine_Api::_()->getApi('settings', 'core')->getSetting('custom.about_us');?>
</div>