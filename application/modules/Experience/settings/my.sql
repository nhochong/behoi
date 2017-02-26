-- --------------------------------------------------------

--
-- Table structure for table `engine4_experience_becomes`
--
DROP TABLE IF EXISTS `engine4_experience_becomes`;
CREATE TABLE `engine4_experience_becomes` (
  `become_id` int(11) NOT NULL AUTO_INCREMENT,
  `experience_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`become_id`),
  UNIQUE KEY `experience_user` (`experience_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_experience_experiences`;
CREATE TABLE `engine4_experience_experiences` (
  `experience_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `meta_description` longtext COLLATE utf8_unicode_ci,
  `owner_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `pub_date` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link_detail` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `become_count` int(11) NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `draft` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  `add_activity` tinyint(1) NOT NULL DEFAULT '0',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`experience_id`),
  KEY `owner_type` (`owner_type`,`owner_id`),
  KEY `search` (`search`,`creation_date`),
  KEY `owner_id` (`owner_id`,`draft`),
  KEY `draft` (`draft`,`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_experience_categories`;
CREATE TABLE `engine4_experience_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `category_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `meta_description` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`category_id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`,`category_name`),
  KEY `category_name` (`category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `engine4_experience_categories` (`category_id`, `user_id`, `category_name`, `meta_description`) VALUES
(1,	1,	'General',	NULL),
(2,	1,	'Business',	'Các câu hỏi hay nhất về thiên nhiên thời tiết, cây cối, môi trường, nước, đất đai, tài nguyên khoáng sản'),
(3,	1,	'Entertainment',	NULL),
(5,	1,	'Family & Home',	NULL),
(6,	1,	'Health',	NULL),
(7,	1,	'Recreation',	NULL),
(8,	1,	'Personal',	NULL),
(9,	1,	'Shopping',	NULL),
(10,	1,	'Society',	NULL),
(11,	1,	'Sports',	NULL),
(12,	1,	'Technology',	NULL),
(13,	1,	'Other',	NULL);

DROP TABLE IF EXISTS `engine4_experience_links`;
CREATE TABLE `engine4_experience_links` (
  `link_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `link_url` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `cronjob_enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_experience_subscriptions`;
CREATE TABLE `engine4_experience_subscriptions` (
  `subscription_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `subscriber_user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`subscription_id`),
  UNIQUE KEY `user_id` (`user_id`,`subscriber_user_id`),
  KEY `subscriber_user_id` (`subscriber_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Dumping data for table `engine4_core_modules`
--
INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES
('experience', 'Experience', '', '4.09', 1, 'extra');
-- --------------------------------------------------------

--
-- Dumping data for table `engine4_core_tasks`
--
INSERT IGNORE INTO `engine4_core_jobtypes` (`title`, `type`, `module`, `plugin`, `priority`) VALUES
('Rebuild Experience Privacy', 'experience_maintenance_rebuild_privacy', 'experience', 'Experience_Plugin_Job_Maintenance_RebuildPrivacy', 50);
-- --------------------------------------------------------

--
-- Dumping data for table `engine4_core_menus`
--
INSERT IGNORE INTO `engine4_core_menus` (`name`, `type`, `title`) VALUES
('experience_main', 'standard', 'Experience Main Navigation Menu'),
('experience_quick', 'standard', 'Experience Quick Navigation Menu'),
('experience_gutter', 'standard', 'Experience Gutter Navigation Menu');
-- --------------------------------------------------------

--
-- Dumping data for table `engine4_core_menuitems`
--
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_main_experience', 'experience', 'Experiences', '', '{"route":"experience_general"}', 'core_main', '', 4),
('core_sitemap_experience', 'experience', 'Experiences', '', '{"route":"experience_general"}', 'core_sitemap', '', 4),

('experience_main_browse', 'experience', 'Browse Entries', 'Experience_Plugin_Menus::canViewExperiences', '{"route":"experience_general"}', 'experience_main', '', 1),
('experience_main_manage', 'experience', 'My Entries', 'Experience_Plugin_Menus::canCreateExperiences', '{"route":"experience_general","action":"manage"}', 'experience_main', '', 2),
('experience_main_create', 'experience', 'Write New Entry', 'Experience_Plugin_Menus::canCreateExperiences', '{"route":"experience_general","action":"create"}', 'experience_main', '', 3),

('experience_quick_create', 'experience', 'Write New Entry', 'Experience_Plugin_Menus::canCreateExperiences', '{"route":"experience_general","action":"create","class":"buttonlink icon_experience_new"}', 'experience_quick', '', 1),
('experience_quick_style', 'experience', 'Edit Experience Style', 'Experience_Plugin_Menus', '{"route":"experience_general","action":"style","class":"smoothbox buttonlink icon_experience_style"}', 'experience_quick', '', 2),

('experience_gutter_list', 'experience', 'View All Entries', 'Experience_Plugin_Menus', '{"route":"experience_view","class":"buttonlink icon_experience_viewall"}', 'experience_gutter', '', 1),
('experience_gutter_create', 'experience', 'Write New Entry', 'Experience_Plugin_Menus', '{"route":"experience_general","action":"create","class":"buttonlink icon_experience_new"}', 'experience_gutter', '', 2),
('experience_gutter_style', 'experience', 'Edit Experience Style', 'Experience_Plugin_Menus', '{"route":"experience_general","action":"style","class":"smoothbox buttonlink icon_experience_style"}', 'experience_gutter', '', 3),
('experience_gutter_edit', 'experience', 'Edit This Entry', 'Experience_Plugin_Menus', '{"route":"experience_specific","action":"edit","class":"buttonlink icon_experience_edit"}', 'experience_gutter', '', 4),
('experience_gutter_delete', 'experience', 'Delete This Entry', 'Experience_Plugin_Menus', '{"route":"experience_specific","action":"delete","class":"buttonlink smoothbox icon_experience_delete"}', 'experience_gutter', '', 5),
('experience_gutter_share', 'experience', 'Share', 'Experience_Plugin_Menus', '{"route":"default","module":"activity","controller":"index","action":"share","class":"buttonlink smoothbox icon_comments"}', 'experience_gutter', '', 6),
('experience_gutter_report', 'experience', 'Report', 'Experience_Plugin_Menus', '{"route":"default","module":"core","controller":"report","action":"create","class":"buttonlink smoothbox icon_report"}', 'experience_gutter', '', 7),
('experience_gutter_subscribe', 'experience', 'Subscribe', 'Experience_Plugin_Menus', '{"route":"default","module":"experience","controller":"subscription","action":"add","class":"buttonlink smoothbox icon_experience_subscribe"}', 'experience_gutter', '', 8),

('core_admin_main_plugins_experience', 'experience', 'Experiences', '', '{"route":"admin_default","module":"experience","controller":"manage"}', 'core_admin_main_plugins', '', 999),

('experience_admin_main_manage', 'experience', 'Manage Experiences', '', '{"route":"admin_default","module":"experience","controller":"manage"}', 'experience_admin_main', '', 1),
('experience_admin_main_manageurl', 'experience', 'Manage Urls', '', '{"route":"admin_default","module":"experience","controller":"manage","action":"urls"}', 'experience_admin_main', '', 2),
('experience_admin_main_settings', 'experience', 'Global Settings', '', '{"route":"admin_default","module":"experience","controller":"settings"}', 'experience_admin_main', '', 3),
('experience_admin_main_level', 'experience', 'Member Level Settings', '', '{"route":"admin_default","module":"experience","controller":"level"}', 'experience_admin_main', '', 4),
('experience_admin_main_categories', 'experience', 'Categories', '', '{"route":"admin_default","module":"experience","controller":"settings", "action":"categories"}', 'experience_admin_main', '', 5),
('experience_admin_main_addthis', 'experience', 'AddThis Settings', '', '{"route":"admin_default","module":"experience","controller":"addthis"}', 'experience_admin_main', '', 6),

('authorization_admin_level_experience', 'experience', 'Experiences', '', '{"route":"admin_default","module":"experience","controller":"level","action":"index"}', 'authorization_admin_level', '', 999),
('mobi_browse_experience', 'experience', 'Experiences', '', '{"route":"experience_general"}', 'mobi_browse', '', 3);
-- --------------------------------------------------------

DELETE FROM `engine4_core_menuitems` where `name` = 'experience_main_import';

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('experience_main_import', 'experience', 'Import Experiences', 'Experience_Plugin_Menus::canCreateExperiences', '{"route":"experience_import","action":"import"}', 'experience_main', '', 4);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES ('experience_main_export', 'experience', 'Export Experiences', 'Experience_Plugin_Menus::canExportExperiences','{"route":"experience_export","action":"index"}','experience_main','',5);

--
-- Dumping data for table `engine4_activity_actiontypes`
--
INSERT IGNORE INTO `engine4_activity_actiontypes` (`type`, `module`, `body`, `enabled`, `displayable`, `attachable`, `commentable`, `shareable`, `is_generated`) VALUES
('experience_import', 'experience', '{item:$subject} imported a new experience entry:', 1, 5, 1, 3, 1, 1),
('experience_new', 'experience', '{item:$subject} wrote a new experience entry:', 1, 5, 1, 3, 1, 1),
('comment_experience', 'experience', '{item:$subject} commented on {item:$owner}''s {item:$object:experience entry}: {body:$body}', 1, 1, 1, 1, 1, 0),
('like_experience', 'experience', '{item:$subject} liked {item:$owner}''s {item:$object:experience entry}: {body:$body}', 1, 1, 1, 1, 1, 0);
-- --------------------------------------------------------

--
-- Dumping data for table `engine4_activity_notificationtypes`
--

INSERT IGNORE INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`) VALUES
('experience_subscribed_new', 'experience', '{item:$subject} has posted a new experience entry: {item:$object}.', 0, '');
-- --------------------------------------------------------

--
-- Dumping data for table `engine4_core_mailtemplates`
--

INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, `vars`) VALUES
('notify_experience_subscribed_new', 'experience', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]');
-- --------------------------------------------------------

