<?php
/**
 * SocialEngine
 *
 * @category   Application_Widget
 * @package    Clock
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>
<div class="statistic_webname">
	<div class="webname"><?php echo $this->translate('Website behoi.com');?></div>
	<div class="description"><?php echo $this->translate('Nơi tổng hợp các câu hỏi cho bé');?></div>
</div>
<div class="statistic_online">
	<div class="statistic_online_user">
		<strong><?php echo ($this->onlineUserCount + $this->guestCount)?></strong>
		<?php echo $this->translate('người đang truy cập');?>
	</div>
	<div class="description"><?php echo $this->translate('(' . $this->onlineUserCount . ' thành viên và ' . $this->guestCount . ' khách)');?></div>
</div>
<div class="statistic_overall">
	<ul class="statistic">
		<li><div class="number"><?php echo $this->number_of_users?></div><div><?php echo $this->translate('thành viên');?></div></li>
		<li><div class="number"><?php echo $this->number_of_classified?></div><div><?php echo $this->translate('chủ đề');?></div></li>
		<li><div class="number"><?php echo $this->number_of_topic?></div><div><?php echo $this->translate('câu hỏi');?></div></li>
		<li><div class="number"><?php echo $this->number_of_reply?></div><div><?php echo $this->translate('câu trả lời');?></div></li>
	</ul>
</div>
