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

INSERT IGNORE INTO `engine4_authorization_allow`
  SELECT
    'question' as `resource_type`,
    question_id as `resource_id`,
    'answer' as `action`,
    'registered' as `role`,
    0 as `role_id`,
    1 as `value`,
    null as `params`
  FROM `engine4_question_questions`;

INSERT IGNORE INTO `engine4_authorization_allow`
  SELECT
    'question' AS `resource_type`,
    question_id AS `resource_id`,
    'view' AS `action`,
    'everyone' AS `role`,
    0 AS `role_id`,
    1 AS `value`,
    NULL AS `params`
  FROM `engine4_question_questions`;
