UPDATE `engine4_core_modules` SET `version` = '4.09p2' where 'name' = 'ynblog';
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES ('ynblog_main_export', 'ynblog', 'Export Blogs', 'YnBlog_Plugin_Menus::canExportBlogs','{"route":"blog_export","action":"index"}','ynblog_main','',5);