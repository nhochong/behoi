-- Classifield

ALTER TABLE `engine4_classified_categories` ADD `code` varchar(255) DEFAULT NULL AFTER `category_id`;
ALTER TABLE `engine4_classified_categories` ADD `parent_id` int(11) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `engine4_classified_categories` ADD `photo_id` int(11) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `engine4_classified_categories` ADD `is_hot` tinyint(1) NOT NULL DEFAULT '0';

ALTER TABLE `engine4_classified_classifieds` ADD `more_info` longtext DEFAULT NULL AFTER `body`;
