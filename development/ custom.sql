-- Classifield

ALTER TABLE `engine4_classified_categories` ADD `code` varchar(255) DEFAULT NULL AFTER `category_id`;
ALTER TABLE `engine4_classified_categories` ADD `parent_id` int(11) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `engine4_classified_categories` ADD `photo_id` int(11) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `engine4_classified_categories` ADD `is_hot` tinyint(1) NOT NULL DEFAULT '0';

ALTER TABLE `engine4_classified_classifieds` ADD `more_info` longtext DEFAULT NULL AFTER `body`;
ALTER TABLE `engine4_classified_classifieds` ADD `enabled` tinyint(1) DEFAULT 1 AFTER `photo_id`;
UPDATE engine4_classified_classifieds
SET  `enabled` = 0;

ALTER TABLE `engine4_classified_classifieds` MODIFY COLUMN `category_id` varchar(255);

UPDATE `engine4_classified_classifieds`
SET `category_id` = concat('["', `category_id`, '"]');

UPDATE `engine4_core_menuitems`
SET `params` = '{"route":"question_general"}'
WHERE `name` = 'question_main_browse';

UPDATE `engine4_core_menuitems`
SET `params` = '{"route":"question_general","action":"manage"}'
WHERE `name` = 'question_main_manage';

UPDATE `engine4_core_menuitems`
SET `params` = '{"route":"question_general","action":"rating"}'
WHERE `name` = 'question_main_ratings';

UPDATE `engine4_core_menuitems`
SET `params` = '{"route":"question_general","action":"create"}'
WHERE `name` = 'question_main_create';

UPDATE `engine4_core_menuitems`
SET `params` = '{"route":"question_general","action":"unanswered"}'
WHERE `name` = 'question_main_unanswered';

ALTER TABLE  `engine4_album_albums` CHANGE  `type`  `type` ENUM(  'wall',  'profile',  'message',  'blog',  'forum',  'group', 'event',  'question' ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL ;

UPDATE `engine4_core_menuitems`
SET `enabled` = 0
WHERE `name` = 'question_main_ratings';

UPDATE `engine4_core_menuitems`
SET `order` = 2
WHERE `name` = 'question_main_unanswered';

UPDATE `engine4_core_menuitems`
SET `order` = 3
WHERE `name` = 'question_main_manage';

ALTER TABLE `engine4_classified_classifieds` ADD `meta_description` longtext DEFAULT NULL AFTER `more_info`;
ALTER TABLE `engine4_blog_blogs` ADD `meta_description` longtext DEFAULT NULL AFTER `body`;

CREATE TABLE IF NOT EXISTS `engine4_custom_subscribers` (
  `subscriber_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `email` varchar(128) NOT NULL,
  `creation_date` datetime NOT NULL
) ENGINE='InnoDB' COLLATE 'utf8_unicode_ci';

ALTER TABLE `engine4_classified_categories` ADD `meta_description` longtext DEFAULT NULL AFTER `category_name`;
ALTER TABLE `engine4_blog_categories` ADD `meta_description` longtext DEFAULT NULL AFTER `category_name`;

INSERT INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`, `flag_unique`) VALUES
('custom_admin_main_settings', 'custom', 'Settings', '', '{"route":"admin_default","module":"custom","controller":"manage","action":"settings"}', 'custom_admin_main', '', 1, 0, 1, 0);

ALTER TABLE `engine4_question_questions` ADD `modified_date` datetime DEFAULT NULL;
UPDATE `engine4_question_questions`
SET `modified_date` = `creation_date`;

UPDATE `engine4_core_menuitems`
SET `enabled` = 0
WHERE `name` IN ('ultimatenews_main_addnews', 'ultimatenews_main_mynews', 'ultimatenews_main_newsmanagement', 'ultimatenews_main_addfeed', 'ultimatenews_main_myfeeds', 'ultimatenews_main_feedmanagement', 'ultimatenews_main_favoritenews' );