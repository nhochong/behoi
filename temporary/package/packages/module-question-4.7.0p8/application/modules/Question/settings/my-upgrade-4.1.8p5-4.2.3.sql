ALTER TABLE `engine4_question_questions`     ADD COLUMN `resource_type` VARCHAR(32) NULL AFTER `search`;
ALTER TABLE `engine4_question_questions`     ADD COLUMN `resource_id` INT NULL AFTER `resource_type`;
ALTER TABLE `engine4_question_questions` ADD INDEX `resource_type` (`resource_type`, `resource_id`);
