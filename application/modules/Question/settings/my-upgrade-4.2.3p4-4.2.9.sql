ALTER TABLE `engine4_question_categories` ADD COLUMN `url` VARCHAR(34) NOT NULL AFTER `order`; 
UPDATE `engine4_question_categories` SET `url` = REPLACE (LOWER( `category_name` ), ' ', '_');
ALTER TABLE `engine4_question_categories` ADD UNIQUE `url` (`url`); 

ALTER TABLE `engine4_question_questions` ADD COLUMN `anonymous` TINYINT(1) UNSIGNED DEFAULT '0' NOT NULL AFTER `resource_id`;
ALTER TABLE `engine4_question_questions` ADD INDEX `anonymous` (`anonymous`); 

ALTER TABLE `engine4_question_answers` ADD COLUMN `anonymous` TINYINT(1) UNSIGNED DEFAULT '0' NOT NULL AFTER `creation_date`; 
ALTER TABLE `engine4_question_answers` ADD INDEX `anonymous` (`anonymous`); 

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`)
                                     VALUES ('question_main_unanswered', 'question', 'Unanswered', '', '{"route":"default","module":"question","controller":"index","action":"unanswered"}', 'question_main', '', 5);