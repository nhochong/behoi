INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'max_files' as `name`,
    1 as `value`,
    's:1:"2";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` != 'public';

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'max_files' as `name`,
    0 as `value`,
    null as `params`
  FROM `engine4_authorization_levels` WHERE `type` = 'public';

ALTER TABLE `engine4_question_categories`
    ADD COLUMN `order` smallint(6) NOT NULL DEFAULT '999',
    ADD KEY `order` (`order`);


INSERT IGNORE INTO engine4_core_tasks (`title`, `module`, `plugin`, `timeout`)
                               VALUES ('Rebuilt Q&A Users Ratings', 'question', 'Question_Plugin_Task_Maintenance_RebuildRating', 86400);

ALTER TABLE `engine4_question_answers`
    CHANGE `user_id`
                    `user_id` int(11) unsigned NOT NULL;

ALTER TABLE `engine4_question_votes`
    CHANGE `user_id`
                    `user_id` int(11) unsigned NOT NULL;

ALTER TABLE `engine4_question_answers`
    ADD CONSTRAINT `FK_engine4_question_answers_new` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `engine4_question_votes`
    ADD CONSTRAINT `FK_engine4_question_votes` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, vars)
                                         VALUES ('notify_answer_new', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link]');
INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, vars)
                                         VALUES ('notify_choose_best', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link]');

INSERT IGNORE INTO `engine4_activity_notificationtypes` (`type`, `module`, body, is_request, `handler`)
                                                 VALUES ('answer_new', 'question', '{item:$subject} has answered your question {item:$object:$label}', 0, '');
INSERT IGNORE INTO `engine4_activity_notificationtypes` (`type`, `module`, body, is_request, `handler`)
                                                 VALUES ('choose_best', 'question', '{item:$subject} has chosen the best answer to a question {item:$object:$label}', 0, '');

ALTER TABLE `engine4_question_questions`
    ADD COLUMN `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;
