UPDATE `engine4_core_modules` SET `version` = '4.01p5' WHERE `name` = 'ynlistings';

ALTER TABLE `engine4_ynlistings_listings` ADD `video_type` VARCHAR(64) NULL AFTER `video_id`;