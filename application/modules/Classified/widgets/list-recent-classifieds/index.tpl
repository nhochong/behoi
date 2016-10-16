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
        <?php echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.normal')) ?>
      </div>
      <div class="classifieds_browse_info">
        <div class="classifieds_browse_info_title icon">
          <?php echo $this->htmlLink($item->getHref(), $item->getTitle()) ?>
          <?php if( $item->closed ): ?>
            <img src='<?php echo $this->layout()->staticBaseUrl ?>application/modules/Classified/externals/images/close.png'/>
          <?php endif ?>
        </div>
		<?php echo $this->partial('_category_breadcrumbs.tpl', 'classified', array('category' => $item->getCategory()));?>
      </div>
      <div class="classifieds_browse_info_blurb">
        <?php $fieldStructure = Engine_Api::_()->fields()->getFieldsStructurePartial($item)?>
        <?php echo $this->fieldValueLoop($item, $fieldStructure) ?>
        <?php echo Engine_Api::_()->classified()->subPhrase($this->string()->stripTags($item->body), 500) ?>
      </div>
    </li>
  <?php endforeach; ?>
</ul>