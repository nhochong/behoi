INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'answer' as `type`,
    'view' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels`;

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'answer' as `name`,
    1 as `value`,
    'a:2:{i:0;s:8:"everyone";i:1;s:5:"owner";}' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'answer' as `name`,
    1 as `value`,
    's:0:"";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'answer' as `name`,
    1 as `value`,
    'a:1:{i:0;s:8:"everyone";}' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'choose_answer' as `name`,
    1 as `value`,
    'a:2:{i:0;s:8:"everyone";i:1;s:5:"owner";}' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'choose_answer' as `name`,
    1 as `value`,
    'a:1:{i:0;s:5:"owner";}' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'create' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('admin', 'user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'create' as `name`,
    0 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'del_answer' as `name`,
    1 as `value`,
    's:8:"everyone";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('admin', 'moderator');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'del_answer' as `name`,
    1 as `value`,
    's:3:"all";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'edit' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('admin', 'moderator', 'user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'level' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'level' as `name`,
    1 as `value`,
    's:1:"3";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'level' as `name`,
    1 as `value`,
    's:1:"4";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'max_answers' as `name`,
    0 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('admin', 'moderator');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'max_answers' as `name`,
    1 as `value`,
    '3' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'update_ratings' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'view' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels`;

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'del_question' as `name`,
    1 as `value`,
    's:8:"everyone";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'del_question' as `name`,
    1 as `value`,
    's:5:"owner";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'del_question' as `name`,
    0 as `value`,
    null as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('public');

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

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'delcom_question' as `name`,
    1 as `value`,
    's:8:"everyone";' as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'delcom_question' as `name`,
    0 as `value`,
    null as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'delcom_question' as `name`,
    0 as `value`,
    null as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('public');

INSERT IGNORE INTO `engine4_core_menus` (`name`, `type`, `title`) 
                                 VALUES ('question_main', 'standard', 'Q&A Main Navigation Menu');

/*Data for the table `engine4_core_menuitems` */

