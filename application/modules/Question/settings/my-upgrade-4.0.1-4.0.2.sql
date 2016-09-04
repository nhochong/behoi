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