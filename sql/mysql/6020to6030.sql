-- 20111014
--- modify table struct
ALTER TABLE `eip_t_todo` ADD `create_user_id` INTEGER NOT NULL DEFAULT 0;
UPDATE `eip_t_todo` SET `create_user_id` = `user_id`;
-- 20111014

-- 20111019
-- change ACL settings
UPDATE eip_t_acl_portlet_feature SET acl_type = 31 WHERE feature_name = 'todo_todo_other';
UPDATE eip_t_acl_role SET acl_type = 31, note = '＊詳細表示、追加、削除は一覧表示の権限を持っていないと使用できません' WHERE feature_id IN (SELECT feature_id FROM eip_t_acl_portlet_feature WHERE feature_name = 'todo_todo_other');

-- modify table struct
ALTER TABLE eip_t_todo_category ADD update_user_id INTEGER NOT NULL DEFAULT 0;
UPDATE eip_t_todo_category SET update_user_id = user_id;

-- add new ACL setting
INSERT INTO eip_t_acl_portlet_feature VALUES(null,'todo_category_other','ToDo（他ユーザのカテゴリ）操作',27);
INSERT INTO eip_t_acl_role VALUES(null, 'ToDo（他ユーザのカテゴリ）管理者', (SELECT feature_id from eip_t_acl_portlet_feature WHERE feature_name = 'todo_category_other' limit 1),27,'＊詳細表示、編集、削除は一覧表示の権限を持っていないと使用できません', null, null);
-- 20111019

-- 20111021
-- modify table struct
CREATE TABLE `eip_m_inactive_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- 20111021

-- 20111021
INSERT INTO eip_m_mail_notify_conf VALUES(null,1,25,3,NULL,now(),now());
-- 20111021

-- 20111025
INSERT INTO eip_t_cabinet_folder_map VALUES(null,1,0,NULL);
-- 20111025

-- 20111028
UPDATE `eip_t_cabinet_file` SET `counter` = 0 WHERE `counter` = '';
UPDATE `eip_t_cabinet_file` SET `counter` = 0 WHERE `counter` IS NULL;
-- 20111028

-- 20111116
UPDATE `eip_t_acl_portlet_feature` SET `feature_alias_name` = 'スケジュール（設備の予約）操作' WHERE `feature_name` = 'schedule_facility' AND `feature_alias_name` = 'スケジュール（施設の予約）操作';
UPDATE `eip_t_acl_role` SET `role_name` = 'スケジュール（設備の予約）操作' WHERE feature_id IN (SELECT feature_id FROM eip_t_acl_portlet_feature WHERE feature_name = 'schedule_facility') AND `role_name` = 'スケジュール（施設の予約）管理者';
-- 20111116

-- 20111116
UPDATE `eip_t_acl_portlet_feature` SET `acl_type` = 27 WHERE feature_name = 'blog_entry_other';
INSERT INTO `eip_t_acl_portlet_feature` VALUES(null,'blog_entry_other_reply','ブログ（他ユーザーの記事へのコメント）操作',16);
UPDATE `eip_t_acl_role` SET `note` = '＊詳細表示、編集、削除は一覧表示の権限を持っていないと使用できません' WHERE feature_id IN (SELECT feature_id FROM eip_t_acl_portlet_feature WHERE feature_name = 'blog_entry_other');
-- 20111116

-- 20111124
ALTER TABLE eip_t_todo MODIFY COLUMN `create_user_id` INTEGER NOT NULL;
ALTER TABLE eip_t_todo_category MODIFY COLUMN `update_user_id` INTEGER NOT NULL;
-- 20111124

-- 20111214
CREATE TABLE `eip_t_report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `report_name` varchar(64) COLLATE utf8_unicode_ci,
  `note` text COLLATE utf8_unicode_ci,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `eip_t_report_file` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `file_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `file_path` text COLLATE utf8_unicode_ci NOT NULL,
  `file_thumbnail` blob,
  `create_date` date DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `eip_t_report_member_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `eip_t_report_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
INSERT INTO eip_m_mail_notify_conf VALUES(null,1,26,3,NULL,now(),now());
INSERT INTO eip_t_acl_portlet_feature VALUES(null,'report_self','報告書（自分の報告書）操作',31);
INSERT INTO eip_t_acl_role VALUES(null, '報告書（自分の報告書）管理者', (SELECT feature_id from eip_t_acl_portlet_feature WHERE feature_name = 'report_self' limit 1),31,'＊追加、編集、削除は一覧表示と詳細表示の権限を持っていないと使用できません', null, null);
INSERT INTO eip_t_acl_portlet_feature VALUES(null,'report_other','報告書（他ユーザーの報告書）操作',3);
INSERT INTO eip_t_acl_role VALUES(null, '報告書（他ユーザーの報告書）管理者', (SELECT feature_id from eip_t_acl_portlet_feature WHERE feature_name = 'report_other' limit 1),3,'＊詳細表示は一覧表示の権限を持っていないと使用できません', null, null);
ALTER TABLE `eip_t_report_file` ADD FOREIGN KEY (  `report_id` ) REFERENCES  `eip_t_report` (`report_id`) ON DELETE CASCADE ;
ALTER TABLE `eip_t_report_member_map` ADD FOREIGN KEY (  `report_id` ) REFERENCES  `eip_t_report` (`report_id`) ON DELETE CASCADE ;
ALTER TABLE `eip_t_report_map` ADD FOREIGN KEY (  `report_id` ) REFERENCES  `eip_t_report` (`report_id`) ON DELETE CASCADE ;
-- 20111214