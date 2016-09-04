ALTER TABLE `engine4_question_questions` ADD INDEX `creation_date` (`creation_date`);
ALTER TABLE `engine4_question_answers` DROP FOREIGN KEY  `FK_engine4_question_answers`;
ALTER TABLE `engine4_question_questions` CHANGE `question_id` `question_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `engine4_question_answers` CHANGE `question_id` `question_id` INT(11) UNSIGNED NOT NULL;
ALTER TABLE `engine4_question_answers` ADD CONSTRAINT `FK_engine4_question_answers` FOREIGN KEY (`question_id`) REFERENCES `engine4_question_questions` (`question_id`) ON DELETE CASCADE  ON UPDATE CASCADE;

CREATE TABLE `engine4_question_qvotes` (
  `qvote_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `question_id` int(11) unsigned NOT NULL,
  `vote_for` int(11) NOT NULL DEFAULT '0',
  `creation_date` datetime DEFAULT NULL,
  `vote_against` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`qvote_id`),
  UNIQUE KEY `user_question_id` (`user_id`,`question_id`),
  KEY `user_id` (`user_id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `FK_engine4_question_qvotes` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_engine4_question_qvotes_question` FOREIGN KEY (`question_id`) REFERENCES `engine4_question_questions` (`question_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;