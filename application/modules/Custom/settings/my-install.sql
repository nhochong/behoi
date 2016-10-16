INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('custom', 'Custom', 'Customization', '4.0.0', 1, 'extra') ;

INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_plugins_custom', 'custom', 'Customs', '', '{"route":"admin_default","module":"custom","controller":"manage"}', 'core_admin_main_plugins', '', '1', '0', '999');

INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'custom_admin_main_manage', 'custom', 'Sliders', '', '{"route":"admin_default","module":"custom","controller":"manage"}', 'custom_admin_main', '', '1', '0', '5');

-- Create engine4_custom_sliders` 
CREATE TABLE `engine4_custom_sliders` (
  `slider_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `links_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`slider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;