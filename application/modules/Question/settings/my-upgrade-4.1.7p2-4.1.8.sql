UPDATE `engine4_core_mailtemplates` SET `vars` = '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[unsubscribe_link]'
                                    WHERE `type` = 'notify_answer_new' and `module` = 'question';
INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, vars)
                                         VALUES ('notify_answer_new_subs', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[unsubscribe_link]');
INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, vars)
                                         VALUES ('notify_answer_new_comment', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[unsubscribe_link]');
INSERT IGNORE INTO `engine4_activity_notificationtypes` (`type`, `module`, body, is_request, `handler`)
                                                 VALUES ('answer_new_subs', 'question', '{item:$subject} has answered on question {item:$object:$label}', 0, '');
INSERT IGNORE INTO `engine4_activity_notificationtypes` (`type`, `module`, body, is_request, `handler`)
                                                 VALUES ('answer_new_comment', 'question', '{item:$subject} has commented a question {item:$object:$label}', 0, '');

insert IGNORE into `engine4_activity_actiontypes`(`type`,`module`,`body`,`enabled`,`displayable`,`attachable`,`commentable`,`shareable`,`is_generated`)
                                          values ('comment_answer','question','{item:$subject} has commented an answer to the question {item:$object}:',1,5,0,0,0,1);

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'cancel_question' as `name`,
    1 as `value`,
    's:8:"everyone";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'cancel_question' as `name`,
    1 as `value`,
    's:5:"owner";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'cancel_question' as `name`,
    0 as `value`,
    null as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('public');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'reopen_question' as `name`,
    1 as `value`,
    's:8:"everyone";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'reopen_question' as `name`,
    0 as `value`,
    null as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'reopen_question' as `name`,
    0 as `value`,
    null as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('public');

INSERT IGNORE INTO `engine4_core_menus` (`name`, `type`, `title`)
                                 VALUES ('question_main', 'standard', 'Q&A Main Navigation Menu');

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`)
                                     VALUES ('question_main_browse', 'question', 'Browse All', 'Question_Plugin_Menus::canViewQuestions', '{"route":"default","module":"question","controller":"index","action":"index"}', 'question_main', '', 1),
                                            ('question_main_manage', 'question', 'My Questions', 'Question_Plugin_Menus::canCreateQuestions', '{"route":"default","module":"question","controller":"index","action":"manage"}', 'question_main', '', 2),
                                            ('question_main_ratings', 'question', 'Ratings', 'Question_Plugin_Menus::canViewQuestions', '{"route":"default","module":"question","controller":"index","action":"rating"}', 'question_main', '', 3),
                                            ('question_main_create', 'question', 'Ask a Question', 'Question_Plugin_Menus::canCreateQuestions', '{"route":"default","module":"question","controller":"index","action":"create"}', 'question_main', '', 4);

/*Table structure for table `engine4_question_ratings` */

CREATE TABLE `engine4_question_mratings` (
  `mrating_id` int(11) unsigned NOT NULL DEFAULT '0',
  `total_points` int(11) NOT NULL DEFAULT '0',
  `total_questions` int(11) NOT NULL DEFAULT '0',
  `total_answers` int(11) NOT NULL DEFAULT '0',
  `total_best_answers` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mrating_id`),
  CONSTRAINT `FK_engine4_question_mratings` FOREIGN KEY (`mrating_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `engine4_question_subscribers` (
  `subscriber_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `question_id` int(10) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `hash` char(32) NOT NULL,
  UNIQUE KEY `subscriber_id` (`subscriber_id`),
  UNIQUE KEY `hash` (`hash`),
  UNIQUE KEY `user_id` (`user_id`,`question_id`),
  KEY `question_id` (`question_id`),
  KEY `user_id_only` (`user_id`),
  CONSTRAINT `FK_engine4_question_subscribers` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_engine4_question_subscribers_q` FOREIGN KEY (`question_id`) REFERENCES `engine4_question_questions` (`question_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
