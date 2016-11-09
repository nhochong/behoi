<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<ul class="generic_list_widget generic_list_widget_large_photo classifieds_browse">
  <?php foreach( $this->paginator as $item ): ?>
    <li>
      <div class="classifieds_browse_photo">
        <?php echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.icon'), array('class' => 'thumb')) ?>
      </div>
      <div class="classifieds_browse_info">
        <div class="classifieds_browse_info_title">
          <?php echo $this->htmlLink($item->getHref(), $item->getTitle()) ?>
          <?php if( $item->closed ): ?>
            <img src='<?php echo $this->layout()->staticBaseUrl ?>application/modules/Classified/externals/images/close.png' />
          <?php endif ?>
        </div>
	  </div>
    </li>
  <?php endforeach; ?>
</ul>