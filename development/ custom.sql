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