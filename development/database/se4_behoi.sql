-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 22, 2016 at 09:29 AM
-- Server version: 5.6.14
-- PHP Version: 5.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `se4_behoi`
--

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_actions`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_actions` (
  `action_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `params` text COLLATE utf8_unicode_ci,
  `date` datetime NOT NULL,
  `attachment_count` smallint(3) unsigned NOT NULL DEFAULT '0',
  `comment_count` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `like_count` mediumint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`action_id`),
  KEY `SUBJECT` (`subject_type`,`subject_id`),
  KEY `OBJECT` (`object_type`,`object_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `engine4_activity_actions`
--

INSERT INTO `engine4_activity_actions` (`action_id`, `type`, `subject_type`, `subject_id`, `object_type`, `object_id`, `body`, `params`, `date`, `attachment_count`, `comment_count`, `like_count`) VALUES
(1, 'classified_new', 'user', 1, 'classified', 1, '', '[]', '2016-09-18 09:54:15', 1, 0, 0),
(2, 'classified_new', 'user', 1, 'classified', 2, '', '[]', '2016-09-18 10:54:37', 1, 0, 0),
(3, 'classified_new', 'user', 1, 'classified', 3, '', '[]', '2016-09-18 16:41:15', 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_actionsettings`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_actionsettings` (
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `publish` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_actiontypes`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_actiontypes` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `displayable` tinyint(1) NOT NULL DEFAULT '3',
  `attachable` tinyint(1) NOT NULL DEFAULT '1',
  `commentable` tinyint(1) NOT NULL DEFAULT '1',
  `shareable` tinyint(1) NOT NULL DEFAULT '1',
  `is_generated` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_activity_actiontypes`
--

INSERT INTO `engine4_activity_actiontypes` (`type`, `module`, `body`, `enabled`, `displayable`, `attachable`, `commentable`, `shareable`, `is_generated`) VALUES
('answer_new', 'question', '{item:$subject} answered to {item:$owner}''s question:', 1, 5, 1, 0, 0, 1),
('answer_new_a_a', 'question', 'Somebody posted an anonymous reply to {item:$owner}''s question:', 1, 5, 1, 0, 0, 1),
('answer_new_a_q', 'question', 'Somebody posted an anonymous reply to question:', 1, 5, 1, 0, 0, 1),
('answer_new_q_a', 'question', '{item:$subject} answered an anonymous question:', 1, 5, 1, 0, 0, 1),
('choose_best', 'question', '{item:$subject} has chosen the best answer to the question:', 1, 5, 1, 0, 0, 1),
('classified_new', 'classified', '{item:$subject} posted a new classified listing:', 1, 5, 1, 3, 1, 1),
('comment_answer', 'question', '{item:$subject} has commented an answer to the question {item:$object}:', 1, 5, 0, 0, 0, 1),
('comment_classified', 'classified', '{item:$subject} commented on {item:$owner}''s {item:$object:classified listing}: {body:$body}', 1, 1, 1, 1, 1, 0),
('friends', 'user', '{item:$subject} is now friends with {item:$object}.', 1, 3, 0, 1, 1, 1),
('friends_follow', 'user', '{item:$subject} is now following {item:$object}.', 1, 3, 0, 1, 1, 1),
('login', 'user', '{item:$subject} has signed in.', 0, 1, 0, 1, 1, 1),
('logout', 'user', '{item:$subject} has signed out.', 0, 1, 0, 1, 1, 1),
('network_join', 'network', '{item:$subject} joined the network {item:$object}', 1, 3, 1, 1, 1, 1),
('post', 'user', '{actors:$subject:$object}: {body:$body}', 1, 7, 1, 4, 1, 0),
('post_self', 'user', '{item:$subject} {body:$body}', 1, 5, 1, 4, 1, 0),
('profile_photo_update', 'user', '{item:$subject} has added a new profile photo.', 1, 5, 1, 4, 1, 1),
('question_new', 'question', '{item:$subject} has asked a new question:', 1, 5, 1, 0, 0, 1),
('share', 'activity', '{item:$subject} shared {item:$object}''s {var:$type}. {body:$body}', 1, 5, 1, 1, 0, 1),
('signup', 'user', '{item:$subject} has just signed up. Say hello!', 1, 5, 0, 1, 1, 1),
('status', 'user', '{item:$subject} {body:$body}', 1, 5, 0, 1, 4, 0),
('tagged', 'user', '{item:$subject} tagged {item:$object} in a {var:$label}:', 1, 7, 1, 1, 0, 1),
('ynlistings_listing_create', 'ynlistings', '{item:$subject} add a new listing:', 1, 5, 1, 1, 1, 1),
('ynlistings_listing_transfer', 'ynlistings', '{item:$subject} has became the owner of the listing {item:$object}', 1, 3, 1, 1, 1, 1),
('ynlistings_photo_upload', 'ynlistings', '{item:$subject} added {var:$count} photo(s).', 1, 3, 2, 1, 1, 1),
('ynlistings_review_create', 'ynlistings', '{item:$subject} add a review for the listing {item:$object}', 1, 3, 1, 1, 1, 1),
('ynlistings_topic_create', 'ynlistings', '{item:$subject} posted a new topic:', 1, 3, 1, 1, 1, 1),
('ynlistings_topic_reply', 'ynlistings', '{item:$subject} replied to the topic {body:$body}', 1, 3, 1, 1, 1, 1),
('ynlistings_video_create', 'ynlistings', '{item:$subject} posted a new video:', 1, 3, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_attachments`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_attachments` (
  `attachment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(11) unsigned NOT NULL,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `mode` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`attachment_id`),
  KEY `action_id` (`action_id`),
  KEY `type_id` (`type`,`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `engine4_activity_attachments`
--

INSERT INTO `engine4_activity_attachments` (`attachment_id`, `action_id`, `type`, `id`, `mode`) VALUES
(1, 1, 'classified', 1, 1),
(2, 2, 'classified', 2, 1),
(3, 3, 'classified', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_comments`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_comments` (
  `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `like_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `resource_type` (`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_likes`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_likes` (
  `like_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`like_id`),
  KEY `resource_id` (`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_notifications`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_notifications` (
  `notification_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `mitigated` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `LOOKUP` (`user_id`,`date`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `object` (`object_type`,`object_id`),
  KEY `user_id` (`user_id`,`type`,`mitigated`),
  KEY `user_id_2` (`user_id`,`type`,`read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_notificationsettings`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_notificationsettings` (
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `email` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_notificationtypes`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_notificationtypes` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `is_request` tinyint(1) NOT NULL DEFAULT '0',
  `handler` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `default` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_activity_notificationtypes`
--

INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES
('answer_new', 'question', '{item:$subject} has answered your question {item:$object:$label}', 0, '', 1),
('answer_new_comment', 'question', '{item:$subject} has commented an answer to the question {item:$object:$label}', 0, '', 1),
('answer_new_subs', 'question', '{item:$subject} has answered the question {item:$object:$label}', 0, '', 1),
('choose_best', 'question', '{item:$subject} has chosen the best answer to a question {item:$object:$label}', 0, '', 1),
('commented', 'activity', '{item:$subject} has commented on your {item:$object:$label}.', 0, '', 1),
('commented_commented', 'activity', '{item:$subject} has commented on a {item:$object:$label} you commented on.', 0, '', 1),
('friend_accepted', 'user', 'You and {item:$subject} are now friends.', 0, '', 1),
('friend_follow', 'user', '{item:$subject} is now following you.', 0, '', 1),
('friend_follow_accepted', 'user', 'You are now following {item:$subject}.', 0, '', 1),
('friend_follow_request', 'user', '{item:$subject} has requested to follow you.', 1, 'user.friends.request-follow', 1),
('friend_request', 'user', '{item:$subject} has requested to be your friend.', 1, 'user.friends.request-friend', 1),
('liked', 'activity', '{item:$subject} likes your {item:$object:$label}.', 0, '', 1),
('liked_commented', 'activity', '{item:$subject} has commented on a {item:$object:$label} you liked.', 0, '', 1),
('message_new', 'messages', '{item:$subject} has sent you a {item:$object:message}.', 0, '', 1),
('post_user', 'user', '{item:$subject} has posted on your {item:$object:profile}.', 0, '', 1),
('shared', 'activity', '{item:$subject} has shared your {item:$object:$label}.', 0, '', 1),
('tagged', 'user', '{item:$subject} tagged you in a {item:$object:$label}.', 0, '', 1),
('ynlistings_discussion_reply', 'ynlistings', '{item:$subject} has {item:$object:posted} on a {itemParent:$object::listing topic} you posted on.', 0, '', 1),
('ynlistings_discussion_response', 'ynlistings', '{item:$subject} has {item:$object:posted} on a {itemParent:$object::listing topic} you created.', 0, '', 1),
('ynlistings_listing_add_review', 'ynlistings', 'Your listing {item:$object} has a new review.', 0, '', 1),
('ynlistings_listing_approve', 'ynlistings', 'Your listing {item:$object} has been approved.', 0, '', 1),
('ynlistings_listing_deny', 'ynlistings', 'Your listing {item:$object} has been denied.', 0, '', 1),
('ynlistings_listing_follow', 'ynlistings', '{item:$subject} has create a new {item:$object:listing}.', 0, '', 1),
('ynlistings_listing_follow_owner', 'ynlistings', '{item:$subject} start to follow your listings.', 0, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_stream`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_stream` (
  `target_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `target_id` int(11) unsigned NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `action_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`target_type`,`target_id`,`action_id`),
  KEY `SUBJECT` (`subject_type`,`subject_id`,`action_id`),
  KEY `OBJECT` (`object_type`,`object_id`,`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_activity_stream`
--

INSERT INTO `engine4_activity_stream` (`target_type`, `target_id`, `subject_type`, `subject_id`, `object_type`, `object_id`, `type`, `action_id`) VALUES
('everyone', 0, 'user', 1, 'classified', 1, 'classified_new', 1),
('everyone', 0, 'user', 1, 'classified', 2, 'classified_new', 2),
('everyone', 0, 'user', 1, 'classified', 3, 'classified_new', 3),
('members', 1, 'user', 1, 'classified', 1, 'classified_new', 1),
('members', 1, 'user', 1, 'classified', 2, 'classified_new', 2),
('members', 1, 'user', 1, 'classified', 3, 'classified_new', 3),
('owner', 1, 'user', 1, 'classified', 1, 'classified_new', 1),
('owner', 1, 'user', 1, 'classified', 2, 'classified_new', 2),
('owner', 1, 'user', 1, 'classified', 3, 'classified_new', 3),
('parent', 1, 'user', 1, 'classified', 1, 'classified_new', 1),
('parent', 1, 'user', 1, 'classified', 2, 'classified_new', 2),
('parent', 1, 'user', 1, 'classified', 3, 'classified_new', 3),
('registered', 0, 'user', 1, 'classified', 1, 'classified_new', 1),
('registered', 0, 'user', 1, 'classified', 2, 'classified_new', 2),
('registered', 0, 'user', 1, 'classified', 3, 'classified_new', 3);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_advmenusystem_contents`
--

CREATE TABLE IF NOT EXISTS `engine4_advmenusystem_contents` (
  `content_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL,
  `level` int(1) NOT NULL,
  `photo_id` int(11) NOT NULL,
  `params` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `order` smallint(6) NOT NULL DEFAULT '999',
  `modified_date` datetime NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_advmenusystem_submenus`
--

CREATE TABLE IF NOT EXISTS `engine4_advmenusystem_submenus` (
  `submenu_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL,
  `level` int(1) unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `order` smallint(6) NOT NULL DEFAULT '999',
  `core_menu_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`submenu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_announcement_announcements`
--

CREATE TABLE IF NOT EXISTS `engine4_announcement_announcements` (
  `announcement_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `networks` text COLLATE utf8_unicode_ci,
  `member_levels` text COLLATE utf8_unicode_ci,
  `profile_types` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`announcement_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_authorization_allow`
--

CREATE TABLE IF NOT EXISTS `engine4_authorization_allow` (
  `resource_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `action` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `role` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `role_id` int(11) unsigned NOT NULL DEFAULT '0',
  `value` tinyint(1) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_type`,`resource_id`,`action`,`role`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_authorization_allow`
--

INSERT INTO `engine4_authorization_allow` (`resource_type`, `resource_id`, `action`, `role`, `role_id`, `value`, `params`) VALUES
('classified', 1, 'comment', 'everyone', 0, 1, NULL),
('classified', 1, 'comment', 'owner_member', 0, 1, NULL),
('classified', 1, 'comment', 'owner_member_member', 0, 1, NULL),
('classified', 1, 'comment', 'owner_network', 0, 1, NULL),
('classified', 1, 'comment', 'registered', 0, 1, NULL),
('classified', 1, 'view', 'everyone', 0, 1, NULL),
('classified', 1, 'view', 'owner_member', 0, 1, NULL),
('classified', 1, 'view', 'owner_member_member', 0, 1, NULL),
('classified', 1, 'view', 'owner_network', 0, 1, NULL),
('classified', 1, 'view', 'registered', 0, 1, NULL),
('classified', 2, 'comment', 'everyone', 0, 1, NULL),
('classified', 2, 'comment', 'owner_member', 0, 1, NULL),
('classified', 2, 'comment', 'owner_member_member', 0, 1, NULL),
('classified', 2, 'comment', 'owner_network', 0, 1, NULL),
('classified', 2, 'comment', 'registered', 0, 1, NULL),
('classified', 2, 'view', 'everyone', 0, 1, NULL),
('classified', 2, 'view', 'owner_member', 0, 1, NULL),
('classified', 2, 'view', 'owner_member_member', 0, 1, NULL),
('classified', 2, 'view', 'owner_network', 0, 1, NULL),
('classified', 2, 'view', 'registered', 0, 1, NULL),
('classified', 3, 'comment', 'everyone', 0, 1, NULL),
('classified', 3, 'comment', 'owner_member', 0, 1, NULL),
('classified', 3, 'comment', 'owner_member_member', 0, 1, NULL),
('classified', 3, 'comment', 'owner_network', 0, 1, NULL),
('classified', 3, 'comment', 'registered', 0, 1, NULL),
('classified', 3, 'view', 'everyone', 0, 1, NULL),
('classified', 3, 'view', 'owner_member', 0, 1, NULL),
('classified', 3, 'view', 'owner_member_member', 0, 1, NULL),
('classified', 3, 'view', 'owner_network', 0, 1, NULL),
('classified', 3, 'view', 'registered', 0, 1, NULL),
('user', 1, 'comment', 'everyone', 0, 1, NULL),
('user', 1, 'comment', 'member', 0, 1, NULL),
('user', 1, 'comment', 'network', 0, 1, NULL),
('user', 1, 'comment', 'registered', 0, 1, NULL),
('user', 1, 'view', 'everyone', 0, 1, NULL),
('user', 1, 'view', 'member', 0, 1, NULL),
('user', 1, 'view', 'network', 0, 1, NULL),
('user', 1, 'view', 'registered', 0, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_authorization_levels`
--

CREATE TABLE IF NOT EXISTS `engine4_authorization_levels` (
  `level_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('public','user','moderator','admin') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `flag` enum('default','superadmin','public') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `engine4_authorization_levels`
--

INSERT INTO `engine4_authorization_levels` (`level_id`, `title`, `description`, `type`, `flag`) VALUES
(1, 'Superadmins', 'Users of this level can modify all of your settings and data.  This level cannot be modified or deleted.', 'admin', 'superadmin'),
(2, 'Admins', 'Users of this level have full access to all of your network settings and data.', 'admin', ''),
(3, 'Moderators', 'Users of this level may edit user-side content.', 'moderator', ''),
(4, 'Default Level', 'This is the default user level.  New users are assigned to it automatically.', 'user', 'default'),
(5, 'Public', 'Settings for this level apply to users who have not logged in.', 'public', 'public');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_authorization_permissions`
--

CREATE TABLE IF NOT EXISTS `engine4_authorization_permissions` (
  `level_id` int(11) unsigned NOT NULL,
  `type` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` tinyint(3) NOT NULL DEFAULT '0',
  `params` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`level_id`,`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_authorization_permissions`
--

INSERT INTO `engine4_authorization_permissions` (`level_id`, `type`, `name`, `value`, `params`) VALUES
(1, 'admin', 'view', 1, NULL),
(1, 'announcement', 'create', 1, NULL),
(1, 'announcement', 'delete', 2, NULL),
(1, 'announcement', 'edit', 2, NULL),
(1, 'announcement', 'view', 2, NULL),
(1, 'answer', 'view', 1, NULL),
(1, 'classified', 'auth_comment', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(1, 'classified', 'auth_html', 3, 'strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr'),
(1, 'classified', 'auth_view', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(1, 'classified', 'comment', 2, NULL),
(1, 'classified', 'create', 1, NULL),
(1, 'classified', 'css', 2, NULL),
(1, 'classified', 'delete', 2, NULL),
(1, 'classified', 'edit', 2, NULL),
(1, 'classified', 'max', 0, NULL),
(1, 'classified', 'photo', 1, NULL),
(1, 'classified', 'style', 2, NULL),
(1, 'classified', 'view', 2, NULL),
(1, 'core_link', 'create', 1, NULL),
(1, 'core_link', 'delete', 2, NULL),
(1, 'core_link', 'view', 2, NULL),
(1, 'general', 'activity', 2, NULL),
(1, 'general', 'style', 2, NULL),
(1, 'messages', 'auth', 3, 'friends'),
(1, 'messages', 'create', 1, NULL),
(1, 'messages', 'editor', 3, 'plaintext'),
(1, 'question', 'answer', 1, 'a:2:{i:0;s:8:"everyone";i:1;s:5:"owner";}'),
(1, 'question', 'auth_answer', 1, 'a:5:{i:0;s:10:"registered";i:1;s:13:"owner_network";i:2;s:19:"owner_member_member";i:3;s:12:"owner_member";i:4;s:5:"owner";}'),
(1, 'question', 'auth_view', 1, 'a:6:{i:0;s:8:"everyone";i:1;s:10:"registered";i:2;s:13:"owner_network";i:3;s:19:"owner_member_member";i:4;s:12:"owner_member";i:5;s:5:"owner";}'),
(1, 'question', 'cancel_question', 1, 's:8:"everyone";'),
(1, 'question', 'choose_answer', 1, 'a:2:{i:0;s:8:"everyone";i:1;s:5:"owner";}'),
(1, 'question', 'create', 1, NULL),
(1, 'question', 'delcom_question', 1, 's:8:"everyone";'),
(1, 'question', 'del_answer', 1, 's:8:"everyone";'),
(1, 'question', 'del_question', 1, 's:8:"everyone";'),
(1, 'question', 'edit', 1, NULL),
(1, 'question', 'level', 1, NULL),
(1, 'question', 'max_answers', 0, NULL),
(1, 'question', 'max_files', 1, 's:1:"2";'),
(1, 'question', 'reopen_question', 1, 's:8:"everyone";'),
(1, 'question', 'update_ratings', 1, NULL),
(1, 'question', 'view', 1, NULL),
(1, 'user', 'activity', 1, NULL),
(1, 'user', 'auth_comment', 5, '["everyone","registered","network","member","owner"]'),
(1, 'user', 'auth_view', 5, '["everyone","registered","network","member","owner"]'),
(1, 'user', 'block', 1, NULL),
(1, 'user', 'comment', 2, NULL),
(1, 'user', 'create', 1, NULL),
(1, 'user', 'delete', 2, NULL),
(1, 'user', 'edit', 2, NULL),
(1, 'user', 'search', 1, NULL),
(1, 'user', 'status', 1, NULL),
(1, 'user', 'style', 2, NULL),
(1, 'user', 'username', 2, NULL),
(1, 'user', 'view', 2, NULL),
(1, 'ynlistings_listing', 'add_discussions', 5, '["everyone","registered","network","owner_member","owner"]'),
(1, 'ynlistings_listing', 'add_photos', 5, '["everyone","registered","network","owner_member","owner"]'),
(1, 'ynlistings_listing', 'add_videos', 5, '["everyone","registered","network","owner_member","owner"]'),
(1, 'ynlistings_listing', 'approve', 1, NULL),
(1, 'ynlistings_listing', 'auth_comment', 5, '["everyone","registered","network","owner_member","owner"]'),
(1, 'ynlistings_listing', 'auth_view', 5, '["everyone","registered","network","owner_member","owner"]'),
(1, 'ynlistings_listing', 'comment', 1, NULL),
(1, 'ynlistings_listing', 'create', 1, NULL),
(1, 'ynlistings_listing', 'delete', 2, NULL),
(1, 'ynlistings_listing', 'discussion', 1, NULL),
(1, 'ynlistings_listing', 'edit', 2, NULL),
(1, 'ynlistings_listing', 'export', 1, NULL),
(1, 'ynlistings_listing', 'feature_fee', 3, '100'),
(1, 'ynlistings_listing', 'follow', 1, NULL),
(1, 'ynlistings_listing', 'import', 1, NULL),
(1, 'ynlistings_listing', 'max_listings', 3, '100'),
(1, 'ynlistings_listing', 'print', 1, NULL),
(1, 'ynlistings_listing', 'printing', 5, '["everyone","registered","network","owner_member","owner"]'),
(1, 'ynlistings_listing', 'publish_credit', 1, NULL),
(1, 'ynlistings_listing', 'publish_fee', 3, '10'),
(1, 'ynlistings_listing', 'rate', 1, NULL),
(1, 'ynlistings_listing', 'report', 1, NULL),
(1, 'ynlistings_listing', 'select_theme', 1, NULL),
(1, 'ynlistings_listing', 'share', 1, NULL),
(1, 'ynlistings_listing', 'sharing', 5, '["everyone","registered","network","owner_member","owner"]'),
(1, 'ynlistings_listing', 'upload_photos', 1, NULL),
(1, 'ynlistings_listing', 'upload_videos', 1, NULL),
(1, 'ynlistings_listing', 'view', 1, NULL),
(1, 'ynlistings_listing', 'view_listings', 5, '["everyone","registered","network","owner_member","owner"]'),
(1, 'ynlistings_review', 'delete', 2, NULL),
(1, 'ynlistings_review', 'edit', 2, NULL),
(1, 'ynlistings_review', 'view', 1, NULL),
(2, 'admin', 'view', 1, NULL),
(2, 'announcement', 'create', 1, NULL),
(2, 'announcement', 'delete', 2, NULL),
(2, 'announcement', 'edit', 2, NULL),
(2, 'announcement', 'view', 2, NULL),
(2, 'answer', 'view', 1, NULL),
(2, 'classified', 'auth_comment', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(2, 'classified', 'auth_html', 3, 'strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr'),
(2, 'classified', 'auth_view', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(2, 'classified', 'comment', 2, NULL),
(2, 'classified', 'create', 1, NULL),
(2, 'classified', 'css', 2, NULL),
(2, 'classified', 'delete', 2, NULL),
(2, 'classified', 'edit', 2, NULL),
(2, 'classified', 'max', 3, '1000'),
(2, 'classified', 'photo', 1, NULL),
(2, 'classified', 'style', 2, NULL),
(2, 'classified', 'view', 2, NULL),
(2, 'core_link', 'create', 1, NULL),
(2, 'core_link', 'delete', 2, NULL),
(2, 'core_link', 'view', 2, NULL),
(2, 'general', 'activity', 2, NULL),
(2, 'general', 'style', 2, NULL),
(2, 'messages', 'auth', 3, 'friends'),
(2, 'messages', 'create', 1, NULL),
(2, 'messages', 'editor', 3, 'plaintext'),
(2, 'question', 'answer', 1, 'a:2:{i:0;s:8:"everyone";i:1;s:5:"owner";}'),
(2, 'question', 'auth_answer', 1, 'a:5:{i:0;s:10:"registered";i:1;s:13:"owner_network";i:2;s:19:"owner_member_member";i:3;s:12:"owner_member";i:4;s:5:"owner";}'),
(2, 'question', 'auth_view', 1, 'a:6:{i:0;s:8:"everyone";i:1;s:10:"registered";i:2;s:13:"owner_network";i:3;s:19:"owner_member_member";i:4;s:12:"owner_member";i:5;s:5:"owner";}'),
(2, 'question', 'cancel_question', 1, 's:8:"everyone";'),
(2, 'question', 'choose_answer', 1, 'a:2:{i:0;s:8:"everyone";i:1;s:5:"owner";}'),
(2, 'question', 'create', 1, NULL),
(2, 'question', 'delcom_question', 1, 's:8:"everyone";'),
(2, 'question', 'del_answer', 1, 's:8:"everyone";'),
(2, 'question', 'del_question', 1, 's:8:"everyone";'),
(2, 'question', 'edit', 1, NULL),
(2, 'question', 'level', 1, NULL),
(2, 'question', 'max_answers', 0, NULL),
(2, 'question', 'max_files', 1, 's:1:"2";'),
(2, 'question', 'reopen_question', 1, 's:8:"everyone";'),
(2, 'question', 'update_ratings', 1, NULL),
(2, 'question', 'view', 1, NULL),
(2, 'user', 'activity', 1, NULL),
(2, 'user', 'auth_comment', 5, '["everyone","registered","network","member","owner"]'),
(2, 'user', 'auth_view', 5, '["everyone","registered","network","member","owner"]'),
(2, 'user', 'block', 1, NULL),
(2, 'user', 'comment', 2, NULL),
(2, 'user', 'create', 1, NULL),
(2, 'user', 'delete', 2, NULL),
(2, 'user', 'edit', 2, NULL),
(2, 'user', 'search', 1, NULL),
(2, 'user', 'status', 1, NULL),
(2, 'user', 'style', 2, NULL),
(2, 'user', 'username', 2, NULL),
(2, 'user', 'view', 2, NULL),
(2, 'ynlistings_listing', 'add_discussions', 5, '["everyone","registered","network","owner_member","owner"]'),
(2, 'ynlistings_listing', 'add_photos', 5, '["everyone","registered","network","owner_member","owner"]'),
(2, 'ynlistings_listing', 'add_videos', 5, '["everyone","registered","network","owner_member","owner"]'),
(2, 'ynlistings_listing', 'approve', 1, NULL),
(2, 'ynlistings_listing', 'auth_comment', 5, '["everyone","registered","network","owner_member","owner"]'),
(2, 'ynlistings_listing', 'auth_view', 5, '["everyone","registered","network","owner_member","owner"]'),
(2, 'ynlistings_listing', 'comment', 1, NULL),
(2, 'ynlistings_listing', 'create', 1, NULL),
(2, 'ynlistings_listing', 'delete', 2, NULL),
(2, 'ynlistings_listing', 'discussion', 1, NULL),
(2, 'ynlistings_listing', 'edit', 2, NULL),
(2, 'ynlistings_listing', 'export', 1, NULL),
(2, 'ynlistings_listing', 'feature_fee', 3, '100'),
(2, 'ynlistings_listing', 'follow', 1, NULL),
(2, 'ynlistings_listing', 'import', 1, NULL),
(2, 'ynlistings_listing', 'max_listings', 3, '100'),
(2, 'ynlistings_listing', 'print', 1, NULL),
(2, 'ynlistings_listing', 'printing', 5, '["everyone","registered","network","owner_member","owner"]'),
(2, 'ynlistings_listing', 'publish_credit', 1, NULL),
(2, 'ynlistings_listing', 'publish_fee', 3, '10'),
(2, 'ynlistings_listing', 'rate', 1, NULL),
(2, 'ynlistings_listing', 'report', 1, NULL),
(2, 'ynlistings_listing', 'select_theme', 1, NULL),
(2, 'ynlistings_listing', 'share', 1, NULL),
(2, 'ynlistings_listing', 'sharing', 5, '["everyone","registered","network","owner_member","owner"]'),
(2, 'ynlistings_listing', 'upload_photos', 1, NULL),
(2, 'ynlistings_listing', 'upload_videos', 1, NULL),
(2, 'ynlistings_listing', 'view', 1, NULL),
(2, 'ynlistings_listing', 'view_listings', 5, '["everyone","registered","network","owner_member","owner"]'),
(2, 'ynlistings_review', 'delete', 2, NULL),
(2, 'ynlistings_review', 'edit', 2, NULL),
(2, 'ynlistings_review', 'view', 1, NULL),
(3, 'announcement', 'view', 1, NULL),
(3, 'answer', 'view', 1, NULL),
(3, 'classified', 'auth_comment', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(3, 'classified', 'auth_html', 3, 'strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr'),
(3, 'classified', 'auth_view', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(3, 'classified', 'comment', 2, NULL),
(3, 'classified', 'create', 1, NULL),
(3, 'classified', 'css', 2, NULL),
(3, 'classified', 'delete', 2, NULL),
(3, 'classified', 'edit', 2, NULL),
(3, 'classified', 'max', 3, '1000'),
(3, 'classified', 'photo', 1, NULL),
(3, 'classified', 'style', 2, NULL),
(3, 'classified', 'view', 2, NULL),
(3, 'core_link', 'create', 1, NULL),
(3, 'core_link', 'delete', 2, NULL),
(3, 'core_link', 'view', 2, NULL),
(3, 'general', 'activity', 2, NULL),
(3, 'general', 'style', 2, NULL),
(3, 'messages', 'auth', 3, 'friends'),
(3, 'messages', 'create', 1, NULL),
(3, 'messages', 'editor', 3, 'plaintext'),
(3, 'question', 'answer', 1, 's:0:"";'),
(3, 'question', 'auth_answer', 1, 'a:5:{i:0;s:10:"registered";i:1;s:13:"owner_network";i:2;s:19:"owner_member_member";i:3;s:12:"owner_member";i:4;s:5:"owner";}'),
(3, 'question', 'auth_view', 1, 'a:6:{i:0;s:8:"everyone";i:1;s:10:"registered";i:2;s:13:"owner_network";i:3;s:19:"owner_member_member";i:4;s:12:"owner_member";i:5;s:5:"owner";}'),
(3, 'question', 'cancel_question', 1, 's:8:"everyone";'),
(3, 'question', 'choose_answer', 1, 'a:2:{i:0;s:8:"everyone";i:1;s:5:"owner";}'),
(3, 'question', 'create', 0, NULL),
(3, 'question', 'delcom_question', 1, 's:8:"everyone";'),
(3, 'question', 'del_answer', 1, 's:8:"everyone";'),
(3, 'question', 'del_question', 1, 's:8:"everyone";'),
(3, 'question', 'edit', 1, NULL),
(3, 'question', 'level', 1, 's:1:"3";'),
(3, 'question', 'max_answers', 0, NULL),
(3, 'question', 'max_files', 1, 's:1:"2";'),
(3, 'question', 'reopen_question', 1, 's:8:"everyone";'),
(3, 'question', 'view', 1, NULL),
(3, 'user', 'activity', 1, NULL),
(3, 'user', 'auth_comment', 5, '["everyone","registered","network","member","owner"]'),
(3, 'user', 'auth_view', 5, '["everyone","registered","network","member","owner"]'),
(3, 'user', 'block', 1, NULL),
(3, 'user', 'comment', 2, NULL),
(3, 'user', 'create', 1, NULL),
(3, 'user', 'delete', 2, NULL),
(3, 'user', 'edit', 2, NULL),
(3, 'user', 'search', 1, NULL),
(3, 'user', 'status', 1, NULL),
(3, 'user', 'style', 2, NULL),
(3, 'user', 'username', 2, NULL),
(3, 'user', 'view', 2, NULL),
(3, 'ynlistings_listing', 'add_discussions', 5, '["everyone","registered","network","owner_member","owner"]'),
(3, 'ynlistings_listing', 'add_photos', 5, '["everyone","registered","network","owner_member","owner"]'),
(3, 'ynlistings_listing', 'add_videos', 5, '["everyone","registered","network","owner_member","owner"]'),
(3, 'ynlistings_listing', 'approve', 1, NULL),
(3, 'ynlistings_listing', 'auth_comment', 5, '["everyone","registered","network","owner_member","owner"]'),
(3, 'ynlistings_listing', 'auth_view', 5, '["everyone","registered","network","owner_member","owner"]'),
(3, 'ynlistings_listing', 'comment', 1, NULL),
(3, 'ynlistings_listing', 'create', 1, NULL),
(3, 'ynlistings_listing', 'delete', 2, NULL),
(3, 'ynlistings_listing', 'discussion', 1, NULL),
(3, 'ynlistings_listing', 'edit', 2, NULL),
(3, 'ynlistings_listing', 'export', 1, NULL),
(3, 'ynlistings_listing', 'feature_fee', 3, '100'),
(3, 'ynlistings_listing', 'follow', 1, NULL),
(3, 'ynlistings_listing', 'import', 1, NULL),
(3, 'ynlistings_listing', 'max_listings', 3, '100'),
(3, 'ynlistings_listing', 'print', 1, NULL),
(3, 'ynlistings_listing', 'printing', 5, '["everyone","registered","network","owner_member","owner"]'),
(3, 'ynlistings_listing', 'publish_credit', 1, NULL),
(3, 'ynlistings_listing', 'publish_fee', 3, '10'),
(3, 'ynlistings_listing', 'rate', 1, NULL),
(3, 'ynlistings_listing', 'report', 1, NULL),
(3, 'ynlistings_listing', 'select_theme', 1, NULL),
(3, 'ynlistings_listing', 'share', 1, NULL),
(3, 'ynlistings_listing', 'sharing', 5, '["everyone","registered","network","owner_member","owner"]'),
(3, 'ynlistings_listing', 'upload_photos', 1, NULL),
(3, 'ynlistings_listing', 'upload_videos', 1, NULL),
(3, 'ynlistings_listing', 'view', 1, NULL),
(3, 'ynlistings_listing', 'view_listings', 5, '["everyone","registered","network","owner_member","owner"]'),
(3, 'ynlistings_review', 'delete', 2, NULL),
(3, 'ynlistings_review', 'edit', 2, NULL),
(3, 'ynlistings_review', 'view', 1, NULL),
(4, 'announcement', 'view', 1, NULL),
(4, 'answer', 'view', 1, NULL),
(4, 'classified', 'auth_comment', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(4, 'classified', 'auth_html', 3, 'strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr'),
(4, 'classified', 'auth_view', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(4, 'classified', 'comment', 1, NULL),
(4, 'classified', 'create', 0, NULL),
(4, 'classified', 'css', 1, NULL),
(4, 'classified', 'delete', 1, NULL),
(4, 'classified', 'edit', 1, NULL),
(4, 'classified', 'max', 3, '50'),
(4, 'classified', 'photo', 1, NULL),
(4, 'classified', 'style', 1, NULL),
(4, 'classified', 'view', 1, NULL),
(4, 'core_link', 'create', 1, NULL),
(4, 'core_link', 'delete', 1, NULL),
(4, 'core_link', 'view', 1, NULL),
(4, 'general', 'style', 1, NULL),
(4, 'messages', 'auth', 3, 'friends'),
(4, 'messages', 'create', 1, NULL),
(4, 'messages', 'editor', 3, 'plaintext'),
(4, 'question', 'answer', 1, 'a:1:{i:0;s:8:"everyone";}'),
(4, 'question', 'auth_answer', 1, 'a:5:{i:0;s:10:"registered";i:1;s:13:"owner_network";i:2;s:19:"owner_member_member";i:3;s:12:"owner_member";i:4;s:5:"owner";}'),
(4, 'question', 'auth_view', 1, 'a:6:{i:0;s:8:"everyone";i:1;s:10:"registered";i:2;s:13:"owner_network";i:3;s:19:"owner_member_member";i:4;s:12:"owner_member";i:5;s:5:"owner";}'),
(4, 'question', 'cancel_question', 1, 's:5:"owner";'),
(4, 'question', 'choose_answer', 1, 'a:1:{i:0;s:5:"owner";}'),
(4, 'question', 'create', 1, NULL),
(4, 'question', 'delcom_question', 0, NULL),
(4, 'question', 'del_answer', 1, 's:3:"all";'),
(4, 'question', 'del_question', 1, 's:5:"owner";'),
(4, 'question', 'edit', 1, NULL),
(4, 'question', 'level', 1, 's:1:"4";'),
(4, 'question', 'max_answers', 1, '3'),
(4, 'question', 'max_files', 1, 's:1:"2";'),
(4, 'question', 'reopen_question', 0, NULL),
(4, 'question', 'view', 1, NULL),
(4, 'user', 'auth_comment', 5, '["everyone","registered","network","member","owner"]'),
(4, 'user', 'auth_view', 5, '["everyone","registered","network","member","owner"]'),
(4, 'user', 'block', 1, NULL),
(4, 'user', 'comment', 1, NULL),
(4, 'user', 'create', 1, NULL),
(4, 'user', 'delete', 1, NULL),
(4, 'user', 'edit', 1, NULL),
(4, 'user', 'search', 1, NULL),
(4, 'user', 'status', 1, NULL),
(4, 'user', 'style', 1, NULL),
(4, 'user', 'username', 1, NULL),
(4, 'user', 'view', 1, NULL),
(4, 'ynlistings_listing', 'add_photos', 5, '["everyone","registered","network","owner_member","owner"]'),
(4, 'ynlistings_listing', 'add_videos', 5, '["everyone","registered","network","owner_member","owner"]'),
(4, 'ynlistings_listing', 'approve', 1, NULL),
(4, 'ynlistings_listing', 'auth_view', 5, '["everyone","registered","network","owner_member","owner"]'),
(4, 'ynlistings_listing', 'comment', 1, NULL),
(4, 'ynlistings_listing', 'create', 1, NULL),
(4, 'ynlistings_listing', 'delete', 1, NULL),
(4, 'ynlistings_listing', 'discussion', 1, NULL),
(4, 'ynlistings_listing', 'edit', 1, NULL),
(4, 'ynlistings_listing', 'export', 1, NULL),
(4, 'ynlistings_listing', 'feature_fee', 3, '100'),
(4, 'ynlistings_listing', 'follow', 1, NULL),
(4, 'ynlistings_listing', 'import', 1, NULL),
(4, 'ynlistings_listing', 'max_listings', 3, '100'),
(4, 'ynlistings_listing', 'print', 1, NULL),
(4, 'ynlistings_listing', 'printing', 5, '["everyone","registered","network","owner_member","owner"]'),
(4, 'ynlistings_listing', 'publish_credit', 1, NULL),
(4, 'ynlistings_listing', 'publish_fee', 3, '10'),
(4, 'ynlistings_listing', 'rate', 1, NULL),
(4, 'ynlistings_listing', 'report', 1, NULL),
(4, 'ynlistings_listing', 'select_theme', 1, NULL),
(4, 'ynlistings_listing', 'share', 1, NULL),
(4, 'ynlistings_listing', 'sharing', 5, '["everyone","registered","network","owner_member","owner"]'),
(4, 'ynlistings_listing', 'upload_photos', 1, NULL),
(4, 'ynlistings_listing', 'upload_videos', 1, NULL),
(4, 'ynlistings_listing', 'view', 1, NULL),
(4, 'ynlistings_listing', 'view_listings', 5, '["everyone","registered","network","owner_member","owner"]'),
(4, 'ynlistings_review', 'delete', 1, NULL),
(4, 'ynlistings_review', 'edit', 1, NULL),
(4, 'ynlistings_review', 'view', 1, NULL),
(5, 'announcement', 'view', 1, NULL),
(5, 'answer', 'view', 1, NULL),
(5, 'classified', 'view', 1, NULL),
(5, 'core_link', 'view', 1, NULL),
(5, 'question', 'cancel_question', 0, NULL),
(5, 'question', 'delcom_question', 0, NULL),
(5, 'question', 'del_question', 0, NULL),
(5, 'question', 'max_files', 0, NULL),
(5, 'question', 'reopen_question', 0, NULL),
(5, 'question', 'view', 1, NULL),
(5, 'user', 'view', 1, NULL),
(5, 'ynlistings_listing', 'print', 1, NULL),
(5, 'ynlistings_listing', 'view', 1, NULL),
(5, 'ynlistings_review', 'view', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_classified_albums`
--

CREATE TABLE IF NOT EXISTS `engine4_classified_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `classified_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `collectible_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`album_id`),
  KEY `classified_id` (`classified_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `engine4_classified_albums`
--

INSERT INTO `engine4_classified_albums` (`album_id`, `classified_id`, `title`, `description`, `creation_date`, `modified_date`, `search`, `photo_id`, `view_count`, `comment_count`, `collectible_count`) VALUES
(1, 1, 'Buffet Ăn Không Giới Hạn 60 Món Lẩu Hải Sản, Bò Mỹ Cao Cấp Tại ', '', '2016-09-18 09:54:13', '2016-09-18 09:54:13', 1, 0, 0, 0, 3),
(2, 2, 'Hệ Thống Bánh Chewy Junior - Bánh Sự Kiện/ Sinh Nhật', '', '2016-09-18 10:54:35', '2016-09-18 10:54:35', 1, 0, 0, 0, 1),
(3, 3, 'International Buffet BBQ Tối Thứ 7 Hàng Tuần Tại Tầng 25 Windso', '', '2016-09-18 16:41:12', '2016-09-18 16:41:12', 1, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_classified_categories`
--

CREATE TABLE IF NOT EXISTS `engine4_classified_categories` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `category_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=74 ;

--
-- Dumping data for table `engine4_classified_categories`
--

INSERT INTO `engine4_classified_categories` (`category_id`, `code`, `user_id`, `category_name`, `parent_id`, `photo_id`, `is_hot`) VALUES
(1, 'TN', 1, 'Thiên Nhiên', 0, 0, 1),
(2, 'DV', 1, 'Động Vật', 0, 0, 1),
(3, 'XH', 1, 'Xã Hội', 0, 0, 1),
(4, 'VH', 1, 'Văn Hóa', 0, 0, 0),
(5, 'KH', 1, 'Khoa Học', 0, 0, 0),
(6, 'CN', 1, 'Con Người', 0, 0, 0),
(7, 'AU', 1, 'Ăn Uống', 0, 0, 1),
(8, 'VD', 1, 'Vấn Đề Nghiêm Túc', 0, 0, 0),
(9, 'YT', 1, 'Bé Yêu Thích', 0, 0, 0),
(10, 'TN_TT', 1, 'Thời Tiết', 1, 0, 0),
(11, 'TN_CC', 1, 'Cây Cối', 1, 5, 0),
(12, 'TN_MT', 1, 'Môi Trường', 1, 0, 0),
(13, 'TN_N', 1, 'Nước', 1, 0, 0),
(14, 'TN_DD', 1, 'Đất Đai', 1, 0, 0),
(15, 'TN_TN', 1, 'Tài Nguyên & Khoáng Sản', 1, 1, 0),
(16, 'DV_TC', 1, 'Thú Cưng', 2, 0, 0),
(17, 'DV_C', 1, 'Chim', 2, 0, 0),
(21, 'DV_CT', 1, 'Côn Trùng', 2, 0, 0),
(22, 'DV_DN', 1, 'Động Vật Dưới Nước', 2, 0, 0),
(23, 'DV_VN', 1, 'Động Vật Nhỏ Có Vú ', 2, 0, 0),
(24, 'DV_VL', 1, 'Động Vật Lớn có Vú ', 2, 0, 0),
(25, 'DV_LC', 1, 'Động Vật Lưỡng Cư & Bò Sát', 2, 0, 0),
(26, 'DV_DD', 1, 'Đặc Điểm Động Vật', 2, 0, 0),
(27, 'XH_NN', 1, 'Ngành Nghề', 3, 0, 0),
(28, 'XH_CP', 1, 'Chính Phủ', 3, 0, 0),
(29, 'XH_TG', 1, 'Tôn Giáo', 3, 0, 0),
(30, 'XH_KT', 1, 'Kinh Tế', 3, 0, 0),
(31, 'XH_LS', 1, 'Lịch Sử', 3, 0, 0),
(32, 'XH_TG', 1, 'Thời Gian & Số Học', 3, 0, 0),
(33, 'XH_NN', 1, 'Ngôn Ngữ', 3, 0, 0),
(34, 'XH_LN', 1, 'Lớn Nhất & Cao Nhất & Nhanh Nhất', 3, 0, 0),
(35, 'XH_DN', 1, 'Định Nghĩa', 3, 0, 0),
(36, 'VH_PA', 1, 'Phim Ảnh & Trò Chơi', 4, 0, 0),
(37, 'VH_S', 1, 'Sách', 4, 0, 0),
(38, 'VH_AN', 1, 'Âm Nhạc', 4, 0, 0),
(39, 'VH_NT', 1, 'Nghệ Thuật', 4, 0, 0),
(40, 'VH_NL', 1, 'Ngày Lễ', 4, 0, 0),
(41, 'VH_CN', 1, 'Con Người & Địa Danh', 4, 0, 0),
(42, 'VH_CUX', 1, 'Cách Ứng Xử', 4, 0, 0),
(43, 'KH_NVT', 1, 'Ngoài Vũ Trụ', 5, 0, 0),
(44, 'KH_TD', 1, 'Trái Đất', 5, 0, 0),
(45, 'KH_CNTT', 1, 'Công Nghệ Truyền Thông', 5, 0, 0),
(46, 'KH_GTVT', 1, 'Giao Thông Vận Tải', 5, 0, 0),
(47, 'KH_NL', 1, 'Năng Lượng', 5, 0, 0),
(48, 'KH_XDKT', 1, 'Xây Dựng & Kiến Trúc', 5, 0, 0),
(49, 'KH_SVHN', 1, 'Sự Việc Hằng Ngày', 5, 0, 0),
(50, 'KH_TGHV', 1, 'Thế Giới Hiển Vi', 5, 0, 0),
(51, 'CN_BT', 1, 'Bên Trong Cơ Thể', 6, 0, 0),
(52, 'CN_BN', 1, 'Bên Ngoài Cơ Thể', 6, 0, 0),
(53, 'CN_CN', 1, 'Chức năng Cơ Thể', 6, 0, 0),
(54, 'CN_SK', 1, 'Sức Khỏe', 6, 0, 0),
(55, 'CN_TT', 1, 'Trưởng Thành', 6, 0, 0),
(56, 'AU_TC', 1, 'Trái cây & rau củ', 7, 0, 0),
(57, 'AU_BK', 1, 'Bánh kẹo & đồ ngọt', 7, 0, 0),
(58, 'AU_SD', 1, 'Sữa & Đạm', 7, 0, 0),
(59, 'AU_DD', 1, 'Dinh dưỡng', 7, 0, 0),
(60, 'AU_NG', 1, 'Nguồn gốc thức ăn', 7, 0, 0),
(61, 'VD_BT', 1, 'Chết & Bệnh tật', 8, 0, 0),
(62, 'VD_CT', 1, 'Chiến tranh & Thiên tai', 8, 0, 0),
(63, 'VD_BL', 1, 'Bạo lực & Lạm dụng', 8, 0, 0),
(64, 'VD_CX', 1, 'Cảm xúc', 8, 0, 0),
(65, 'VD_GT', 1, 'Giới tính & quan hệ', 8, 0, 0),
(66, 'VD_GD', 1, 'Gia Đình', 8, 0, 0),
(67, 'VD_AT', 1, 'An toàn', 8, 0, 0),
(68, 'VD_PC', 1, 'Phẩm chất', 8, 0, 0),
(69, 'YT_SN', 1, 'Siêu Nhiên', 9, 0, 0),
(70, 'YT_KL', 1, 'Khủng Long', 9, 0, 0),
(71, 'YT_NV', 1, 'Nhân Vật Đặc Biệt', 9, 0, 0),
(72, 'YT_VT', 1, 'Vũ Trụ', 9, 0, 0),
(73, 'YT_NT', 1, 'Nông Trại', 9, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_classified_classifieds`
--

CREATE TABLE IF NOT EXISTS `engine4_classified_classifieds` (
  `classified_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL,
  `photo_id` int(10) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`classified_id`),
  KEY `owner_id` (`owner_id`),
  KEY `search` (`search`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `engine4_classified_classifieds`
--

INSERT INTO `engine4_classified_classifieds` (`classified_id`, `title`, `body`, `owner_id`, `category_id`, `photo_id`, `creation_date`, `modified_date`, `view_count`, `comment_count`, `search`, `closed`) VALUES
(1, 'Buffet Ăn Không Giới Hạn 60 Món Lẩu Hải Sản, Bò Mỹ Cao Cấp Tại ', '<p>Lu&ocirc;n giữ được hương vị đặc trưng, tự nhi&ecirc;n của m&oacute;n ăn, nguy&ecirc;n liệu th&igrave; v&ocirc; c&ugrave;ng phong ph&uacute;, đa dạng v&agrave; rất hợp cho những buổi li&ecirc;n hoan, tiệc t&ugrave;ng, thế n&ecirc;n c&aacute;c m&oacute;n nướng, lẩu lu&ocirc;n giữ được độ &ldquo;hot&rdquo; trong l&ograve;ng thực kh&aacute;ch bất kể thời gian, kh&ocirc;ng gian. D&ugrave; l&agrave; ai đi nữa th&igrave; cũng kh&oacute; c&oacute; thể k&igrave;m l&ograve;ng trước những miếng thịt nướng ch&iacute;n v&agrave;ng, thơm nức hay nước lẩu n&oacute;ng hổi đậm đ&agrave;, ngon miệng. Thế n&ecirc;n, đừng bỏ lỡ cơ hội được thưởng thức cả 2 m&oacute;n l&agrave;m say m&ecirc; l&ograve;ng người n&agrave;y c&ugrave;ng 1 l&uacute;c trong bữa tiệc Buffet nướng lẩu hải sản, b&ograve; Mỹ cao cấp tại Sườn No.1 m&agrave; Hotdeal mang đến lần n&agrave;y nh&eacute;!</p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://hd1.vinacdn.com/images/uploads/2016/01/07/222680/222680-buffet-nuong-lau-hai-san-bo-my-body%20%283%29.jpg" alt="" width="710" height="473"></p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://hd1.vinacdn.com/images/uploads/2016/01/11/222680-1/222680-buffet-nuong-lau-hai-san-bo-my-body-new%20%2822%29.jpg" alt="" width="650" height="433"></p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://hd1.vinacdn.com/images/uploads/2016/01/11/222680-1/222680-buffet-nuong-lau-hai-san-bo-my-body-new%20%2820%29.jpg" alt="" width="650" height="650"></p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://hd1.vinacdn.com/images/uploads/2016/01/11/222680-1/222680-buffet-nuong-lau-hai-san-bo-my-body-new%20%283%29.jpg" alt="" width="650" height="585"></p>', 1, 59, 9, '2016-09-18 09:54:07', '2016-09-18 09:54:14', 1, 0, 1, 0),
(2, 'Hệ Thống Bánh Chewy Junior - Bánh Sự Kiện/ Sinh Nhật', '<p>V&agrave;o những dịp trọng thể như ng&agrave;y lễ kỷ niệm, ng&agrave;y diễn ra chương tr&igrave;nh, sự kiện của c&aacute; nh&acirc;n hay c&ocirc;ng ty, ch&uacute;ng ta kh&ocirc;ng thể thiếu phần chi&ecirc;u đ&atilde;i thực kh&aacute;ch bằng một &iacute;t b&aacute;nh ngọt d&ugrave;ng l&agrave;m tr&aacute;ng miệng. Sẽ v&ocirc; c&ugrave;ng ấn tượng v&agrave; hấp dẫn, khi bạn c&oacute; trong bữa tiệc trang trọng của m&igrave;nh những chiếc b&aacute;nh kem, hay phần b&aacute;nh d&agrave;nh ri&ecirc;ng cho mỗi người (kh&aacute;ch h&agrave;ng) đến dự tiệc mừng. Kh&ocirc;ng kh&iacute; buổi tiệc sẽ th&ecirc;m phần ngọt ng&agrave;o, ấm c&uacute;ng bởi những hương vị thơm ngon tinh tế, dậy l&ecirc;n ch&uacute;t b&eacute;o ngậy của bơ sữa, chất ngọt lịm của lớp b&aacute;nh xốp mềm. Voucher lần n&agrave;y, Hotdeal mang đến cho bạn cơ hội sở hữu những chiếc B&aacute;nh event, sinh nhật, kỷ niệm, ch&uacute;c mừng, c&aacute;m ơn, tỏ t&igrave;nh , cầu h&ocirc;n, đ&igrave;nh h&ocirc;n, t&acirc;n gia, th&ocirc;i n&ocirc;i, đầy th&aacute;ng..., chỉ với gi&aacute; 69.000 VNĐ (Kh&aacute;ch h&agrave;ng vui l&ograve;ng thanh to&aacute;n th&ecirc;m tiền ch&ecirc;nh lệch nếu sử dụng vượt qu&aacute; gi&aacute; trị voucher)</p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://hd1.vinacdn.com/images/uploads/2016/Thang%208/25/285122/285122-he-thong-banh-chewy-body%20%281%29.jpg" alt="" width="710" height="1017"></p>\r\n<p>&nbsp;</p>\r\n<p>Chewy Junior l&agrave; thương hiệu b&aacute;nh ngọt ra đời tại Singapore, do Mr.Kevin Ong - người c&oacute; hơn 20 năm kinh nghiệm trong ng&agrave;nh thực phẩm s&aacute;ng tạo ra dựa tr&ecirc;n sự kết hợp giữa hai loại b&aacute;nh từ Nhật Bản v&agrave; Mexico. Xuất hiện tại Việt Nam từ năm 2009, thương hiệu b&aacute;nh ngọt Chewy Junior đang chiếm được nhiều sự y&ecirc;u mến từ c&aacute;c thực kh&aacute;ch th&agrave;nh phố Hồ Ch&iacute; Minh, đặc biệt l&agrave; giới trẻ nhờ phong c&aacute;ch mới v&agrave; hương vị lạ của b&aacute;nh.</p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://hd1.vinacdn.com/images/uploads/2016/Thang%208/25/284954-2/285122-body-bs.jpg" alt="" width="710" height="575"></p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://hd1.vinacdn.com/images/uploads/2016/Thang%208/25/285122/285122-he-thong-banh-chewy-body%20%283%29.jpg" alt="" width="710" height="420"></p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://hd1.vinacdn.com/images/uploads/2016/Thang%208/25/285122/285122-he-thong-banh-chewy-body%20%289%29.jpg" alt="" width="710" height="420"></p>', 1, 57, 17, '2016-09-18 10:54:34', '2016-09-18 16:06:57', 8, 0, 1, 0),
(3, 'International Buffet BBQ Tối Thứ 7 Hàng Tuần Tại Tầng 25 Windso', '<p>Thưởng thức tiệc buffet chắc chắn kh&ocirc;ng c&ograve;n qu&aacute; mới mẻ với những thực kh&aacute;ch đam m&ecirc; ăn uống. Nhưng cảm gi&aacute;c được d&ugrave;ng tiệc buffet tr&ecirc;n tầng cao: vừa thưởng thức hương vị của những m&oacute;n ăn ngon, vừa được ngắm nh&igrave;n to&agrave;n cảnh th&agrave;nh phố, tận hưởng kh&iacute; trời m&aacute;t mẻ chắc chắc chắn l&agrave; một trải nghiệm v&ocirc; c&ugrave;ng th&uacute; vị m&agrave; nhiều người chưa c&oacute; được. Thế n&ecirc;n voucher lần n&agrave;y, Hotdeal mang đến bữa tiệc International Buffet BBQ Tối thứ 7 h&agrave;ng tuần tại tầng 25 Windsor Plaza Hotel 5* cho bạn cơ hội được tự m&igrave;nh kh&aacute;m ph&aacute; điều th&uacute; vị đ&oacute;!</p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://hd1.vinacdn.com/images/27-10-2014/buffet%20trua%20wind/101061_body_%20%2831%29.jpg" alt="" width="600" height="367"></p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://hd1.vinacdn.com/images/uploads/2016/Thang%206/11/263610%20bs/view-2-copy.jpg" alt="" width="710" height="473"></p>\r\n<p>&nbsp;</p>\r\n<p>Ấn tượng đầu ti&ecirc;n khi đến với bữa tiệc buffet n&agrave;y ch&iacute;nh l&agrave; cảm gi&aacute;c được đứng tr&ecirc;n &ldquo;đỉnh phố&rdquo; để ngắm nh&igrave;n to&agrave;n cảnh th&agrave;nh phố hiện đại nhất Việt Nam. Tọa lạc tr&ecirc;n tầng 25 kh&aacute;ch sạn Windsor Plaza, Top of the Town mang đến cho thực kh&aacute;ch cảm gi&aacute;c thật phi&ecirc;u l&atilde;ng khi ph&iacute;a tr&ecirc;n l&agrave; bầu trời đầy &aacute;nh sao lung linh, ph&iacute;a dưới l&agrave; phố phường tấp nập, s&aacute;ng lo&aacute;ng &aacute;nh đ&egrave;n đủ m&agrave;u sắc. C&ugrave;ng với đ&oacute; l&agrave; những cơn gi&oacute; thi&ecirc;n nhi&ecirc;n m&aacute;t l&agrave;nh xua tan c&aacute;i n&oacute;ng nực của S&agrave;i G&ograve;n mang đến cảm nhận kh&aacute;c hẳn khi bạn thưởng thức buffet trong ph&ograve;ng m&aacute;y lạnh.</p>', 1, 1, 29, '2016-09-18 16:41:10', '2016-09-18 16:41:12', 3, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_classified_fields_maps`
--

CREATE TABLE IF NOT EXISTS `engine4_classified_fields_maps` (
  `field_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `order` smallint(6) NOT NULL,
  PRIMARY KEY (`field_id`,`option_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_classified_fields_meta`
--

CREATE TABLE IF NOT EXISTS `engine4_classified_fields_meta` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) unsigned NOT NULL,
  `search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `order` smallint(3) unsigned NOT NULL DEFAULT '999',
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `validators` text COLLATE utf8_unicode_ci,
  `filters` text COLLATE utf8_unicode_ci,
  `style` text COLLATE utf8_unicode_ci,
  `error` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_classified_fields_options`
--

CREATE TABLE IF NOT EXISTS `engine4_classified_fields_options` (
  `option_id` int(11) NOT NULL AUTO_INCREMENT,
  `field_id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`option_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_classified_fields_search`
--

CREATE TABLE IF NOT EXISTS `engine4_classified_fields_search` (
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_classified_fields_search`
--

INSERT INTO `engine4_classified_fields_search` (`item_id`) VALUES
(1),
(2),
(3);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_classified_fields_values`
--

CREATE TABLE IF NOT EXISTS `engine4_classified_fields_values` (
  `item_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `index` smallint(3) NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`item_id`,`field_id`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_classified_photos`
--

CREATE TABLE IF NOT EXISTS `engine4_classified_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(11) unsigned NOT NULL,
  `classified_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `collection_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `album_id` (`album_id`),
  KEY `classified_id` (`classified_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=29 ;

--
-- Dumping data for table `engine4_classified_photos`
--

INSERT INTO `engine4_classified_photos` (`photo_id`, `album_id`, `classified_id`, `user_id`, `title`, `description`, `collection_id`, `file_id`, `creation_date`, `modified_date`) VALUES
(1, 1, 1, 1, '', '', 1, 9, '2016-09-18 09:54:14', '2016-09-18 09:54:14'),
(13, 1, 1, 1, '', '', 1, 13, '2016-09-18 09:55:28', '2016-09-18 09:55:28'),
(15, 1, 1, 1, '', '', 1, 15, '2016-09-18 09:55:36', '2016-09-18 09:55:36'),
(16, 2, 2, 1, '', '', 2, 17, '2016-09-18 10:54:36', '2016-09-18 16:06:57'),
(28, 3, 3, 1, '', '', 3, 29, '2016-09-18 16:41:12', '2016-09-18 16:41:12');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_adcampaigns`
--

CREATE TABLE IF NOT EXISTS `engine4_core_adcampaigns` (
  `adcampaign_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `end_settings` tinyint(4) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `limit_view` int(11) unsigned NOT NULL DEFAULT '0',
  `limit_click` int(11) unsigned NOT NULL DEFAULT '0',
  `limit_ctr` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `network` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `level` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`adcampaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_adphotos`
--

CREATE TABLE IF NOT EXISTS `engine4_core_adphotos` (
  `adphoto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`adphoto_id`),
  KEY `ad_id` (`ad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_ads`
--

CREATE TABLE IF NOT EXISTS `engine4_core_ads` (
  `ad_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `ad_campaign` int(11) unsigned NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `media_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `html_code` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ad_id`),
  KEY `ad_campaign` (`ad_campaign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_auth`
--

CREATE TABLE IF NOT EXISTS `engine4_core_auth` (
  `id` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `expires` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`user_id`),
  KEY `expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_bannedemails`
--

CREATE TABLE IF NOT EXISTS `engine4_core_bannedemails` (
  `bannedemail_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedemail_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_bannedips`
--

CREATE TABLE IF NOT EXISTS `engine4_core_bannedips` (
  `bannedip_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start` varbinary(16) NOT NULL,
  `stop` varbinary(16) NOT NULL,
  PRIMARY KEY (`bannedip_id`),
  UNIQUE KEY `start` (`start`,`stop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_bannedusernames`
--

CREATE TABLE IF NOT EXISTS `engine4_core_bannedusernames` (
  `bannedusername_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedusername_id`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_bannedwords`
--

CREATE TABLE IF NOT EXISTS `engine4_core_bannedwords` (
  `bannedword_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_comments`
--

CREATE TABLE IF NOT EXISTS `engine4_core_comments` (
  `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `like_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_content`
--

CREATE TABLE IF NOT EXISTS `engine4_core_content` (
  `content_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'widget',
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `parent_content_id` int(11) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `params` text COLLATE utf8_unicode_ci,
  `attribs` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`content_id`),
  KEY `page_id` (`page_id`,`order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=999 ;

--
-- Dumping data for table `engine4_core_content`
--

INSERT INTO `engine4_core_content` (`content_id`, `page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES
(500, 5, 'container', 'main', NULL, 1, '', NULL),
(510, 5, 'container', 'left', 500, 1, '', NULL),
(511, 5, 'container', 'middle', 500, 3, '', NULL),
(520, 5, 'widget', 'user.profile-photo', 510, 1, '', NULL),
(521, 5, 'widget', 'user.profile-options', 510, 2, '', NULL),
(522, 5, 'widget', 'user.profile-friends-common', 510, 3, '{"title":"Mutual Friends"}', NULL),
(523, 5, 'widget', 'user.profile-info', 510, 4, '{"title":"Member Info"}', NULL),
(530, 5, 'widget', 'user.profile-status', 511, 1, '', NULL),
(531, 5, 'widget', 'core.container-tabs', 511, 2, '{"max":"6"}', NULL),
(540, 5, 'widget', 'activity.feed', 531, 1, '{"title":"Updates"}', NULL),
(541, 5, 'widget', 'user.profile-fields', 531, 2, '{"title":"Info"}', NULL),
(542, 5, 'widget', 'user.profile-friends', 531, 3, '{"title":"Friends","titleCount":true}', NULL),
(546, 5, 'widget', 'core.profile-links', 531, 7, '{"title":"Links","titleCount":true}', NULL),
(547, 6, 'container', 'main', NULL, 1, NULL, NULL),
(548, 6, 'container', 'middle', 547, 2, NULL, NULL),
(549, 6, 'widget', 'core.content', 548, 1, NULL, NULL),
(550, 7, 'container', 'main', NULL, 1, NULL, NULL),
(551, 7, 'container', 'middle', 550, 2, NULL, NULL),
(552, 7, 'widget', 'core.content', 551, 1, NULL, NULL),
(553, 8, 'container', 'main', NULL, 1, NULL, NULL),
(554, 8, 'container', 'middle', 553, 2, NULL, NULL),
(555, 8, 'widget', 'core.content', 554, 1, NULL, NULL),
(556, 9, 'container', 'main', NULL, 1, NULL, NULL),
(557, 9, 'container', 'middle', 556, 1, NULL, NULL),
(558, 9, 'widget', 'core.content', 557, 1, NULL, NULL),
(559, 10, 'container', 'main', NULL, 1, NULL, NULL),
(560, 10, 'container', 'middle', 559, 1, NULL, NULL),
(561, 10, 'widget', 'core.content', 560, 1, NULL, NULL),
(562, 11, 'container', 'main', NULL, 1, NULL, NULL),
(563, 11, 'container', 'middle', 562, 1, NULL, NULL),
(564, 11, 'widget', 'core.content', 563, 1, NULL, NULL),
(565, 12, 'container', 'main', NULL, 1, NULL, NULL),
(566, 12, 'container', 'middle', 565, 1, NULL, NULL),
(567, 12, 'widget', 'core.content', 566, 1, NULL, NULL),
(568, 13, 'container', 'main', NULL, 1, NULL, NULL),
(569, 13, 'container', 'middle', 568, 1, NULL, NULL),
(570, 13, 'widget', 'core.content', 569, 1, NULL, NULL),
(571, 14, 'container', 'top', NULL, 1, NULL, NULL),
(572, 14, 'container', 'main', NULL, 2, NULL, NULL),
(573, 14, 'container', 'middle', 571, 1, NULL, NULL),
(574, 14, 'container', 'middle', 572, 2, NULL, NULL),
(575, 14, 'widget', 'user.settings-menu', 573, 1, NULL, NULL),
(576, 14, 'widget', 'core.content', 574, 1, NULL, NULL),
(577, 15, 'container', 'top', NULL, 1, NULL, NULL),
(578, 15, 'container', 'main', NULL, 2, NULL, NULL),
(579, 15, 'container', 'middle', 577, 1, NULL, NULL),
(580, 15, 'container', 'middle', 578, 2, NULL, NULL),
(581, 15, 'widget', 'user.settings-menu', 579, 1, NULL, NULL),
(582, 15, 'widget', 'core.content', 580, 1, NULL, NULL),
(583, 16, 'container', 'top', NULL, 1, NULL, NULL),
(584, 16, 'container', 'main', NULL, 2, NULL, NULL),
(585, 16, 'container', 'middle', 583, 1, NULL, NULL),
(586, 16, 'container', 'middle', 584, 2, NULL, NULL),
(587, 16, 'widget', 'user.settings-menu', 585, 1, NULL, NULL),
(588, 16, 'widget', 'core.content', 586, 1, NULL, NULL),
(589, 17, 'container', 'top', NULL, 1, NULL, NULL),
(590, 17, 'container', 'main', NULL, 2, NULL, NULL),
(591, 17, 'container', 'middle', 589, 1, NULL, NULL),
(592, 17, 'container', 'middle', 590, 2, NULL, NULL),
(593, 17, 'widget', 'user.settings-menu', 591, 1, NULL, NULL),
(594, 17, 'widget', 'core.content', 592, 1, NULL, NULL),
(595, 18, 'container', 'top', NULL, 1, NULL, NULL),
(596, 18, 'container', 'main', NULL, 2, NULL, NULL),
(597, 18, 'container', 'middle', 595, 1, NULL, NULL),
(598, 18, 'container', 'middle', 596, 2, NULL, NULL),
(599, 18, 'widget', 'user.settings-menu', 597, 1, NULL, NULL),
(600, 18, 'widget', 'core.content', 598, 1, NULL, NULL),
(601, 19, 'container', 'top', NULL, 1, NULL, NULL),
(602, 19, 'container', 'main', NULL, 2, NULL, NULL),
(603, 19, 'container', 'middle', 601, 1, NULL, NULL),
(604, 19, 'container', 'middle', 602, 2, NULL, NULL),
(605, 19, 'widget', 'user.settings-menu', 603, 1, NULL, NULL),
(606, 19, 'widget', 'core.content', 604, 1, NULL, NULL),
(607, 20, 'container', 'top', NULL, 1, NULL, NULL),
(608, 20, 'container', 'main', NULL, 2, NULL, NULL),
(609, 20, 'container', 'middle', 607, 1, NULL, NULL),
(610, 20, 'container', 'middle', 608, 2, NULL, NULL),
(611, 20, 'container', 'left', 608, 1, NULL, NULL),
(612, 20, 'widget', 'user.browse-menu', 609, 1, NULL, NULL),
(613, 20, 'widget', 'core.content', 610, 1, NULL, NULL),
(614, 20, 'widget', 'user.browse-search', 611, 1, NULL, NULL),
(615, 21, 'container', 'main', NULL, 1, NULL, NULL),
(616, 21, 'container', 'middle', 615, 1, NULL, NULL),
(617, 21, 'widget', 'core.content', 616, 1, NULL, NULL),
(618, 22, 'container', 'main', NULL, 1, NULL, NULL),
(619, 22, 'container', 'middle', 618, 1, NULL, NULL),
(620, 22, 'widget', 'core.content', 619, 2, NULL, NULL),
(621, 22, 'widget', 'messages.menu', 619, 1, NULL, NULL),
(622, 23, 'container', 'main', NULL, 1, NULL, NULL),
(623, 23, 'container', 'middle', 622, 1, NULL, NULL),
(624, 23, 'widget', 'core.content', 623, 2, NULL, NULL),
(625, 23, 'widget', 'messages.menu', 623, 1, NULL, NULL),
(626, 24, 'container', 'main', NULL, 1, NULL, NULL),
(627, 24, 'container', 'middle', 626, 1, NULL, NULL),
(628, 24, 'widget', 'core.content', 627, 2, NULL, NULL),
(629, 24, 'widget', 'messages.menu', 627, 1, NULL, NULL),
(630, 25, 'container', 'main', NULL, 1, NULL, NULL),
(631, 25, 'container', 'middle', 630, 1, NULL, NULL),
(632, 25, 'widget', 'core.content', 631, 2, NULL, NULL),
(633, 25, 'widget', 'messages.menu', 631, 1, NULL, NULL),
(634, 26, 'container', 'main', NULL, 1, NULL, NULL),
(635, 26, 'container', 'middle', 634, 1, NULL, NULL),
(636, 26, 'widget', 'core.content', 635, 2, NULL, NULL),
(637, 26, 'widget', 'messages.menu', 635, 1, NULL, NULL),
(725, 1, 'container', 'main', NULL, 2, '[""]', ''),
(727, 1, 'widget', 'ynresponsiveclean.menu-main', 725, 3, '{"logo":"1","title":"","itemCountPerPage":"","name":"ynresponsiveclean.menu-main","nomobile":"0"}', ''),
(728, 2, 'container', 'main', NULL, 2, '[""]', ''),
(729, 2, 'widget', 'advancedhtmlblock', 728, 2, '{"title0":"","lbl_desktop":null,"body":"<div class=\\"layout_ynresponsiveclean_htmlblock_footer\\">\\r\\n<div class=\\"container margin-bottom-20\\">\\r\\n<div class=\\"row\\">\\r\\n<div id=\\"footer-about-company\\" class=\\"col-sm-6\\"><!-- About -->\\r\\n<div class=\\"ybo_headline\\">\\r\\n<h3>About<\\/h3>\\r\\n<\\/div>\\r\\n<p class=\\"margin-bottom-25\\">YouBootstraps is an incredibly beautiful responsive Bootstrap Template for corporate and creative professionals.<br>It works on all major web browsers, tablets and phone. <br> Award winning digital agency. We bring a personal and effective approach to every project we work on, which is why. YouBootstraps is an incredibly beautiful responsive Bootstrap Template for corporate professionals.<\\/p>\\r\\n<\\/div>\\r\\n<!--\\/col-md-4-->\\r\\n<div class=\\"col-sm-6\\"><!-- Monthly Newsletter -->\\r\\n<div class=\\"ybo_headline\\">\\r\\n<h3>Contact Us<\\/h3>\\r\\n<\\/div>\\r\\n<address>Floor 2, Lu Gia Plaza, 70 Lu Gia St., Dist 11 <br> Ho Chi Minh City, Vietnam <br> Phone: +84(0) 8 626-464-88 <br> Fax: +84(0) 8 62646489 <br> Email: <a href=\\"mailto:info@younetco.com\\">younetco.com<\\/a><\\/address><\\/div>\\r\\n<!--\\/span4--><\\/div>\\r\\n<!--\\/row-fluid--><\\/div>\\r\\n<!--\\/container-->\\r\\n<\\/div>","lbl_tablet":null,"tablet":"<div class=\\"layout_ynresponsiveclean_htmlblock_footer\\">\\r\\n<div class=\\"container margin-bottom-20\\">\\r\\n<div class=\\"row\\">\\r\\n<div id=\\"footer-about-company\\" class=\\"col-sm-6\\"><!-- About -->\\r\\n<div class=\\"ybo_headline\\">\\r\\n<h3>About<\\/h3>\\r\\n<\\/div>\\r\\n<p class=\\"margin-bottom-25\\">YouBootstraps is an incredibly beautiful responsive Bootstrap Template for corporate and creative professionals.<br>It works on all major web browsers, tablets and phone. <br> Award winning digital agency. We bring a personal and effective approach to every project we work on, which is why. YouBootstraps is an incredibly beautiful responsive Bootstrap Template for corporate professionals.<\\/p>\\r\\n<\\/div>\\r\\n<!--\\/col-md-4-->\\r\\n<div class=\\"col-sm-6\\"><!-- Monthly Newsletter -->\\r\\n<div class=\\"ybo_headline\\">\\r\\n<h3>Contact Us<\\/h3>\\r\\n<\\/div>\\r\\n<address>Floor 2, Lu Gia Plaza, 70 Lu Gia St., Dist 11 <br> Ho Chi Minh City, Vietnam <br> Phone: +84(0) 8 626-464-88 <br> Fax: +84(0) 8 62646489 <br> Email: <a href=\\"mailto:info@younetco.com\\">younetco.com<\\/a><\\/address><\\/div>\\r\\n<!--\\/span4--><\\/div>\\r\\n<!--\\/row-fluid--><\\/div>\\r\\n<!--\\/container-->\\r\\n<\\/div>","lbl_mobile":null,"mobile":"<div class=\\"layout_ynresponsiveclean_htmlblock_footer\\">\\r\\n<div class=\\"container margin-bottom-20\\">\\r\\n<div class=\\"row\\">\\r\\n<div id=\\"footer-about-company\\" class=\\"col-sm-6\\"><!-- About -->\\r\\n<div class=\\"ybo_headline\\">\\r\\n<h3>About<\\/h3>\\r\\n<\\/div>\\r\\n<p class=\\"margin-bottom-25\\">YouBootstraps is an incredibly beautiful responsive Bootstrap Template for corporate and creative professionals.<br>It works on all major web browsers, tablets and phone. <br> Award winning digital agency. We bring a personal and effective approach to every project we work on, which is why. YouBootstraps is an incredibly beautiful responsive Bootstrap Template for corporate professionals.<\\/p>\\r\\n<\\/div>\\r\\n<!--\\/col-md-4-->\\r\\n<div class=\\"col-sm-6\\"><!-- Monthly Newsletter -->\\r\\n<div class=\\"ybo_headline\\">\\r\\n<h3>Contact Us<\\/h3>\\r\\n<\\/div>\\r\\n<address>Floor 2, Lu Gia Plaza, 70 Lu Gia St., Dist 11 <br> Ho Chi Minh City, Vietnam <br> Phone: +84(0) 8 626-464-88 <br> Fax: +84(0) 8 62646489 <br> Email: <a href=\\"mailto:info@younetco.com\\">younetco.com<\\/a><\\/address><\\/div>\\r\\n<!--\\/span4--><\\/div>\\r\\n<!--\\/row-fluid--><\\/div>\\r\\n<!--\\/container-->\\r\\n<\\/div>","name":"advancedhtmlblock","nomobile":"0"}', ''),
(730, 2, 'widget', 'ynresponsiveclean.menu-footer', 728, 3, '["[]"]', ''),
(731, 3, 'container', 'main', NULL, 2, '[""]', ''),
(732, 3, 'container', 'middle', 731, 6, '[""]', ''),
(738, 4, 'container', 'main', NULL, 2, '[""]', ''),
(739, 4, 'container', 'left', 738, 4, '[""]', ''),
(740, 4, 'widget', 'user.home-photo', 739, 3, '[""]', ''),
(741, 4, 'widget', 'user.home-links', 739, 4, '[""]', ''),
(742, 4, 'widget', 'user.list-online', 739, 5, '{"title":"%s Members Online"}', ''),
(743, 4, 'widget', 'core.statistics', 739, 6, '{"title":"Statistics"}', ''),
(744, 4, 'container', 'right', 738, 5, '[""]', ''),
(745, 4, 'widget', 'activity.list-requests', 744, 11, '{"title":"Requests"}', ''),
(746, 4, 'widget', 'user.list-signups', 744, 12, '{"title":"Newest Members"}', ''),
(747, 4, 'widget', 'user.list-popular', 744, 13, '{"title":"Popular Members"}', ''),
(748, 4, 'widget', 'ynresponsiveclean.slider', 744, 14, '{"content_type":"ynresponsive1_viewed_photos","background_image":"","show_title":"1","show_description":"1","height":"150","slider_type":"flex","title":"Most Viewed Photos","nomobile":"0","itemCountPerPage":"3","name":"ynresponsiveclean.slider"}', ''),
(749, 4, 'container', 'middle', 738, 6, '[""]', ''),
(750, 4, 'widget', 'advancedhtmlblock', 749, 8, '{"title0":"Announcement","lbl_desktop":null,"body":"<div class=\\"highlighting\\" style=\\"background-image: none; background-attachment: scroll; background-color: #ffff99; box-shadow: #72c02c 0px 0px 4px; padding: 10px; line-height: 200%; margin-top: 20px; margin-bottom: 10px; text-align: left; background-position: 0px 0px; background-repeat: repeat repeat;\\">This price for&nbsp;<strong>Early Bird Purchase, <\\/strong>available to<strong><strong> Dec\\/15<\\/strong><\\/strong>\\r\\n<ul>\\r\\n<li><span style=\\"line-height: 200%;\\">Template<\\/span><strong style=\\"line-height: 200%;\\">: $100 <\\/strong>instead of <del><strong style=\\"line-height: 200%;\\">$120<\\/strong><\\/del><\\/li>\\r\\n<li><span style=\\"color: #111111; line-height: 200%;\\">Template WITH Advanced Album<\\/span><strong style=\\"line-height: 200%;\\">: $120 <\\/strong>instead of <del><strong style=\\"line-height: 200%;\\">$150<\\/strong><\\/del><\\/li>\\r\\n<\\/ul>\\r\\n<\\/div>","lbl_tablet":null,"tablet":"<div class=\\"highlighting\\" style=\\"background-image: none; background-attachment: scroll; background-color: #ffff99; box-shadow: #72c02c 0px 0px 4px; padding: 10px; line-height: 200%; margin-top: 20px; margin-bottom: 10px; text-align: left; background-position: 0px 0px; background-repeat: repeat repeat;\\">This price for&nbsp;<strong>Early Bird Purchase, <\\/strong>available to<strong><strong> Dec\\/15<\\/strong><\\/strong>\\r\\n<ul>\\r\\n<li><span style=\\"line-height: 200%;\\">Template<\\/span><strong style=\\"line-height: 200%;\\">: $100 <\\/strong>instead of <del><strong style=\\"line-height: 200%;\\">$120<\\/strong><\\/del><\\/li>\\r\\n<li><span style=\\"color: #111111; line-height: 200%;\\">Template WITH Advanced Album<\\/span><strong style=\\"line-height: 200%;\\">: $120 <\\/strong>instead of <del><strong style=\\"line-height: 200%;\\">$150<\\/strong><\\/del><\\/li>\\r\\n<\\/ul>\\r\\n<\\/div>","lbl_mobile":null,"mobile":"<div class=\\"highlighting\\" style=\\"background-image: none; background-attachment: scroll; background-color: #ffff99; box-shadow: #72c02c 0px 0px 4px; padding: 10px; line-height: 200%; margin-top: 20px; margin-bottom: 10px; text-align: left; background-position: 0px 0px; background-repeat: repeat repeat;\\">This price for&nbsp;<strong>Early Bird Purchase, <\\/strong>available to<strong><strong> Dec\\/15<\\/strong><\\/strong>\\r\\n<ul>\\r\\n<li><span style=\\"line-height: 200%;\\">Template<\\/span><strong style=\\"line-height: 200%;\\">: $100 <\\/strong>instead of <del><strong style=\\"line-height: 200%;\\">$120<\\/strong><\\/del><\\/li>\\r\\n<li><span style=\\"color: #111111; line-height: 200%;\\">Template WITH Advanced Album<\\/span><strong style=\\"line-height: 200%;\\">: $120 <\\/strong>instead of <del><strong style=\\"line-height: 200%;\\">$150<\\/strong><\\/del><\\/li>\\r\\n<\\/ul>\\r\\n<\\/div>","name":"advancedhtmlblock","nomobile":"0"}', ''),
(751, 4, 'widget', 'activity.feed', 749, 9, '{"title":"What''s New"}', ''),
(752, 5, 'widget', 'classified.profile-classifieds', 531, 6, '{"title":"Classifieds","titleCount":true}', NULL),
(753, 27, 'container', 'top', NULL, 1, '["[]"]', NULL),
(754, 27, 'container', 'main', NULL, 2, '["[]"]', NULL),
(755, 27, 'container', 'middle', 753, 6, '["[]"]', NULL),
(756, 27, 'container', 'middle', 754, 6, '["[]"]', NULL),
(757, 27, 'container', 'right', 754, 5, '["[]"]', NULL),
(758, 27, 'widget', 'classified.browse-menu', 755, 3, '["[]"]', NULL),
(760, 27, 'widget', 'classified.browse-search', 757, 11, '["[]"]', NULL),
(761, 27, 'widget', 'classified.browse-menu-quick', 757, 12, '["[]"]', NULL),
(762, 28, 'container', 'main', NULL, 2, '[""]', NULL),
(763, 28, 'container', 'middle', 762, 6, '[""]', NULL),
(764, 28, 'widget', 'core.content', 763, 6, '[""]', NULL),
(766, 29, 'container', 'top', NULL, 1, NULL, NULL),
(767, 29, 'container', 'main', NULL, 2, NULL, NULL),
(768, 29, 'container', 'middle', 766, 1, NULL, NULL),
(769, 29, 'container', 'middle', 767, 2, NULL, NULL),
(770, 29, 'widget', 'classified.browse-menu', 768, 1, NULL, NULL),
(771, 29, 'widget', 'core.content', 769, 1, NULL, NULL),
(772, 30, 'container', 'top', NULL, 1, NULL, NULL),
(773, 30, 'container', 'main', NULL, 2, NULL, NULL),
(774, 30, 'container', 'middle', 772, 1, NULL, NULL),
(775, 30, 'container', 'middle', 773, 2, NULL, NULL),
(776, 30, 'container', 'right', 773, 1, NULL, NULL),
(777, 30, 'widget', 'classified.browse-menu', 774, 1, NULL, NULL),
(778, 30, 'widget', 'core.content', 775, 1, NULL, NULL),
(779, 30, 'widget', 'classified.browse-search', 776, 1, NULL, NULL),
(780, 30, 'widget', 'classified.browse-menu-quick', 776, 2, NULL, NULL),
(781, 5, 'widget', 'ynlistings.profile-listings', 531, 999, '{"title":"Listings","titleCount":true}', NULL),
(782, 31, 'container', 'top', NULL, 1, NULL, NULL),
(783, 31, 'container', 'main', NULL, 2, NULL, NULL),
(784, 31, 'container', 'middle', 782, 1, NULL, NULL),
(785, 31, 'container', 'middle', 783, 2, NULL, NULL),
(786, 31, 'container', 'right', 783, 1, NULL, NULL),
(787, 31, 'widget', 'ynlistings.main-menu', 784, 1, NULL, NULL),
(788, 31, 'widget', 'ynlistings.browse-search', 786, 1, NULL, NULL),
(789, 31, 'widget', 'ynlistings.most-liked-listings', 786, 2, '{"title":"Most Liked"}', NULL),
(790, 31, 'widget', 'ynlistings.most-discussion-listings', 786, 3, '{"title":"Most Discussion"}', NULL),
(791, 31, 'widget', 'ynlistings.most-reviewed-listings', 786, 4, '{"title":"Most Reviewed"}', NULL),
(792, 31, 'widget', 'ynlistings.recently-viewed', 786, 5, '{"title":"Recently Viewed"}', NULL),
(793, 31, 'widget', 'ynlistings.listings-you-may-like', 786, 6, '{"title":"You May Like"}', NULL),
(794, 31, 'widget', 'ynlistings.listings-tags', 786, 7, '{"title":"Tags"}', NULL),
(795, 31, 'widget', 'core.content', 785, 1, NULL, NULL),
(796, 31, 'widget', 'ynlistings.featured-listings', 785, 2, NULL, NULL),
(797, 31, 'widget', 'ynlistings.browse-category', 785, 3, NULL, NULL),
(798, 31, 'widget', 'ynlistings.list-most-items', 785, 4, NULL, NULL),
(799, 32, 'container', 'top', NULL, 1, NULL, NULL),
(800, 32, 'container', 'main', NULL, 2, NULL, NULL),
(801, 32, 'container', 'middle', 799, 1, NULL, NULL),
(802, 32, 'container', 'middle', 800, 2, NULL, NULL),
(803, 32, 'container', 'right', 800, 1, NULL, NULL),
(804, 32, 'widget', 'ynlistings.main-menu', 801, 1, NULL, NULL),
(805, 32, 'widget', 'ynlistings.browse-search', 803, 1, NULL, NULL),
(806, 32, 'widget', 'core.content', 802, 1, NULL, NULL),
(807, 33, 'container', 'top', NULL, 1, NULL, NULL),
(808, 33, 'container', 'main', NULL, 2, NULL, NULL),
(809, 33, 'container', 'middle', 807, 1, NULL, NULL),
(810, 33, 'container', 'left', 808, 1, NULL, NULL),
(811, 33, 'container', 'right', 808, 2, NULL, NULL),
(812, 33, 'container', 'middle', 808, 3, NULL, NULL),
(813, 33, 'widget', 'ynlistings.main-menu', 809, 1, NULL, NULL),
(814, 33, 'widget', 'ynlistings.highlight-listing', 811, 1, NULL, NULL),
(815, 33, 'widget', 'ynlistings.browse-search', 811, 2, NULL, NULL),
(816, 33, 'widget', 'ynlistings.list-categories', 810, 2, NULL, NULL),
(817, 33, 'widget', 'ynlistings.browse-listings', 812, 1, NULL, NULL),
(818, 34, 'container', 'top', NULL, 1, NULL, NULL),
(819, 34, 'container', 'main', NULL, 2, NULL, NULL),
(820, 34, 'container', 'middle', 818, 1, NULL, NULL),
(821, 34, 'container', 'middle', 819, 2, NULL, NULL),
(822, 34, 'container', 'right', 819, 1, NULL, NULL),
(823, 34, 'widget', 'ynlistings.main-menu', 820, 1, NULL, NULL),
(824, 34, 'widget', 'core.content', 821, 1, NULL, NULL),
(825, 35, 'container', 'top', NULL, 1, NULL, NULL),
(826, 35, 'container', 'main', NULL, 2, NULL, NULL),
(827, 35, 'container', 'middle', 825, 1, NULL, NULL),
(828, 35, 'container', 'middle', 826, 2, NULL, NULL),
(829, 35, 'container', 'right', 826, 1, NULL, NULL),
(830, 35, 'widget', 'ynlistings.main-menu', 827, 1, NULL, NULL),
(831, 35, 'widget', 'core.content', 828, 1, NULL, NULL),
(832, 36, 'container', 'top', NULL, 1, NULL, NULL),
(833, 36, 'container', 'main', NULL, 2, NULL, NULL),
(834, 36, 'container', 'middle', 832, 1, NULL, NULL),
(835, 36, 'container', 'middle', 833, 2, NULL, NULL),
(836, 36, 'container', 'right', 833, 1, NULL, NULL),
(837, 36, 'widget', 'ynlistings.main-menu', 834, 1, NULL, NULL),
(838, 36, 'widget', 'core.content', 835, 1, NULL, NULL),
(839, 37, 'container', 'top', NULL, 1, NULL, NULL),
(840, 37, 'container', 'main', NULL, 2, NULL, NULL),
(841, 37, 'container', 'middle', 839, 1, NULL, NULL),
(842, 37, 'container', 'middle', 840, 2, NULL, NULL),
(843, 37, 'container', 'right', 840, 1, NULL, NULL),
(844, 37, 'widget', 'ynlistings.listing-location', 843, 1, '{"title":"Location"}', NULL),
(845, 37, 'widget', 'ynlistings.listing-about', 843, 2, '{"title":"About Us"}', NULL),
(846, 37, 'widget', 'ynlistings.listings-tags', 843, 3, '{"title":"Tags"}', NULL),
(847, 37, 'widget', 'ynlistings.main-menu', 841, 1, NULL, NULL),
(848, 37, 'widget', 'core.content', 842, 1, NULL, NULL),
(849, 37, 'widget', 'core.container-tabs', 842, 2, '{"max":"8"}', NULL),
(850, 37, 'widget', 'ynlistings.listing-info', 849, 1, '{"title":"Info"}', NULL),
(851, 37, 'widget', 'activity.feed', 849, 2, '{"title":"Activity"}', NULL),
(852, 37, 'widget', 'ynlistings.listing-reviews', 849, 3, '{"title":"Reviews"}', NULL),
(853, 37, 'widget', 'ynlistings.listing-albums', 849, 4, '{"title":"Albums"}', NULL),
(854, 37, 'widget', 'ynlistings.listing-videos', 849, 5, '{"title":"Videos"}', NULL),
(855, 37, 'widget', 'ynlistings.listing-ultimate-videos', 849, 6, '{"title":"Ultimate Videos"}', NULL),
(856, 37, 'widget', 'ynlistings.listing-discussions', 849, 7, '{"title":"Discussion"}', NULL),
(857, 37, 'widget', 'ynlistings.related-listings', 842, 3, NULL, NULL),
(858, 38, 'container', 'top', NULL, 1, NULL, NULL),
(859, 38, 'container', 'main', NULL, 2, NULL, NULL),
(860, 38, 'container', 'middle', 858, 1, NULL, NULL),
(861, 38, 'container', 'middle', 859, 2, NULL, NULL),
(862, 38, 'container', 'right', 859, 1, NULL, NULL),
(863, 38, 'widget', 'ynlistings.listing-location', 862, 1, '{"title":"Location"}', NULL),
(864, 38, 'widget', 'ynlistings.listing-about', 862, 2, '{"title":"About Us"}', NULL),
(865, 38, 'widget', 'ynlistings.listings-tags', 862, 3, '{"title":"Tags"}', NULL),
(866, 38, 'widget', 'ynlistings.main-menu', 860, 1, NULL, NULL),
(867, 38, 'widget', 'core.content', 861, 1, NULL, NULL),
(868, 38, 'widget', 'core.container-tabs', 861, 2, '{"max":"8"}', NULL),
(869, 38, 'widget', 'ynlistings.listing-info', 868, 1, '{"title":"Info"}', NULL),
(870, 39, 'container', 'top', NULL, 1, NULL, NULL),
(871, 39, 'container', 'main', NULL, 2, NULL, NULL),
(872, 39, 'container', 'middle', 870, 1, NULL, NULL),
(873, 39, 'container', 'middle', 871, 2, NULL, NULL),
(874, 39, 'container', 'right', 871, 1, NULL, NULL),
(875, 39, 'widget', 'ynlistings.main-menu', 872, 1, NULL, NULL),
(876, 39, 'widget', 'core.content', 873, 1, NULL, NULL),
(877, 40, 'container', 'top', NULL, 1, NULL, NULL),
(878, 40, 'container', 'main', NULL, 2, NULL, NULL),
(879, 40, 'container', 'middle', 877, 1, NULL, NULL),
(880, 40, 'container', 'middle', 878, 2, NULL, NULL),
(881, 40, 'container', 'right', 878, 1, NULL, NULL),
(882, 40, 'widget', 'ynlistings.listing-location', 881, 1, '{"title":"Location"}', NULL),
(883, 40, 'widget', 'ynlistings.listing-about', 881, 2, '{"title":"About Us"}', NULL),
(884, 40, 'widget', 'ynlistings.listings-tags', 881, 3, '{"title":"Tags"}', NULL),
(885, 40, 'widget', 'ynlistings.main-menu', 879, 1, NULL, NULL),
(886, 40, 'widget', 'core.content', 880, 1, NULL, NULL),
(887, 40, 'widget', 'core.container-tabs', 880, 2, '{"max":"8"}', NULL),
(888, 40, 'widget', 'ynmobileview.mobi-feed', 887, 1, '{"title":"Activity"}', NULL),
(889, 40, 'widget', 'ynlistings.listing-info', 887, 2, '{"title":"Info"}', NULL),
(890, 40, 'widget', 'ynlistings.listing-reviews', 887, 3, '{"title":"Reviews"}', NULL),
(891, 40, 'widget', 'ynlistings.listing-albums', 887, 4, '{"title":"Albums"}', NULL),
(892, 40, 'widget', 'ynlistings.listing-videos', 887, 5, '{"title":"Videos"}', NULL),
(893, 40, 'widget', 'ynlistings.listing-discussions', 887, 6, '{"title":"Discussion"}', NULL),
(894, 40, 'widget', 'ynlistings.related-listings', 880, 3, NULL, NULL),
(895, 1, 'widget', 'advmenusystem.advanced-mini-menu', 725, 2, '["[]"]', NULL),
(896, 41, 'container', 'top', NULL, 1, NULL, NULL),
(897, 41, 'container', 'main', NULL, 2, NULL, NULL),
(898, 41, 'container', 'middle', 896, 1, NULL, NULL),
(899, 41, 'container', 'middle', 897, 2, NULL, NULL),
(900, 41, 'container', 'right', 897, 1, NULL, NULL),
(901, 41, 'widget', 'question.browse-menu', 898, 1, NULL, NULL),
(902, 41, 'widget', 'core.content', 899, 1, NULL, NULL),
(903, 41, 'widget', 'question.browse-search', 900, 1, NULL, NULL),
(904, 41, 'widget', 'question.how-collect-points', 900, 2, NULL, NULL),
(905, 41, 'widget', 'question.ask-question', 900, 3, NULL, NULL),
(906, 42, 'container', 'top', NULL, 1, NULL, NULL),
(907, 42, 'container', 'main', NULL, 2, NULL, NULL),
(908, 42, 'container', 'middle', 906, 1, NULL, NULL),
(909, 42, 'container', 'middle', 907, 2, NULL, NULL),
(910, 42, 'container', 'right', 907, 1, NULL, NULL),
(911, 42, 'widget', 'question.browse-menu', 908, 1, NULL, NULL),
(912, 42, 'widget', 'core.content', 909, 1, NULL, NULL),
(913, 42, 'widget', 'question.browse-search', 910, 1, NULL, NULL),
(914, 42, 'widget', 'question.how-collect-points', 910, 2, NULL, NULL),
(915, 42, 'widget', 'question.ask-question', 910, 3, NULL, NULL),
(916, 43, 'container', 'top', NULL, 1, NULL, NULL),
(917, 43, 'container', 'main', NULL, 2, NULL, NULL),
(918, 43, 'container', 'middle', 916, 1, NULL, NULL),
(919, 43, 'container', 'middle', 917, 2, NULL, NULL),
(920, 43, 'container', 'right', 917, 1, NULL, NULL),
(921, 43, 'widget', 'question.browse-menu', 918, 1, NULL, NULL),
(922, 43, 'widget', 'core.content', 919, 1, NULL, NULL),
(923, 43, 'widget', 'question.rating-user-search', 920, 1, NULL, NULL),
(924, 43, 'widget', 'question.update-ratings', 920, 2, NULL, NULL),
(925, 44, 'container', 'top', NULL, 1, NULL, NULL),
(926, 44, 'container', 'main', NULL, 2, NULL, NULL),
(927, 44, 'container', 'middle', 925, 1, NULL, NULL),
(928, 44, 'container', 'middle', 926, 2, NULL, NULL),
(929, 44, 'container', 'right', 926, 1, NULL, NULL),
(930, 44, 'widget', 'question.browse-menu', 927, 1, NULL, NULL),
(931, 44, 'widget', 'core.content', 928, 1, NULL, NULL),
(932, 44, 'widget', 'question.how-collect-points', 929, 1, NULL, NULL),
(933, 45, 'container', 'top', NULL, 1, NULL, NULL),
(934, 45, 'container', 'main', NULL, 2, NULL, NULL),
(935, 45, 'container', 'middle', 933, 1, NULL, NULL),
(936, 45, 'container', 'middle', 934, 2, NULL, NULL),
(937, 45, 'container', 'right', 934, 1, NULL, NULL),
(938, 45, 'widget', 'question.browse-menu', 935, 1, NULL, NULL),
(939, 45, 'widget', 'core.content', 936, 1, NULL, NULL),
(940, 45, 'widget', 'question.how-collect-points', 937, 1, NULL, NULL),
(941, 46, 'container', 'top', NULL, 1, NULL, NULL),
(942, 46, 'container', 'main', NULL, 2, NULL, NULL),
(943, 46, 'container', 'middle', 941, 1, NULL, NULL),
(944, 46, 'container', 'middle', 942, 2, NULL, NULL),
(945, 46, 'container', 'right', 942, 1, NULL, NULL),
(946, 46, 'widget', 'question.browse-menu', 943, 1, NULL, NULL),
(947, 46, 'widget', 'core.content', 944, 1, NULL, NULL),
(948, 46, 'widget', 'question.how-collect-points', 945, 1, NULL, NULL),
(949, 47, 'container', 'top', NULL, 1, NULL, NULL),
(950, 47, 'container', 'main', NULL, 2, NULL, NULL),
(951, 47, 'container', 'middle', 949, 1, NULL, NULL),
(952, 47, 'container', 'middle', 950, 2, NULL, NULL),
(953, 47, 'container', 'right', 950, 1, NULL, NULL),
(954, 47, 'widget', 'question.browse-menu', 951, 1, NULL, NULL),
(955, 47, 'widget', 'core.content', 952, 1, NULL, NULL),
(956, 47, 'widget', 'question.how-collect-points', 953, 1, NULL, NULL),
(957, 48, 'container', 'top', NULL, 1, NULL, NULL),
(958, 48, 'container', 'main', NULL, 2, NULL, NULL),
(959, 48, 'container', 'middle', 957, 1, NULL, NULL),
(960, 48, 'container', 'middle', 958, 2, NULL, NULL),
(961, 48, 'container', 'right', 958, 1, NULL, NULL),
(962, 48, 'widget', 'question.browse-menu', 959, 1, NULL, NULL),
(963, 48, 'widget', 'core.content', 960, 1, NULL, NULL),
(964, 48, 'widget', 'question.browse-search', 961, 1, NULL, NULL),
(965, 48, 'widget', 'question.how-collect-points', 961, 2, NULL, NULL),
(966, 48, 'widget', 'question.ask-question', 961, 3, NULL, NULL),
(967, 27, 'widget', 'classified.browse-category', 756, 6, '{"title":"Browse Categories"}', NULL),
(968, 49, 'container', 'top', NULL, 1, '["[]"]', NULL),
(969, 49, 'container', 'main', NULL, 2, '["[]"]', NULL),
(970, 49, 'container', 'middle', 968, 6, '["[]"]', NULL),
(971, 49, 'container', 'middle', 969, 6, '["[]"]', NULL),
(972, 49, 'container', 'right', 969, 5, '["[]"]', NULL),
(973, 49, 'widget', 'classified.browse-menu', 970, 3, '["[]"]', NULL),
(975, 49, 'widget', 'classified.browse-search', 972, 9, '["[]"]', NULL),
(976, 49, 'widget', 'classified.browse-menu-quick', 972, 10, '["[]"]', NULL),
(978, 49, 'container', 'left', 969, 4, '["[]"]', NULL),
(979, 49, 'widget', 'classified.list-categories', 978, 6, '{"title":"Categories"}', NULL),
(980, 28, 'container', 'top', NULL, 1, '["[]"]', NULL),
(981, 28, 'container', 'middle', 980, 6, '["[]"]', NULL),
(982, 28, 'widget', 'classified.browse-menu', 981, 3, '["[]"]', NULL),
(983, 28, 'container', 'right', 762, 5, '["[]"]', NULL),
(985, 27, 'widget', 'core.container-tabs', 756, 7, '{"max":6}', NULL),
(986, 27, 'widget', 'classified.list-recent-classifieds', 985, 8, '{"title":"Recent Classifieds"}', NULL),
(987, 27, 'widget', 'classified.list-popular-classifieds', 985, 9, '{"title":"Popular Classifieds"}', NULL),
(990, 28, 'widget', 'classified.list-popular-classifieds', 983, 8, '{"title":"Popular Classifieds"}', NULL),
(991, 3, 'container', 'left', 731, 4, '["[]"]', NULL),
(994, 3, 'widget', 'classified.menu-category', 991, 3, '["[]"]', NULL),
(997, 3, 'widget', 'custom.landing-slider', 732, 5, '{"title":""}', NULL),
(998, 3, 'widget', 'classified.hot-classifieds', 732, 6, '{"title":"Hot Classifieds"}', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_geotags`
--

CREATE TABLE IF NOT EXISTS `engine4_core_geotags` (
  `geotag_id` int(11) unsigned NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  PRIMARY KEY (`geotag_id`),
  KEY `latitude` (`latitude`,`longitude`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_jobs`
--

CREATE TABLE IF NOT EXISTS `engine4_core_jobs` (
  `job_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `jobtype_id` int(10) unsigned NOT NULL,
  `state` enum('pending','active','sleeping','failed','cancelled','completed','timeout') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `is_complete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `progress` decimal(5,4) unsigned NOT NULL DEFAULT '0.0000',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `started_date` datetime DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL,
  `priority` mediumint(9) NOT NULL DEFAULT '100',
  `data` text COLLATE utf8_unicode_ci,
  `messages` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`job_id`),
  KEY `jobtype_id` (`jobtype_id`),
  KEY `state` (`state`),
  KEY `is_complete` (`is_complete`,`priority`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_jobtypes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_jobtypes` (
  `jobtype_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `form` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `priority` mediumint(9) NOT NULL DEFAULT '100',
  `multi` tinyint(3) unsigned DEFAULT '1',
  PRIMARY KEY (`jobtype_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `engine4_core_jobtypes`
--

INSERT INTO `engine4_core_jobtypes` (`jobtype_id`, `title`, `type`, `module`, `plugin`, `form`, `enabled`, `priority`, `multi`) VALUES
(1, 'Download File', 'file_download', 'core', 'Core_Plugin_Job_FileDownload', 'Core_Form_Admin_Job_FileDownload', 1, 100, 1),
(2, 'Upload File', 'file_upload', 'core', 'Core_Plugin_Job_FileUpload', 'Core_Form_Admin_Job_FileUpload', 1, 100, 1),
(3, 'Rebuild Activity Privacy', 'activity_maintenance_rebuild_privacy', 'activity', 'Activity_Plugin_Job_Maintenance_RebuildPrivacy', NULL, 1, 50, 1),
(4, 'Rebuild Member Privacy', 'user_maintenance_rebuild_privacy', 'user', 'User_Plugin_Job_Maintenance_RebuildPrivacy', NULL, 1, 50, 1),
(5, 'Rebuild Network Membership', 'network_maintenance_rebuild_membership', 'network', 'Network_Plugin_Job_Maintenance_RebuildMembership', NULL, 1, 50, 1),
(6, 'Storage Transfer', 'storage_transfer', 'core', 'Storage_Plugin_Job_Transfer', 'Core_Form_Admin_Job_Generic', 1, 100, 1),
(7, 'Storage Cleanup', 'storage_cleanup', 'core', 'Storage_Plugin_Job_Cleanup', 'Core_Form_Admin_Job_Generic', 1, 100, 1),
(8, 'Rebuild Classified Privacy', 'classified_maintenance_rebuild_privacy', 'classified', 'Classified_Plugin_Job_Maintenance_RebuildPrivacy', NULL, 1, 50, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_languages`
--

CREATE TABLE IF NOT EXISTS `engine4_core_languages` (
  `language_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fallback` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `order` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `engine4_core_languages`
--

INSERT INTO `engine4_core_languages` (`language_id`, `code`, `name`, `fallback`, `order`) VALUES
(1, 'en', 'English', 'en', 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_likes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_likes` (
  `like_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`like_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_links`
--

CREATE TABLE IF NOT EXISTS `engine4_core_links` (
  `link_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `parent_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `parent_id` int(11) unsigned NOT NULL,
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `view_count` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`link_id`),
  KEY `owner` (`owner_type`,`owner_id`),
  KEY `parent` (`parent_type`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_listitems`
--

CREATE TABLE IF NOT EXISTS `engine4_core_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_lists`
--

CREATE TABLE IF NOT EXISTS `engine4_core_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `child_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_type` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_log`
--

CREATE TABLE IF NOT EXISTS `engine4_core_log` (
  `message_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `plugin` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority` smallint(2) NOT NULL DEFAULT '6',
  `priorityName` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INFO',
  PRIMARY KEY (`message_id`),
  KEY `domain` (`domain`,`timestamp`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_mail`
--

CREATE TABLE IF NOT EXISTS `engine4_core_mail` (
  `mail_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('system','zend') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority` smallint(3) DEFAULT '100',
  `recipient_count` int(11) unsigned DEFAULT '0',
  `recipient_total` int(10) NOT NULL DEFAULT '0',
  `creation_time` datetime NOT NULL,
  PRIMARY KEY (`mail_id`),
  KEY `priority` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_mailrecipients`
--

CREATE TABLE IF NOT EXISTS `engine4_core_mailrecipients` (
  `recipient_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `email` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`recipient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_mailtemplates`
--

CREATE TABLE IF NOT EXISTS `engine4_core_mailtemplates` (
  `mailtemplate_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `vars` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`mailtemplate_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=44 ;

--
-- Dumping data for table `engine4_core_mailtemplates`
--

INSERT INTO `engine4_core_mailtemplates` (`mailtemplate_id`, `type`, `module`, `vars`) VALUES
(1, 'header', 'core', ''),
(2, 'footer', 'core', ''),
(3, 'header_member', 'core', ''),
(4, 'footer_member', 'core', ''),
(5, 'core_contact', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_name],[sender_email],[sender_link],[sender_photo],[message]'),
(6, 'core_verification', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),
(7, 'core_verification_password', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link],[password]'),
(8, 'core_welcome', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),
(9, 'core_welcome_password', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link],[password]'),
(10, 'notify_admin_user_signup', 'core', '[host],[email],[date],[recipient_title],[object_title],[object_link]'),
(11, 'core_lostpassword', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),
(12, 'notify_commented', 'activity', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(13, 'notify_commented_commented', 'activity', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(14, 'notify_liked', 'activity', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(15, 'notify_liked_commented', 'activity', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(16, 'user_account_approved', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo]'),
(17, 'notify_friend_accepted', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(18, 'notify_friend_request', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(19, 'notify_friend_follow_request', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(20, 'notify_friend_follow_accepted', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(21, 'notify_friend_follow', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(22, 'notify_post_user', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(23, 'notify_tagged', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(24, 'notify_message_new', 'messages', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(25, 'invite', 'invite', '[host],[email],[sender_email],[sender_title],[sender_link],[sender_photo],[message],[object_link],[code]'),
(26, 'invite_code', 'invite', '[host],[email],[sender_email],[sender_title],[sender_link],[sender_photo],[message],[object_link],[code]'),
(27, 'payment_subscription_active', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(28, 'payment_subscription_cancelled', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(29, 'payment_subscription_expired', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(30, 'payment_subscription_overdue', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(31, 'payment_subscription_pending', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(32, 'payment_subscription_recurrence', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(33, 'payment_subscription_refunded', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(34, 'ynlistings_email_to_friends', 'ynlistings', '[host],[email],[date],[sender_title],[sender_link],[sender_photo],[object_title],[message],[object_link],[object_photo],[object_description]'),
(35, 'notify_ynlistings_discussion_reply', 'ynlistings', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(36, 'notify_ynlistings_discussion_response', 'ynlistings', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(37, 'notify_ynlistings_listing_follow', 'ynlistings', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(38, 'notify_ynlistings_listing_approve', 'ynlistings', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(39, 'notify_ynlistings_listing_deny', 'ynlistings', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(40, 'notify_answer_new', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[unsubscribe_link]'),
(41, 'notify_choose_best', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link]'),
(42, 'notify_answer_new_subs', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[unsubscribe_link]'),
(43, 'notify_answer_new_comment', 'question', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[unsubscribe_link]');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_menuitems`
--

CREATE TABLE IF NOT EXISTS `engine4_core_menuitems` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `params` text COLLATE utf8_unicode_ci NOT NULL,
  `menu` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `submenu` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `custom` tinyint(1) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999',
  `flag_unique` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`flag_unique`),
  KEY `LOOKUP` (`name`,`order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=158 ;

--
-- Dumping data for table `engine4_core_menuitems`
--

INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`, `flag_unique`) VALUES
(1, 'core_main_home', 'core', 'Home', 'User_Plugin_Menus', '', 'core_main', '', 1, 0, 1, 0),
(2, 'core_sitemap_home', 'core', 'Home', '', '{"route":"default"}', 'core_sitemap', '', 1, 0, 1, 0),
(3, 'core_footer_privacy', 'core', 'Privacy', '', '{"route":"default","module":"core","controller":"help","action":"privacy"}', 'core_footer', '', 1, 0, 1, 0),
(4, 'core_footer_terms', 'core', 'Terms of Service', '', '{"route":"default","module":"core","controller":"help","action":"terms"}', 'core_footer', '', 1, 0, 2, 0),
(5, 'core_footer_contact', 'core', 'Contact', '', '{"route":"default","module":"core","controller":"help","action":"contact"}', 'core_footer', '', 1, 0, 3, 0),
(6, 'core_mini_admin', 'core', 'Admin', 'User_Plugin_Menus', '', 'core_mini', '', 1, 0, 6, 0),
(7, 'core_mini_profile', 'user', 'My Profile', 'User_Plugin_Menus', '', 'core_mini', '', 1, 0, 5, 0),
(8, 'core_mini_settings', 'user', 'Settings', 'User_Plugin_Menus', '', 'core_mini', '', 1, 0, 3, 0),
(9, 'core_mini_auth', 'user', 'Auth', 'User_Plugin_Menus', '', 'core_mini', '', 1, 0, 2, 0),
(10, 'core_mini_signup', 'user', 'Signup', 'User_Plugin_Menus', '', 'core_mini', '', 1, 0, 1, 0),
(11, 'core_admin_main_home', 'core', 'Home', '', '{"route":"admin_default"}', 'core_admin_main', '', 1, 0, 1, 0),
(12, 'core_admin_main_manage', 'core', 'Manage', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_manage', 1, 0, 2, 0),
(13, 'core_admin_main_settings', 'core', 'Settings', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_settings', 1, 0, 3, 0),
(14, 'core_admin_main_plugins', 'core', 'Plugins', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_plugins', 1, 0, 4, 0),
(15, 'core_admin_main_layout', 'core', 'Layout', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_layout', 1, 0, 5, 0),
(16, 'core_admin_main_ads', 'core', 'Ads', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_ads', 1, 0, 6, 0),
(17, 'core_admin_main_stats', 'core', 'Stats', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_stats', 1, 0, 8, 0),
(18, 'core_admin_main_manage_levels', 'core', 'Member Levels', '', '{"route":"admin_default","module":"authorization","controller":"level"}', 'core_admin_main_manage', '', 1, 0, 2, 0),
(19, 'core_admin_main_manage_networks', 'network', 'Networks', '', '{"route":"admin_default","module":"network","controller":"manage"}', 'core_admin_main_manage', '', 1, 0, 3, 0),
(20, 'core_admin_main_manage_announcements', 'announcement', 'Announcements', '', '{"route":"admin_default","module":"announcement","controller":"manage"}', 'core_admin_main_manage', '', 1, 0, 4, 0),
(21, 'core_admin_message_mail', 'core', 'Email All Members', '', '{"route":"admin_default","module":"core","controller":"message","action":"mail"}', 'core_admin_main_manage', '', 1, 0, 5, 0),
(22, 'core_admin_main_manage_reports', 'core', 'Abuse Reports', '', '{"route":"admin_default","module":"core","controller":"report"}', 'core_admin_main_manage', '', 1, 0, 6, 0),
(23, 'core_admin_main_manage_packages', 'core', 'Packages & Plugins', '', '{"route":"admin_default","module":"core","controller":"packages"}', 'core_admin_main_manage', '', 1, 0, 7, 0),
(24, 'core_admin_main_settings_general', 'core', 'General Settings', '', '{"route":"core_admin_settings","action":"general"}', 'core_admin_main_settings', '', 1, 0, 1, 0),
(25, 'core_admin_main_settings_locale', 'core', 'Locale Settings', '', '{"route":"core_admin_settings","action":"locale"}', 'core_admin_main_settings', '', 1, 0, 1, 0),
(26, 'core_admin_main_settings_fields', 'fields', 'Profile Questions', '', '{"route":"admin_default","module":"user","controller":"fields"}', 'core_admin_main_settings', '', 1, 0, 2, 0),
(27, 'core_admin_main_wibiya', 'core', 'Wibiya Integration', '', '{"route":"admin_default", "action":"wibiya", "controller":"settings", "module":"core"}', 'core_admin_main_settings', '', 1, 0, 4, 0),
(28, 'core_admin_main_settings_spam', 'core', 'Spam & Banning Tools', '', '{"route":"core_admin_settings","action":"spam"}', 'core_admin_main_settings', '', 1, 0, 5, 0),
(29, 'core_admin_main_settings_mailtemplates', 'core', 'Mail Templates', '', '{"route":"admin_default","controller":"mail","action":"templates"}', 'core_admin_main_settings', '', 1, 0, 6, 0),
(30, 'core_admin_main_settings_mailsettings', 'core', 'Mail Settings', '', '{"route":"admin_default","controller":"mail","action":"settings"}', 'core_admin_main_settings', '', 1, 0, 7, 0),
(31, 'core_admin_main_settings_performance', 'core', 'Performance & Caching', '', '{"route":"core_admin_settings","action":"performance"}', 'core_admin_main_settings', '', 1, 0, 8, 0),
(32, 'core_admin_main_settings_password', 'core', 'Admin Password', '', '{"route":"core_admin_settings","action":"password"}', 'core_admin_main_settings', '', 1, 0, 9, 0),
(33, 'core_admin_main_settings_tasks', 'core', 'Task Scheduler', '', '{"route":"admin_default","controller":"tasks"}', 'core_admin_main_settings', '', 1, 0, 10, 0),
(34, 'core_admin_main_layout_content', 'core', 'Layout Editor', '', '{"route":"admin_default","controller":"content"}', 'core_admin_main_layout', '', 1, 0, 1, 0),
(35, 'core_admin_main_layout_themes', 'core', 'Theme Editor', '', '{"route":"admin_default","controller":"themes"}', 'core_admin_main_layout', '', 1, 0, 2, 0),
(36, 'core_admin_main_layout_files', 'core', 'File & Media Manager', '', '{"route":"admin_default","controller":"files"}', 'core_admin_main_layout', '', 1, 0, 3, 0),
(37, 'core_admin_main_layout_language', 'core', 'Language Manager', '', '{"route":"admin_default","controller":"language"}', 'core_admin_main_layout', '', 1, 0, 4, 0),
(38, 'core_admin_main_layout_menus', 'core', 'Menu Editor', '', '{"route":"admin_default","controller":"menus"}', 'core_admin_main_layout', '', 1, 0, 5, 0),
(39, 'core_admin_main_ads_manage', 'core', 'Manage Ad Campaigns', '', '{"route":"admin_default","controller":"ads"}', 'core_admin_main_ads', '', 1, 0, 1, 0),
(40, 'core_admin_main_ads_create', 'core', 'Create New Campaign', '', '{"route":"admin_default","controller":"ads","action":"create"}', 'core_admin_main_ads', '', 1, 0, 2, 0),
(41, 'core_admin_main_ads_affiliate', 'core', 'SE Affiliate Program', '', '{"route":"admin_default","controller":"settings","action":"affiliate"}', 'core_admin_main_ads', '', 1, 0, 3, 0),
(42, 'core_admin_main_ads_viglink', 'core', 'VigLink', '', '{"route":"admin_default","controller":"settings","action":"viglink"}', 'core_admin_main_ads', '', 1, 0, 4, 0),
(43, 'core_admin_main_stats_statistics', 'core', 'Site-wide Statistics', '', '{"route":"admin_default","controller":"stats"}', 'core_admin_main_stats', '', 1, 0, 1, 0),
(44, 'core_admin_main_stats_url', 'core', 'Referring URLs', '', '{"route":"admin_default","controller":"stats","action":"referrers"}', 'core_admin_main_stats', '', 1, 0, 2, 0),
(45, 'core_admin_main_stats_resources', 'core', 'Server Information', '', '{"route":"admin_default","controller":"system"}', 'core_admin_main_stats', '', 1, 0, 3, 0),
(46, 'core_admin_main_stats_logs', 'core', 'Log Browser', '', '{"route":"admin_default","controller":"log","action":"index"}', 'core_admin_main_stats', '', 1, 0, 3, 0),
(47, 'core_admin_banning_general', 'core', 'Spam & Banning Tools', '', '{"route":"core_admin_settings","action":"spam"}', 'core_admin_banning', '', 1, 0, 1, 0),
(48, 'adcampaign_admin_main_edit', 'core', 'Edit Settings', '', '{"route":"admin_default","module":"core","controller":"ads","action":"edit"}', 'adcampaign_admin_main', '', 1, 0, 1, 0),
(49, 'adcampaign_admin_main_manageads', 'core', 'Manage Advertisements', '', '{"route":"admin_default","module":"core","controller":"ads","action":"manageads"}', 'adcampaign_admin_main', '', 1, 0, 2, 0),
(50, 'core_admin_main_settings_activity', 'activity', 'Activity Feed Settings', '', '{"route":"admin_default","module":"activity","controller":"settings","action":"index"}', 'core_admin_main_settings', '', 1, 0, 4, 0),
(51, 'core_admin_main_settings_notifications', 'activity', 'Default Email Notifications', '', '{"route":"admin_default","module":"activity","controller":"settings","action":"notifications"}', 'core_admin_main_settings', '', 1, 0, 11, 0),
(52, 'authorization_admin_main_manage', 'authorization', 'View Member Levels', '', '{"route":"admin_default","module":"authorization","controller":"level"}', 'authorization_admin_main', '', 1, 0, 1, 0),
(53, 'authorization_admin_main_level', 'authorization', 'Member Level Settings', '', '{"route":"admin_default","module":"authorization","controller":"level","action":"edit"}', 'authorization_admin_main', '', 1, 0, 3, 0),
(54, 'authorization_admin_level_main', 'authorization', 'Level Info', '', '{"route":"admin_default","module":"authorization","controller":"level","action":"edit"}', 'authorization_admin_level', '', 1, 0, 1, 0),
(55, 'core_main_user', 'user', 'Members', '', '{"route":"user_general","action":"browse","style":"standard","icon":"","hover_active_icon":"","main_menu_background_color":"transparent","main_menu_text_color":"transparent","main_menu_hover_color":"transparent","separator":null,"background_multicolumn_color":"transparent","background_multicolumn_image":"","login":"1","logout":"1","target":"_blank","enabled":"0"}', 'core_main', '', 0, 0, 3, 0),
(56, 'core_sitemap_user', 'user', 'Members', '', '{"route":"user_general","action":"browse"}', 'core_sitemap', '', 1, 0, 2, 0),
(57, 'user_home_updates', 'user', 'View Recent Updates', '', '{"route":"recent_activity","icon":"application/modules/User/externals/images/links/updates.png"}', 'user_home', '', 1, 0, 1, 0),
(58, 'user_home_view', 'user', 'View My Profile', 'User_Plugin_Menus', '{"route":"user_profile_self","icon":"application/modules/User/externals/images/links/profile.png"}', 'user_home', '', 1, 0, 2, 0),
(59, 'user_home_edit', 'user', 'Edit My Profile', 'User_Plugin_Menus', '{"route":"user_extended","module":"user","controller":"edit","action":"profile","icon":"application/modules/User/externals/images/links/edit.png"}', 'user_home', '', 1, 0, 3, 0),
(60, 'user_home_friends', 'user', 'Browse Members', '', '{"route":"user_general","controller":"index","action":"browse","icon":"application/modules/User/externals/images/links/search.png"}', 'user_home', '', 1, 0, 4, 0),
(61, 'user_profile_edit', 'user', 'Edit Profile', 'User_Plugin_Menus', '', 'user_profile', '', 1, 0, 1, 0),
(62, 'user_profile_friend', 'user', 'Friends', 'User_Plugin_Menus', '', 'user_profile', '', 1, 0, 3, 0),
(63, 'user_profile_block', 'user', 'Block', 'User_Plugin_Menus', '', 'user_profile', '', 1, 0, 4, 0),
(64, 'user_profile_report', 'user', 'Report User', 'User_Plugin_Menus', '', 'user_profile', '', 1, 0, 5, 0),
(65, 'user_profile_admin', 'user', 'Admin Settings', 'User_Plugin_Menus', '', 'user_profile', '', 1, 0, 9, 0),
(66, 'user_edit_profile', 'user', 'Personal Info', '', '{"route":"user_extended","module":"user","controller":"edit","action":"profile"}', 'user_edit', '', 1, 0, 1, 0),
(67, 'user_edit_photo', 'user', 'Edit My Photo', '', '{"route":"user_extended","module":"user","controller":"edit","action":"photo"}', 'user_edit', '', 1, 0, 2, 0),
(68, 'user_edit_style', 'user', 'Profile Style', 'User_Plugin_Menus', '{"route":"user_extended","module":"user","controller":"edit","action":"style"}', 'user_edit', '', 1, 0, 3, 0),
(69, 'user_settings_general', 'user', 'General', '', '{"route":"user_extended","module":"user","controller":"settings","action":"general"}', 'user_settings', '', 1, 0, 1, 0),
(70, 'user_settings_privacy', 'user', 'Privacy', '', '{"route":"user_extended","module":"user","controller":"settings","action":"privacy"}', 'user_settings', '', 1, 0, 2, 0),
(71, 'user_settings_notifications', 'user', 'Notifications', '', '{"route":"user_extended","module":"user","controller":"settings","action":"notifications"}', 'user_settings', '', 1, 0, 3, 0),
(72, 'user_settings_password', 'user', 'Change Password', '', '{"route":"user_extended", "module":"user", "controller":"settings", "action":"password"}', 'user_settings', '', 1, 0, 5, 0),
(73, 'user_settings_delete', 'user', 'Delete Account', 'User_Plugin_Menus::canDelete', '{"route":"user_extended", "module":"user", "controller":"settings", "action":"delete"}', 'user_settings', '', 1, 0, 6, 0),
(74, 'core_admin_main_manage_members', 'user', 'Members', '', '{"route":"admin_default","module":"user","controller":"manage"}', 'core_admin_main_manage', '', 1, 0, 1, 0),
(75, 'core_admin_main_signup', 'user', 'Signup Process', '', '{"route":"admin_default", "controller":"signup", "module":"user"}', 'core_admin_main_settings', '', 1, 0, 3, 0),
(76, 'core_admin_main_facebook', 'user', 'Facebook Integration', '', '{"route":"admin_default", "action":"facebook", "controller":"settings", "module":"user"}', 'core_admin_main_settings', '', 1, 0, 4, 0),
(77, 'core_admin_main_twitter', 'user', 'Twitter Integration', '', '{"route":"admin_default", "action":"twitter", "controller":"settings", "module":"user"}', 'core_admin_main_settings', '', 1, 0, 4, 0),
(78, 'core_admin_main_janrain', 'user', 'Janrain Integration', '', '{"route":"admin_default", "action":"janrain", "controller":"settings", "module":"user"}', 'core_admin_main_settings', '', 1, 0, 4, 0),
(79, 'core_admin_main_settings_friends', 'user', 'Friendship Settings', '', '{"route":"admin_default","module":"user","controller":"settings","action":"friends"}', 'core_admin_main_settings', '', 1, 0, 6, 0),
(80, 'user_admin_banning_logins', 'user', 'Login History', '', '{"route":"admin_default","module":"user","controller":"logins","action":"index"}', 'core_admin_banning', '', 1, 0, 2, 0),
(81, 'authorization_admin_level_user', 'user', 'Members', '', '{"route":"admin_default","module":"user","controller":"settings","action":"level"}', 'authorization_admin_level', '', 1, 0, 2, 0),
(82, 'core_mini_messages', 'messages', 'Messages', 'Messages_Plugin_Menus', '', 'core_mini', '', 1, 0, 4, 0),
(83, 'user_profile_message', 'messages', 'Send Message', 'Messages_Plugin_Menus', '', 'user_profile', '', 1, 0, 2, 0),
(84, 'authorization_admin_level_messages', 'messages', 'Messages', '', '{"route":"admin_default","module":"messages","controller":"settings","action":"level"}', 'authorization_admin_level', '', 1, 0, 3, 0),
(85, 'messages_main_inbox', 'messages', 'Inbox', '', '{"route":"messages_general","action":"inbox"}', 'messages_main', '', 1, 0, 1, 0),
(86, 'messages_main_outbox', 'messages', 'Sent Messages', '', '{"route":"messages_general","action":"outbox"}', 'messages_main', '', 1, 0, 2, 0),
(87, 'messages_main_compose', 'messages', 'Compose Message', '', '{"route":"messages_general","action":"compose"}', 'messages_main', '', 1, 0, 3, 0),
(88, 'user_settings_network', 'network', 'Networks', '', '{"route":"user_extended", "module":"user", "controller":"settings", "action":"network"}', 'user_settings', '', 1, 0, 3, 0),
(89, 'core_main_invite', 'invite', 'Invite', 'Invite_Plugin_Menus::canInvite', '{"route":"default","module":"invite"}', 'core_main', '', 1, 0, 2, 0),
(90, 'user_home_invite', 'invite', 'Invite Your Friends', 'Invite_Plugin_Menus::canInvite', '{"route":"default","module":"invite","icon":"application/modules/Invite/externals/images/invite.png"}', 'user_home', '', 1, 0, 5, 0),
(91, 'core_admin_main_settings_storage', 'core', 'Storage System', '', '{"route":"admin_default","module":"storage","controller":"services","action":"index"}', 'core_admin_main_settings', '', 1, 0, 11, 0),
(92, 'user_settings_payment', 'user', 'Subscription', 'Payment_Plugin_Menus', '{"route":"default", "module":"payment", "controller":"settings", "action":"index"}', 'user_settings', '', 1, 0, 4, 0),
(93, 'core_admin_main_payment', 'payment', 'Billing', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_payment', 1, 0, 7, 0),
(94, 'core_admin_main_payment_transactions', 'payment', 'Transactions', '', '{"route":"admin_default","module":"payment","controller":"index","action":"index"}', 'core_admin_main_payment', '', 1, 0, 1, 0),
(95, 'core_admin_main_payment_settings', 'payment', 'Settings', '', '{"route":"admin_default","module":"payment","controller":"settings","action":"index"}', 'core_admin_main_payment', '', 1, 0, 2, 0),
(96, 'core_admin_main_payment_gateways', 'payment', 'Gateways', '', '{"route":"admin_default","module":"payment","controller":"gateway","action":"index"}', 'core_admin_main_payment', '', 1, 0, 3, 0),
(97, 'core_admin_main_payment_packages', 'payment', 'Plans', '', '{"route":"admin_default","module":"payment","controller":"package","action":"index"}', 'core_admin_main_payment', '', 1, 0, 4, 0),
(98, 'core_admin_main_payment_subscriptions', 'payment', 'Subscriptions', '', '{"route":"admin_default","module":"payment","controller":"subscription","action":"index"}', 'core_admin_main_payment', '', 1, 0, 5, 0),
(99, 'yntheme_admin_main_settings', 'yntheme', 'Global Settings', NULL, '{"route":"admin_default","module":"yntheme","controller":"settings"}', 'yntheme_admin_main', NULL, 1, 0, 999, 0),
(100, 'yntheme_admin_main_themes', 'yntheme', 'Themes', NULL, '{"route":"admin_default","module":"yntheme","controller":"themes"}', 'yntheme_admin_main', NULL, 1, 0, 999, 0),
(101, 'core_admin_main_plugins_yntheme', 'yntheme', 'YouNet Themes', NULL, '{"route":"admin_default","module":"yntheme","controller":"themes"}', 'core_admin_main_plugins', NULL, 0, 0, 999, 0),
(102, 'core_admin_main_plugins_ynresponsive1', 'ynresponsive1', 'YN - Responsive', '', '{"route":"admin_default","module":"ynresponsive1","controller":"settings"}', 'core_admin_main_plugins', '', 1, 0, 999, 0),
(103, 'ynresponsive1_admin_main_settings', 'ynresponsive1', 'Global Settings', '', '{"route":"admin_default","module":"ynresponsive1","controller":"settings"}', 'ynresponsive1_admin_main', '', 1, 0, 1, 0),
(104, 'core_admin_plugins_younet_core', 'younet-core', 'YouNet Core', '', '{"route":"admin_default","module":"younet-core","controller":"settings","action":"yours"}', 'core_admin_main_plugins', '', 1, 0, 1, 0),
(105, 'younet_core_admin_main_yours', 'younet-core', 'Your Plugins', '', '{"route":"admin_default","module":"younet-core","controller":"settings","action":"yours"}', 'younet_core_admin_main', '', 1, 0, 2, 0),
(106, 'younet_core_admin_main_younet', 'younet-core', 'YouNet Plugins', '', '{"route":"admin_default","module":"younet-core","controller":"settings","action":"younet"}', 'younet_core_admin_main', '', 1, 0, 1, 0),
(107, 'younet_core_admin_main_info', 'younet-core', 'License Term', '', '{"route":"admin_default","module":"younet-core","controller":"settings","action":"information"}', 'younet_core_admin_main', '', 1, 0, 3, 0),
(108, 'core_main_classified', 'classified', 'Classifieds', '', '{"route":"classified_general"}', 'core_main', '', 1, 0, 4, 0),
(109, 'core_sitemap_classified', 'classified', 'Classifieds', '', '{"route":"classified_general"}', 'core_sitemap', '', 1, 0, 4, 0),
(110, 'classified_main_browse', 'classified', 'Browse Listings', 'Classified_Plugin_Menus::canViewClassifieds', '{"route":"classified_general"}', 'classified_main', '', 1, 0, 1, 0),
(111, 'classified_main_manage', 'classified', 'My Listings', 'Classified_Plugin_Menus::canCreateClassifieds', '{"route":"classified_general","action":"manage"}', 'classified_main', '', 1, 0, 2, 0),
(112, 'classified_main_create', 'classified', 'Post a New Listing', 'Classified_Plugin_Menus::canCreateClassifieds', '{"route":"classified_general","action":"create"}', 'classified_main', '', 1, 0, 3, 0),
(113, 'classified_quick_create', 'classified', 'Post a New Listing', 'Classified_Plugin_Menus::canCreateClassifieds', '{"route":"classified_general","action":"create","class":"buttonlink icon_classified_new"}', 'classified_quick', '', 1, 0, 1, 0),
(114, 'core_admin_main_plugins_classified', 'classified', 'Classifieds', '', '{"route":"admin_default","module":"classified","controller":"manage"}', 'core_admin_main_plugins', '', 1, 0, 999, 0),
(115, 'classified_admin_main_manage', 'classified', 'View Classifieds', '', '{"route":"admin_default","module":"classified","controller":"manage"}', 'classified_admin_main', '', 1, 0, 1, 0),
(116, 'classified_admin_main_settings', 'classified', 'Global Settings', '', '{"route":"admin_default","module":"classified","controller":"settings"}', 'classified_admin_main', '', 1, 0, 2, 0),
(117, 'classified_admin_main_level', 'classified', 'Member Level Settings', '', '{"route":"admin_default","module":"classified","controller":"level"}', 'classified_admin_main', '', 1, 0, 3, 0),
(118, 'classified_admin_main_fields', 'classified', 'Classified Questions', '', '{"route":"admin_default","module":"classified","controller":"fields"}', 'classified_admin_main', '', 1, 0, 4, 0),
(119, 'classified_admin_main_categories', 'classified', 'Categories', '', '{"route":"admin_default","module":"classified","controller":"settings","action":"categories"}', 'classified_admin_main', '', 1, 0, 5, 0),
(120, 'authorization_admin_level_classified', 'classified', 'Classifieds', '', '{"route":"admin_default","module":"classified","controller":"level","action":"index"}', 'authorization_admin_level', '', 1, 0, 999, 0),
(121, 'mobi_browse_classified', 'classified', 'Classifieds', '', '{"route":"classified_general"}', 'mobi_browse', '', 1, 0, 4, 0),
(122, 'core_admin_main_plugins_ynlistings', 'ynlistings', 'YN Listings', '', '{"route":"admin_default","module":"ynlistings","controller":"settings", "action":"global"}', 'core_admin_main_plugins', '', 1, 0, 999, 0),
(123, 'ynlistings_admin_settings_global', 'ynlistings', 'Global Settings', '', '{"route":"admin_default","module":"ynlistings","controller":"settings", "action":"global"}', 'ynlistings_admin_main', '', 1, 0, 1, 0),
(124, 'ynlistings_admin_settings_level', 'ynlistings', 'Member Level Settings', '', '{"route":"admin_default","module":"ynlistings","controller":"settings", "action":"level"}', 'ynlistings_admin_main', '', 1, 0, 2, 0),
(125, 'ynlistings_admin_main_categories', 'ynlistings', 'Categories', '', '{"route":"admin_default","module":"ynlistings","controller":"category", "action":"index"}', 'ynlistings_admin_main', '', 1, 0, 3, 0),
(126, 'ynlistings_admin_main_listings', 'ynlistings', 'Manage Listings', '', '{"route":"admin_default","module":"ynlistings","controller":"listings", "action":"index"}', 'ynlistings_admin_main', '', 1, 0, 4, 0),
(127, 'ynlistings_admin_main_imports', 'ynlistings', 'Import Listings', '', '{"route":"admin_default","module":"ynlistings","controller":"imports", "action":"index"}', 'ynlistings_admin_main', '', 1, 0, 5, 0),
(128, 'ynlistings_admin_main_transactions', 'ynlistings', 'Manage Transactions', '', '{"route":"admin_default","module":"ynlistings","controller":"transactions", "action":"index"}', 'ynlistings_admin_main', '', 1, 0, 6, 0),
(129, 'ynlistings_admin_main_statistics', 'ynlistings', 'Statistics', '', '{"route":"admin_default","module":"ynlistings","controller":"statistics", "action":"index"}', 'ynlistings_admin_main', '', 1, 0, 7, 0),
(130, 'ynlistings_admin_main_reports', 'ynlistings', 'Manage Reports', '', '{"route":"admin_default","module":"ynlistings","controller":"report", "action":"manage"}', 'ynlistings_admin_main', '', 1, 0, 8, 0),
(131, 'ynlistings_admin_main_faqs', 'ynlistings', 'Manage FAQs', '', '{"route":"admin_default","module":"ynlistings","controller":"faqs", "action":"index"}', 'ynlistings_admin_main', '', 1, 0, 9, 0),
(132, 'core_main_ynlistings', 'ynlistings', 'Listings', '', '{"route":"ynlistings_general"\n}', 'core_main', '', 1, 0, 5, 0),
(133, 'ynlistings_main_home', 'ynlistings', 'Listings Home Page', '', '{"route":"ynlistings_general","module":"ynlistings","controller":"index","action":"index"}', 'ynlistings_main', '', 1, 0, 1, 0),
(134, 'ynlistings_main_browse', 'ynlistings', 'Browse Listings', '', '{"route":"ynlistings_general","module":"ynlistings","controller":"index","action":"browse"}', 'ynlistings_main', '', 1, 0, 2, 0),
(135, 'ynlistings_main_manage', 'ynlistings', 'My Listings', 'Ynlistings_Plugin_Menus', '{"route":"ynlistings_general","module":"ynlistings","controller":"index","action":"manage"}', 'ynlistings_main', '', 1, 0, 3, 0),
(136, 'ynlistings_main_post_listing', 'ynlistings', 'Post A New Listing', 'Ynlistings_Plugin_Menus', '{"route":"ynlistings_general","module":"ynlistings","controller":"index","action":"create"}', 'ynlistings_main', '', 1, 0, 4, 0),
(137, 'ynlistings_main_import_listing', 'ynlistings', 'Import Listings', 'Ynlistings_Plugin_Menus', '{"route":"ynlistings_general","module":"ynlistings","controller":"index","action":"import"}', 'ynlistings_main', '', 1, 0, 5, 0),
(138, 'ynlistings_main_faqs', 'ynlistings', 'FAQs', '', '{"route":"ynlistings_faqs","module":"ynlistings","controller":"faqs"}', 'ynlistings_main', '', 1, 0, 6, 0),
(139, 'core_admin_main_plugins_advmenusystem', 'advmenusystem', 'Adv Menu System', '', '{"route":"admin_default","module":"advmenusystem","controller":"menus"}', 'core_admin_main_plugins', '', 1, 0, 999, 0),
(140, 'advmenusystem_admin_main_menus', 'advmenusystem', 'Menu Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"menus"}', 'advmenusystem_admin_main', '', 1, 0, 2, 0),
(141, 'advmenusystem_admin_main_styles', 'advmenusystem', 'Style Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"styles"}', 'advmenusystem_admin_main', '', 1, 0, 3, 0),
(142, 'advmenusystem_admin_contents_menu', 'advmenusystem', 'Content Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"contents"}', 'advmenusystem_admin_main', '', 1, 0, 4, 0),
(143, 'advmenusystem_admin_socials_menu', 'advmenusystem', 'Social Link Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"socials"}', 'advmenusystem_admin_main', '', 1, 0, 5, 0),
(144, 'core_main_question', 'question', 'Questions & Answers', '', '{"route":"default","module":"question"}', 'core_main', '', 1, 0, 4, 0),
(145, 'mobi_browse_question', 'question', 'Questions & Answers', '', '{"route":"default","module":"question"}', 'mobi_browse', '', 1, 0, 999, 0),
(146, 'core_admin_main_plugins_question', 'question', 'Questions', '', '{"route":"admin_default","module":"question","controller":"settings"}', 'core_admin_main_plugins', '', 1, 0, 999, 0),
(147, 'question_admin_main_manage', 'question', 'View Questions', '', '{"route":"admin_default","module":"question","controller":"manage"}', 'question_admin_main', '', 1, 0, 1, 0),
(148, 'question_admin_main_settings', 'question', 'Global Settings', '', '{"route":"admin_default","module":"question","controller":"settings"}', 'question_admin_main', '', 1, 0, 2, 0),
(149, 'question_admin_main_level', 'question', 'Member Level Settings', '', '{"route":"admin_default","module":"question","controller":"level"}', 'question_admin_main', '', 1, 0, 3, 0),
(150, 'question_admin_main_categories', 'question', 'Categories', '', '{"route":"admin_default","module":"question","controller":"settings", "action":"categories"}', 'question_admin_main', '', 1, 0, 4, 0),
(151, 'question_main_browse', 'question', 'Browse All', 'Question_Plugin_Menus::canViewQuestions', '{"route":"default","module":"question","controller":"index","action":"index"}', 'question_main', '', 1, 0, 1, 0),
(152, 'question_main_manage', 'question', 'My Questions', 'Question_Plugin_Menus::canCreateQuestions', '{"route":"default","module":"question","controller":"index","action":"manage"}', 'question_main', '', 1, 0, 2, 0),
(153, 'question_main_ratings', 'question', 'Ratings', 'Question_Plugin_Menus::canViewQuestions', '{"route":"default","module":"question","controller":"index","action":"rating"}', 'question_main', '', 1, 0, 3, 0),
(154, 'question_main_create', 'question', 'Ask a Question', 'Question_Plugin_Menus::canCreateQuestions', '{"route":"default","module":"question","controller":"index","action":"create"}', 'question_main', '', 1, 0, 4, 0),
(155, 'question_main_unanswered', 'question', 'Unanswered', '', '{"route":"default","module":"question","controller":"index","action":"unanswered"}', 'question_main', '', 1, 0, 5, 0),
(156, 'core_admin_main_plugins_custom', 'custom', 'Customs', '', '{"route":"admin_default","module":"custom","controller":"manage"}', 'core_admin_main_plugins', '', 1, 0, 999, 0),
(157, 'custom_admin_main_manage', 'custom', 'Sliders', '', '{"route":"admin_default","module":"custom","controller":"manage"}', 'custom_admin_main', '', 1, 0, 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_menus`
--

CREATE TABLE IF NOT EXISTS `engine4_core_menus` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `type` enum('standard','hidden','custom') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'standard',
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(3) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `order` (`order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `engine4_core_menus`
--

INSERT INTO `engine4_core_menus` (`id`, `name`, `type`, `title`, `order`) VALUES
(1, 'core_main', 'standard', 'Main Navigation Menu', 1),
(2, 'core_mini', 'standard', 'Mini Navigation Menu', 2),
(3, 'core_footer', 'standard', 'Footer Menu', 3),
(4, 'core_sitemap', 'standard', 'Sitemap', 4),
(5, 'user_home', 'standard', 'Member Home Quick Links Menu', 999),
(6, 'user_profile', 'standard', 'Member Profile Options Menu', 999),
(7, 'user_edit', 'standard', 'Member Edit Profile Navigation Menu', 999),
(8, 'user_browse', 'standard', 'Member Browse Navigation Menu', 999),
(9, 'user_settings', 'standard', 'Member Settings Navigation Menu', 999),
(10, 'messages_main', 'standard', 'Messages Main Navigation Menu', 999),
(11, 'classified_main', 'standard', 'Classified Main Navigation Menu', 999),
(12, 'classified_quick', 'standard', 'Classified Quick Navigation Menu', 999),
(13, 'ynlistings_main', 'standard', 'YN Listings Main Navigation Menu', 999),
(14, 'question_main', 'standard', 'Q&A Main Navigation Menu', 999);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_migrations`
--

CREATE TABLE IF NOT EXISTS `engine4_core_migrations` (
  `package` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `current` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`package`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_modules`
--

CREATE TABLE IF NOT EXISTS `engine4_core_modules` (
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `version` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('core','standard','extra') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'extra',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_modules`
--

INSERT INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES
('activity', 'Activity', 'Activity', '4.8.12', 1, 'core'),
('advmenusystem', 'YN - Advanced Menu System', 'This is Advanced Menu System module.', '4.04p5', 1, 'extra'),
('announcement', 'Announcements', 'Announcements', '4.8.0', 1, 'standard'),
('authorization', 'Authorization', 'Authorization', '4.7.0', 1, 'core'),
('classified', 'Classifieds', 'Classifieds', '4.8.10', 1, 'extra'),
('core', 'Core', 'Core', '4.8.12', 1, 'core'),
('custom', 'Custom', 'Customization', '4.0.0', 1, 'extra'),
('fields', 'Fields', 'Fields', '4.8.12', 1, 'core'),
('invite', 'Invite', 'Invite', '4.8.7', 1, 'standard'),
('messages', 'Messages', 'Messages', '4.8.12', 1, 'standard'),
('network', 'Networks', 'Networks', '4.8.6', 1, 'standard'),
('payment', 'Payment', 'Payment', '4.8.11', 1, 'standard'),
('question', 'Questions', 'Questions & Answers Plugin', '4.7.0p8', 1, 'extra'),
('storage', 'Storage', 'Storage', '4.8.9', 1, 'core'),
('user', 'Members', 'Members', '4.8.12', 1, 'core'),
('ynlistings', 'YN - Listings', 'This is YouNet Listings Module', '4.01p5', 0, 'extra'),
('ynresponsive1', 'YN - Responsive Core', 'YouNet Responsive Module', '4.05', 1, 'extra'),
('ynresponsiveclean', 'YN - Responsive Clean Template', 'Responsive Clean Template', '4.02', 1, 'extra'),
('yntheme', 'YN - Themes Core', 'Manage YouNet Themes', '4.04p1', 1, 'extra'),
('younet-core', 'YN - Core Module', 'YouNet Core Module', '4.02p9', 1, 'extra');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_nodes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_nodes` (
  `node_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `signature` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `first_seen` datetime NOT NULL,
  `last_seen` datetime NOT NULL,
  PRIMARY KEY (`node_id`),
  UNIQUE KEY `signature` (`signature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_pages`
--

CREATE TABLE IF NOT EXISTS `engine4_core_pages` (
  `page_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `displayname` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `keywords` text COLLATE utf8_unicode_ci NOT NULL,
  `custom` tinyint(1) NOT NULL DEFAULT '1',
  `fragment` tinyint(1) NOT NULL DEFAULT '0',
  `layout` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `levels` text COLLATE utf8_unicode_ci,
  `provides` text COLLATE utf8_unicode_ci,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=50 ;

--
-- Dumping data for table `engine4_core_pages`
--

INSERT INTO `engine4_core_pages` (`page_id`, `name`, `displayname`, `url`, `title`, `description`, `keywords`, `custom`, `fragment`, `layout`, `levels`, `provides`, `view_count`, `search`) VALUES
(1, 'header', 'Site Header', NULL, '', '', '', 0, 1, '', NULL, 'header-footer', 0, 0),
(2, 'footer', 'Site Footer', NULL, '', '', '', 0, 1, '', NULL, 'header-footer', 0, 0),
(3, 'core_index_index', 'Landing Page', NULL, 'Landing Page', 'This is your site''s landing page.', '', 0, 0, '', NULL, 'no-viewer;no-subject', 0, 0),
(4, 'user_index_home', 'Member Home Page', NULL, 'Member Home Page', 'This is the home page for members.', '', 0, 0, '', NULL, 'viewer;no-subject', 0, 0),
(5, 'user_profile_index', 'Member Profile', NULL, 'Member Profile', 'This is a member''s profile.', '', 0, 0, '', NULL, 'subject=user', 0, 0),
(6, 'core_help_contact', 'Contact Page', NULL, 'Contact Us', 'This is the contact page', '', 0, 0, '', NULL, 'no-viewer;no-subject', 0, 0),
(7, 'core_help_privacy', 'Privacy Page', NULL, 'Privacy Policy', 'This is the privacy policy page', '', 0, 0, '', NULL, 'no-viewer;no-subject', 0, 0),
(8, 'core_help_terms', 'Terms of Service Page', NULL, 'Terms of Service', 'This is the terms of service page', '', 0, 0, '', NULL, 'no-viewer;no-subject', 0, 0),
(9, 'core_error_requireuser', 'Sign-in Required Page', NULL, 'Sign-in Required', '', '', 0, 0, '', NULL, NULL, 0, 0),
(10, 'core_search_index', 'Search Page', NULL, 'Search Results', '', '', 0, 0, '', NULL, NULL, 0, 0),
(11, 'user_auth_login', 'Sign-in Page', NULL, 'Sign-in', 'This is the site sign-in page.', '', 0, 0, '', NULL, NULL, 0, 0),
(12, 'user_signup_index', 'Sign-up Page', NULL, 'Sign-up', 'This is the site sign-up page.', '', 0, 0, '', NULL, NULL, 0, 0),
(13, 'user_auth_forgot', 'Forgot Password Page', NULL, 'Forgot Password', 'This is the site forgot password page.', '', 0, 0, '', NULL, NULL, 0, 0),
(14, 'user_settings_general', 'User General Settings Page', NULL, 'General', 'This page is the user general settings page.', '', 0, 0, '', NULL, NULL, 0, 0),
(15, 'user_settings_privacy', 'User Privacy Settings Page', NULL, 'Privacy', 'This page is the user privacy settings page.', '', 0, 0, '', NULL, NULL, 0, 0),
(16, 'user_settings_network', 'User Networks Settings Page', NULL, 'Networks', 'This page is the user networks settings page.', '', 0, 0, '', NULL, NULL, 0, 0),
(17, 'user_settings_notifications', 'User Notifications Settings Page', NULL, 'Notifications', 'This page is the user notification settings page.', '', 0, 0, '', NULL, NULL, 0, 0),
(18, 'user_settings_password', 'User Change Password Settings Page', NULL, 'Change Password', 'This page is the change password page.', '', 0, 0, '', NULL, NULL, 0, 0),
(19, 'user_settings_delete', 'User Delete Account Settings Page', NULL, 'Delete Account', 'This page is the delete accout page.', '', 0, 0, '', NULL, NULL, 0, 0),
(20, 'user_index_browse', 'Member Browse Page', NULL, 'Member Browse', 'This page show member lists.', '', 0, 0, '', NULL, NULL, 0, 0),
(21, 'invite_index_index', 'Invite Page', NULL, 'Invite', '', '', 0, 0, '', NULL, NULL, 0, 0),
(22, 'messages_messages_compose', 'Messages Compose Page', NULL, 'Compose', '', '', 0, 0, '', NULL, NULL, 0, 0),
(23, 'messages_messages_inbox', 'Messages Inbox Page', NULL, 'Inbox', '', '', 0, 0, '', NULL, NULL, 0, 0),
(24, 'messages_messages_outbox', 'Messages Outbox Page', NULL, 'Inbox', '', '', 0, 0, '', NULL, NULL, 0, 0),
(25, 'messages_messages_search', 'Messages Search Page', NULL, 'Search', '', '', 0, 0, '', NULL, NULL, 0, 0),
(26, 'messages_messages_view', 'Messages View Page', NULL, 'My Message', '', '', 0, 0, '', NULL, NULL, 0, 0),
(27, 'classified_index_index', 'Classified Home Page', NULL, 'Classified Browse', 'This page lists classifieds.', '', 0, 0, '', NULL, NULL, 0, 0),
(28, 'classified_index_view', 'Classified View Page', NULL, 'View Classified', 'This is the view page for a classified.', '', 0, 0, '', NULL, 'subject=classified', 0, 0),
(29, 'classified_index_create', 'Classified Create Page', NULL, 'Post a New Listing', 'This page is the classified create page.', '', 0, 0, '', NULL, NULL, 0, 0),
(30, 'classified_index_manage', 'Classified Manage Page', NULL, 'My Listings', 'This page lists a user''s classifieds.', '', 0, 0, '', NULL, NULL, 0, 0),
(31, 'ynlistings_index_index', 'YN - Listings Home Page', NULL, 'Home Listings', 'This page is listing home page.', '', 0, 0, '', NULL, NULL, 0, 0),
(32, 'ynlistings_index_manage', 'YN - Listings My Listings Page', NULL, 'My Listings', 'This page lists a user''s listings', '', 0, 0, '', NULL, NULL, 0, 0),
(33, 'ynlistings_index_browse', 'YN - Listings Browse Listings Page', NULL, 'Browse Listings', 'This page lists search result listings', '', 0, 0, '', NULL, NULL, 0, 0),
(34, 'ynlistings_index_create', 'YN - Listings Post a new listing', NULL, 'Post a new listing', 'Post a new listing', '', 0, 0, '', NULL, NULL, 0, 0),
(35, 'ynlistings_faqs_index', 'YN - Listings FAQs Page', NULL, 'FAQs', 'This page show the FAQs', '', 0, 0, '', NULL, NULL, 0, 0),
(36, 'ynlistings_index_import', 'YN - Listings Import listings', NULL, 'Import listings', 'Import listings', '', 0, 0, '', NULL, NULL, 0, 0),
(37, 'ynlistings_index_view', 'YN - Listings Profile Listing Page', NULL, 'Profile listing page', 'Profile listing page', '', 0, 0, '', NULL, NULL, 0, 0),
(38, 'ynlistings_index_print', 'YN - Listings Print Listing Page', NULL, 'Print listing page', 'Print listing page', '', 0, 0, '', NULL, NULL, 0, 0),
(39, 'ynlistings_index_edit', 'YN - Listings Edit Listing', NULL, 'Edit Listing', 'Edit listing', '', 0, 0, '', NULL, NULL, 0, 0),
(40, 'ynlistings_index_mobileview', 'YN - Listings Mobile Profile Listing Page', NULL, 'Mobile Profile listing page', 'Mobile Profile listing page', '', 0, 0, '', NULL, NULL, 0, 0),
(41, 'question_index_index', 'Q&A: Browse Page', NULL, 'Q&A: Browse Page', 'Show all Questions on your site.', '', 0, 0, '', NULL, NULL, 0, 0),
(42, 'question_index_manage', 'Q&A: Manage Questions', NULL, 'Q&A: Manage Questions', 'Show members of theirs questions.', '', 0, 0, '', NULL, NULL, 0, 0),
(43, 'question_index_rating', 'Q&A: Ratings', NULL, 'Q&A: Ratings', 'Show members ratings.', '', 0, 0, '', NULL, NULL, 0, 0),
(44, 'question_index_create', 'Q&A: Ask a Question', NULL, 'Q&A: Ask a Question', 'Show page for ask a Question.', '', 0, 0, '', NULL, NULL, 0, 0),
(45, 'question_index_view', 'Q&A: View a Question', NULL, 'Q&A: View a Question', 'Show page view a Question.', '', 0, 0, '', NULL, NULL, 0, 0),
(46, 'question_index_edit', 'Q&A: Edit a Question', NULL, 'Q&A: Edit a Question', 'Show page for edit a Question.', '', 0, 0, '', NULL, NULL, 0, 0),
(47, 'question_index_answers', 'Q&A: User Answers', NULL, 'Q&A: User Answers', 'Show user answers.', '', 0, 0, '', NULL, NULL, 0, 0),
(48, 'question_index_unanswered', 'Q&A: Unanswered Questions', NULL, 'Q&A: Unanswered Questions', 'Show only unanswered questions.', '', 0, 0, '', NULL, NULL, 0, 0),
(49, 'classified_index_browse', 'Classified Browse Page', NULL, '', '', '', 1, 0, '', NULL, 'no-subject', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_processes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_processes` (
  `pid` int(10) unsigned NOT NULL,
  `parent_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `system_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `started` int(10) unsigned NOT NULL,
  `timeout` mediumint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_referrers`
--

CREATE TABLE IF NOT EXISTS `engine4_core_referrers` (
  `host` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `query` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `value` int(11) unsigned NOT NULL,
  PRIMARY KEY (`host`,`path`,`query`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_reports`
--

CREATE TABLE IF NOT EXISTS `engine4_core_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `subject_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) NOT NULL,
  `creation_date` datetime NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`report_id`),
  KEY `category` (`category`),
  KEY `user_id` (`user_id`),
  KEY `read` (`read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_routes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_routes` (
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`),
  KEY `order` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_search`
--

CREATE TABLE IF NOT EXISTS `engine4_core_search` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hidden` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type`,`id`),
  FULLTEXT KEY `LOOKUP` (`title`,`description`,`keywords`,`hidden`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_search`
--

INSERT INTO `engine4_core_search` (`type`, `id`, `title`, `description`, `keywords`, `hidden`) VALUES
('user', 1, 'admin', '', '', ''),
('classified', 1, 'Buffet Ăn Không Giới Hạn 60 Món Lẩu Hải Sản, Bò Mỹ Cao Cấp Tại', 'Lu&ocirc;n giữ được hương vị đặc trưng, tự nhi&ecirc;n của m&oacute;n ăn, nguy&ecirc;n liệu th&igrave; v&ocirc; c&ugrave;ng phong ph&uacute;, đa dạng v&agrave; rất hợp cho những buổi li&ecirc;n hoan, tiệc t&ugrave;ng, th', '', ''),
('classified_album', 1, 'Buffet Ăn Không Giới Hạn 60 Món Lẩu Hải Sản, Bò Mỹ Cao Cấp Tại', '', '', ''),
('classified', 2, 'Hệ Thống Bánh Chewy Junior - Bánh Sự Kiện/ Sinh Nhật', 'V&agrave;o những dịp trọng thể như ng&agrave;y lễ kỷ niệm, ng&agrave;y diễn ra chương tr&igrave;nh, sự kiện của c&aacute; nh&acirc;n hay c&ocirc;ng ty, ch&uacute;ng ta kh&ocirc;ng thể thiếu phần chi&ecirc;u đ&atilde;i thự', '', ''),
('classified_album', 2, 'Hệ Thống Bánh Chewy Junior - Bánh Sự Kiện/ Sinh Nhật', '', '', ''),
('classified', 3, 'International Buffet BBQ Tối Thứ 7 Hàng Tuần Tại Tầng 25 Windso', 'Thưởng thức tiệc buffet chắc chắn kh&ocirc;ng c&ograve;n qu&aacute; mới mẻ với những thực kh&aacute;ch đam m&ecirc; ăn uống. Nhưng cảm gi&aacute;c được d&ugrave;ng tiệc buffet tr&ecirc;n tầng cao: vừa thưởng thức', '', ''),
('classified_album', 3, 'International Buffet BBQ Tối Thứ 7 Hàng Tuần Tại Tầng 25 Windso', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_serviceproviders`
--

CREATE TABLE IF NOT EXISTS `engine4_core_serviceproviders` (
  `serviceprovider_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serviceprovider_id`),
  UNIQUE KEY `type` (`type`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

--
-- Dumping data for table `engine4_core_serviceproviders`
--

INSERT INTO `engine4_core_serviceproviders` (`serviceprovider_id`, `title`, `type`, `name`, `class`, `enabled`) VALUES
(1, 'MySQL', 'database', 'mysql', 'Engine_ServiceLocator_Plugin_Database_Mysql', 1),
(2, 'PDO MySQL', 'database', 'mysql_pdo', 'Engine_ServiceLocator_Plugin_Database_MysqlPdo', 1),
(3, 'MySQLi', 'database', 'mysqli', 'Engine_ServiceLocator_Plugin_Database_Mysqli', 1),
(4, 'File', 'cache', 'file', 'Engine_ServiceLocator_Plugin_Cache_File', 1),
(5, 'APC', 'cache', 'apc', 'Engine_ServiceLocator_Plugin_Cache_Apc', 1),
(6, 'Memcache', 'cache', 'memcached', 'Engine_ServiceLocator_Plugin_Cache_Memcached', 1),
(7, 'Simple', 'captcha', 'image', 'Engine_ServiceLocator_Plugin_Captcha_Image', 1),
(8, 'ReCaptcha', 'captcha', 'recaptcha', 'Engine_ServiceLocator_Plugin_Captcha_Recaptcha', 1),
(9, 'SMTP', 'mail', 'smtp', 'Engine_ServiceLocator_Plugin_Mail_Smtp', 1),
(10, 'Sendmail', 'mail', 'sendmail', 'Engine_ServiceLocator_Plugin_Mail_Sendmail', 1),
(11, 'GD', 'image', 'gd', 'Engine_ServiceLocator_Plugin_Image_Gd', 1),
(12, 'Imagick', 'image', 'imagick', 'Engine_ServiceLocator_Plugin_Image_Imagick', 1),
(13, 'Akismet', 'akismet', 'standard', 'Engine_ServiceLocator_Plugin_Akismet', 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_services`
--

CREATE TABLE IF NOT EXISTS `engine4_core_services` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `profile` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'default',
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_id`),
  UNIQUE KEY `type` (`type`,`profile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_servicetypes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_servicetypes` (
  `servicetype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `interface` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servicetype_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `engine4_core_servicetypes`
--

INSERT INTO `engine4_core_servicetypes` (`servicetype_id`, `title`, `type`, `interface`, `enabled`) VALUES
(1, 'Database', 'database', 'Zend_Db_Adapter_Abstract', 1),
(2, 'Cache', 'cache', 'Zend_Cache_Backend', 1),
(3, 'Captcha', 'captcha', 'Zend_Captcha_Adapter', 1),
(4, 'Mail Transport', 'mail', 'Zend_Mail_Transport_Abstract', 1),
(5, 'Image', 'image', 'Engine_Image_Adapter_Abstract', 1),
(6, 'Akismet', 'akismet', 'Zend_Service_Akismet', 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_session`
--

CREATE TABLE IF NOT EXISTS `engine4_core_session` (
  `id` char(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_session`
--

INSERT INTO `engine4_core_session` (`id`, `modified`, `lifetime`, `data`, `user_id`) VALUES
('00urha3se1pq2f3iq8q65ok7u3', 1476598818, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('040mtq82fq04331ith77d1tuh1', 1477120855, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('04kf4nh7ebeof3pi4p5timo7l5', 1474779168, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('0m0jd0i78tr9tr980orc5nl6i6', 1474780514, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('0mvcf1usn4ik3j8mfirqafico7', 1474787152, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('0o6872nd9j2bejkmpg9te0tef6', 1474781300, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('0oups3hb6ecui6krfi8klnmq10', 1476589884, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('0p9g57mfgtkbgkusf7s450g5v4', 1474769806, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('0rodo3ofeehchd2m2he7gpkt65', 1474783847, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('0so6cvcl6g87o2rmvfrk5p7pe1', 1474806843, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('0su569uot17kbte14u0ra789r1', 1474771797, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('0u9t3a6rsjt10a7qi2phopntt5', 1474806516, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('12h2ttal8m5ohuf88bn1fil9s1', 1474818139, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('149s5b0v7d5u94k3lp54c9bm96', 1474774884, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('17prspn43thjol5ho3voomc2t5', 1474819846, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('1cblb8h8g7mmtglr66cu7b7le0', 1476601041, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('1d1hcnnmpeqll854g8rj3s2jc7', 1476602149, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('1gifrf1uefnhq12aj2cd13qn01', 1474810161, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('1s5c6qh4sl5hg0732tn4ofjd47', 1476598713, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('1vhsbvic76ltprb858638oo0o4', 1476598649, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('26krmfnmb476015se3j2eb54c6', 1476588656, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('27paeb231t996145pq63lctji3', 1474775255, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('2mpnbpa6d0pa88glnu0i2bukj4', 1476603363, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('2na79ltmagn02968jc5pjp6ag0', 1474775504, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('376fiqmph1v52e9iue1jb9tdu5', 1476602025, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('3ekd0eak3iaaqbst3cm6b20ps0', 1476601776, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('3id90u4igaotaokooeojb2bqc7', 1474769516, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('3osolfjuehshrbrkj9thhsqbq5', 1476599588, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('3pho0amietp368lg61idtqa897', 1476601408, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('49hvnhvbno7vkip7smicaums10', 1474779414, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('4esiqsuq2bn3lmefj8a0vgfun3', 1474771552, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('4ud033j31j31og43js92tg5su5', 1474772045, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('5312sot1l6cs4h9vrj45is7g65', 1474818072, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('5547q3lhk9jf8i13k0foqo0t15', 1474806594, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('58rgoh0765km7ehn2megp2fi50', 1474771180, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('5sdvk2btpn96sajs5mtbqooor7', 1474772168, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('69u6vb92qq2aq8q8jbpv1v13h1', 1474816370, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('6b5ko4qej12pd5fasdl7ugeqt6', 1474770567, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('6bgkc4f09lu29fpsqj4gt0m8o5', 1474772669, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('6ie4mcau0o4mhpfvqe5jld7c32', 1474777937, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('6jhll71q8291hjv0q1n8kictj1', 1474777691, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('6papmlvtg00slfr00fh8ojc437', 1476620013, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('72j6buqvdcdtln99tpdv3o7gl5', 1474775008, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('75ftf4d1mhdomtnvdlcfi2o0a0', 1474787302, 86400, 'mobile|a:1:{s:6:"mobile";N;}ynbusinesspages_business|a:1:{s:10:"businessId";N;}redirectURL|s:18:"/behoi/classifieds";User_Plugin_Signup_Account|a:2:{s:6:"active";b:1;s:4:"data";N;}User_Plugin_Signup_Fields|a:1:{s:6:"active";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:"active";b:1;}', NULL),
('782grh7tk6vsrbjoi4v6vrd401', 1474820316, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('7cuvi34cl87m6o7f16jvoeqko2', 1476589097, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('7kjsvh2j814v6uda73adc68734', 1474780080, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('7tpgh35b5h4guvc13epu4e17c1', 1474771303, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('81jjea418d2er8ea127mhlbm42', 1474820379, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('850jbtojhdt974m1n8pdjrsg25', 1474809403, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('8grk7q6j7fj3n566vjm091vkb0', 1474774387, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('8un2249qpso9eo4pb2i0d3ird1', 1476599517, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('8vll4k5uqb28ropf3v9jqrd3l0', 1474769930, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('9kekrt02rium17khg6p3vjuq72', 1476601675, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('9lb43dr8bm0eev3q13j4v68a46', 1476613466, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('9lftvlinap3os1pec26tvcql27', 1474779044, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('9npeiut644t5o3d0746f26r373', 1474768924, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('a4clt5du7m9r6nke2bq223qpb4', 1476603295, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('aclhe3ircjda6m6cs9int38kc7', 1476601306, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('anfl49qtnmkabgrfrtd6mrr0u2', 1474816993, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('aolbr8okjad0l864m75bbmeb25', 1476598583, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('b4fr5pb743r8nkqko2bqksa9g5', 1474772730, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('b56lkok5qectdgvd1ruk4oqs13', 1474809280, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('b741u3ou39vn1hsbuvavbbd5i7', 1474808911, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('b7ra6njbkau7d7bvb1f8m9dca4', 1474769867, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('b9lrhsob4v0g9ak1kra1puqp44', 1474775380, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('bd193obcaotk8lkfufqg3brje0', 1474775132, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('bt0dj53uc7pasvkhogd4jfcao1', 1474817161, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('cahutlcs7ql5jqbh5lv4j17s04', 1474773769, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('chigncjmulgbs6ov5hqs1g0qn3', 1476598893, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('cqb5ce1iobjgcfv4k90mcq52m7', 1474821193, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('ct6qa8teuk8ah06l9dlkgrmsj4', 1474817804, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('d61cbobfq6ecu3ek9akbag1uj4', 1476601140, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('d6mumltamk6n129pho4vv9ud50', 1474786213, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('d84i710f3982r9u333g14sds94', 1474821379, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('d8dufivuv681f29n0vq7d6u780', 1474778920, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('d93jtfrhf6orv94q1geamhmop6', 1476588723, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('dj184gsugdps3m8dpcclg3r0e2', 1476620137, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('dpfu357te5vaaf1c7ont7mpg45', 1474770075, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('due6k7gh8bcgc1n7b8lc7uq571', 1476590048, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('e0a889tca0pjdc7cvoj3fbb9t4', 1477120575, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('e0trrtb99vmh6rh6el800nba95', 1474818302, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('e330f81c986deada353add8cdcb39b68', 1477120894, 86400, 'mobile|a:1:{s:6:"mobile";N;}ynbusinesspages_business|a:1:{s:10:"businessId";N;}redirectURL|s:12:"/behoi/login";User_Plugin_Signup_Account|a:2:{s:6:"active";b:1;s:4:"data";N;}User_Plugin_Signup_Fields|a:1:{s:6:"active";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:"active";b:1;}Zend_Auth|a:1:{s:7:"storage";i:1;}login_id|s:2:"12";', 1),
('e7ohbvtu7vqt2ff032jto3ea44', 1474772416, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('f6vdo9v2inau5cgssnecllnh30', 1474810321, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('fg44ls2ufghmusp9h9hh7a1581', 1476600068, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('flgoiudj1ov43188mau4qes9t7', 1474810031, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('fp96s2ika80po72ucsbfs1mn76', 1474773399, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('g2tuq8bpot1dp5ttassu365fn4', 1474821010, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('g6rrhun1f3nb4cgutr3h15lof0', 1474771921, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('g7dpq016t0qp1svvi9ituc5fo0', 1474774634, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('gctka9stk74knjvui21fq48mk2', 1474810094, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('gf219agk9ughe9pftfah7vtca5', 1474779525, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('gfsihc5kf0pnvmeotoue9sgai3', 1474772545, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('gg5jgbio404glu5i5gf35cd855', 1474816435, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('gsfn79jpiu3o01keddekqh4l83', 1474784333, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('h6n5019absttto9oin1g3must1', 1474770444, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('h9q4p2hjb7fkbvk91cnvattpj4', 1476621558, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('hen69r4g7dbj0ssa41k0knpgg1', 1474810949, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('hoduvm83f6r0tchdatdg4seso3', 1474773588, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('hpqe34iqj5jm7tinca4t9lad66', 1476620544, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('i2vffbqehghjl3v4mmsf9vec21', 1474772888, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('i4a4u5mihug259h8fb3fdb92h1', 1476620138, 86400, 'mobile|a:1:{s:6:"mobile";N;}redirectURL|s:12:"/behoi/login";ynbusinesspages_business|a:1:{s:10:"businessId";N;}Zend_Auth|a:1:{s:7:"storage";i:1;}login_id|s:2:"11";ActivityFormToken|a:1:{s:5:"token";s:32:"bc3dbbf7664edd3562a773d57b104599";}twitter_lock|i:1;twitter_uid|b:0;', 1),
('i6uari3ql6hoies4e0jq38u112', 1476599987, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('idb5oe8l4brgaa4ttmekeo1rs6', 1474816646, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('if75o85q472t1h1144g4ktlgo6', 1476600392, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('ihre8i7qum7anrkgevvt0oeuo3', 1474817913, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('iqa8u9obmcja44kq0gqhnopmm2', 1474820892, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('j9dgpn326h95gj694e7dlhl9j3', 1474811021, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('jiiiblankim1jn0ujtqhs0qu37', 1474821133, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('jjrdkhjqhh1c49knblj06e7th1', 1474774760, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('k33h3gsqanu4pb3n4f6rvb4213', 1474770934, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('kf6fvdh8ddp6f071uiusq1qhi6', 1474819624, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('kiu2ga1n4pldov5mobgd0ufbr0', 1476601247, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('kmes56ffbnranar56djp7rb046', 1476601901, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('l4b4sn188q468e3mdtqk6ddpk1', 1474808211, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('l5c26ifvqt0hjqtrtcvpv6pah3', 1476619939, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('l6el1dcmjbihh9jg06pfrotsr0', 1474774264, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('lcqibevk9mjpsm52sd923i3mh0', 1474773513, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('lfeh3vrblesbfkf31nv3r14ls6', 1474770198, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('lg8t2t995ihmbpra0rskcevk67', 1474780231, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('m5kvs1885p46mc21653ikr2pc0', 1474774015, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('m5ocfuqock3glodpqoel5u9051', 1474806590, 86400, 'mobile|a:1:{s:6:"mobile";N;}ynbusinesspages_business|a:1:{s:10:"businessId";N;}redirectURL|s:7:"/behoi/";User_Plugin_Signup_Account|a:2:{s:6:"active";b:1;s:4:"data";N;}User_Plugin_Signup_Fields|a:1:{s:6:"active";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:"active";b:1;}', NULL),
('mbf5olvvupolf72bu4p5k5sa14', 1474808420, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('mcmhjonlhmggsao36jpgrvd1r1', 1474780714, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('me2hr2lfh9ihikck55o7db7nd0', 1474771427, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('mgl4bslrqlgei6olhn1uccr2e2', 1474787029, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('mkpsvads2in3bpuq7qcih79vk2', 1474774510, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('mm1lfrbsbb5hb5qt05m59deh61', 1476588443, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('mnt4brqfqvns7si6pcvr6hqcg3', 1474783728, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('msvgkmjfvp85059je7ejp15op4', 1474809158, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('mtbrad3po956vgrmrd1tqa2s06', 1476599918, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('n0l6jtdge70r7o7k6ajhuo5p27', 1474820763, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('n0tuvraq0skacug3h1730pj6s4', 1476598965, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('n20c0gak08ktqashlhudnd2rb0', 1474821639, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('n3eilied1j58b908vqkk5cdgp6', 1474817303, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('n5df25judpo2op6lp2vkkk3vk1', 1474771057, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('naneinnbf6riq1fsoocp68jrt0', 1477120723, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('nefo9tj9tm2ehrj9fn7onujgc4', 1474766429, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('njob3gkkrfntie695dsooh5862', 1474778060, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('no9qa56t3voeeso94enistuc56', 1474808789, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('nu5guh3jig6fi56rbuov6l5fn5', 1474817587, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('o259n1qolgn0921s5lqil7jia2', 1474808544, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('o4ojgascv1mu4n0nhds2tia653', 1474771674, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('o8ao2mpdnpflqvque4h429epg3', 1474778796, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('ogp0hmqjtofvishr655b65re06', 1474784191, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('oo01lk1mn6bf8ur5rgvputctu1', 1474819453, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('otim763k7keuvimpvvl2eods24', 1476603453, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('ou8hhqqmm4bcf09q4730u2r216', 1474769744, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('ovg5midp78reh4la005r87ruv0', 1476589035, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('p9k63ag3b52c5g1j16lkn4a2b0', 1474786779, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('pifnfto22d1q01iebri37rs536', 1476619365, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('plq5uc540rdtlqdv8udv8b3t66', 1474819754, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('putgls3m9gh7c95nts5c0tscc1', 1474778429, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('q61n5kuv3ricjrgfkfaof8ckq1', 1474772796, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('qcgv2cbqj24rco6rrg4f95rsk6', 1476620349, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('qd95lmtcb0bt3il8nd622mlgf4', 1474778306, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('qlea6qmqqne4kednoehp9g91f5', 1474778673, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('qqe3i515c7air321pv0urdjck6', 1474787276, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('qua8uk5png122cs7sj3eobick6', 1474775751, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('r2jucf2ui1133ljbt2phch13l0', 1474820040, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('r5rr00mhm0i5firku1fomne751', 1474773892, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('r76folqq55oj6tee3dmipbpe24', 1474808666, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('r86iqigfc929hjhnlef6b83n81', 1476599709, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('r92dnleidccu90e2ofk2vcbgj1', 1474778510, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('ra1qdsplnm25umn7ut96r0ak04', 1474819544, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('rgicg41s5jur02dmdmab8prtg4', 1474765825, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('s4jfl716vu9ntkl268eo8ibe46', 1477120784, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('sj4sa2n8pg7puauf27ada5kah3', 1477120849, 86400, 'mobile|a:1:{s:6:"mobile";N;}ynbusinesspages_business|a:1:{s:10:"businessId";N;}redirectURL|s:7:"/behoi/";User_Plugin_Signup_Account|a:2:{s:6:"active";b:1;s:4:"data";N;}User_Plugin_Signup_Fields|a:1:{s:6:"active";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:"active";b:1;}', NULL),
('sp5u1d0joutnu71dfgm1d2gv05', 1474821646, 86400, 'mobile|a:1:{s:6:"mobile";N;}ynbusinesspages_business|a:1:{s:10:"businessId";N;}redirectURL|s:7:"/behoi/";User_Plugin_Signup_Account|a:2:{s:6:"active";b:1;s:4:"data";N;}User_Plugin_Signup_Fields|a:1:{s:6:"active";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:"active";b:1;}', NULL),
('t0rfhjpgpel9golh399jqgmf60', 1474770321, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('tfrqangr2h69mg6vbmhekq3pc5', 1474775875, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('tjsui16dpe8daprgc56jv29f73', 1474775627, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('tn3mp19m62hj2068k4u36s9617', 1474820233, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('tq4tmttl49rb2su2dl0pjuv977', 1474777814, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('tshgdiop1scp4c5b3g2qoell93', 1476601532, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('tslpo8cd3gdu95cs1324vgi1h5', 1474809034, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('u29rg0on8otdsig8ultldan3p6', 1476599436, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('u3uksdfgkduvrmqh9fkmtecvq6', 1474806966, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('u7hph87t66v1qgk6m6m9rrgeb3', 1474772292, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('u80r8msvo4p5c1b8i0o9vjutf4', 1476620418, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('ua4slkdm4g55si7driu2f53030', 1474778183, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('ubliq7poktnm4koh0l0jvh3kj2', 1474786905, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('un5tpsrjn374n07ob70in37rc6', 1474774117, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('urg022p79hjahtk8ruou1qvm30', 1474770811, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('uumbgkeo8uuee21707bsb95vr3', 1476619867, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('v4h0757rb75o36m175fv82j3m5', 1476599144, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('v68ar2l25u69b0ugfdjf4gtcc3', 1474779291, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('vb3u2tlkbk0b13dt26a8m5mok4', 1474783349, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('vg28dcmjq1fpv48f9sjftdh852', 1474786607, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('vgq4seg6v5pa3bcqnj6mfje7i3', 1474773041, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('vh0lkg8vuteamro4j1a4jq8345', 1476621059, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL),
('vs8hbmkueqjul20qukujobns16', 1474806908, 86400, 'mobile|a:1:{s:6:"mobile";N;}', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_settings`
--

CREATE TABLE IF NOT EXISTS `engine4_core_settings` (
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_settings`
--

INSERT INTO `engine4_core_settings` (`name`, `value`) VALUES
('activity.content', 'everyone'),
('activity.disallowed', 'N'),
('activity.filter', '1'),
('activity.length', '15'),
('activity.liveupdate', '120000'),
('activity.publish', '1'),
('activity.userdelete', '1'),
('activity.userlength', '5'),
('classified.currency', '$'),
('core.admin.mode', 'none'),
('core.admin.password', ''),
('core.admin.reauthenticate', '0'),
('core.admin.timeout', '600'),
('core.doctype', 'XHTML1_STRICT'),
('core.facebook.enable', 'none'),
('core.facebook.key', ''),
('core.facebook.secret', ''),
('core.general.browse', '1'),
('core.general.commenthtml', ''),
('core.general.notificationupdate', '120000'),
('core.general.portal', '1'),
('core.general.profile', '1'),
('core.general.quota', '0'),
('core.general.search', '1'),
('core.general.site.title', 'Bé Hỏi'),
('core.license.email', 'email@domain.com'),
('core.license.key', '6120-6465-4486-0768'),
('core.license.statistics', '0'),
('core.locale.locale', 'vi_VN'),
('core.locale.timezone', 'Asia/Ho_Chi_Minh'),
('core.log.adapter', 'file'),
('core.mail.contact', 'admin@behoi.com'),
('core.mail.count', '25'),
('core.mail.enabled', '1'),
('core.mail.from', 'admin@behoi.com'),
('core.mail.name', 'BeHoi Administrator'),
('core.mail.queueing', '0'),
('core.secret', '02fae8c34e6040e4498c2adb1b3fa10a048b8783'),
('core.site.counter', '18'),
('core.site.creation', '2016-08-21 16:31:54'),
('core.site.title', 'Social Network'),
('core.spam.censor', ''),
('core.spam.comment', '0'),
('core.spam.contact', '0'),
('core.spam.email.antispam.login', '1'),
('core.spam.email.antispam.signup', '1'),
('core.spam.invite', '0'),
('core.spam.ipbans', ''),
('core.spam.login', '0'),
('core.spam.signup', '0'),
('core.tasks.count', '1'),
('core.tasks.interval', '60'),
('core.tasks.jobs', '3'),
('core.tasks.key', '40d07098'),
('core.tasks.last', '1477120847'),
('core.tasks.mode', 'curl'),
('core.tasks.pid', ''),
('core.tasks.processes', '2'),
('core.tasks.time', '120'),
('core.tasks.timeout', '900'),
('core.thumbnails.icon.height', '48'),
('core.thumbnails.icon.mode', 'crop'),
('core.thumbnails.icon.width', '48'),
('core.thumbnails.main.height', '720'),
('core.thumbnails.main.mode', 'resize'),
('core.thumbnails.main.width', '720'),
('core.thumbnails.normal.height', '160'),
('core.thumbnails.normal.mode', 'resize'),
('core.thumbnails.normal.width', '140'),
('core.thumbnails.profile.height', '400'),
('core.thumbnails.profile.mode', 'resize'),
('core.thumbnails.profile.width', '200'),
('core.translate.adapter', 'csv'),
('core.twitter.enable', 'none'),
('core.twitter.key', ''),
('core.twitter.secret', ''),
('invite.allowCustomMessage', '1'),
('invite.fromEmail', ''),
('invite.fromName', ''),
('invite.max', '10'),
('invite.message', 'You are being invited to join our social network.'),
('invite.subject', 'Join Us'),
('need.qarating.update', '0'),
('payment.benefit', 'all'),
('payment.currency', 'USD'),
('payment.secret', 'c8ecf98c0dcf7ee4ad366945535a29cf'),
('storage.service.mirrored.counter', '0'),
('storage.service.mirrored.index', '0'),
('storage.service.roundrobin.counter', '0'),
('time.qarating.update', '1477120854'),
('user.friends.direction', '1'),
('user.friends.eligible', '2'),
('user.friends.lists', '1'),
('user.friends.verification', '1'),
('user.signup.approve', '1'),
('user.signup.checkemail', '1'),
('user.signup.inviteonly', '0'),
('user.signup.random', '0'),
('user.signup.terms', '1'),
('user.signup.username', '1'),
('user.signup.verifyemail', '0'),
('user.support.links', '1'),
('yntheme.enabled', '0');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_statistics`
--

CREATE TABLE IF NOT EXISTS `engine4_core_statistics` (
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`type`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_statistics`
--

INSERT INTO `engine4_core_statistics` (`type`, `date`, `value`) VALUES
('core.views', '2016-08-21 16:00:00', 17),
('core.views', '2016-08-21 18:00:00', 7),
('core.views', '2016-08-21 19:00:00', 11),
('core.views', '2016-08-22 15:00:00', 3),
('core.views', '2016-08-22 16:00:00', 8),
('core.views', '2016-08-28 13:00:00', 4),
('core.views', '2016-08-29 15:00:00', 7),
('core.views', '2016-08-31 15:00:00', 12),
('core.views', '2016-08-31 16:00:00', 1),
('core.views', '2016-09-04 08:00:00', 4),
('core.views', '2016-09-04 09:00:00', 2),
('core.views', '2016-09-04 11:00:00', 1),
('core.views', '2016-09-04 15:00:00', 3),
('core.views', '2016-09-11 03:00:00', 2),
('core.views', '2016-09-11 08:00:00', 10),
('core.views', '2016-09-11 09:00:00', 4),
('core.views', '2016-09-11 10:00:00', 1),
('core.views', '2016-09-11 15:00:00', 20),
('core.views', '2016-09-11 16:00:00', 15),
('core.views', '2016-09-18 09:00:00', 33),
('core.views', '2016-09-18 10:00:00', 30),
('core.views', '2016-09-18 15:00:00', 32),
('core.views', '2016-09-18 16:00:00', 26),
('core.views', '2016-09-19 15:00:00', 2),
('core.views', '2016-09-19 16:00:00', 5),
('core.views', '2016-09-25 01:00:00', 3),
('core.views', '2016-09-25 02:00:00', 9),
('core.views', '2016-09-25 03:00:00', 13),
('core.views', '2016-09-25 04:00:00', 5),
('core.views', '2016-09-25 05:00:00', 5),
('core.views', '2016-09-25 06:00:00', 14),
('core.views', '2016-09-25 07:00:00', 3),
('core.views', '2016-09-25 12:00:00', 5),
('core.views', '2016-09-25 13:00:00', 25),
('core.views', '2016-09-25 15:00:00', 17),
('core.views', '2016-09-25 16:00:00', 25),
('core.views', '2016-10-16 03:00:00', 3),
('core.views', '2016-10-16 06:00:00', 63),
('core.views', '2016-10-16 07:00:00', 6),
('core.views', '2016-10-16 10:00:00', 2),
('core.views', '2016-10-16 12:00:00', 18),
('core.views', '2016-10-22 07:00:00', 7),
('user.logins', '2016-08-21 16:00:00', 2),
('user.logins', '2016-08-21 18:00:00', 1),
('user.logins', '2016-08-29 15:00:00', 1),
('user.logins', '2016-08-31 15:00:00', 2),
('user.logins', '2016-09-04 08:00:00', 1),
('user.logins', '2016-09-11 03:00:00', 1),
('user.logins', '2016-09-18 09:00:00', 1),
('user.logins', '2016-09-25 02:00:00', 1),
('user.logins', '2016-10-16 03:00:00', 1),
('user.logins', '2016-10-22 07:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_status`
--

CREATE TABLE IF NOT EXISTS `engine4_core_status` (
  `status_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_styles`
--

CREATE TABLE IF NOT EXISTS `engine4_core_styles` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `style` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_tagmaps`
--

CREATE TABLE IF NOT EXISTS `engine4_core_tagmaps` (
  `tagmap_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `tagger_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tagger_id` int(11) unsigned NOT NULL,
  `tag_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  `creation_date` datetime DEFAULT NULL,
  `extra` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`tagmap_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `tagger_type` (`tagger_type`,`tagger_id`),
  KEY `tag_type` (`tag_type`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_tags`
--

CREATE TABLE IF NOT EXISTS `engine4_core_tags` (
  `tag_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_tasks`
--

CREATE TABLE IF NOT EXISTS `engine4_core_tasks` (
  `task_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `timeout` int(11) unsigned NOT NULL DEFAULT '60',
  `processes` smallint(3) unsigned NOT NULL DEFAULT '1',
  `semaphore` smallint(3) NOT NULL DEFAULT '0',
  `started_last` int(11) NOT NULL DEFAULT '0',
  `started_count` int(11) unsigned NOT NULL DEFAULT '0',
  `completed_last` int(11) NOT NULL DEFAULT '0',
  `completed_count` int(11) unsigned NOT NULL DEFAULT '0',
  `failure_last` int(11) NOT NULL DEFAULT '0',
  `failure_count` int(11) unsigned NOT NULL DEFAULT '0',
  `success_last` int(11) NOT NULL DEFAULT '0',
  `success_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `plugin` (`plugin`),
  KEY `module` (`module`),
  KEY `started_last` (`started_last`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dumping data for table `engine4_core_tasks`
--

INSERT INTO `engine4_core_tasks` (`task_id`, `title`, `module`, `plugin`, `timeout`, `processes`, `semaphore`, `started_last`, `started_count`, `completed_last`, `completed_count`, `failure_last`, `failure_count`, `success_last`, `success_count`) VALUES
(1, 'Job Queue', 'core', 'Core_Plugin_Task_Jobs', 5, 1, 0, 1477120847, 372, 1477120848, 371, 0, 0, 1477120848, 371),
(2, 'Background Mailer', 'core', 'Core_Plugin_Task_Mail', 15, 1, 0, 1477120848, 371, 1477120848, 371, 0, 0, 1477120848, 371),
(3, 'Cache Prefetch', 'core', 'Core_Plugin_Task_Prefetch', 300, 1, 0, 1477120575, 158, 1477120575, 158, 0, 0, 1477120575, 158),
(4, 'Statistics', 'core', 'Core_Plugin_Task_Statistics', 43200, 1, 0, 1477120721, 13, 1477120722, 13, 0, 0, 1477120722, 13),
(5, 'Log Rotation', 'core', 'Core_Plugin_Task_LogRotation', 7200, 1, 0, 1477120722, 23, 1477120722, 23, 0, 0, 1477120722, 23),
(6, 'Member Data Maintenance', 'user', 'User_Plugin_Task_Cleanup', 60, 1, 0, 1477120849, 186, 1477120849, 186, 0, 0, 1477120849, 186),
(7, 'Payment Maintenance', 'user', 'Payment_Plugin_Task_Cleanup', 43200, 1, 0, 1477120783, 12, 1477120783, 12, 0, 0, 1477120783, 12),
(8, 'Ynlistings Check Listing', 'ynlistings', 'Ynlistings_Plugin_Task_CheckListing', 600, 1, 0, 1474302021, 32, 1474302022, 32, 0, 0, 1474302022, 32),
(9, 'Rebuilt Q&A Users Ratings', 'question', 'Question_Plugin_Task_Maintenance_RebuildRating', 86400, 1, 0, 1477120849, 9, 1477120855, 9, 0, 0, 1477120855, 9);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_themes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_themes` (
  `theme_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`theme_id`),
  UNIQUE KEY `name` (`name`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=40 ;

--
-- Dumping data for table `engine4_core_themes`
--

INSERT INTO `engine4_core_themes` (`theme_id`, `name`, `title`, `description`, `active`) VALUES
(1, 'default', 'Default', '', 0),
(2, 'midnight', 'Midnight', '', 0),
(3, 'clean', 'Clean', '', 0),
(4, 'modern', 'Modern', '', 0),
(5, 'ynresponsive1', 'YN - Responsive Clean Template - Green', 'YouNet Responsive Clean Template - Green', 1),
(6, 'ynresponsiveclean-blue', 'YN - Responsive Clean Template - Blue', 'Responsive Clean Template - Blue', 0),
(7, 'ynresponsiveclean-red', 'YN - Responsive Clean Template - Red', 'Responsive Clean Template - Red', 0),
(8, 'bamboo', 'Bamboo', '', 0),
(9, 'digita', 'Digita', '', 0),
(10, 'grid-blue', 'Grid Blue', '', 0),
(11, 'grid-brown', 'Grid Brown', '', 0),
(12, 'grid-dark', 'Grid Dark', '', 0),
(13, 'grid-gray', 'Grid Gray', '', 0),
(14, 'grid-green', 'Grid Green', '', 0),
(15, 'grid-pink', 'Grid Pink', '', 0),
(16, 'grid-purple', 'Grid Purple', '', 0),
(17, 'grid-red', 'Grid Red', '', 0),
(18, 'kandy-cappuccino', 'Kandy Cappuccino', '', 0),
(19, 'kandy-limeorange', 'Kandy Limeorange', '', 0),
(20, 'kandy-mangoberry', 'Kandy Mangoberry', '', 0),
(21, 'kandy-watermelon', 'Kandy Watermelon', '', 0),
(22, 'musicbox-blue', 'Musicbox Blue', '', 0),
(23, 'musicbox-brown', 'Musicbox Brown', '', 0),
(24, 'musicbox-gray', 'Musicbox Gray', '', 0),
(25, 'musicbox-green', 'Musicbox Green', '', 0),
(26, 'musicbox-pink', 'Musicbox Pink', '', 0),
(27, 'musicbox-purple', 'Musicbox Purple', '', 0),
(28, 'musicbox-red', 'Musicbox Red', '', 0),
(29, 'musicbox-yellow', 'Musicbox Yellow', '', 0),
(30, 'quantum-beige', 'Quantum Beige', '', 0),
(31, 'quantum-blue', 'Quantum Blue', '', 0),
(32, 'quantum-gray', 'Quantum Gray', '', 0),
(33, 'quantum-green', 'Quantum Green', '', 0),
(34, 'quantum-orange', 'Quantum Orange', '', 0),
(35, 'quantum-pink', 'Quantum Pink', '', 0),
(36, 'quantum-purple', 'Quantum Purple', '', 0),
(37, 'quantum-red', 'Quantum Red', '', 0),
(38, 'slipstream', 'Slipstream', '', 0),
(39, 'snowbot', 'Snowbot', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_custom_sliders`
--

CREATE TABLE IF NOT EXISTS `engine4_custom_sliders` (
  `slider_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `links_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`slider_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `engine4_custom_sliders`
--

INSERT INTO `engine4_custom_sliders` (`slider_id`, `title`, `description`, `photo_id`, `creation_date`, `links_url`, `modified_date`) VALUES
(1, '', '', 33, '2016-10-16 06:18:00', '', '2016-10-16 06:18:01'),
(2, '', '', 35, '2016-10-16 06:18:12', '', '2016-10-16 06:18:12'),
(3, '', '', 37, '2016-10-16 06:18:20', '', '2016-10-16 06:18:21'),
(4, '', '', 39, '2016-10-16 06:18:30', '', '2016-10-16 06:18:30');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_invites`
--

CREATE TABLE IF NOT EXISTS `engine4_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `recipient` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `send_request` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `new_user_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `user_id` (`user_id`),
  KEY `recipient` (`recipient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_messages_conversations`
--

CREATE TABLE IF NOT EXISTS `engine4_messages_conversations` (
  `conversation_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_id` int(11) unsigned NOT NULL,
  `recipients` int(11) unsigned NOT NULL,
  `modified` datetime NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `resource_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '',
  `resource_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`conversation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_messages_messages`
--

CREATE TABLE IF NOT EXISTS `engine4_messages_messages` (
  `message_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `attachment_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '',
  `attachment_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`),
  UNIQUE KEY `CONVERSATIONS` (`conversation_id`,`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_messages_recipients`
--

CREATE TABLE IF NOT EXISTS `engine4_messages_recipients` (
  `user_id` int(11) unsigned NOT NULL,
  `conversation_id` int(11) unsigned NOT NULL,
  `inbox_message_id` int(11) unsigned DEFAULT NULL,
  `inbox_updated` datetime DEFAULT NULL,
  `inbox_read` tinyint(1) DEFAULT NULL,
  `inbox_deleted` tinyint(1) DEFAULT NULL,
  `outbox_message_id` int(11) unsigned DEFAULT NULL,
  `outbox_updated` datetime DEFAULT NULL,
  `outbox_deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`conversation_id`),
  KEY `INBOX_UPDATED` (`user_id`,`conversation_id`,`inbox_updated`),
  KEY `OUTBOX_UPDATED` (`user_id`,`conversation_id`,`outbox_updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_network_membership`
--

CREATE TABLE IF NOT EXISTS `engine4_network_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_network_networks`
--

CREATE TABLE IF NOT EXISTS `engine4_network_networks` (
  `network_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `field_id` int(11) unsigned NOT NULL DEFAULT '0',
  `pattern` text COLLATE utf8_unicode_ci,
  `member_count` int(11) unsigned NOT NULL DEFAULT '0',
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  `assignment` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`network_id`),
  KEY `assignment` (`assignment`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `engine4_network_networks`
--

INSERT INTO `engine4_network_networks` (`network_id`, `title`, `description`, `field_id`, `pattern`, `member_count`, `hide`, `assignment`) VALUES
(1, 'North America', '', 0, NULL, 0, 0, 0),
(2, 'South America', '', 0, NULL, 0, 0, 0),
(3, 'Europe', '', 0, NULL, 0, 0, 0),
(4, 'Asia', '', 0, NULL, 0, 0, 0),
(5, 'Africa', '', 0, NULL, 0, 0, 0),
(6, 'Australia', '', 0, NULL, 0, 0, 0),
(7, 'Antarctica', '', 0, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_gateways`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_gateways` (
  `gateway_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `config` mediumblob,
  `test_mode` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`gateway_id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `engine4_payment_gateways`
--

INSERT INTO `engine4_payment_gateways` (`gateway_id`, `title`, `description`, `enabled`, `plugin`, `config`, `test_mode`) VALUES
(1, '2Checkout', NULL, 0, 'Payment_Plugin_Gateway_2Checkout', NULL, 0),
(2, 'PayPal', NULL, 0, 'Payment_Plugin_Gateway_PayPal', NULL, 0),
(3, 'Testing', NULL, 0, 'Payment_Plugin_Gateway_Testing', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_orders`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_orders` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `gateway_id` int(10) unsigned NOT NULL,
  `gateway_order_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` enum('pending','cancelled','failed','incomplete','complete') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'pending',
  `creation_date` datetime NOT NULL,
  `source_type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `source_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `gateway_id` (`gateway_id`,`gateway_order_id`),
  KEY `state` (`state`),
  KEY `source_type` (`source_type`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_packages`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_packages` (
  `package_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `level_id` int(10) unsigned NOT NULL,
  `downgrade_level_id` int(10) unsigned NOT NULL DEFAULT '0',
  `price` decimal(16,2) unsigned NOT NULL,
  `recurrence` int(11) unsigned NOT NULL,
  `recurrence_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci NOT NULL,
  `duration` int(11) unsigned NOT NULL,
  `duration_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci NOT NULL,
  `trial_duration` int(11) unsigned NOT NULL DEFAULT '0',
  `trial_duration_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `signup` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `after_signup` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`package_id`),
  KEY `level_id` (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_products`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_products` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `extension_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `extension_id` int(10) unsigned DEFAULT NULL,
  `sku` bigint(20) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(16,2) unsigned NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `extension_type` (`extension_type`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_subscriptions`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_subscriptions` (
  `subscription_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `package_id` int(11) unsigned NOT NULL,
  `status` enum('initial','trial','pending','active','cancelled','expired','overdue','refunded') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'initial',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `gateway_id` int(10) unsigned DEFAULT NULL,
  `gateway_profile_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`subscription_id`),
  UNIQUE KEY `gateway_id` (`gateway_id`,`gateway_profile_id`),
  KEY `user_id` (`user_id`),
  KEY `package_id` (`package_id`),
  KEY `status` (`status`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_transactions`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_transactions` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `gateway_id` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `gateway_parent_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_order_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `amount` decimal(16,2) NOT NULL,
  `currency` char(3) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`transaction_id`),
  KEY `user_id` (`user_id`),
  KEY `gateway_id` (`gateway_id`),
  KEY `type` (`type`),
  KEY `state` (`state`),
  KEY `gateway_transaction_id` (`gateway_transaction_id`),
  KEY `gateway_parent_transaction_id` (`gateway_parent_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_question_answers`
--

CREATE TABLE IF NOT EXISTS `engine4_question_answers` (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `question_id` int(11) unsigned NOT NULL,
  `answer` text COLLATE utf8_bin,
  `creation_date` datetime NOT NULL,
  `anonymous` tinyint(1) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`answer_id`),
  KEY `user_id` (`user_id`),
  KEY `answer_question_id` (`question_id`),
  KEY `anonymous` (`anonymous`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_question_categories`
--

CREATE TABLE IF NOT EXISTS `engine4_question_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(128) NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  `url` varchar(34) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `url` (`url`),
  KEY `order` (`order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `engine4_question_categories`
--

INSERT INTO `engine4_question_categories` (`category_id`, `category_name`, `order`, `url`) VALUES
(1, 'Default Category', 999, 'default_category');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_question_mratings`
--

CREATE TABLE IF NOT EXISTS `engine4_question_mratings` (
  `mrating_id` int(11) unsigned NOT NULL DEFAULT '0',
  `total_points` int(11) NOT NULL DEFAULT '0',
  `total_questions` int(11) NOT NULL DEFAULT '0',
  `total_answers` int(11) NOT NULL DEFAULT '0',
  `total_best_answers` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mrating_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_question_questions`
--

CREATE TABLE IF NOT EXISTS `engine4_question_questions` (
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
  KEY `anonymous` (`anonymous`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_question_qvotes`
--

CREATE TABLE IF NOT EXISTS `engine4_question_qvotes` (
  `qvote_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `question_id` int(11) unsigned NOT NULL,
  `vote_for` int(11) NOT NULL DEFAULT '0',
  `creation_date` datetime DEFAULT NULL,
  `vote_against` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`qvote_id`),
  UNIQUE KEY `user_question_id` (`user_id`,`question_id`),
  KEY `user_id` (`user_id`),
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_question_ratings`
--

CREATE TABLE IF NOT EXISTS `engine4_question_ratings` (
  `rating_id` int(11) unsigned NOT NULL DEFAULT '0',
  `total_points` int(11) NOT NULL DEFAULT '0',
  `total_questions` int(11) NOT NULL DEFAULT '0',
  `total_answers` int(11) NOT NULL DEFAULT '0',
  `total_best_answers` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rating_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_question_subscribers`
--

CREATE TABLE IF NOT EXISTS `engine4_question_subscribers` (
  `subscriber_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `question_id` int(10) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `hash` char(32) NOT NULL,
  UNIQUE KEY `subscriber_id` (`subscriber_id`),
  UNIQUE KEY `hash` (`hash`),
  UNIQUE KEY `user_id` (`user_id`,`question_id`),
  KEY `question_id` (`question_id`),
  KEY `user_id_only` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_question_votes`
--

CREATE TABLE IF NOT EXISTS `engine4_question_votes` (
  `vote_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `answer_id` int(11) DEFAULT NULL,
  `vote_for` int(11) NOT NULL DEFAULT '0',
  `creation_date` datetime DEFAULT NULL,
  `vote_against` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`vote_id`),
  UNIQUE KEY `user_answer_id` (`user_id`,`answer_id`),
  KEY `user_id` (`user_id`),
  KEY `answer_id` (`answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_storage_chunks`
--

CREATE TABLE IF NOT EXISTS `engine4_storage_chunks` (
  `chunk_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(11) unsigned NOT NULL,
  `data` blob NOT NULL,
  PRIMARY KEY (`chunk_id`),
  KEY `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_storage_files`
--

CREATE TABLE IF NOT EXISTS `engine4_storage_files` (
  `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_file_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `service_id` int(10) unsigned NOT NULL DEFAULT '1',
  `storage_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mime_major` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `mime_minor` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `hash` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `parent_file_id` (`parent_file_id`,`type`),
  KEY `PARENT` (`parent_type`,`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=41 ;

--
-- Dumping data for table `engine4_storage_files`
--

INSERT INTO `engine4_storage_files` (`file_id`, `parent_file_id`, `type`, `parent_type`, `parent_id`, `user_id`, `creation_date`, `modified_date`, `service_id`, `storage_path`, `extension`, `name`, `mime_major`, `mime_minor`, `size`, `hash`) VALUES
(1, NULL, NULL, 'classified_category', 17, 1, '2016-09-11 03:32:00', '2016-09-11 03:32:00', 1, 'public/classified_category/01/0001_0136.jpg', 'jpg', 'm_dubstep_9-wallpaper-1366x768.jpg', 'image', 'jpeg', 127138, '3cde013688c7a3807c0ab466374144ef'),
(2, 1, 'thumb.profile', 'classified_category', 17, 1, '2016-09-11 03:32:00', '2016-09-11 03:32:00', 1, 'public/classified_category/02/0002_36c3.jpg', 'jpg', 'p_dubstep_9-wallpaper-1366x768.jpg', 'image', 'jpeg', 5129, '001036c3b2bee8fe948051c120f0cafc'),
(3, 1, 'thumb.normal', 'classified_category', 17, 1, '2016-09-11 03:32:00', '2016-09-11 03:32:00', 1, 'public/classified_category/03/0003_1b87.jpg', 'jpg', 'in_dubstep_9-wallpaper-1366x768.jpg', 'image', 'jpeg', 3213, '98aa1b872968e656b2aae4c97db654cf'),
(4, 1, 'thumb.icon', 'classified_category', 17, 1, '2016-09-11 03:32:00', '2016-09-11 03:32:00', 1, 'public/classified_category/04/0004_9f4d.jpg', 'jpg', 'is_dubstep_9-wallpaper-1366x768.jpg', 'image', 'jpeg', 1320, 'ddae9f4d62aef31e5c9d2b7350e66c3a'),
(5, NULL, NULL, 'classified_category', 12, 1, '2016-09-11 03:39:50', '2016-09-11 03:39:50', 1, 'public/classified_category/05/0005_8a62.jpg', 'jpg', 'm_lp_blast-wallpaper-1366x768.jpg', 'image', 'jpeg', 102951, '166f8a62c7ad69ba6796bf3d0245d92a'),
(6, 5, 'thumb.profile', 'classified_category', 12, 1, '2016-09-11 03:39:50', '2016-09-11 03:39:50', 1, 'public/classified_category/06/0006_e024.jpg', 'jpg', 'p_lp_blast-wallpaper-1366x768.jpg', 'image', 'jpeg', 4011, '165fe0243f34a218e422142b3dde81f6'),
(7, 5, 'thumb.normal', 'classified_category', 12, 1, '2016-09-11 03:39:50', '2016-09-11 03:39:50', 1, 'public/classified_category/07/0007_85f4.jpg', 'jpg', 'in_lp_blast-wallpaper-1366x768.jpg', 'image', 'jpeg', 2543, '028a85f4642ea10c31fdb0a24c123a64'),
(8, 5, 'thumb.icon', 'classified_category', 12, 1, '2016-09-11 03:39:50', '2016-09-11 03:39:50', 1, 'public/classified_category/08/0008_3421.jpg', 'jpg', 'is_lp_blast-wallpaper-1366x768.jpg', 'image', 'jpeg', 1357, 'f2ea34219909f4f87b1b974db3cfb3a4'),
(9, NULL, NULL, 'classified', 1, 1, '2016-09-18 09:54:08', '2016-09-18 09:54:08', 1, 'public/classified/09/0009_504b.jpg', 'jpg', '279266-buffet-an-khong-gioi-han-60-mon-lau-hai-san-bo-my-cao-cap-cong-nghe-nuong-khong-khoi-hien-dai_m.jpg', 'image', 'jpeg', 79954, '5522504bff9236b9838c02e6b825672f'),
(10, 9, 'thumb.profile', 'classified', 1, 1, '2016-09-18 09:54:08', '2016-09-18 09:54:08', 1, 'public/classified/0a/000a_de4a.jpg', 'jpg', '279266-buffet-an-khong-gioi-han-60-mon-lau-hai-san-bo-my-cao-cap-cong-nghe-nuong-khong-khoi-hien-dai_p.jpg', 'image', 'jpeg', 12466, '24d8de4add1f526f104d01f18cc4cc54'),
(11, 9, 'thumb.normal', 'classified', 1, 1, '2016-09-18 09:54:08', '2016-09-18 09:54:08', 1, 'public/classified/0b/000b_9262.jpg', 'jpg', '279266-buffet-an-khong-gioi-han-60-mon-lau-hai-san-bo-my-cao-cap-cong-nghe-nuong-khong-khoi-hien-dai_in.jpg', 'image', 'jpeg', 7394, 'f79b926285362bae150206bb7b977ee8'),
(12, 9, 'thumb.icon', 'classified', 1, 1, '2016-09-18 09:54:08', '2016-09-18 09:54:08', 1, 'public/classified/0c/000c_18aa.jpg', 'jpg', '279266-buffet-an-khong-gioi-han-60-mon-lau-hai-san-bo-my-cao-cap-cong-nghe-nuong-khong-khoi-hien-dai_is.jpg', 'image', 'jpeg', 1672, '630918aae81bbe6be36dee5a68089b5f'),
(13, NULL, NULL, 'classified', 1, 1, '2016-09-18 09:55:28', '2016-09-18 09:55:28', 1, 'public/classified/0d/000d_504b.jpg', 'jpg', 'm_phpB929.tmp.jpg', 'image', 'jpeg', 79954, '5522504bff9236b9838c02e6b825672f'),
(14, 13, 'thumb.normal', 'classified', 1, 1, '2016-09-18 09:55:28', '2016-09-18 09:55:28', 1, 'public/classified/0e/000e_9262.jpg', 'jpg', 't_phpB929.tmp.jpg', 'image', 'jpeg', 7394, 'f79b926285362bae150206bb7b977ee8'),
(15, NULL, NULL, 'classified', 1, 1, '2016-09-18 09:55:36', '2016-09-18 09:55:36', 1, 'public/classified/0f/000f_7907.jpg', 'jpg', 'm_phpD745.tmp.jpg', 'image', 'jpeg', 67834, '6cc379072916518df78e317cca79c57e'),
(16, 15, 'thumb.normal', 'classified', 1, 1, '2016-09-18 09:55:36', '2016-09-18 09:55:36', 1, 'public/classified/10/0010_8ef2.jpg', 'jpg', 't_phpD745.tmp.jpg', 'image', 'jpeg', 6678, '020a8ef21b87fc0d1fd304e0fc2c8bf0'),
(17, NULL, NULL, 'classified', 2, 1, '2016-09-18 10:54:35', '2016-09-18 10:54:35', 1, 'public/classified/11/0011_4471.jpg', 'jpg', '285122-he-thong-banh-chewy-junior-banh-su-kien-sinh-nhat_m.jpg', 'image', 'jpeg', 80564, '5ae844711b4e605adbb172412b99ccbd'),
(18, 17, 'thumb.profile', 'classified', 2, 1, '2016-09-18 10:54:35', '2016-09-18 10:54:35', 1, 'public/classified/12/0012_eb6d.jpg', 'jpg', '285122-he-thong-banh-chewy-junior-banh-su-kien-sinh-nhat_p.jpg', 'image', 'jpeg', 12503, '6959eb6d4ab2e102c9889b3372c491af'),
(19, 17, 'thumb.normal', 'classified', 2, 1, '2016-09-18 10:54:35', '2016-09-18 10:54:35', 1, 'public/classified/13/0013_3d97.jpg', 'jpg', '285122-he-thong-banh-chewy-junior-banh-su-kien-sinh-nhat_in.jpg', 'image', 'jpeg', 7583, '31673d974cc842ed7b935251cb1b85c6'),
(20, 17, 'thumb.icon', 'classified', 2, 1, '2016-09-18 10:54:35', '2016-09-18 10:54:35', 1, 'public/classified/14/0014_2299.jpg', 'jpg', '285122-he-thong-banh-chewy-junior-banh-su-kien-sinh-nhat_is.jpg', 'image', 'jpeg', 1794, 'b62c22992d798c9306e609c55e3d944a'),
(29, NULL, NULL, 'classified', 3, 1, '2016-09-18 16:41:12', '2016-09-18 16:41:12', 1, 'public/classified/1d/001d_fc9a.jpg', 'jpg', '263613-windsor-plaza-hotel-5-international-buffet-toi-t7-1-ngay-duy-nhat_m.jpg', 'image', 'jpeg', 111519, 'f509fc9a3d062cfebab13f37abe4af30'),
(30, 29, 'thumb.profile', 'classified', 3, 1, '2016-09-18 16:41:12', '2016-09-18 16:41:12', 1, 'public/classified/1e/001e_026f.jpg', 'jpg', '263613-windsor-plaza-hotel-5-international-buffet-toi-t7-1-ngay-duy-nhat_p.jpg', 'image', 'jpeg', 13416, '9bd3026fcff850587ec698ea20d2010f'),
(31, 29, 'thumb.normal', 'classified', 3, 1, '2016-09-18 16:41:12', '2016-09-18 16:41:12', 1, 'public/classified/1f/001f_7bfb.jpg', 'jpg', '263613-windsor-plaza-hotel-5-international-buffet-toi-t7-1-ngay-duy-nhat_in.jpg', 'image', 'jpeg', 7466, 'aa2e7bfb95582e4b36df6be611b5d379'),
(32, 29, 'thumb.icon', 'classified', 3, 1, '2016-09-18 16:41:12', '2016-09-18 16:41:12', 1, 'public/classified/20/0020_08b2.jpg', 'jpg', '263613-windsor-plaza-hotel-5-international-buffet-toi-t7-1-ngay-duy-nhat_is.jpg', 'image', 'jpeg', 1581, 'aa0908b2d7c21bb05f866dc489656d6c'),
(33, NULL, NULL, 'custom', 1, 1, '2016-10-16 06:18:01', '2016-10-16 06:18:01', 1, 'public/custom/21/0021_3405.jpg', 'jpg', 'm_kitchen_adventurer_caramel.jpg', 'image', 'jpeg', 104220, 'ced33405969f3b624b4dc5550a419289'),
(34, 33, 'thumb.icon', 'custom', 1, 1, '2016-10-16 06:18:01', '2016-10-16 06:18:01', 1, 'public/custom/22/0022_fe81.jpg', 'jpg', 'is_kitchen_adventurer_caramel.jpg', 'image', 'jpeg', 1276, '80aafe81be2572b8038efcb89f844b1b'),
(35, NULL, NULL, 'custom', 2, 1, '2016-10-16 06:18:12', '2016-10-16 06:18:12', 1, 'public/custom/23/0023_dc97.jpg', 'jpg', 'm_kitchen_adventurer_cheesecake_brownie.jpg', 'image', 'jpeg', 64298, '1f5edc9758acd8a56ad342478eea0a66'),
(36, 35, 'thumb.icon', 'custom', 2, 1, '2016-10-16 06:18:12', '2016-10-16 06:18:12', 1, 'public/custom/24/0024_7684.jpg', 'jpg', 'is_kitchen_adventurer_cheesecake_brownie.jpg', 'image', 'jpeg', 1121, '04767684c27c6fc41e1a233e9e8b3844'),
(37, NULL, NULL, 'custom', 3, 1, '2016-10-16 06:18:21', '2016-10-16 06:18:21', 1, 'public/custom/25/0025_4f09.jpg', 'jpg', 'm_kitchen_adventurer_donut.jpg', 'image', 'jpeg', 99553, '66d54f096287a1a87e7429ce843b4b27'),
(38, 37, 'thumb.icon', 'custom', 3, 1, '2016-10-16 06:18:21', '2016-10-16 06:18:21', 1, 'public/custom/26/0026_b2d2.jpg', 'jpg', 'is_kitchen_adventurer_donut.jpg', 'image', 'jpeg', 1178, 'eed5b2d20e33d34e2d3fff517493c823'),
(39, NULL, NULL, 'custom', 4, 1, '2016-10-16 06:18:30', '2016-10-16 06:18:30', 1, 'public/custom/27/0027_7cb5.jpg', 'jpg', 'm_kitchen_adventurer_lemon.jpg', 'image', 'jpeg', 111454, 'dcfe7cb58b6a32c08140d301f868cd1c'),
(40, 39, 'thumb.icon', 'custom', 4, 1, '2016-10-16 06:18:30', '2016-10-16 06:18:30', 1, 'public/custom/28/0028_92ea.jpg', 'jpg', 'is_kitchen_adventurer_lemon.jpg', 'image', 'jpeg', 1386, '231b92ea5ca19b9bd9729b3f89772062');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_storage_mirrors`
--

CREATE TABLE IF NOT EXISTS `engine4_storage_mirrors` (
  `file_id` bigint(20) unsigned NOT NULL,
  `service_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`file_id`,`service_id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_storage_services`
--

CREATE TABLE IF NOT EXISTS `engine4_storage_services` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `servicetype_id` int(10) unsigned NOT NULL,
  `config` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `engine4_storage_services`
--

INSERT INTO `engine4_storage_services` (`service_id`, `servicetype_id`, `config`, `enabled`, `default`) VALUES
(1, 1, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_storage_servicetypes`
--

CREATE TABLE IF NOT EXISTS `engine4_storage_servicetypes` (
  `servicetype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `form` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`servicetype_id`),
  UNIQUE KEY `plugin` (`plugin`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `engine4_storage_servicetypes`
--

INSERT INTO `engine4_storage_servicetypes` (`servicetype_id`, `title`, `plugin`, `form`, `enabled`) VALUES
(1, 'Local Storage', 'Storage_Service_Local', 'Storage_Form_Admin_Service_Local', 1),
(2, 'Database Storage', 'Storage_Service_Db', 'Storage_Form_Admin_Service_Db', 0),
(3, 'Amazon S3', 'Storage_Service_S3', 'Storage_Form_Admin_Service_S3', 1),
(4, 'Virtual File System', 'Storage_Service_Vfs', 'Storage_Form_Admin_Service_Vfs', 1),
(5, 'Round-Robin', 'Storage_Service_RoundRobin', 'Storage_Form_Admin_Service_RoundRobin', 0),
(6, 'Mirrored', 'Storage_Service_Mirrored', 'Storage_Form_Admin_Service_Mirrored', 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_users`
--

CREATE TABLE IF NOT EXISTS `engine4_users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `displayname` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `status` text COLLATE utf8_unicode_ci,
  `status_date` datetime DEFAULT NULL,
  `password` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `salt` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'auto',
  `language` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'en_US',
  `timezone` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'America/Los_Angeles',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `show_profileviewers` tinyint(1) NOT NULL DEFAULT '1',
  `level_id` int(11) unsigned NOT NULL,
  `invites_used` int(11) unsigned NOT NULL DEFAULT '0',
  `extra_invites` int(11) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `creation_date` datetime NOT NULL,
  `creation_ip` varbinary(16) NOT NULL,
  `modified_date` datetime NOT NULL,
  `lastlogin_date` datetime DEFAULT NULL,
  `lastlogin_ip` varbinary(16) DEFAULT NULL,
  `update_date` int(11) DEFAULT NULL,
  `member_count` smallint(5) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `EMAIL` (`email`),
  UNIQUE KEY `USERNAME` (`username`),
  KEY `MEMBER_COUNT` (`member_count`),
  KEY `CREATION_DATE` (`creation_date`),
  KEY `search` (`search`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `engine4_users`
--

INSERT INTO `engine4_users` (`user_id`, `email`, `username`, `displayname`, `photo_id`, `status`, `status_date`, `password`, `salt`, `locale`, `language`, `timezone`, `search`, `show_profileviewers`, `level_id`, `invites_used`, `extra_invites`, `enabled`, `verified`, `approved`, `creation_date`, `creation_ip`, `modified_date`, `lastlogin_date`, `lastlogin_ip`, `update_date`, `member_count`, `view_count`) VALUES
(1, 'admin@behoi.com', 'admin', 'admin', 0, NULL, NULL, 'bfa9c81ec481f35a63842596c3a99db4', '8750854', 'auto', 'en_US', 'Asia/Ho_Chi_Minh', 1, 1, 1, 0, 0, 1, 1, 1, '2016-08-21 16:33:09', '', '2016-09-18 16:41:15', '2016-10-22 07:21:02', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_block`
--

CREATE TABLE IF NOT EXISTS `engine4_user_block` (
  `user_id` int(11) unsigned NOT NULL,
  `blocked_user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`blocked_user_id`),
  KEY `REVERSE` (`blocked_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_facebook`
--

CREATE TABLE IF NOT EXISTS `engine4_user_facebook` (
  `user_id` int(11) unsigned NOT NULL,
  `facebook_uid` bigint(20) unsigned NOT NULL,
  `access_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `expires` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `facebook_uid` (`facebook_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_fields_maps`
--

CREATE TABLE IF NOT EXISTS `engine4_user_fields_maps` (
  `field_id` int(11) unsigned NOT NULL,
  `option_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  `order` smallint(6) NOT NULL,
  PRIMARY KEY (`field_id`,`option_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_fields_maps`
--

INSERT INTO `engine4_user_fields_maps` (`field_id`, `option_id`, `child_id`, `order`) VALUES
(0, 0, 1, 1),
(1, 1, 2, 2),
(1, 1, 3, 3),
(1, 1, 4, 4),
(1, 1, 5, 5),
(1, 1, 6, 6),
(1, 1, 7, 7),
(1, 1, 8, 8),
(1, 1, 9, 9),
(1, 1, 10, 10),
(1, 1, 11, 11),
(1, 1, 12, 12),
(1, 1, 13, 13);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_fields_meta`
--

CREATE TABLE IF NOT EXISTS `engine4_user_fields_meta` (
  `field_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) unsigned NOT NULL,
  `publish` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `order` smallint(3) unsigned NOT NULL DEFAULT '999',
  `config` text COLLATE utf8_unicode_ci,
  `validators` text COLLATE utf8_unicode_ci,
  `filters` text COLLATE utf8_unicode_ci,
  `style` text COLLATE utf8_unicode_ci,
  `error` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

--
-- Dumping data for table `engine4_user_fields_meta`
--

INSERT INTO `engine4_user_fields_meta` (`field_id`, `type`, `label`, `description`, `alias`, `required`, `display`, `publish`, `search`, `show`, `order`, `config`, `validators`, `filters`, `style`, `error`) VALUES
(1, 'profile_type', 'Profile Type', '', 'profile_type', 1, 0, 0, 2, 1, 999, '', NULL, NULL, NULL, NULL),
(2, 'heading', 'Personal Information', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(3, 'first_name', 'First Name', '', 'first_name', 1, 1, 0, 2, 1, 999, '', '[["StringLength",false,[1,32]]]', NULL, NULL, NULL),
(4, 'last_name', 'Last Name', '', 'last_name', 1, 1, 0, 2, 1, 999, '', '[["StringLength",false,[1,32]]]', NULL, NULL, NULL),
(5, 'gender', 'Gender', '', 'gender', 0, 1, 0, 1, 1, 999, '', NULL, NULL, NULL, NULL),
(6, 'birthdate', 'Birthday', '', 'birthdate', 0, 1, 0, 1, 1, 999, '', NULL, NULL, NULL, NULL),
(7, 'heading', 'Contact Information', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(8, 'website', 'Website', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(9, 'twitter', 'Twitter', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(10, 'facebook', 'Facebook', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(11, 'aim', 'AIM', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(12, 'heading', 'Personal Details', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(13, 'about_me', 'About Me', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_fields_options`
--

CREATE TABLE IF NOT EXISTS `engine4_user_fields_options` (
  `option_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`option_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `engine4_user_fields_options`
--

INSERT INTO `engine4_user_fields_options` (`option_id`, `field_id`, `label`, `order`) VALUES
(1, 1, 'Regular Member', 1),
(2, 5, 'Male', 1),
(3, 5, 'Female', 2);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_fields_search`
--

CREATE TABLE IF NOT EXISTS `engine4_user_fields_search` (
  `item_id` int(11) unsigned NOT NULL,
  `profile_type` smallint(11) unsigned DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` smallint(6) unsigned DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `profile_type` (`profile_type`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `gender` (`gender`),
  KEY `birthdate` (`birthdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_fields_values`
--

CREATE TABLE IF NOT EXISTS `engine4_user_fields_values` (
  `item_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `index` smallint(3) unsigned NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `privacy` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`item_id`,`field_id`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_fields_values`
--

INSERT INTO `engine4_user_fields_values` (`item_id`, `field_id`, `index`, `value`, `privacy`) VALUES
(1, 1, 0, '1', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_forgot`
--

CREATE TABLE IF NOT EXISTS `engine4_user_forgot` (
  `user_id` int(11) unsigned NOT NULL,
  `code` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_janrain`
--

CREATE TABLE IF NOT EXISTS `engine4_user_janrain` (
  `user_id` int(11) unsigned NOT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_listitems`
--

CREATE TABLE IF NOT EXISTS `engine4_user_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_lists`
--

CREATE TABLE IF NOT EXISTS `engine4_user_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_id` int(11) unsigned NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_logins`
--

CREATE TABLE IF NOT EXISTS `engine4_user_logins` (
  `login_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varbinary(16) NOT NULL,
  `timestamp` datetime NOT NULL,
  `state` enum('success','no-member','bad-password','disabled','unpaid','third-party','v3-migration','unknown') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'unknown',
  `source` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`login_id`),
  KEY `user_id` (`user_id`),
  KEY `email` (`email`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `engine4_user_logins`
--

INSERT INTO `engine4_user_logins` (`login_id`, `user_id`, `email`, `ip`, `timestamp`, `state`, `source`, `active`) VALUES
(1, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-08-21 16:56:16', 'success', NULL, 0),
(2, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-08-21 16:57:03', 'success', NULL, 0),
(3, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-08-21 18:25:59', 'success', NULL, 1),
(4, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-08-29 15:58:21', 'success', NULL, 1),
(5, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-08-31 15:45:44', 'success', NULL, 0),
(6, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-08-31 15:53:57', 'success', NULL, 1),
(7, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-09-04 08:33:08', 'success', NULL, 1),
(8, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-09-11 03:14:05', 'success', NULL, 1),
(9, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-09-18 09:17:16', 'success', NULL, 1),
(10, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-09-25 02:15:38', 'success', NULL, 1),
(11, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-10-16 03:30:59', 'success', NULL, 1),
(12, 1, 'admin@behoi.com', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '2016-10-22 07:21:01', 'success', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_membership`
--

CREATE TABLE IF NOT EXISTS `engine4_user_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  `message` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_id`,`user_id`),
  KEY `REVERSE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_online`
--

CREATE TABLE IF NOT EXISTS `engine4_user_online` (
  `ip` varbinary(16) NOT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `active` datetime NOT NULL,
  PRIMARY KEY (`ip`,`user_id`),
  KEY `LOOKUP` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_online`
--

INSERT INTO `engine4_user_online` (`ip`, `user_id`, `active`) VALUES
('\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', 0, '2016-10-22 07:20:58'),
('\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', 1, '2016-10-22 07:21:33');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_settings`
--

CREATE TABLE IF NOT EXISTS `engine4_user_settings` (
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_signup`
--

CREATE TABLE IF NOT EXISTS `engine4_user_signup` (
  `signup_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  `enable` smallint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`signup_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `engine4_user_signup`
--

INSERT INTO `engine4_user_signup` (`signup_id`, `class`, `order`, `enable`) VALUES
(1, 'User_Plugin_Signup_Account', 1, 1),
(2, 'User_Plugin_Signup_Fields', 2, 1),
(3, 'User_Plugin_Signup_Photo', 3, 1),
(4, 'User_Plugin_Signup_Invite', 4, 0),
(5, 'Payment_Plugin_Signup_Subscription', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_twitter`
--

CREATE TABLE IF NOT EXISTS `engine4_user_twitter` (
  `user_id` int(10) unsigned NOT NULL,
  `twitter_uid` bigint(20) unsigned NOT NULL,
  `twitter_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `twitter_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `twitter_uid` (`twitter_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_verify`
--

CREATE TABLE IF NOT EXISTS `engine4_user_verify` (
  `user_id` int(11) unsigned NOT NULL,
  `code` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_albums`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `listing_id` int(11) unsigned NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `collectible_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`album_id`),
  KEY `search` (`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_categories`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_categories` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `parent_id` int(11) unsigned DEFAULT NULL,
  `pleft` int(11) unsigned NOT NULL,
  `pright` int(11) unsigned NOT NULL,
  `level` int(11) unsigned NOT NULL DEFAULT '0',
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) DEFAULT NULL,
  `themes` text COLLATE utf8_unicode_ci,
  `use_parent_category` tinyint(1) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '0',
  `option_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `user_id` (`user_id`),
  KEY `parent_id` (`parent_id`),
  KEY `pleft` (`pleft`),
  KEY `pright` (`pright`),
  KEY `level` (`level`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `engine4_ynlistings_categories`
--

INSERT INTO `engine4_ynlistings_categories` (`category_id`, `user_id`, `parent_id`, `pleft`, `pright`, `level`, `title`, `photo_id`, `themes`, `use_parent_category`, `order`, `option_id`) VALUES
(1, 0, NULL, 1, 4, 0, 'All Categories', NULL, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_faqs`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_faqs` (
  `faq_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `answer` text COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('show','hide') COLLATE utf8_unicode_ci NOT NULL,
  `order` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`faq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_follows`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_follows` (
  `follow_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`follow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_imports`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_imports` (
  `import_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `creation_date` datetime NOT NULL,
  `file_name` text COLLATE utf8_unicode_ci,
  `number_listings` text COLLATE utf8_unicode_ci,
  `list_listings` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`import_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_listings`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_listings` (
  `listing_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT '0',
  `theme` text COLLATE utf8_unicode_ci,
  `creation_date` datetime NOT NULL,
  `approved_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `approved_status` enum('pending','approved','denied') COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('closed','open','draft','expired') COLLATE utf8_unicode_ci NOT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `feature_expiration_date` datetime DEFAULT NULL,
  `feature_day_number` int(11) unsigned NOT NULL DEFAULT '0',
  `highlight` tinyint(1) NOT NULL DEFAULT '0',
  `location` text COLLATE utf8_unicode_ci NOT NULL,
  `longitude` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `latitude` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `short_description` text COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `about_us` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) DEFAULT NULL,
  `video_id` int(11) DEFAULT NULL,
  `price` decimal(16,2) unsigned NOT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `view_count` int(11) NOT NULL DEFAULT '0',
  `like_count` int(11) NOT NULL DEFAULT '0',
  `view_time` datetime NOT NULL,
  PRIMARY KEY (`listing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_listing_fields_maps`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_listing_fields_maps` (
  `field_id` int(11) unsigned NOT NULL,
  `option_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  `order` smallint(6) NOT NULL,
  PRIMARY KEY (`field_id`,`option_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_ynlistings_listing_fields_maps`
--

INSERT INTO `engine4_ynlistings_listing_fields_maps` (`field_id`, `option_id`, `child_id`, `order`) VALUES
(0, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_listing_fields_meta`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_listing_fields_meta` (
  `field_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) unsigned NOT NULL,
  `publish` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `order` smallint(3) unsigned NOT NULL DEFAULT '999',
  `config` text COLLATE utf8_unicode_ci,
  `validators` text COLLATE utf8_unicode_ci,
  `filters` text COLLATE utf8_unicode_ci,
  `style` text COLLATE utf8_unicode_ci,
  `error` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `engine4_ynlistings_listing_fields_meta`
--

INSERT INTO `engine4_ynlistings_listing_fields_meta` (`field_id`, `type`, `label`, `description`, `alias`, `required`, `display`, `publish`, `search`, `order`, `config`, `validators`, `filters`, `style`, `error`) VALUES
(1, 'profile_type', 'Profile Type', '', 'profile_type', 1, 0, 0, 2, 999, '', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_listing_fields_options`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_listing_fields_options` (
  `option_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`option_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_listing_fields_search`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_listing_fields_search` (
  `item_id` int(11) unsigned NOT NULL,
  `profile_type` enum('1','4') COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` smallint(6) unsigned DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `gender` (`gender`),
  KEY `birthdate` (`birthdate`),
  KEY `profile_type` (`profile_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_listing_fields_values`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_listing_fields_values` (
  `item_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `index` smallint(3) unsigned NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `privacy` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`item_id`,`field_id`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_mappings`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_mappings` (
  `mapping_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `listing_id` int(11) unsigned NOT NULL,
  `item_id` int(11) unsigned NOT NULL,
  `type` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`mapping_id`,`listing_id`,`item_id`),
  KEY `user_id` (`listing_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_orders`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_orders` (
  `order_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `gateway_id` int(11) unsigned NOT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `status` enum('pending','completed','cancelled','failed') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'pending',
  `creation_date` datetime NOT NULL,
  `payment_date` datetime DEFAULT NULL,
  `listing_id` int(11) unsigned NOT NULL DEFAULT '0',
  `price` decimal(16,2) NOT NULL DEFAULT '0.00',
  `currency` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `feature_day_number` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `gateway_id` (`gateway_id`),
  KEY `state` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_photos`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) unsigned NOT NULL,
  `album_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `image_title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `image_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `collection_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_posts`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_posts` (
  `post_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) unsigned NOT NULL,
  `listing_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `topic_id` (`topic_id`),
  KEY `listing_id` (`listing_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_reports`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `creation_date` datetime NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`report_id`),
  KEY `user_id` (`user_id`),
  KEY `listing_id` (`listing_id`),
  KEY `topic_id` (`topic_id`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_reviews`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_reviews` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `rate_number` smallint(5) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `listing_id` (`listing_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_topics`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_topics` (
  `topic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `sticky` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `post_count` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `lastpost_id` int(11) unsigned NOT NULL DEFAULT '0',
  `lastposter_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`topic_id`),
  KEY `listing_id` (`listing_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_topicwatches`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_topicwatches` (
  `resource_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `watch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`resource_id`,`topic_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_ynlistings_transactions`
--

CREATE TABLE IF NOT EXISTS `engine4_ynlistings_transactions` (
  `transaction_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `payment_transaction_id` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creation_date` date NOT NULL,
  `status` enum('initialized','expired','pending','completed','canceled') COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `gateway_id` int(11) NOT NULL,
  `amount` decimal(16,2) unsigned NOT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `listing_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_younetcore_apisettings`
--

CREATE TABLE IF NOT EXISTS `engine4_younetcore_apisettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `value` text NOT NULL,
  `params` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_younetcore_install`
--

CREATE TABLE IF NOT EXISTS `engine4_younetcore_install` (
  `token` text NOT NULL,
  `params` text NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `engine4_younetcore_install`
--

INSERT INTO `engine4_younetcore_install` (`token`, `params`, `id`) VALUES
('02cf5e1fec2a33b3473257cc373295d3', '1471798443', 1),
('da5268d6ffb3c7b95e77bbaf63968a6d', '1471799594', 2),
('f6543c8d23cf27566f457854f2bf37ca', '1471803810', 3);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_younetcore_license`
--

CREATE TABLE IF NOT EXISTS `engine4_younetcore_license` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `title` text NOT NULL,
  `descriptions` text,
  `type` varchar(50) NOT NULL,
  `current_version` varchar(50) NOT NULL,
  `lasted_version` varchar(50) NOT NULL,
  `is_active` int(1) DEFAULT '0',
  `date_active` int(11) DEFAULT NULL,
  `params` text,
  `download_link` varchar(500) DEFAULT NULL,
  `demo_link` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `engine4_younetcore_license`
--

INSERT INTO `engine4_younetcore_license` (`id`, `name`, `title`, `descriptions`, `type`, `current_version`, `lasted_version`, `is_active`, `date_active`, `params`, `download_link`, `demo_link`) VALUES
(1, 'ynresponsiveclean', 'YN - Responsive Clean Template', 'Responsive Clean Template', 'module', '4.01p7', '4.01p7', 1, NULL, 'a:8:{s:1:"m";s:17:"ynresponsiveclean";s:2:"tk";s:32:"02cf5e1fec2a33b3473257cc373295d3";s:1:"d";s:12:"bG9jYWxob3N0";s:2:"ep";s:10:"1471798443";s:4:"time";s:10:"1471798443";s:2:"ls";s:0:"";s:1:"t";s:7:"license";s:3:"svl";s:300:"YTo4OntzOjI6ImlkIjtpOjE0NzE3OTg0NDU7czo1OiJlbWFpbCI7czoxNDoidGVzdEBsb2NhbGhvc3QiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjE3OiJ5bnJlc3BvbnNpdmVjbGVhbiI7czo4OiJoYXNoX2tleSI7czowOiIiO3M6MTM6Im51bWJlcl9hY3RpdmUiO2k6MTtzOjY6InN0YXR1cyI7aToxO3M6MjoidHQiO3M6MTI6InNvY2lhbGVuZ2luZSI7czo5OiJ0dHZlcnNpb24iO3M6MToiNCI7fQ==";}', NULL, NULL),
(2, 'ynlistings', 'YN - Listings', '', 'module', '4.01p5', '4.01p5', 1, NULL, 'a:8:{s:1:"m";s:10:"ynlistings";s:2:"tk";s:32:"da5268d6ffb3c7b95e77bbaf63968a6d";s:1:"d";s:12:"bG9jYWxob3N0";s:2:"ep";s:10:"1471799595";s:4:"time";s:10:"1471799594";s:2:"ls";s:0:"";s:1:"t";s:7:"license";s:3:"svl";s:288:"YTo4OntzOjI6ImlkIjtpOjE0NzE3OTk1OTc7czo1OiJlbWFpbCI7czoxNDoidGVzdEBsb2NhbGhvc3QiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjEwOiJ5bmxpc3RpbmdzIjtzOjg6Imhhc2hfa2V5IjtzOjA6IiI7czoxMzoibnVtYmVyX2FjdGl2ZSI7aToxO3M6Njoic3RhdHVzIjtpOjE7czoyOiJ0dCI7czoxMjoic29jaWFsZW5naW5lIjtzOjk6InR0dmVyc2lvbiI7czoxOiI0Ijt9";}', NULL, NULL),
(3, 'advmenusystem', 'YN - Advanced Menu System', 'This is Advanced Menu System module.', 'module', '4.04p5', '4.04p5', 1, NULL, 'a:8:{s:1:"m";s:13:"advmenusystem";s:2:"tk";s:32:"f6543c8d23cf27566f457854f2bf37ca";s:1:"d";s:12:"bG9jYWxob3N0";s:2:"ep";s:10:"1471803810";s:4:"time";s:10:"1471803810";s:2:"ls";s:0:"";s:1:"t";s:7:"license";s:3:"svl";s:292:"YTo4OntzOjI6ImlkIjtpOjE0NzE4MDM4MTI7czo1OiJlbWFpbCI7czoxNDoidGVzdEBsb2NhbGhvc3QiO3M6MTE6Im1vZHVsZV9uYW1lIjtzOjEzOiJhZHZtZW51c3lzdGVtIjtzOjg6Imhhc2hfa2V5IjtzOjA6IiI7czoxMzoibnVtYmVyX2FjdGl2ZSI7aToxO3M6Njoic3RhdHVzIjtpOjE7czoyOiJ0dCI7czoxMjoic29jaWFsZW5naW5lIjtzOjk6InR0dmVyc2lvbiI7czoxOiI0Ijt9";}', NULL, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `engine4_question_answers`
--
ALTER TABLE `engine4_question_answers`
  ADD CONSTRAINT `FK_engine4_question_answers` FOREIGN KEY (`question_id`) REFERENCES `engine4_question_questions` (`question_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_engine4_question_answers_new` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `engine4_question_mratings`
--
ALTER TABLE `engine4_question_mratings`
  ADD CONSTRAINT `FK_engine4_question_mratings` FOREIGN KEY (`mrating_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `engine4_question_questions`
--
ALTER TABLE `engine4_question_questions`
  ADD CONSTRAINT `FK_engine4_question_questions` FOREIGN KEY (`best_answer_id`) REFERENCES `engine4_question_answers` (`answer_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_engine4_question_questions_user` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `engine4_question_qvotes`
--
ALTER TABLE `engine4_question_qvotes`
  ADD CONSTRAINT `FK_engine4_question_qvotes` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_engine4_question_qvotes_question` FOREIGN KEY (`question_id`) REFERENCES `engine4_question_questions` (`question_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `engine4_question_ratings`
--
ALTER TABLE `engine4_question_ratings`
  ADD CONSTRAINT `FK_engine4_question_ratings` FOREIGN KEY (`rating_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `engine4_question_subscribers`
--
ALTER TABLE `engine4_question_subscribers`
  ADD CONSTRAINT `FK_engine4_question_subscribers` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_engine4_question_subscribers_q` FOREIGN KEY (`question_id`) REFERENCES `engine4_question_questions` (`question_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `engine4_question_votes`
--
ALTER TABLE `engine4_question_votes`
  ADD CONSTRAINT `FK_engine4_question_answers_votes` FOREIGN KEY (`answer_id`) REFERENCES `engine4_question_answers` (`answer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_engine4_question_votes` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