--
-- Dumping data for table `engine4_core_settings`
--
INSERT IGNORE INTO `engine4_core_settings`(`name`,`value`) VALUES
('experience.moderation','0'),
('experience.captcha','0');

INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, `vars`) VALUES
('notify_admin_experience_moderation', 'experience', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]');

-- --------------------------------------------------------

--
-- Dumping data for table `engine4_authorization_permissions`
--

-- ALL
-- auth_view, auth_comment, auth_html
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'auth_view' as `name`,
    5 as `value`,
    '["everyone","owner_network","owner_member_member","owner_member","owner"]' as `params`
  FROM `engine4_authorization_levels` WHERE `type` NOT IN('public');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'auth_comment' as `name`,
    5 as `value`,
    '["everyone","owner_network","owner_member_member","owner_member","owner"]' as `params`
  FROM `engine4_authorization_levels` WHERE `type` NOT IN('public');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'auth_html' as `name`,
    3 as `value`,
    'strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr, iframe' as `params`
  FROM `engine4_authorization_levels` WHERE `type` NOT IN('public');

-- ADMIN, MODERATOR
-- create, delete, edit, view, comment, css, style, max
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'create' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'delete' as `name`,
    2 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'edit' as `name`,
    2 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'view' as `name`,
    2 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'comment' as `name`,
    2 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'style' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'max' as `name`,
    3 as `value`,
    1000 as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');

-- USER
-- create, delete, edit, view, comment, css, style, max
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'create' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'delete' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'edit' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'view' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'comment' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'style' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'max' as `name`,
    3 as `value`,
    50 as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('user');

-- PUBLIC
-- view
INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'experience' as `type`,
    'view' as `name`,
    1 as `value`,
    NULL as `params`
  FROM `engine4_authorization_levels` WHERE `type` IN('public');