insert IGNORE into `engine4_core_menuitems`(`name`,`module`,`label`,`plugin`,`params`,`menu`,`submenu`,`custom`,`order`)
		                    values ('core_main_question','question','Questions & Answers','','{\"route\":\"default\",\"module\":\"question\"}','core_main','',0,14),
                                           ('mobi_browse_question','question','Questions & Answers','','{\"route\":\"default\",\"module\":\"question\"}','mobi_browse','',0,999),
		                           ('core_admin_main_plugins_question','question','Questions','','{\"route\":\"admin_default\",\"module\":\"question\",\"controller\":\"settings\"}','core_admin_main_plugins','',0,999),
                                           ('question_admin_main_manage','question','View Questions','','{\"route\":\"admin_default\",\"module\":\"question\",\"controller\":\"manage\"}','question_admin_main','',0,1),
                                           ('question_admin_main_settings','question','Global Settings','','{\"route\":\"admin_default\",\"module\":\"question\",\"controller\":\"settings\"}','question_admin_main','',0,2),
                                           ('question_admin_main_level','question','Member Level Settings','','{\"route\":\"admin_default\",\"module\":\"question\",\"controller\":\"level\"}','question_admin_main','',0,3),
                                           ('question_admin_main_categories','question','Categories','','{\"route\":\"admin_default\",\"module\":\"question\",\"controller\":\"settings\", \"action\":\"categories\"}','question_admin_main','',0,4);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`)
                                     VALUES ('question_main_browse', 'question', 'Browse All', 'Question_Plugin_Menus::canViewQuestions', '{"route":"default","module":"question","controller":"index","action":"index"}', 'question_main', '', 1),
                                            ('question_main_manage', 'question', 'My Questions', 'Question_Plugin_Menus::canCreateQuestions', '{"route":"default","module":"question","controller":"index","action":"manage"}', 'question_main', '', 2),
                                            ('question_main_ratings', 'question', 'Ratings', 'Question_Plugin_Menus::canViewQuestions', '{"route":"default","module":"question","controller":"index","action":"rating"}', 'question_main', '', 3),
                                            ('question_main_create', 'question', 'Ask a Question', 'Question_Plugin_Menus::canCreateQuestions', '{"route":"default","module":"question","controller":"index","action":"create"}', 'question_main', '', 4),
                                            ('question_main_unanswered', 'question', 'Unanswered', '', '{"route":"default","module":"question","controller":"index","action":"unanswered"}', 'question_main', '', 5);

/*Data for the table `engine4_core_modules` */

insert IGNORE into `engine4_core_modules`(`name`,`title`,`description`,`version`,`enabled`,`type`)
                            	  values ('question','Questions & Answers','Questions & Answers Plugin','4.2.9p6',1,'extra');

/*Table structure for table `engine4_question_questions` */

CREATE TABLE `engine4_question_questions` (
  `question_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `question` text COLLATE utf8_bin NOT NULL,
  `creation_date` datetime NOT NULL,
  `best_answer_id` int(11) DEFAULT NULL,
  `status` enum('open','closed','canceled') CHARACTER SET utf8 NOT NULL DEFAULT 'open',
  `question_views` int(11) NOT NULL DEFAULT '0',
  `owner_type` varchar(128) CHARACTER SET utf8 NOT NULL,
  `search` int(1) NOT NULL DEFAULT '1',
  `resource_type` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `anonymous` tinyint(1) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`question_id`),
  UNIQUE KEY `best_answer_id` (`best_answer_id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  KEY `status_id` (`status`),
  KEY `creation_date` (`creation_date`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `anonymous` (`anonymous`),
  CONSTRAINT `FK_engine4_question_questions_user` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `engine4_question_answers` */

CREATE TABLE `engine4_question_answers` (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `question_id` int(11) unsigned NOT NULL,
  `answer` text COLLATE utf8_bin,
  `creation_date` datetime NOT NULL,
  `anonymous` tinyint(1) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`answer_id`),
  KEY `user_id` (`user_id`),
  KEY `answer_question_id` (`question_id`),
  KEY `anonymous` (`anonymous`),
  CONSTRAINT `FK_engine4_question_answers_new` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_engine4_question_answers` FOREIGN KEY (`question_id`) REFERENCES `engine4_question_questions` (`question_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `engine4_question_categories` */

CREATE TABLE `engine4_question_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(128) NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  `url` varchar(34) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `url` (`url`),
  KEY `order` (`order`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO engine4_question_categories (category_name, url) VALUES ('Default Category', 'default_category');

/*Table structure for table `engine4_question_ratings` */

CREATE TABLE `engine4_question_ratings` (
  `rating_id` int(11) unsigned NOT NULL DEFAULT '0',
  `total_points` int(11) NOT NULL DEFAULT '0',
  `total_questions` int(11) NOT NULL DEFAULT '0',
  `total_answers` int(11) NOT NULL DEFAULT '0',
  `total_best_answers` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rating_id`),
  CONSTRAINT `FK_engine4_question_ratings` FOREIGN KEY (`rating_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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

/*Table structure for table `engine4_question_votes` */

CREATE TABLE `engine4_question_votes` (
  `vote_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `answer_id` int(11) DEFAULT NULL,
  `vote_for` int(11) NOT NULL DEFAULT '0',
  `creation_date` datetime DEFAULT NULL,
  `vote_against` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`vote_id`),
  UNIQUE KEY `user_answer_id` (`user_id`,`answer_id`),
  KEY `user_id` (`user_id`),
  KEY `answer_id` (`answer_id`),
  CONSTRAINT `FK_engine4_question_votes` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_engine4_question_answers_votes` FOREIGN KEY (`answer_id`) REFERENCES `engine4_question_answers` (`answer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

ALTER TABLE `engine4_question_questions` ADD CONSTRAINT `FK_engine4_question_questions` FOREIGN KEY (`best_answer_id`) REFERENCES `engine4_question_answers` (`answer_id`) ON DELETE SET NULL  ON UPDATE CASCADE ;

INSERT IGNORE INTO `engine4_core_tasks` (`title`, `module`, `plugin`, `timeout`)
                                 VALUES ('Rebuilt Q&A Users Ratings', 'question', 'Question_Plugin_Task_Maintenance_RebuildRating', 86400);

INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, vars)
                                         VALUES ('notify_answer_new', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[unsubscribe_link]');
INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, vars)
                                         VALUES ('notify_choose_best', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link]');
INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, vars)
                                         VALUES ('notify_answer_new_subs', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[unsubscribe_link]');
INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, vars)
                                         VALUES ('notify_answer_new_comment', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[unsubscribe_link]');

INSERT IGNORE INTO `engine4_activity_notificationtypes` (`type`, `module`, body, is_request, `handler`)
                                                 VALUES ('answer_new', 'question', '{item:$subject} has answered your question {item:$object:$label}', 0, '');
INSERT IGNORE INTO `engine4_activity_notificationtypes` (`type`, `module`, body, is_request, `handler`)
                                                 VALUES ('choose_best', 'question', '{item:$subject} has chosen the best answer to a question {item:$object:$label}', 0, '');
INSERT IGNORE INTO `engine4_activity_notificationtypes` (`type`, `module`, body, is_request, `handler`)
                                                 VALUES ('answer_new_subs', 'question', '{item:$subject} has answered the question {item:$object:$label}', 0, '');
INSERT IGNORE INTO `engine4_activity_notificationtypes` (`type`, `module`, body, is_request, `handler`)
                                                 VALUES ('answer_new_comment', 'question', '{item:$subject} has commented an answer to the question {item:$object:$label}', 0, '');


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

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'auth_view' as `name`,
    1 as `value`,
    'a:6:{i:0;s:8:"everyone";i:1;s:10:"registered";i:2;s:13:"owner_network";i:3;s:19:"owner_member_member";i:4;s:12:"owner_member";i:5;s:5:"owner";}' as `params`
  FROM `engine4_authorization_levels` WHERE `type` NOT IN('public');

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'question' as `type`,
    'auth_answer' as `name`,
    1 as `value`,
    'a:5:{i:0;s:10:"registered";i:1;s:13:"owner_network";i:2;s:19:"owner_member_member";i:3;s:12:"owner_member";i:4;s:5:"owner";}' as `params`
  FROM `engine4_authorization_levels` WHERE `type` NOT IN('public');

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

INSERT IGNORE INTO `engine4_activity_actiontypes`(`type`,`module`,`body`,`enabled`,`displayable`,`attachable`,`commentable`,`shareable`,`is_generated`)
                                          values ('answer_new','question','{item:$subject} answered to {item:$owner}\'s question:',1,5,1,0,0,1),
                                                 ('choose_best','question','{item:$subject} has chosen the best answer to the question:',1,5,1,0,0,1),
                                                 ('question_new','question','{item:$subject} has asked a new question:',1,5,1,0,0,1),
                                                 ('comment_answer','question','{item:$subject} has commented an answer to the question {item:$object}:',1,5,0,0,0,1),
                                                 -- only answer is anonymous
                                                 ('answer_new_a_a','question','Somebody posted an anonymous reply to {item:$owner}\'s question:',1,5,1,0,0,1),
                                                 -- only question is anonymous
                                                 ('answer_new_q_a','question','{item:$subject} answered an anonymous question:',1,5,1,0,0,1),
                                                 -- question && answer are anonymous
                                                 ('answer_new_a_q','question','Somebody posted an anonymous reply to question:',1,5,1,0,0,1);
