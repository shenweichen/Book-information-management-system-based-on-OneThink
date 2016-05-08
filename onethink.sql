-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2016 at 07:17 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `onethink`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_bookid`(isbnid varchar(17)) RETURNS int(11)
begin
DECLARE a int ;
set a = (select totalnum from ot_book where isbn=isbnid);
return (a+1);
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ot_action`
--

CREATE TABLE IF NOT EXISTS `ot_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text COMMENT '行为规则',
  `log` text COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表' AUTO_INCREMENT=12 ;

--
-- Dumping data for table `ot_action`
--

INSERT INTO `ot_action` (`id`, `name`, `title`, `remark`, `rule`, `log`, `type`, `status`, `update_time`) VALUES
(1, 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', 1, 1, 1387181220),
(2, 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', 2, 0, 1380173180),
(3, 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', 2, 1, 1383285646),
(4, 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', 2, 0, 1386139726),
(5, 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', 2, 0, 1383285551),
(6, 'update_config', '更新配置', '新增或修改或删除配置', '', '', 1, 1, 1383294988),
(7, 'update_model', '更新模型', '新增或修改模型', '', '', 1, 1, 1383295057),
(8, 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', 1, 1, 1383295963),
(9, 'update_channel', '更新导航', '新增或修改或删除导航', '', '', 1, 1, 1383296301),
(10, 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', 1, 1, 1383296392),
(11, 'update_category', '更新分类', '新增或修改或删除分类', '', '', 1, 1, 1383296765);

-- --------------------------------------------------------

--
-- Table structure for table `ot_action_log`
--

CREATE TABLE IF NOT EXISTS `ot_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表' AUTO_INCREMENT=84 ;

--
-- Dumping data for table `ot_action_log`
--

INSERT INTO `ot_action_log` (`id`, `action_id`, `user_id`, `action_ip`, `model`, `record_id`, `remark`, `status`, `create_time`) VALUES
(1, 1, 1, 0, 'member', 1, 'admin在2016-04-17 11:33登录了后台', 1, 1460863983),
(2, 9, 1, 0, 'channel', 2, '操作url：/onethinkbt3/admin.php?s=/Channel/edit.html', 1, 1460864091),
(3, 1, 1, 0, 'member', 1, 'admin在2016-04-17 15:31登录了后台', 1, 1460878309),
(4, 1, 1, 0, 'member', 1, 'admin在2016-04-17 16:06登录了后台', 1, 1460880404),
(5, 1, 1, 0, 'member', 1, 'admin在2016-04-17 16:38登录了后台', 1, 1460882318),
(6, 1, 1, 0, 'member', 1, 'admin在2016-04-17 22:13登录了后台', 1, 1460902427),
(7, 1, 1, 0, 'member', 1, 'admin在2016-04-17 22:23登录了后台', 1, 1460903025),
(8, 1, 1, 0, 'member', 1, 'admin在2016-04-17 23:26登录了后台', 1, 1460906779),
(9, 1, 1, 0, 'member', 1, 'admin在2016-04-18 09:33登录了后台', 1, 1460943232),
(10, 1, 1, 0, 'member', 1, 'admin在2016-04-18 10:53登录了后台', 1, 1460947988),
(11, 1, 1, 0, 'member', 1, 'admin在2016-04-18 14:29登录了后台', 1, 1460960958),
(12, 1, 1, 0, 'member', 1, 'admin在2016-04-18 19:10登录了后台', 1, 1460977828),
(13, 1, 1, 0, 'member', 1, 'admin在2016-04-18 20:16登录了后台', 1, 1460981761),
(14, 1, 1, 0, 'member', 1, 'admin在2016-04-18 21:22登录了后台', 1, 1460985773),
(15, 1, 2, 0, 'member', 2, 'swc在2016-04-18 21:33登录了后台', 1, 1460986400),
(16, 1, 1, 0, 'member', 1, 'admin在2016-04-18 23:23登录了后台', 1, 1460993011),
(17, 1, 2, 0, 'member', 2, 'swc在2016-04-19 11:43登录了后台', 1, 1461037424),
(18, 1, 1, 0, 'member', 1, 'admin在2016-04-19 11:46登录了后台', 1, 1461037619),
(19, 7, 1, 0, 'model', 4, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461052737),
(20, 8, 1, 0, 'attribute', 33, '操作url：/onethink/admin.php?s=/Attribute/update.html', 1, 1461052776),
(21, 8, 1, 0, 'attribute', 34, '操作url：/onethink/admin.php?s=/Attribute/update.html', 1, 1461052811),
(22, 7, 1, 0, 'model', 4, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461052907),
(23, 11, 1, 0, 'category', 39, '操作url：/onethink/admin.php?s=/Category/add.html', 1, 1461053359),
(24, 7, 1, 0, 'model', 5, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461063071),
(25, 8, 1, 0, 'attribute', 35, '操作url：/onethink/admin.php?s=/Attribute/update.html', 1, 1461063201),
(26, 7, 1, 0, 'model', 5, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461063298),
(27, 7, 1, 0, 'model', 5, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461064778),
(28, 7, 1, 0, 'model', 5, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461064910),
(29, 11, 1, 0, 'category', 39, '操作url：/onethink/admin.php?s=/Category/remove/id/39.html', 1, 1461065000),
(30, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461065098),
(31, 8, 1, 0, 'attribute', 38, '操作url：/onethink/admin.php?s=/Attribute/update.html', 1, 1461065160),
(32, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461065224),
(33, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461065252),
(34, 11, 1, 0, 'category', 40, '操作url：/onethink/admin.php?s=/Category/add.html', 1, 1461065326),
(35, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461066336),
(36, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461066560),
(37, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461066584),
(38, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461066622),
(39, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461066657),
(40, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461066667),
(41, 11, 1, 0, 'category', 40, '操作url：/onethink/admin.php?s=/Category/remove/id/40.html', 1, 1461066911),
(42, 11, 1, 0, 'category', 41, '操作url：/onethink/admin.php?s=/Category/add.html', 1, 1461066930),
(43, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461067133),
(44, 7, 1, 0, 'model', 6, '操作url：/onethink/admin.php?s=/Model/update.html', 1, 1461067146),
(45, 8, 1, 0, 'attribute', 39, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(46, 8, 1, 0, 'attribute', 40, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(47, 8, 1, 0, 'attribute', 41, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(48, 8, 1, 0, 'attribute', 42, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(49, 8, 1, 0, 'attribute', 43, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(50, 8, 1, 0, 'attribute', 44, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(51, 8, 1, 0, 'attribute', 45, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(52, 8, 1, 0, 'attribute', 46, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(53, 8, 1, 0, 'attribute', 47, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(54, 8, 1, 0, 'attribute', 48, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(55, 8, 1, 0, 'attribute', 49, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071229),
(56, 8, 1, 0, 'attribute', 50, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(57, 8, 1, 0, 'attribute', 51, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(58, 8, 1, 0, 'attribute', 52, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(59, 8, 1, 0, 'attribute', 53, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(60, 8, 1, 0, 'attribute', 54, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(61, 8, 1, 0, 'attribute', 55, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(62, 8, 1, 0, 'attribute', 56, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(63, 8, 1, 0, 'attribute', 57, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(64, 8, 1, 0, 'attribute', 58, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(65, 8, 1, 0, 'attribute', 59, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(66, 8, 1, 0, 'attribute', 60, '操作url：/onethink/admin.php?s=/Model/generate.html', 1, 1461071285),
(67, 11, 1, 0, 'category', 41, '操作url：/onethink/admin.php?s=/Category/remove/id/41.html', 1, 1461071417),
(68, 1, 1, 0, 'member', 1, 'admin在2016-04-20 09:14登录了后台', 1, 1461114849),
(69, 1, 1, 0, 'member', 1, 'admin在2016-04-22 19:17登录了后台', 1, 1461323875),
(70, 1, 1, 0, 'member', 1, 'admin在2016-04-22 20:01登录了后台', 1, 1461326504),
(71, 1, 1, 0, 'member', 1, 'admin在2016-04-22 21:28登录了后台', 1, 1461331732),
(72, 1, 1, 0, 'member', 1, 'admin在2016-04-24 12:39登录了后台', 1, 1461472787),
(73, 1, 1, 0, 'member', 1, 'admin在2016-04-27 16:59登录了后台', 1, 1461747599),
(74, 1, 1, 0, 'member', 1, 'admin在2016-05-06 13:31登录了后台', 1, 1462512713),
(75, 1, 1, 0, 'member', 1, 'admin在2016-05-06 13:36登录了后台', 1, 1462512986),
(76, 1, 1, 0, 'member', 1, 'admin在2016-05-06 14:02登录了后台', 1, 1462514551),
(77, 9, 1, 0, 'channel', 3, '操作url：/onethink/admin.php?s=/Channel/edit.html', 1, 1462514984),
(78, 9, 1, 0, 'channel', 3, '操作url：/onethink/admin.php?s=/Channel/edit.html', 1, 1462515183),
(79, 1, 1, 0, 'member', 1, 'admin在2016-05-07 16:06登录了后台', 1, 1462608402),
(80, 1, 2, 0, 'member', 2, 'swc在2016-05-07 16:57登录了后台', 1, 1462611453),
(81, 1, 1, 0, 'member', 1, 'admin在2016-05-07 18:12登录了后台', 1, 1462615920),
(82, 1, 1, 0, 'member', 1, 'admin在2016-05-07 23:34登录了后台', 1, 1462635287),
(83, 1, 1, 0, 'member', 1, 'admin在2016-05-08 11:41登录了后台', 1, 1462678898);

-- --------------------------------------------------------

--
-- Table structure for table `ot_addons`
--

CREATE TABLE IF NOT EXISTS `ot_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='插件表' AUTO_INCREMENT=16 ;

--
-- Dumping data for table `ot_addons`
--

INSERT INTO `ot_addons` (`id`, `name`, `title`, `description`, `status`, `config`, `author`, `version`, `create_time`, `has_adminlist`) VALUES
(15, 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', 1, '{"editor_type":"2","editor_wysiwyg":"1","editor_height":"500px","editor_resize_type":"1"}', 'thinkphp', '0.1', 1383126253, 0),
(2, 'SiteStat', '站点统计信息', '统计站点的基础信息', 1, '{"title":"\\u7cfb\\u7edf\\u4fe1\\u606f","width":"1","display":"1","status":"0"}', 'thinkphp', '0.1', 1379512015, 0),
(3, 'DevTeam', '开发团队信息', '开发团队成员信息', 1, '{"title":"OneThink\\u5f00\\u53d1\\u56e2\\u961f","width":"2","display":"1"}', 'thinkphp', '0.1', 1379512022, 0),
(4, 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', 1, '{"title":"\\u7cfb\\u7edf\\u4fe1\\u606f","width":"2","display":"1"}', 'thinkphp', '0.1', 1379512036, 0),
(5, 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', 1, '{"editor_type":"2","editor_wysiwyg":"1","editor_height":"300px","editor_resize_type":"1"}', 'thinkphp', '0.1', 1379830910, 0),
(6, 'Attachment', '附件', '用于文档模型上传附件', 1, 'null', 'thinkphp', '0.1', 1379842319, 1),
(9, 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', 1, '{"comment_type":"1","comment_uid_youyan":"","comment_short_name_duoshuo":"","comment_data_list_duoshuo":""}', 'thinkphp', '0.1', 1380273962, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ot_attachment`
--

CREATE TABLE IF NOT EXISTS `ot_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ot_attribute`
--

CREATE TABLE IF NOT EXISTS `ot_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL DEFAULT '',
  `validate_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `error_info` varchar(100) NOT NULL DEFAULT '',
  `validate_type` varchar(25) NOT NULL DEFAULT '',
  `auto_rule` varchar(100) NOT NULL DEFAULT '',
  `auto_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `auto_type` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='模型属性表' AUTO_INCREMENT=61 ;

--
-- Dumping data for table `ot_attribute`
--

INSERT INTO `ot_attribute` (`id`, `name`, `title`, `field`, `type`, `value`, `remark`, `is_show`, `extra`, `model_id`, `is_must`, `status`, `update_time`, `create_time`, `validate_rule`, `validate_time`, `error_info`, `validate_type`, `auto_rule`, `auto_time`, `auto_type`) VALUES
(1, 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', 0, '', 1, 0, 1, 1384508362, 1383891233, '', 0, '', '', '', 0, ''),
(2, 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', 1, '', 1, 0, 1, 1383894743, 1383891233, '', 0, '', '', '', 0, ''),
(3, 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', 1, '', 1, 0, 1, 1383894778, 1383891233, '', 0, '', '', '', 0, ''),
(4, 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', 0, '', 1, 0, 1, 1384508336, 1383891233, '', 0, '', '', '', 0, ''),
(5, 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', 1, '', 1, 0, 1, 1383894927, 1383891233, '', 0, '', '', '', 0, ''),
(6, 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', 0, '', 1, 0, 1, 1384508323, 1383891233, '', 0, '', '', '', 0, ''),
(7, 'pid', '所属ID', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', 0, '', 1, 0, 1, 1384508543, 1383891233, '', 0, '', '', '', 0, ''),
(8, 'model_id', '内容模型ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', 0, '', 1, 0, 1, 1384508350, 1383891233, '', 0, '', '', '', 0, ''),
(9, 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', 1, '1:目录\r\n2:主题\r\n3:段落', 1, 0, 1, 1384511157, 1383891233, '', 0, '', '', '', 0, ''),
(10, 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', 1, '[DOCUMENT_POSITION]', 1, 0, 1, 1383895640, 1383891233, '', 0, '', '', '', 0, ''),
(11, 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', 1, '', 1, 0, 1, 1383895757, 1383891233, '', 0, '', '', '', 0, ''),
(12, 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', 1, '', 1, 0, 1, 1384147827, 1383891233, '', 0, '', '', '', 0, ''),
(13, 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', 1, '0:不可见\r\n1:所有人可见', 1, 0, 1, 1386662271, 1383891233, '', 0, '', 'regex', '', 0, 'function'),
(14, 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', 1, '', 1, 0, 1, 1387163248, 1383891233, '', 0, '', 'regex', '', 0, 'function'),
(15, 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', 0, '', 1, 0, 1, 1387260355, 1383891233, '', 0, '', 'regex', '', 0, 'function'),
(16, 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', 1, '', 1, 0, 1, 1383895835, 1383891233, '', 0, '', '', '', 0, ''),
(17, 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', 1, '', 1, 0, 1, 1383895846, 1383891233, '', 0, '', '', '', 0, ''),
(18, 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', 0, '', 1, 0, 1, 1384508264, 1383891233, '', 0, '', '', '', 0, ''),
(19, 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', 1, '', 1, 0, 1, 1383895894, 1383891233, '', 0, '', '', '', 0, ''),
(20, 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', 1, '', 1, 0, 1, 1383895903, 1383891233, '', 0, '', '', '', 0, ''),
(21, 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', 0, '', 1, 0, 1, 1384508277, 1383891233, '', 0, '', '', '', 0, ''),
(22, 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', 0, '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', 1, 0, 1, 1384508496, 1383891233, '', 0, '', '', '', 0, ''),
(23, 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', 0, '0:html\r\n1:ubb\r\n2:markdown', 2, 0, 1, 1384511049, 1383891243, '', 0, '', '', '', 0, ''),
(24, 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', 1, '', 2, 0, 1, 1383896225, 1383891243, '', 0, '', '', '', 0, ''),
(25, 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', 1, '', 2, 0, 1, 1383896190, 1383891243, '', 0, '', '', '', 0, ''),
(26, 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', 1, '', 2, 0, 1, 1383896103, 1383891243, '', 0, '', '', '', 0, ''),
(27, 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', 0, '0:html\r\n1:ubb\r\n2:markdown', 3, 0, 1, 1387260461, 1383891252, '', 0, '', 'regex', '', 0, 'function'),
(28, 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', 1, '', 3, 0, 1, 1383896438, 1383891252, '', 0, '', '', '', 0, ''),
(29, 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', 1, '', 3, 0, 1, 1383896429, 1383891252, '', 0, '', '', '', 0, ''),
(30, 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', 1, '', 3, 0, 1, 1383896415, 1383891252, '', 0, '', '', '', 0, ''),
(31, 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', 1, '', 3, 0, 1, 1383896380, 1383891252, '', 0, '', '', '', 0, ''),
(32, 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', 1, '', 3, 0, 1, 1383896371, 1383891252, '', 0, '', '', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `ot_auth_extend`
--

CREATE TABLE IF NOT EXISTS `ot_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

--
-- Dumping data for table `ot_auth_extend`
--

INSERT INTO `ot_auth_extend` (`group_id`, `extend_id`, `type`) VALUES
(1, 1, 1),
(1, 1, 2),
(1, 2, 1),
(1, 2, 2),
(1, 3, 1),
(1, 3, 2),
(1, 4, 1),
(1, 37, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ot_auth_group`
--

CREATE TABLE IF NOT EXISTS `ot_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ot_auth_group`
--

INSERT INTO `ot_auth_group` (`id`, `module`, `type`, `title`, `description`, `status`, `rules`) VALUES
(1, 'admin', 1, '默认用户组', '', 1, '1,2,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,96,97,100,102,103,105,106'),
(2, 'admin', 1, '测试用户', '测试用户', 1, '1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195');

-- --------------------------------------------------------

--
-- Table structure for table `ot_auth_group_access`
--

CREATE TABLE IF NOT EXISTS `ot_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ot_auth_rule`
--

CREATE TABLE IF NOT EXISTS `ot_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=217 ;

--
-- Dumping data for table `ot_auth_rule`
--

INSERT INTO `ot_auth_rule` (`id`, `module`, `type`, `name`, `title`, `status`, `condition`) VALUES
(1, 'admin', 2, 'Admin/Index/index', '首页', 1, ''),
(2, 'admin', 2, 'Admin/Article/index', '内容', 1, ''),
(3, 'admin', 2, 'Admin/User/index', '用户', 1, ''),
(4, 'admin', 2, 'Admin/Addons/index', '扩展', 1, ''),
(5, 'admin', 2, 'Admin/Config/group', '系统', 1, ''),
(7, 'admin', 1, 'Admin/article/add', '新增', 1, ''),
(8, 'admin', 1, 'Admin/article/edit', '编辑', 1, ''),
(9, 'admin', 1, 'Admin/article/setStatus', '改变状态', 1, ''),
(10, 'admin', 1, 'Admin/article/update', '保存', 1, ''),
(11, 'admin', 1, 'Admin/article/autoSave', '保存草稿', 1, ''),
(12, 'admin', 1, 'Admin/article/move', '移动', 1, ''),
(13, 'admin', 1, 'Admin/article/copy', '复制', 1, ''),
(14, 'admin', 1, 'Admin/article/paste', '粘贴', 1, ''),
(15, 'admin', 1, 'Admin/article/permit', '还原', 1, ''),
(16, 'admin', 1, 'Admin/article/clear', '清空', 1, ''),
(17, 'admin', 1, 'Admin/article/examine', '审核列表', 1, ''),
(18, 'admin', 1, 'Admin/article/recycle', '回收站', 1, ''),
(19, 'admin', 1, 'Admin/User/addaction', '新增用户行为', 1, ''),
(20, 'admin', 1, 'Admin/User/editaction', '编辑用户行为', 1, ''),
(21, 'admin', 1, 'Admin/User/saveAction', '保存用户行为', 1, ''),
(22, 'admin', 1, 'Admin/User/setStatus', '变更行为状态', 1, ''),
(23, 'admin', 1, 'Admin/User/changeStatus?method=forbidUser', '禁用会员', 1, ''),
(24, 'admin', 1, 'Admin/User/changeStatus?method=resumeUser', '启用会员', 1, ''),
(25, 'admin', 1, 'Admin/User/changeStatus?method=deleteUser', '删除会员', 1, ''),
(26, 'admin', 1, 'Admin/User/index', '用户信息', 1, ''),
(27, 'admin', 1, 'Admin/User/action', '用户行为', 1, ''),
(28, 'admin', 1, 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', 1, ''),
(29, 'admin', 1, 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', 1, ''),
(30, 'admin', 1, 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', 1, ''),
(31, 'admin', 1, 'Admin/AuthManager/createGroup', '新增', 1, ''),
(32, 'admin', 1, 'Admin/AuthManager/editGroup', '编辑', 1, ''),
(33, 'admin', 1, 'Admin/AuthManager/writeGroup', '保存用户组', 1, ''),
(34, 'admin', 1, 'Admin/AuthManager/group', '授权', 1, ''),
(35, 'admin', 1, 'Admin/AuthManager/access', '访问授权', 1, ''),
(36, 'admin', 1, 'Admin/AuthManager/user', '成员授权', 1, ''),
(37, 'admin', 1, 'Admin/AuthManager/removeFromGroup', '解除授权', 1, ''),
(38, 'admin', 1, 'Admin/AuthManager/addToGroup', '保存成员授权', 1, ''),
(39, 'admin', 1, 'Admin/AuthManager/category', '分类授权', 1, ''),
(40, 'admin', 1, 'Admin/AuthManager/addToCategory', '保存分类授权', 1, ''),
(41, 'admin', 1, 'Admin/AuthManager/index', '权限管理', 1, ''),
(42, 'admin', 1, 'Admin/Addons/create', '创建', 1, ''),
(43, 'admin', 1, 'Admin/Addons/checkForm', '检测创建', 1, ''),
(44, 'admin', 1, 'Admin/Addons/preview', '预览', 1, ''),
(45, 'admin', 1, 'Admin/Addons/build', '快速生成插件', 1, ''),
(46, 'admin', 1, 'Admin/Addons/config', '设置', 1, ''),
(47, 'admin', 1, 'Admin/Addons/disable', '禁用', 1, ''),
(48, 'admin', 1, 'Admin/Addons/enable', '启用', 1, ''),
(49, 'admin', 1, 'Admin/Addons/install', '安装', 1, ''),
(50, 'admin', 1, 'Admin/Addons/uninstall', '卸载', 1, ''),
(51, 'admin', 1, 'Admin/Addons/saveconfig', '更新配置', 1, ''),
(52, 'admin', 1, 'Admin/Addons/adminList', '插件后台列表', 1, ''),
(53, 'admin', 1, 'Admin/Addons/execute', 'URL方式访问插件', 1, ''),
(54, 'admin', 1, 'Admin/Addons/index', '插件管理', 1, ''),
(55, 'admin', 1, 'Admin/Addons/hooks', '钩子管理', 1, ''),
(56, 'admin', 1, 'Admin/model/add', '新增', 1, ''),
(57, 'admin', 1, 'Admin/model/edit', '编辑', 1, ''),
(58, 'admin', 1, 'Admin/model/setStatus', '改变状态', 1, ''),
(59, 'admin', 1, 'Admin/model/update', '保存数据', 1, ''),
(60, 'admin', 1, 'Admin/Model/index', '模型管理', 1, ''),
(61, 'admin', 1, 'Admin/Config/edit', '编辑', 1, ''),
(62, 'admin', 1, 'Admin/Config/del', '删除', 1, ''),
(63, 'admin', 1, 'Admin/Config/add', '新增', 1, ''),
(64, 'admin', 1, 'Admin/Config/save', '保存', 1, ''),
(65, 'admin', 1, 'Admin/Config/group', '网站设置', 1, ''),
(66, 'admin', 1, 'Admin/Config/index', '配置管理', 1, ''),
(67, 'admin', 1, 'Admin/Channel/add', '新增', 1, ''),
(68, 'admin', 1, 'Admin/Channel/edit', '编辑', 1, ''),
(69, 'admin', 1, 'Admin/Channel/del', '删除', 1, ''),
(70, 'admin', 1, 'Admin/Channel/index', '导航管理', 1, ''),
(71, 'admin', 1, 'Admin/Category/edit', '编辑', 1, ''),
(72, 'admin', 1, 'Admin/Category/add', '新增', 1, ''),
(73, 'admin', 1, 'Admin/Category/remove', '删除', 1, ''),
(74, 'admin', 1, 'Admin/Category/index', '分类管理', 1, ''),
(75, 'admin', 1, 'Admin/file/upload', '上传控件', -1, ''),
(76, 'admin', 1, 'Admin/file/uploadPicture', '上传图片', -1, ''),
(77, 'admin', 1, 'Admin/file/download', '下载', -1, ''),
(94, 'admin', 1, 'Admin/AuthManager/modelauth', '模型授权', 1, ''),
(79, 'admin', 1, 'Admin/article/batchOperate', '导入', 1, ''),
(80, 'admin', 1, 'Admin/Database/index?type=export', '备份数据库', 1, ''),
(81, 'admin', 1, 'Admin/Database/index?type=import', '还原数据库', 1, ''),
(82, 'admin', 1, 'Admin/Database/export', '备份', 1, ''),
(83, 'admin', 1, 'Admin/Database/optimize', '优化表', 1, ''),
(84, 'admin', 1, 'Admin/Database/repair', '修复表', 1, ''),
(86, 'admin', 1, 'Admin/Database/import', '恢复', 1, ''),
(87, 'admin', 1, 'Admin/Database/del', '删除', 1, ''),
(88, 'admin', 1, 'Admin/User/add', '新增用户', 1, ''),
(89, 'admin', 1, 'Admin/Attribute/index', '属性管理', 1, ''),
(90, 'admin', 1, 'Admin/Attribute/add', '新增', 1, ''),
(91, 'admin', 1, 'Admin/Attribute/edit', '编辑', 1, ''),
(92, 'admin', 1, 'Admin/Attribute/setStatus', '改变状态', 1, ''),
(93, 'admin', 1, 'Admin/Attribute/update', '保存数据', 1, ''),
(95, 'admin', 1, 'Admin/AuthManager/addToModel', '保存模型授权', 1, ''),
(96, 'admin', 1, 'Admin/Category/move', '移动', -1, ''),
(97, 'admin', 1, 'Admin/Category/merge', '合并', -1, ''),
(98, 'admin', 1, 'Admin/Config/menu', '后台菜单管理', -1, ''),
(99, 'admin', 1, 'Admin/Article/mydocument', '内容', -1, ''),
(100, 'admin', 1, 'Admin/Menu/index', '菜单管理', 1, ''),
(101, 'admin', 1, 'Admin/other', '其他', -1, ''),
(102, 'admin', 1, 'Admin/Menu/add', '新增', 1, ''),
(103, 'admin', 1, 'Admin/Menu/edit', '编辑', 1, ''),
(104, 'admin', 1, 'Admin/Think/lists?model=article', '文章管理', -1, ''),
(105, 'admin', 1, 'Admin/Think/lists?model=download', '下载管理', 1, ''),
(106, 'admin', 1, 'Admin/Think/lists?model=config', '配置管理', 1, ''),
(107, 'admin', 1, 'Admin/Action/actionlog', '行为日志', 1, ''),
(108, 'admin', 1, 'Admin/User/updatePassword', '修改密码', 1, ''),
(109, 'admin', 1, 'Admin/User/updateNickname', '修改昵称', 1, ''),
(110, 'admin', 1, 'Admin/action/edit', '查看行为日志', 1, ''),
(205, 'admin', 1, 'Admin/think/add', '新增数据', 1, ''),
(111, 'admin', 2, 'Admin/article/index', '文档列表', -1, ''),
(112, 'admin', 2, 'Admin/article/add', '新增', -1, ''),
(113, 'admin', 2, 'Admin/article/edit', '编辑', -1, ''),
(114, 'admin', 2, 'Admin/article/setStatus', '改变状态', -1, ''),
(115, 'admin', 2, 'Admin/article/update', '保存', -1, ''),
(116, 'admin', 2, 'Admin/article/autoSave', '保存草稿', -1, ''),
(117, 'admin', 2, 'Admin/article/move', '移动', -1, ''),
(118, 'admin', 2, 'Admin/article/copy', '复制', -1, ''),
(119, 'admin', 2, 'Admin/article/paste', '粘贴', -1, ''),
(120, 'admin', 2, 'Admin/article/batchOperate', '导入', -1, ''),
(121, 'admin', 2, 'Admin/article/recycle', '回收站', -1, ''),
(122, 'admin', 2, 'Admin/article/permit', '还原', -1, ''),
(123, 'admin', 2, 'Admin/article/clear', '清空', -1, ''),
(124, 'admin', 2, 'Admin/User/add', '新增用户', -1, ''),
(125, 'admin', 2, 'Admin/User/action', '用户行为', -1, ''),
(126, 'admin', 2, 'Admin/User/addAction', '新增用户行为', -1, ''),
(127, 'admin', 2, 'Admin/User/editAction', '编辑用户行为', -1, ''),
(128, 'admin', 2, 'Admin/User/saveAction', '保存用户行为', -1, ''),
(129, 'admin', 2, 'Admin/User/setStatus', '变更行为状态', -1, ''),
(130, 'admin', 2, 'Admin/User/changeStatus?method=forbidUser', '禁用会员', -1, ''),
(131, 'admin', 2, 'Admin/User/changeStatus?method=resumeUser', '启用会员', -1, ''),
(132, 'admin', 2, 'Admin/User/changeStatus?method=deleteUser', '删除会员', -1, ''),
(133, 'admin', 2, 'Admin/AuthManager/index', '权限管理', -1, ''),
(134, 'admin', 2, 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', -1, ''),
(135, 'admin', 2, 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', -1, ''),
(136, 'admin', 2, 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', -1, ''),
(137, 'admin', 2, 'Admin/AuthManager/createGroup', '新增', -1, ''),
(138, 'admin', 2, 'Admin/AuthManager/editGroup', '编辑', -1, ''),
(139, 'admin', 2, 'Admin/AuthManager/writeGroup', '保存用户组', -1, ''),
(140, 'admin', 2, 'Admin/AuthManager/group', '授权', -1, ''),
(141, 'admin', 2, 'Admin/AuthManager/access', '访问授权', -1, ''),
(142, 'admin', 2, 'Admin/AuthManager/user', '成员授权', -1, ''),
(143, 'admin', 2, 'Admin/AuthManager/removeFromGroup', '解除授权', -1, ''),
(144, 'admin', 2, 'Admin/AuthManager/addToGroup', '保存成员授权', -1, ''),
(145, 'admin', 2, 'Admin/AuthManager/category', '分类授权', -1, ''),
(146, 'admin', 2, 'Admin/AuthManager/addToCategory', '保存分类授权', -1, ''),
(147, 'admin', 2, 'Admin/AuthManager/modelauth', '模型授权', -1, ''),
(148, 'admin', 2, 'Admin/AuthManager/addToModel', '保存模型授权', -1, ''),
(149, 'admin', 2, 'Admin/Addons/create', '创建', -1, ''),
(150, 'admin', 2, 'Admin/Addons/checkForm', '检测创建', -1, ''),
(151, 'admin', 2, 'Admin/Addons/preview', '预览', -1, ''),
(152, 'admin', 2, 'Admin/Addons/build', '快速生成插件', -1, ''),
(153, 'admin', 2, 'Admin/Addons/config', '设置', -1, ''),
(154, 'admin', 2, 'Admin/Addons/disable', '禁用', -1, ''),
(155, 'admin', 2, 'Admin/Addons/enable', '启用', -1, ''),
(156, 'admin', 2, 'Admin/Addons/install', '安装', -1, ''),
(157, 'admin', 2, 'Admin/Addons/uninstall', '卸载', -1, ''),
(158, 'admin', 2, 'Admin/Addons/saveconfig', '更新配置', -1, ''),
(159, 'admin', 2, 'Admin/Addons/adminList', '插件后台列表', -1, ''),
(160, 'admin', 2, 'Admin/Addons/execute', 'URL方式访问插件', -1, ''),
(161, 'admin', 2, 'Admin/Addons/hooks', '钩子管理', -1, ''),
(162, 'admin', 2, 'Admin/Model/index', '模型管理', -1, ''),
(163, 'admin', 2, 'Admin/model/add', '新增', -1, ''),
(164, 'admin', 2, 'Admin/model/edit', '编辑', -1, ''),
(165, 'admin', 2, 'Admin/model/setStatus', '改变状态', -1, ''),
(166, 'admin', 2, 'Admin/model/update', '保存数据', -1, ''),
(167, 'admin', 2, 'Admin/Attribute/index', '属性管理', -1, ''),
(168, 'admin', 2, 'Admin/Attribute/add', '新增', -1, ''),
(169, 'admin', 2, 'Admin/Attribute/edit', '编辑', -1, ''),
(170, 'admin', 2, 'Admin/Attribute/setStatus', '改变状态', -1, ''),
(171, 'admin', 2, 'Admin/Attribute/update', '保存数据', -1, ''),
(172, 'admin', 2, 'Admin/Config/index', '配置管理', -1, ''),
(173, 'admin', 2, 'Admin/Config/edit', '编辑', -1, ''),
(174, 'admin', 2, 'Admin/Config/del', '删除', -1, ''),
(175, 'admin', 2, 'Admin/Config/add', '新增', -1, ''),
(176, 'admin', 2, 'Admin/Config/save', '保存', -1, ''),
(177, 'admin', 2, 'Admin/Menu/index', '菜单管理', -1, ''),
(178, 'admin', 2, 'Admin/Channel/index', '导航管理', -1, ''),
(179, 'admin', 2, 'Admin/Channel/add', '新增', -1, ''),
(180, 'admin', 2, 'Admin/Channel/edit', '编辑', -1, ''),
(181, 'admin', 2, 'Admin/Channel/del', '删除', -1, ''),
(182, 'admin', 2, 'Admin/Category/index', '分类管理', -1, ''),
(183, 'admin', 2, 'Admin/Category/edit', '编辑', -1, ''),
(184, 'admin', 2, 'Admin/Category/add', '新增', -1, ''),
(185, 'admin', 2, 'Admin/Category/remove', '删除', -1, ''),
(186, 'admin', 2, 'Admin/Category/move', '移动', -1, ''),
(187, 'admin', 2, 'Admin/Category/merge', '合并', -1, ''),
(188, 'admin', 2, 'Admin/Database/index?type=export', '备份数据库', -1, ''),
(189, 'admin', 2, 'Admin/Database/export', '备份', -1, ''),
(190, 'admin', 2, 'Admin/Database/optimize', '优化表', -1, ''),
(191, 'admin', 2, 'Admin/Database/repair', '修复表', -1, ''),
(192, 'admin', 2, 'Admin/Database/index?type=import', '还原数据库', -1, ''),
(193, 'admin', 2, 'Admin/Database/import', '恢复', -1, ''),
(194, 'admin', 2, 'Admin/Database/del', '删除', -1, ''),
(195, 'admin', 2, 'Admin/other', '其他', 1, ''),
(196, 'admin', 2, 'Admin/Menu/add', '新增', -1, ''),
(197, 'admin', 2, 'Admin/Menu/edit', '编辑', -1, ''),
(198, 'admin', 2, 'Admin/Think/lists?model=article', '应用', -1, ''),
(199, 'admin', 2, 'Admin/Think/lists?model=download', '下载管理', -1, ''),
(200, 'admin', 2, 'Admin/Think/lists?model=config', '应用', -1, ''),
(201, 'admin', 2, 'Admin/Action/actionlog', '行为日志', -1, ''),
(202, 'admin', 2, 'Admin/User/updatePassword', '修改密码', -1, ''),
(203, 'admin', 2, 'Admin/User/updateNickname', '修改昵称', -1, ''),
(204, 'admin', 2, 'Admin/action/edit', '查看行为日志', -1, ''),
(206, 'admin', 1, 'Admin/think/edit', '编辑数据', 1, ''),
(207, 'admin', 1, 'Admin/Menu/import', '导入', 1, ''),
(208, 'admin', 1, 'Admin/Model/generate', '生成', 1, ''),
(209, 'admin', 1, 'Admin/Addons/addHook', '新增钩子', 1, ''),
(210, 'admin', 1, 'Admin/Addons/edithook', '编辑钩子', 1, ''),
(211, 'admin', 1, 'Admin/Article/sort', '文档排序', 1, ''),
(212, 'admin', 1, 'Admin/Config/sort', '排序', 1, ''),
(213, 'admin', 1, 'Admin/Menu/sort', '排序', 1, ''),
(214, 'admin', 1, 'Admin/Channel/sort', '排序', 1, ''),
(215, 'admin', 1, 'Admin/Category/operate/type/move', '移动', 1, ''),
(216, 'admin', 1, 'Admin/Category/operate/type/merge', '合并', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `ot_book`
--

CREATE TABLE IF NOT EXISTS `ot_book` (
  `isbn_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `ISBN` varchar(17) NOT NULL COMMENT 'ISBN',
  `book_name` varchar(40) NOT NULL COMMENT '书名',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `introduction` text NOT NULL COMMENT '简介',
  `totalnum` smallint(5) unsigned NOT NULL COMMENT '总量',
  `remainnum` smallint(5) unsigned NOT NULL COMMENT '在馆数目',
  `pub` varchar(30) NOT NULL COMMENT '出版社',
  `pub_date` int(11) NOT NULL COMMENT '出版日期',
  `callnum` varchar(20) NOT NULL DEFAULT '',
  `img` varchar(255) NOT NULL COMMENT '图片路径',
  `catalog` text NOT NULL,
  `avg_score` decimal(2,1) NOT NULL,
  PRIMARY KEY (`ISBN`),
  KEY `isbn_id` (`isbn_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `ot_book`
--

INSERT INTO `ot_book` (`isbn_id`, `ISBN`, `book_name`, `author`, `introduction`, `totalnum`, `remainnum`, `pub`, `pub_date`, `callnum`, `img`, `catalog`, `avg_score`) VALUES
(1, '9787115308276', 'Swift语言实战入门（第2版）', '伍星', '读过这本诚意之作后，相信你能够有实际收获。', 2, 2, '人民邮电出版社', 1454281200, 'TP312/0246 ', 'https://images-cn.ssl-images-amazon.com/images/I/51TY1-qafUL._SX396_BO1,204,203,200_.jpg', ' 目录\n<br>\n<br>\n第1章　欢迎来到Swift语言的世界　1\n<br>\n1.1　起源　2\n<br>\n1.2　什么是Swift语言　3\n<br>\n1.3　特性　3\n<br>\n1.3.1　高级　4\n<br>\n1.3.2　易上手　4\n<br>\n1.3.3　兼容性　4\n<br>\n1.3.4　运行效率　5\n<br>\n1.3.5　运行时（Runtime）　5\n<br>\n1.3.6　可混编　5\n<br>\n1.3.7　开发工具　5\n<br>\n1.4　搭建Swift开发环境　6\n<br>\n1.4.1　Mac OS简介　6\n<br>\n1.4.2　Mac OS 下载安装　6\n<br>\n1.4.3　下载并安装Xcode　9\n<br>\n1.4.4　iOS开发者计划　11\n<br>\n1.5　熟悉Xcode及模拟器环境　11\n<br>\n1.5.1　升级和改变　11\n<br>\n1.5.2　第一个Swift语言程序　12\n<br>\n1.5.3　源代码文件基本组成　16\n<br>\n1.5.4　Xcode集成开发环境　17\n<br>\n1.5.5　iOS模拟器　18\n<br>\n1.5.6　体验Playground　19\n<br>\n1.5.7　关于程序调试　21\n<br>\n1.6　Apple产品历史　22\n<br>\n1.7　关于学习方法的一些讨论　23\n<br>\n1.8　小结　25\n<br>\n<br>\n第2章　Swift基础语法　26\n<br>\n2.1　语法入门　26\n<br>\n2.1.1　变量与常量　27\n<br>\n2.1.2　整型　29\n<br>\n2.1.3　浮点型　30\n<br>\n2.1.4　布尔型　31\n<br>\n2.1.5　字符串和字符　31\n<br>\n2.1.6　可选（optional）　39\n<br>\n2.1.7　元组　42\n<br>\n2.1.8　类型别名　43\n<br>\n2.1.9　类型转换　43\n<br>\n2.1.10　断言（assertion）　45\n<br>\n2.2　运算符　47\n<br>\n2.2.1　基础运算符　47\n<br>\n2.2.2　高级运算符　55\n<br>\n2.2.3　自定义运算符　60\n<br>\n2.2.4　运算符优先级和结合性　60\n<br>\n2.3　复杂数据类型　62\n<br>\n2.3.1　数组　62\n<br>\n2.3.2　字典　64\n<br>\n2.3.3　结构体　64\n<br>\n2.3.4　枚举　66\n<br>\n2.4　控制流　67\n<br>\n2.4.1　条件结构　67\n<br>\n2.4.2　值绑定（Value Bindings）　71\n<br>\n2.4.3　循环结构　72\n<br>\n2.4.4　控制转向语句　76\n<br>\n2.5　函数　80\n<br>\n2.5.1　函数的定义和调用　80\n<br>\n2.5.2　函数的形参和返回值　81\n<br>\n2.5.3　Currying　84\n<br>\n2.6　闭包　85\n<br>\n2.6.1　什么是闭包　85\n<br>\n2.6.2　trailing闭包　87\n<br>\n2.6.3　autoclosure　88\n<br>\n2.6.4　捕获　88\n<br>\n2.7　表达式　88\n<br>\n2.7.1　基本表达式　88\n<br>\n2.7.2　前缀表达式和后缀表达式　89\n<br>\n2.7.3　表达式解析　91\n<br>\n2.8　全局变量和局部变量　93\n<br>\n2.9　小结　95\n<br>\n<br>\n第3章　Swift面向对象编程基础　96\n<br>\n3.1　面向对象编程简介　96\n<br>\n3.1.1　面向对象编程的基本概念　99\n<br>\n3.1.2　面向对象编程的特点　101\n<br>\n3.1.3　为什么要使用面向对象编程　102\n<br>\n3.1.4　Swift语言中的面向对象概览　103\n<br>\n3.2　类、方法、属性介绍　103\n<br>\n3.2.1　编写第一个类　103\n<br>\n3.2.2　属性　105\n<br>\n3.3　方法　117\n<br>\n3.3.1　实例方法　117\n<br>\n3.3.2　类型方法　119\n<br>\n3.3.3　初始化方法和反初始化方法　120\n<br>\n3.3.4　下标脚本　127\n<br>\n3.4　枚举、类与结构体的对比　131\n<br>\n3.4.1　枚举与其他两者的关系　131\n<br>\n3.4.2　类与结构体的关系　132\n<br>\n3.5　小结　133\n<br>\n<br>\n第4章　Swift语言的语法高级特性　135\n<br>\n4.1　高级面向对象特性　135\n<br>\n4.1.1　继承　135\n<br>\n4.1.2　多态　141\n<br>\n4.1.3　封装　145\n<br>\n4.2　面向对象的高级用法　151\n<br>\n4.2.1　协议　151\n<br>\n4.2.2　类扩展　155\n<br>\n4.2.3　类组合　160\n<br>\n4.3　可选链　162\n<br>\n4.3.1　可选概念回顾　162\n<br>\n4.3.2　可选链　165\n<br>\n4.3.3　多级可选链　165\n<br>\n4.4　泛型　166\n<br>\n4.5　高级类型转换　170\n<br>\n4.6　小结　172\n<br>\n<br>\n第5章　Swift语言操作Cocoa底层库　173\n<br>\n5.1　Cocoa开发体系　173\n<br>\n5.1.1　Core OS层　174\n<br>\n5.1.2　Core Service层　174\n<br>\n5.1.3　媒体层　175\n<br>\n5.1.4　UIKit层　176\n<br>\n5.2　Swift语言调用Objective-C　176\n<br>\n5.3　字符串　178\n<br>\n5.3.1　NSString与String互相转换　178\n<br>\n5.3.2　拆分字符串　179\n<br>\n5.3.3　查找字符串　180\n<br>\n5.4　数字　181\n<br>\n5.5　数组　182\n<br>\n5.5.1　NSArray与Array的互相转换　182\n<br>\n5.5.2　NSArray的初始化方法　184\n<br>\n5.5.3　NSArray的常用属性和方法　184\n<br>\n5.6　词典　187\n<br>\n5.6.1　Dictionary和NSDictionary互相转换　187\n<br>\n5.6.2　NSDictionay的初始化方法　188\n<br>\n5.6.3　NSDictionary常用的属性和方法　189\n<br>\n5.7　集　190\n<br>\n5.7.1　初始化　190\n<br>\n5.7.2　常用属性和方法　191\n<br>\n5.7.3　集合元素计数　193\n<br>\n5.8　数据存储NSData　194\n<br>\n5.8.1　创建NSData　194\n<br>\n5.8.2　访问数据　195\n<br>\n5.8.3　字节数据与Base64编码字符串相互转换　196\n<br>\n5.8.4　字节数据存储　197\n<br>\n5.8.5　NSMutableData　198\n<br>\n5.9　文件　199\n<br>\n5.9.1　应用的目录结构　200\n<br>\n5.9.2　访问文件　201\n<br>\n5.9.3　NSURL和NSURLComponents　202\n<br>\n5.9.4　NSFileManager　209\n<br>\n5.9.5　NSFileHandle　217\n<br>\n5.9.6　NSBundle　220\n<br>\n5.10　小结　224\n<br>\n<br>\n第6章　Swift与Objective-C的互操作　225\n<br>\n6.1　Swift与Objective-C介绍　225\n<br>\n6.1.0　互操作简介　225\n<br>\n6.2　简单的互操作实践　225\n<br>\n6.2.1　Swift中调用Objective- C代码　226\n<br>\n6.2.2　Swift中调用C代码　230\n<br>\n6.2.3　Swift项目中的Objective- C代码调用Swift代码　231\n<br>\n6.2.4　Objective- C项目中调用Swift代码　236\n<br>\n6.3　Objective-C代码库的调用　237\n<br>\n6.3.1　理解框架代码相互调用过程　237\n<br>\n6.3.2　KKColorListPicker库的调用　238\n<br>\n6.3.3　SQLite3的引用　241\n<br>\n6.3.4　在Swift项目中引入GDataXML或DDXML　249\n<br>\n6.3.5　JSON解析及JSONKit的引用　253\n<br>\n6.4　Objective-C项目到Swift项目的迁移　256\n<br>\n6.5　小结　265\n<br>\n<br>\n第7章　普通UI控件的开发：UIKit第一部分　266\n<br>\n7.1　UIKit概述　266\n<br>\n7.1.1　应用的创建　266\n<br>\n7.1.2　如何创建UI控件　267\n<br>\n7.1.3　UIKit对象介绍　269\n<br>\n7.2　标签（UILabel）　271\n<br>\n7.2.1　标签的创建　271\n<br>\n7.2.2　背景颜色和文字颜色的设置　271\n<br>\n7.2.3　对齐方式的设置　272\n<br>\n7.2.4　文字阴影设置　272\n<br>\n7.2.5　字体的设置　272\n<br>\n7.2.6　文字的省略方式　273\n<br>\n7.2.7　文字的自动调整　273\n<br>\n7.2.8　多行字符串　274\n<br>\n7.3　按钮（UIButton）　274\n<br>\n7.3.1　按钮的创建　274\n<br>\n7.3.2　按钮的文字、颜色和状态　275\n<br>\n7.3.3　按钮的图片　275\n<br>\n7.3.4　按钮的触摸事件　277\n<br>\n7.4　文本框（UITextField）　277\n<br>\n7.4.1　文本框的创建　277\n<br>\n7.4.2　设置文本样式　278\n<br>\n7.4.3　键盘设置　279\n<br>\n7.4.4　清除按钮　280\n<br>\n7.4.5　背景设置　281\n<br>\n7.5　多行文本控件（UITextView）　281\n<br>\n7.5.1　创建多行文本控件　281\n<br>\n7.5.2　设置文字　282\n<br>\n7.5.3　光标和选择范围　282\n<br>\n7.5.4　委托事件　283\n<br>\n7.6　开关按钮（UISwitch）　284\n<br>\n7.7　选择控件（UISegmentedControl）　285\n<br>\n7.7.1　选择控件的创建　285\n<br>\n7.7.2　选择控件基本设置　286\n<br>\n7.7.3　选择控件选项的插入和删除　286\n<br>\n7.7.4　选择控件获得选择的值　286\n<br>\n7.8　图像控件（UIImageView）　287\n<br>\n7.8.1　图片的显示　287\n<br>\n7.8.2　使用图像控件实现动画　288\n<br>\n7.9　进度条（UIProgressView）　289\n<br>\n7.10　滑块（UISlider）　290\n<br>\n7.10.1　滑块的创建　290\n<br>\n7.10.2　滑块的值通知机制　291\n<br>\n7.10.3　制定滑块样式　291\n<br>\n7.11　警告框（UIAlertView）与操作表 （UIActionSheet）　292\n<br>\n7.11.1　警告框的使用　292\n<br>\n7.11.2　警告框的委托事件　292', '3.0'),
(7, '9787115317957', '机器学习实战', '哈林顿', '机器学习是人工智能研究领域中的一个极其重要的方向。在现今大数据时代的背景下，捕获数据并从中萃取有价值的信息或模式，使得这一过去为分析师与数学家所专属的研究领域越来越为人们瞩目。', 0, 0, '人民邮电出版社', 0, 'TP181/645 ', 'https://images-cn.ssl-images-amazon.com/images/I/51Pb1PYEuNL._SY498_BO1,204,203,200_.jpg', ' 第一部分 分类\n<br>\n第1章 机器学习基础 2\n<br>\n1.1 何谓机器学习 3\n<br>\n1.1.1 传感器和海量数据 4\n<br>\n1.1.2 机器学习非常重要 5\n<br>\n1.2 关键术语 5\n<br>\n1.3 机器学习的主要任务 7\n<br>\n1.4 如何选择合适的算法 8\n<br>\n1.5 开发机器学习应用程序的步骤 9\n<br>\n1.6 Python语言的优势 10\n<br>\n1.6.1 可执行伪代码 10\n<br>\n1.6.2 Python比较流行 10\n<br>\n1.6.3 Python语言的特色 11\n<br>\n1.6.4 Python语言的缺点 11\n<br>\n1.7 NumPy函数库基础 12\n<br>\n1.8 本章小结 13\n<br>\n第2章 k—近邻算法 15\n<br>\n2.1 k—近邻算法概述 15\n<br>\n2.1.1 准备：使用Python导入数据 17\n<br>\n2.1.2 从文本文件中解析数据 19\n<br>\n2.1.3 如何测试分类器 20\n<br>\n2.2 示例：使用k—近邻算法改进约会网站的配对效果 20\n<br>\n2.2.1 准备数据：从文本文件中解析数据 21\n<br>\n2.2.2 分析数据：使用Matplotlib创建散点图 23\n<br>\n2.2.3 准备数据：归一化数值 25\n<br>\n2.2.4 测试算法：作为完整程序验证分类器 26\n<br>\n2.2.5 使用算法：构建完整可用系统 27\n<br>\n2.3 示例：手写识别系统 28\n<br>\n2.3.1 准备数据：将图像转换为测试向量 29\n<br>\n2.3.2 测试算法：使用k—近邻算法识别手写数字 30\n<br>\n2.4 本章小结 31\n<br>\n第3章 决策树 32\n<br>\n3.1 决策树的构造 33\n<br>\n3.1.1 信息增益 35\n<br>\n3.1.2 划分数据集 37\n<br>\n3.1.3 递归构建决策树 39\n<br>\n3.2 在Python中使用Matplotlib注解绘制树形图 42\n<br>\n3.2.1 Matplotlib注解 43\n<br>\n3.2.2 构造注解树 44\n<br>\n3.3 测试和存储分类器 48\n<br>\n3.3.1 测试算法：使用决策树执行分类 49\n<br>\n3.3.2 使用算法：决策树的存储 50\n<br>\n3.4 示例：使用决策树预测隐形眼镜类型 50\n<br>\n3.5 本章小结 52\n<br>\n第4章 基于概率论的分类方法：朴素贝叶斯 53\n<br>\n4.1 基于贝叶斯决策理论的分类方法 53\n<br>\n4.2 条件概率 55\n<br>\n4.3 使用条件概率来分类 56\n<br>\n4.4 使用朴素贝叶斯进行文档分类 57\n<br>\n4.5 使用Python进行文本分类 58\n<br>\n4.5.1 准备数据：从文本中构建词向量 58\n<br>\n4.5.2 训练算法：从词向量计算概率 60\n<br>\n4.5.3 测试算法：根据现实情况修改分类器 62\n<br>\n4.5.4 准备数据：文档词袋模型 64\n<br>\n4.6 示例：使用朴素贝叶斯过滤垃圾邮件 64\n<br>\n4.6.1 准备数据：切分文本 65\n<br>\n4.6.2 测试算法：使用朴素贝叶斯进行交叉验证 66\n<br>\n4.7 示例：使用朴素贝叶斯分类器从个人广告中获取区域倾向 68\n<br>\n4.7.1 收集数据：导入RSS源 68\n<br>\n4.7.2 分析数据：显示地域相关的用词 71\n<br>\n4.8 本章小结 72\n<br>\n第5章 Logistic回归 73\n<br>\n5.1 基于Logistic回归和Sigmoid函数的分类 74\n<br>\n5.2 基于最优化方法的最佳回归系数确定 75\n<br>\n5.2.1 梯度上升法 75\n<br>\n5.2.2 训练算法：使用梯度上升找到最佳参数 77\n<br>\n5.2.3 分析数据：画出决策边界 79\n<br>\n5.2.4 训练算法：随机梯度上升 80\n<br>\n5.3 示例：从疝气病症预测病马的死亡率 85\n<br>\n5.3.1 准备数据：处理数据中的缺失值 85\n<br>\n5.3.2 测试算法：用Logistic回归进行分类 86\n<br>\n5.4 本章小结 88\n<br>\n第6章 支持向量机 89\n<br>\n6.1 基于最大间隔分隔数据 89\n<br>\n6.2 寻找最大间隔 91\n<br>\n6.2.1 分类器求解的优化问题 92\n<br>\n6.2.2 SVM应用的一般框架 93\n<br>\n6.3 SMO高效优化算法 94\n<br>\n6.3.1 Platt的SMO算法 94\n<br>\n6.3.2 应用简化版SMO算法处理小规模数据集 94\n<br>\n6.4 利用完整PlattSMO算法加速优化 99\n<br>\n6.5 在复杂数据上应用核函数 105\n<br>\n6.5.1 利用核函数将数据映射到高维空间 106\n<br>\n6.5.2 径向基核函数 106\n<br>\n6.5.3 在测试中使用核函数 108\n<br>\n6.6 示例：手写识别问题回顾 111\n<br>\n6.7 本章小结 113\n<br>\n第7章 利用AdaBoost元算法提高分类性能 115\n<br>\n7.1 基于数据集多重抽样的分类器 115\n<br>\n7.1.1 bagging：基于数据随机重抽样的分类器构建方法 116\n<br>\n7.1.2 boosting 116\n<br>\n7.2 训练算法：基于错误提升分类器的性能 117\n<br>\n7.3 基于单层决策树构建弱分类器 118\n<br>\n7.4 完整AdaBoost算法的实现 122\n<br>\n7.5 测试算法：基于AdaBoost的分类 124\n<br>\n7.6 示例：在一个难数据集上应用AdaBoost 125\n<br>\n7.7 非均衡分类问题 127\n<br>\n7.7.1 其他分类性能度量指标：正确率、召回率及ROC曲线 128\n<br>\n7.7.2 基于代价函数的分类器决策控制 131\n<br>\n7.7.3 处理非均衡问题的数据抽样方法 132\n<br>\n7.8 本章小结 132\n<br>\n第二部分 利用回归预测数值型数据\n<br>\n第8章 预测数值型数据：回归 136\n<br>\n8.1 用线性回归找到最佳拟合直线 136\n<br>\n8.2 局部加权线性回归 141\n<br>\n8.3 示例：预测鲍鱼的年龄 145\n<br>\n8.4 缩减系数来“理解”数据 146\n<br>\n8.4.1 岭回归 146\n<br>\n8.4.2 lasso 148\n<br>\n8.4.3 前向逐步回归 149\n<br>\n8.5 权衡偏差与方差 152\n<br>\n8.6 示例：预测乐高玩具套装的价格 153\n<br>\n8.6.1 收集数据：使用Google购物的API 153\n<br>\n8.6.2 训练算法：建立模型 155\n<br>\n8.7 本章小结 158\n<br>\n第9章 树回归 159\n<br>\n9.1 复杂数据的局部性建模 159\n<br>\n9.2 连续和离散型特征的树的构建 160\n<br>\n9.3 将CART算法用于回归 163\n<br>\n9.3.1 构建树 163\n<br>\n9.3.2 运行代码 165\n<br>\n9.4 树剪枝 167\n<br>\n9.4.1 预剪枝 167\n<br>\n9.4.2 后剪枝 168\n<br>\n9.5 模型树 170\n<br>\n9.6 示例：树回归与标准回归的比较 173\n<br>\n9.7 使用Python的Tkinter库创建GUI 176\n<br>\n9.7.1 用Tkinter创建GUI 177\n<br>\n9.7.2 集成Matplotlib和Tkinter 179\n<br>\n9.8 本章小结 182\n<br>\n第三部分 无监督学习\n<br>\n第10章 利用K—均值聚类算法对未标注数据分组 184\n<br>\n10.1 K—均值聚类算法 185\n<br>\n10.2 使用后处理来提高聚类性能 189\n<br>\n10.3 二分K—均值算法 190\n<br>\n10.4 示例：对地图上的点进行聚类 193\n<br>\n10.4.1 Yahoo！PlaceFinderAPI 194\n<br>\n10.4.2 对地理坐标进行聚类 196\n<br>\n10.5 本章小结 198\n<br>\n第11章 使用Apriori算法进行关联分析 200\n<br>\n11.1 关联分析 201\n<br>\n11.2 Apriori原理 202\n<br>\n11.3 使用Apriori算法来发现频繁集 204\n<br>\n11.3.1 生成候选项集 204\n<br>\n11.3.2 组织完整的Apriori算法 207\n<br>\n11.4 从频繁项集中挖掘关联规则 209\n<br>\n11.5 示例：发现国会投票中的模式 212\n<br>\n11.5.1 收集数据：构建美国国会投票记录的事务数据集 213\n<br>\n11.5.2 测试算法：基于美国国会投票记录挖掘关联规则 219\n<br>\n11.6 示例：发现毒蘑菇的相似特征 220\n<br>\n11.7 本章小结 221\n<br>\n第12章 使用FP—growth算法来高效发现频繁项集 223\n<br>\n12.1 FP树：用于编码数据集的有效方式 224\n<br>\n12.2 构建FP树 225\n<br>\n12.2.1 创建FP树的数据结构 226\n<br>\n12.2.2 构建FP树 227\n<br>\n12.3 从一棵FP树中挖掘频繁项集 231\n<br>\n12.3.1 抽取条件模式基 231\n<br>\n12.3.2 创建条件FP树 232\n<br>\n12.4 示例：在Twitter源中发现一些共现词 235\n<br>\n12.5 示例：从新闻网站点击流中挖掘 238\n<br>\n12.6 本章小结 239\n<br>\n第四部分 其他工具\n<br>\n第13章 利用PCA来简化数据 242\n<br>\n13.1 降维技术 242\n<br>\n13.2 PCA 243\n<br>\n13.2.1 移动坐标轴 243\n<br>\n13.2.2 在NumPy中实现PCA 246\n<br>\n13.3 示例：利用PCA对半导体制造数据降维 248\n<br>\n13.4 本章小结 251\n<br>\n第14章 利用SVD简化数据 252\n<br>\n14.1 SVD的应用 252\n<br>\n14.1.1 隐性语义索引 253\n<br>\n14.1.2 推荐系统 253\n<br>\n14.2 矩阵分解 254\n<br>\n14.3 利用Python实现SVD 255\n<br>\n14.4 基于协同过滤的推荐引擎 257\n<br>\n14.4.1 相似度计算 257\n<br>\n14.4.2 基于物品的相似度还是基于用户的相似度？ 260\n<br>\n14.4.3 推荐引擎的评价 260\n<br>\n14.5 示例：餐馆菜肴推荐引擎 260\n<br>\n14.5.1 推荐未尝过的菜肴 261\n<br>\n14.5.2 利用SVD提高推荐的效果 263\n<br>\n14.5.3 构建推荐引擎面临的挑战 265\n<br>\n14.6 基于SVD的图像压缩 266\n<br>\n14.7 本章小结 268\n<br>\n第15章 大数据与MapReduce 270\n<br>\n15.1 MapReduce：分布式计算的框架 271\n<br>\n15.2 Hadoop流 273\n<br>\n15.2.1 分布式计算均值和方差的mapper 273\n<br>\n15.2.2 分布式计算均值和方差的reducer 274\n<br>\n15.3 在Amazon网络服务上运行Hadoop程序 275\n<br>\n15.3.1 AWS上的可用服务 276\n<br>\n15.3.2 开启Amazon网络服务之旅 276\n<br>\n15.3.3 在EMR上运行Hadoop作业 278\n<br>\n15.4 MapReduce上的机器学习 282\n<br>\n15.5 在Python中使用mrjob来自动化MapReduce 283\n<br>\n15.5.1 mrjob与EMR的无缝集成 283\n<br>\n15.5.2 mrjob的一个MapReduce脚本剖析 284\n<br>\n15.6 示例：分布式SVM的Pegasos算法 286\n<br>\n15.6.1 Pegasos算法 287\n<br>\n15.6.2 训练算法：用mrjob实现MapReduce版本的SVM 288\n<br>\n15.7 你真的需要MapReduce吗？ 292\n<br>\n15.8 本章小结 292\n<br>\n附录A Python入门 294\n<br>\n附录B 线性代数 303\n<br>\n附录C 概率论复习 309\n<br>\n附录D 资源 312\n<br>\n索引 313\n<br>\n版权声明 316 ', '0.0'),
(2, '9787115391872', 'Swift与Cocoa框架开发', '[澳] 曼宁', '本书会向你展示如何使用Cocoa和Cocoa Touch，用Swift语言开发出令人难以置信的iOS和OS X应用。', 2, 2, '人民邮电出版社', 1454281200, 'TP317.6/4402 ', 'https://images-cn.ssl-images-amazon.com/images/I/51I7IjlukgL._SX380_BO1,204,203,200_.jpg', ' 前 言\n<br>\n第1章 Cocoa开发工具\n<br>\n1.1 Mac和iOS开发者计划\n<br>\n1.2 用Xcode创建自己的第一个项目\n<br>\n1.3 开发一个简单的Swift应用程序\n<br>\n1.4 使用iOS模拟器\n<br>\n1.5 用TestFlight测试iOS App\n<br>\n第2章 用Swift设计程序\n<br>\n2.1 Swift程序设计语言\n<br>\n2.2 playground\n<br>\n2.3 变量和常量\n<br>\n2.4 类型\n<br>\n2.5 控制流\n<br>\n2.6 函数与闭包\n<br>\n2.7 对象\n<br>\n2.8 与Objective-C的互操作\n<br>\n2.9 在同一项目中使用Objective-C和Swift\n<br>\n2.10 模块\n<br>\n2.11 内存管理\n<br>\n2.12 字符串\n<br>\n2.13 数据\n<br>\n2.14 Cocoa中的设计模式\n<br>\n第3章 OS X和iOS上的应用程序\n<br>\n3.1 什么是应用程序\n<br>\n3.2 应用程序生命周期\n<br>\n3.3 应用程序沙盒\n<br>\n3.4 用NSNotification发送通知\n<br>\n第4章 图形用户界面\n<br>\n4.1 OS X和iOS中的界面\n<br>\n4.2 MVC和应用程序设计\n<br>\n4.3 nib文件和故事板\n<br>\n4.4 构建界面\n<br>\n4.5 构建具有nib和约束的App\n<br>\n4.6 iOS上的界面\n<br>\n4.7 UI Dynamics\n<br>\n4.8 Core Animation\n<br>\n第5章 闭包和操作队列\n<br>\n5.1 Cocoa中的闭包\n<br>\n5.2 操作队列中的并发\n<br>\n5.3 操作队列和NSOperation\n<br>\n5.4 在操作队列中执行工作\n<br>\n5.5 融会贯通\n<br>\n第6章 在视图上绘制图形\n<br>\n6.1 如何绘制\n<br>\n6.2 像素网格\n<br>\n6.3 在视图中绘制\n<br>\n6.4 创建自定义视图\n<br>\n第7章 SpriteKit\n<br>\n7.1 SpriteKit的体系结构\n<br>\n7.2 制作使用SpriteKit的App\n<br>\n7.3 使用SpriteKit场景\n<br>\n7.4 SpriteKit节点\n<br>\n7.5 将精灵放在场景中\n<br>\n7.6 对触碰作出响应\n<br>\n7.7 使用纹理\n<br>\n7.8 纹理贴图集\n<br>\n7.9 使用文本\n<br>\n7.10 用操作实现内容的动画\n<br>\n7.11 使用形状节点\n<br>\n7.12 使用图像特效节点\n<br>\n7.13 向SpirteKit对象增加物理属性\n<br>\n7.14 向SpriteKit对象添加接合\n<br>\n7.15 SpriteKit场景照明\n<br>\n7.16 约束\n<br>\n7.17 在SpriteKit中使用阴影\n<br>\n7.18 使用SpriteKit编辑器\n<br>\n第8章 SceneKit\n<br>\n8.1 SceneKit结构\n<br>\n8.2 使用SceneKit\n<br>\n8.3 添加SceneKit视图\n<br>\n8.4 添加场景\n<br>\n8.5 添加照相机\n<br>\n8.6 添加3D对象\n<br>\n8.7 添加光源\n<br>\n8.8 为场景中的内容实现动画\n<br>\n8.9 创建文本几何体\n<br>\n8.10 使用材料\n<br>\n8.11 命中检测\n<br>\n8.12 约束\n<br>\n8.13 从COLLADA文件中加载数据\n<br>\n8.14 向场景中添加物理仿真\n<br>\n第9章 音频与视频\n<br>\n9.1 AV Foundation\n<br>\n9.2 用AVPlayer播放视频\n<br>\n9.3 语音合成\n<br>\n9.4 使用照片库\n<br>\n第10章 iCloud和数据存储\n<br>\n10.1 偏好设置\n<br>\n10.2 使用文件系统\n<br>\n10.3 使用沙盒\n<br>\n10.4 iCould\n<br>\n10.5 iCloud存储什么\n<br>\n10.6 为iCloud进行设置\n<br>\n10.7 测试iCloud是否正常工作\n<br>\n10.8 存储设置\n<br>\n10.9 iCloud存储\n<br>\n10.10 文档选取器\n<br>\n10.11 iCloud的最 佳使用\n<br>\n第11章 Cocoa绑定\n<br>\n11.1 将视图绑定到模型\n<br>\n11.2 一个简单的绑定App\n<br>\n11.3 绑定到控制器\n<br>\n11.4 数组和对象控制器\n<br>\n11.5 一个更复杂的绑定App\n<br>\n第12章 表格视图和集合视图\n<br>\n12.1 数据源和委托\n<br>\n12.2 表格视图\n<br>\n12.3 集合视图\n<br>\n第13章 基于文档的应用程序\n<br>\n13.1 NSDocument和UIDocument类\n<br>\n13.2 MVC 中的文档对象\n<br>\n13.3 OS X上基于文档的应用程序\n<br>\n13.4 iOS上基于文档的应用程序\n<br>\n第14章 联网\n<br>\n14.1 连接\n<br>\n14.2 开发联网应用程序\n<br>\n14.3 Bonjour服务的发现\n<br>\n14.4 Multipeer Connectivity\n<br>\n第15章 与现实世界互动\n<br>\n15.1 使用位置\n<br>\n15.2 地理编码\n<br>\n15.3 区域监测和iBeacon\n<br>\n15.4 位置与隐私\n<br>\n15.5 地图\n<br>\n15.6 设备运动\n<br>\n15.7 打印文档\n<br>\n15.8 Game Controller\n<br>\n15.9 App Nap\n<br>\n15.10 用Touch ID验证\n<br>\n15.11 Handoff\n<br>\n第16章 EventKit\n<br>\n16.1 理解事件\n<br>\n16.2 访问事件存储库\n<br>\n16.3 访问日历\n<br>\n16.4 访问事件\n<br>\n16.5 处理事件\n<br>\n16.6 开发一个事件应用程序\n<br>\n16.7 用户隐私\n<br>\n第17章 Instruments和调试器\n<br>\n17.1 开始使用Instruments\n<br>\n17.2 用Instruments解决问题\n<br>\n17.3 循环保留和漏洞\n<br>\n17.4 使用调试器\n<br>\n17.5 视图调试\n<br>\n17.6 测试框架\n<br>\n17.7 调试仪表\n<br>\n17.8 性能优化\n<br>\n第18章 共享与通知\n<br>\n18.1 共享\n<br>\n18.2 在iOS上共享\n<br>\n18.3 在OS X上共享\n<br>\n18.4 通知\n<br>\n18.5 发送推送通知\n<br>\n18.6 设置接收推送通知\n<br>\n18.7 接收推送通知\n<br>\n18.8 本地通知\n<br>\n第19章 非标准App\n<br>\n19.1 命令行工具\n<br>\n19.2 偏好设置窗格\n<br>\n19.3 状态栏项目\n<br>\n19.4 多窗口iOS App\n<br>\n第20章 处理文本\n<br>\n20.1 国际化与本地化\n<br>\n20.2 用NSFormatter设定数据格式\n<br>\n20.3 设定数字、长度、质量、能量和数据的格式\n<br>\n20.4 用NSDataDetector检测数据\n<br>\n20.5 TextKit ', '3.0'),
(3, '9787115392602', 'Swift基础教程', '皮特 (Boisy G.Pitre)', '零基础上手Swift，大量代码+实例', 2, 1, '人民邮电出版社', 1454281200, ' TP312SW/420 ', 'https://images-cn.ssl-images-amazon.com/images/I/61DAEAj%2BCbL._SX396_BO1,204,203,200_.jpg', ' 第一部分 基础知识\n<br>\n第1章 Swift简介2\n<br>\n1.1 革命性的改良2\n<br>\n1.2 准备工作3\n<br>\n1.2.1 专业工具3\n<br>\n1.2.2 与Swift交互3\n<br>\n1.3 准备出发4\n<br>\n1.4 开始探索Swift6\n<br>\n1.4.1 帮助和退出6\n<br>\n1.4.2 Hello World6\n<br>\n1.5 声明的威力7\n<br>\n1.6 常量9\n<br>\n1.7 类型10\n<br>\n1.7.1 检查上限和下限11\n<br>\n1.7.2 类型转换11\n<br>\n1.7.3 显式地声明类型12\n<br>\n1.8 字符串13\n<br>\n1.8.1 字符串拼接13\n<br>\n1.8.2 Character类型14\n<br>\n1.9 数学运算符14\n<br>\n1.9.1 表达式15\n<br>\n1.9.2 混用不同的数值类型15\n<br>\n1.9.3 数值表示16\n<br>\n1.10 布尔类型17\n<br>\n1.11 轻松显示18\n<br>\n1.12 使用类型别名19\n<br>\n1.13 使用元组将数据编组19\n<br>\n1.14 可选类型20\n<br>\n1.15 小结22\n<br>\n第2章 使用集合23\n<br>\n2.1 糖果罐23\n<br>\n2.1.1 数组中所有元素的类型都必须相同26\n<br>\n2.1.2 增长数组26\n<br>\n2.1.3 替换和删除值27\n<br>\n2.1.4 将值插入到指定位置28\n<br>\n2.1.5 合并数组29\n<br>\n2.2 字典30\n<br>\n2.2.1 查找条目31\n<br>\n2.2.2 添加条目32\n<br>\n2.2.3 更新条目33\n<br>\n2.2.4 删除条目33\n<br>\n2.3 数组的数组34\n<br>\n2.4 创建空数组和空字典36\n<br>\n2.4.1 空数组36\n<br>\n2.4.2 空字典37\n<br>\n2.5 迭代集合38\n<br>\n2.5.1 迭代数组38\n<br>\n2.5.2 迭代字典39\n<br>\n2.6 小结40\n<br>\n第3章 流程控制41\n<br>\n3.1 for循环41\n<br>\n3.1.1 计数41\n<br>\n3.1.2 包含还是不包含结束数字42\n<br>\n3.1.3 老式for循环43\n<br>\n3.1.4 简写44\n<br>\n3.2 游乐场45\n<br>\n3.3 决策48\n<br>\n3.3.1 if语句48\n<br>\n3.3.2 检查多个条件52\n<br>\n3.3.3 switch语句53\n<br>\n3.3.4 while循环56\n<br>\n3.3.5 检查代码58\n<br>\n3.3.6 提早结束循环61\n<br>\n3.4 小结61\n<br>\n第4章 编写函数和闭包62\n<br>\n4.1 函数62\n<br>\n4.1.1 使用Swift编写函数63\n<br>\n4.1.2 执行函数64\n<br>\n4.1.3 参数并非只能是数字65\n<br>\n4.1.4 可变参数66\n<br>\n4.1.5 函数是一级对象69\n<br>\n4.1.6 从函数返回函数71\n<br>\n4.1.7 嵌套函数73\n<br>\n4.1.8 默认参数76\n<br>\n4.1.9 函数名包含哪些内容77\n<br>\n4.1.10 清晰程度79\n<br>\n4.1.11 用不用外部参数名80\n<br>\n4.1.12 变量参数81\n<br>\n4.1.13 inout参数84\n<br>\n4.2 闭包86\n<br>\n4.3 小结88\n<br>\n4.4 类89\n<br>\n第5章 使用类和结构组织代码90\n<br>\n5.1 对象无处不在90\n<br>\n5.2 Swift对象是使用类定义的91\n<br>\n5.2.1 定义类91\n<br>\n5.2.2 创建对象93\n<br>\n5.2.3 开门和关门93\n<br>\n5.2.4 锁门和开锁94\n<br>\n5.2.5 查看属性96\n<br>\n5.2.6 门应是各式各样的97\n<br>\n5.2.7 修改颜色99\n<br>\n5.3 继承99\n<br>\n5.3.1 创建基类100\n<br>\n5.3.2 创建子类103\n<br>\n5.3.3 实例化子类104\n<br>\n5.3.4 便利初始化方法109\n<br>\n5.3.5 枚举111\n<br>\n5.3.6 结构113\n<br>\n5.3.7 值类型和引用类型114\n<br>\n5.4 小结116\n<br>\n第6章 使用协议和扩展进行规范化117\n<br>\n6.1 遵循协议117\n<br>\n6.1.1 类还是协议117\n<br>\n6.1.2 协议并非只能定义方法119\n<br>\n6.1.3 遵循多个协议121\n<br>\n6.1.4 协议也可继承122\n<br>\n6.1.5 委托123\n<br>\n6.2 扩展126\n<br>\n6.2.1 扩展基本类型127\n<br>\n6.2.2 在扩展中使用闭包130\n<br>\n6.3 小结132\n<br>\n第二部分 使用Swift开发软件\n<br>\n第7章 使用Xcode134\n<br>\n7.1 Xcode简史134\n<br>\n7.2 创建第一个Swift项目135\n<br>\n7.3 Xcode界面136\n<br>\n7.3.1 与Xcode窗口交互138\n<br>\n7.3.2 运行应用程序139\n<br>\n7.4 开发应用程序140\n<br>\n7.4.1 腾出空间141\n<br>\n7.4.2 创建界面142\n<br>\n7.4.3 美化145\n<br>\n7.4.4 编写代码146\n<br>\n7.4.5 建立连接149\n<br>\n7.5 小结151\n<br>\n第8章 改进应用程序152\n<br>\n8.1 细节很重要152\n<br>\n8.1.1 显示金额152\n<br>\n8.1.2 再谈可选类型154\n<br>\n8.1.3 可选类型拆封154\n<br>\n8.1.4 美化155\n<br>\n8.1.5 另一种格式设置方法156\n<br>\n8.2 计算复利159\n<br>\n8.2.1 连接起来161\n<br>\n8.2.2 测试164\n<br>\n8.3 调试164\n<br>\n8.3.1 bug在哪里164\n<br>\n8.3.2 断点165\n<br>\n8.3.3 复杂的复利计算168\n<br>\n8.4 测试的价值169\n<br>\n8.4.1 单元测试169\n<br>\n8.4.2 编写测试169\n<br>\n8.4.3 如果测试未通过172\n<br>\n8.4.4 始终运行的测试173\n<br>\n8.5 小结174\n<br>\n第9章 Swift移动开发175\n<br>\n9.1 移动设备和台式机175\n<br>\n9.2 挑战记忆力175\n<br>\n9.2.1 考虑玩法176\n<br>\n9.2.2 设计UI176\n<br>\n9.3 创建项目177\n<br>\n9.4 创建用户界面179\n<br>\n9.4.1 创建按钮180\n<br>\n9.4.2 在模拟器中运行182\n<br>\n9.4.3 设置约束183\n<br>\n9.5 MVC186\n<br>\n9.6 编写游戏代码186\n<br>\n9.6.1 类189\n<br>\n9.6.2 枚举190\n<br>\n9.6.3 视图对象190\n<br>\n9.6.4 模型对象190\n<br>\n9.6.5 可重写的方法191\n<br>\n9.6.6 游戏的方法191\n<br>\n9.6.7 处理输赢195\n<br>\n9.7 回到故事板196\n<br>\n9.8 开玩198\n<br>\n第10章 其他主题199\n<br>\n10.1 Swift内存管理199\n<br>\n10.1.1 值和引用199\n<br>\n10.1.2 引用计数200\n<br>\n10.1.3 引用循环200\n<br>\n10.1.4 演示引用循环201\n<br>\n10.1.5 编写测试代码202\n<br>\n10.1.6 断开引用循环204\n<br>\n10.1.7 闭包中的引用循环205\n<br>\n10.1.8 感恩207\n<br>\n10.2 逻辑运算符207\n<br>\n10.2.1 逻辑非207\n<br>\n10.2.2 逻辑与208\n<br>\n10.2.3 逻辑或208\n<br>\n10.3 泛型209\n<br>\n10.4 运算符重载210\n<br>\n10.5 相等和相同213\n<br>\n10.6 Swift脚本编程214\n<br>\n10.6.1 编辑脚本215\n<br>\n10.6.2 设置权限216\n<br>\n10.6.3 运行脚本216\n<br>\n10.6.4 工作原理216\n<br>\n10.7 获取帮助218\n<br>\n10.8 独闯江湖219\n<br>\n10.8.1 研究苹果公司提供的框架219\n<br>\n10.8.2 加入苹果开发者计划220\n<br>\n10.8.3 成为社区的一分子220\n<br>\n10.8.4 活到老学到老220\n<br>\n10.8.5 一路平安220 ', '3.0'),
(4, '9787121275821', 'Swifter(第2版):100个Swift 2开发必备Tip', '王巍', '绝无仅有基于Swift 2的iOS开发图书', 2, 2, '电子工业出版社', 1454281200, 'TP312SW/424 ', 'https://images-na.ssl-images-amazon.com/images/I/51TqHT6Rx8L._SX384_BO1,204,203,200_.jpg', ' 1Swift新元素1\n<br>\nTip1柯里化（Currying）2\n<br>\nTip2将protocol的方法声明为mutating4\n<br>\nTip3Sequence5\n<br>\nTip4多元组（Tuple）7\n<br>\nTip5@autoclosure和？？9\n<br>\nTip6OptionalChaining12\n<br>\nTip7操作符14\n<br>\nTip8func的参数修饰17\n<br>\nTip9字面量转换19\n<br>\nTip10下标23\n<br>\nTip11方法嵌套25\n<br>\nTip12命名空间28\n<br>\nTip13Any和AnyObject30\n<br>\nTip14typealias和泛型接口33\n<br>\nTip15可变参数函数35\n<br>\nTip16初始化方法顺序37\n<br>\nTip17Designated，Convenience和Required39\n<br>\nTip18初始化返回nil42\n<br>\nTip19protocol组合45\n<br>\nTip20static和class49\n<br>\nTip21多类型和容器52\n<br>\nTip22default参数55\n<br>\nTip23正则表达式57\n<br>\nTip24模式匹配60\n<br>\nTip25…和..＜63\n<br>\nTip26AnyClass、元类型和.self65\n<br>\nTip27接口和类方法中的Self68\n<br>\nTip28动态类型和多方法71\n<br>\nTip29属性观察73\n<br>\nTip30final76\n<br>\nTip31lazy修饰符和lazy方法79\n<br>\nTip32Reflection和Mirror82\n<br>\nTip33隐式解包Optional85\n<br>\nTip34多重Optional87\n<br>\nTip35OptionaIMap89\n<br>\nTip36ProtocolExtension91\n<br>\nTip37where和模式匹配96\n<br>\nTip38indirect和嵌套enum99\n<br>\n2从Objective—C／C到Swift101\n<br>\nTip39Selector102\n<br>\nTip40实例方法的动态调用104\n<br>\nTip41单例106\n<br>\nTip42条件编译109\n<br>\nTip43编译标记111\n<br>\nTip44@UIApplicationMain113\n<br>\nTip45@objc和dynamic115\n<br>\nTip46可选接口和接口扩展118\n<br>\nTip47内存管理，weak和unowned120\n<br>\nTip48@autoreleasepool125\n<br>\nTip49值类型和引用类型128\n<br>\nTip50String还是NSString130\n<br>\nTip51UnsafePointer132\n<br>\nTip52C指针内存管理135\n<br>\nTip53COpaquePointer和Cconvention137\n<br>\nTip54GCD和延时调用139\n<br>\nTip55获取对象类型143\n<br>\nTip56自省145\n<br>\nTip57KVO147\n<br>\nTip58局部scope150\n<br>\nTip59判等153\n<br>\nTip60哈希156\n<br>\nTip61类簇158\n<br>\nTip62Swizzle160\n<br>\nTip63调用C动态库163\n<br>\nTip64输出格式化165\n<br>\nTip65Options167\n<br>\nTip66数组enumerate169\n<br>\nTip67类型编码@encode171\n<br>\nTip68C代码调用和@asmname173\n<br>\nTip69sizeof和sizeofValueP75\n<br>\nTip70delegate177\n<br>\nTip71Associated Object179\n<br>\nTip72Lock181\n<br>\nTip73Toll—Free Bridging和Unmanaged183\n<br>\n3Swift与开发环境及一些实践187\n<br>\nTip74Swift命令行工具188\n<br>\nTip75随机数生成190\n<br>\nTip76print和debugPrint192\n<br>\nTip77错误和异常处理194\n<br>\nTip78断言200\n<br>\nTip79fatalError202\n<br>\nTip80代码组织和Framework205\n<br>\nTip81Playground延时运行209\n<br>\nTip82Playground可视化211\n<br>\nTip83Playground与项目协作213\n<br>\nTip84数学和数字215\n<br>\nTip85JSON217\n<br>\nTip86NSNull219\n<br>\nTip87文档注释221\n<br>\nTip88性能考虑223\n<br>\nTip89Log输出225\n<br>\nTip90溢出227\n<br>\nTip91宏定义define229\n<br>\nTip92属性访问控制231\n<br>\nTip93Swift中的测试233\n<br>\nTip94Core Data235\n<br>\nTip95闭包歧义237\n<br>\nTip96泛型扩展241\n<br>\nTip97兼容性243\n<br>\nTip98列举enum类型245\n<br>\nTip99尾递归248\n<br>\nTip100安全的资源组织方式250\n<br>\n后记及致谢252 ', '0.0'),
(5, '9787121280764', '疯狂Swift讲义(第2版)', '李刚', 'Swift正逐步进入iOS APP的实际应用开发，而Apple在WWDC2015上发布了Swift 2.0版本，这也表明了Apple对Swift的支持决心，不难预测，Swift的市场份额肯定会超过传统的Objective-C。\n<br>\n本书是《疯狂Swift讲义》的第2版，本书以最新的OS X 10.11为平台、以Xcode 7.1为开发工具，全面介绍了Swift 2.1的语法以及使用Swift开发iOS应用的知识。本书全面覆盖了Swift的基本语法结构、Swift函数式编程特征、Swift的面向对象特征、Foundation框架的核心类库用法等知识，并通过示例介绍了如何在iOS应用中混合使用Swift与Objective-C进行开发。本书重点介绍了repeat while循环、guard语句、API检查、条件编译、Set集合、错误处理机制、协议扩展等Swift 2.x新增的内容，这样新增的内容使得Swift具有更强的生命力。\n<br>\n本书并不局限于介绍Swift的简单语法，而是从“项目驱动”的角度来讲授理论。全书为Swift所有语法提供了大量的示例程序，大部分地方甚至从正、反两方面举例，务求使读者能举一反三地真正掌握Swift编程。如果读者在阅读本书时遇到了技术问题，可以登录疯狂Java联盟发帖，笔者将会及时予以解答。', 2, 2, '电子工业出版社', 1454281200, ' TP312/6301 ', 'https://images-na.ssl-images-amazon.com/images/I/514dq7lnu7L._SX258_BO1,204,203,200_QL70_.jpg', ' 第1章 Swift语言与开发环境 1\n<br>\n1.1 Swift语言简介 2\n<br>\n1.1.1 Swift语言 2\n<br>\n1.1.2 关于Swift的几个误解 2\n<br>\n1.2 搭建Swift开发环境 3\n<br>\n1.2.1 下载和安装Xcode 4\n<br>\n1.2.2 安装辅助工具和文档 6\n<br>\n1.3 第一个Swift程序 7\n<br>\n1.3.1 Swift程序入口 7\n<br>\n1.3.2 使用Playground工具 8\n<br>\n1.3.3 开发Swift项目 10\n<br>\n1.4 使用终端窗口编译、运行Swift程序 12\n<br>\n1.4.1 使用swiftc编译Swift程序 12\n<br>\n1.4.2 使用swift交互命令 14\n<br>\n1.5 熟悉Xcode 14\n<br>\n1.5.1 创建iOS项目 14\n<br>\n1.5.2 熟悉导航面板 15\n<br>\n1.5.3 熟悉检查器面板 18\n<br>\n1.5.4 熟悉库面板 20\n<br>\n1.5.5 使用Xcode的帮助系统 22\n<br>\n1.6 本章小结 24\n<br>\n第2章 Swift的基本数据类型 25\n<br>\n2.1 注释 26\n<br>\n2.2 变量与常量 27\n<br>\n2.2.1 分隔符 27\n<br>\n2.2.2 标识符规则 29\n<br>\n2.2.3 Swift的关键字 29\n<br>\n2.2.4 声明变量和常量 30\n<br>\n2.2.5 输出变量和常量 32\n<br>\n2.3 整型 32\n<br>\n2.4 浮点型 34\n<br>\n2.5 数值型之间的类型转换 35\n<br>\n2.5.1 整型之间的转换 35\n<br>\n2.5.2 浮点型与整型之间的转换 37\n<br>\n2.6 Bool型 38\n<br>\n2.7 元组（tuple）类型 38\n<br>\n2.7.1 定义元组类型的变量 39\n<br>\n2.7.2 获取元组中的元素值 39\n<br>\n2.7.3 为元组中的元素命名 40\n<br>\n2.8 可选类型 40\n<br>\n2.8.1 可选和nil 41\n<br>\n2.8.2 强制解析 42\n<br>\n2.8.3 可选绑定 43\n<br>\n2.8.4 隐式可选类型 43\n<br>\n2.9 类型别名 45\n<br>\n2.10 字符和字符串 45\n<br>\n2.10.1 字符类型 45\n<br>\n2.10.2 字符串类型 46\n<br>\n2.10.3 字符串的可变性 48\n<br>\n2.10.4 字符串的基本操作 48\n<br>\n2.10.5 字符串比较 50\n<br>\n2.10.6 获取字符串中字符的Unicode编码 50\n<br>\n2.11 本章小结 51\n<br>\n第3章 运算符和表达式 52\n<br>\n3.1 赋值运算符 53\n<br>\n3.2 算术运算符 54\n<br>\n3.3 溢出运算符 57\n<br>\n3.3.1 值的上溢 57\n<br>\n3.3.2 值的下溢 58\n<br>\n3.4 位运算符 58\n<br>\n3.5 扩展后的赋值运算符 61\n<br>\n3.6 范围运算符 61\n<br>\n3.6.1 闭范围运算符 61\n<br>\n3.6.2 半开范围运算符 61\n<br>\n3.7 比较运算符 62\n<br>\n3.8 逻辑运算符 63\n<br>\n3.8.1 Swift的3个逻辑运算符 63\n<br>\n3.8.2 组合逻辑与括号 63\n<br>\n3.9 三目运算符 64\n<br>\n3.10 nil合并运算符 65\n<br>\n3.11 运算符的结合性和优先级 66\n<br>\n3.12 本章小结 67\n<br>\n第4章 流程控制 68\n<br>\n4.1 顺序结构 69\n<br>\n4.2 分支结构 69\n<br>\n4.2.1 if条件语句 69\n<br>\n4.2.2 switch分支语句 72\n<br>\n4.2.3 switch不存在隐式贯穿（fallthrough）和显式贯穿 73\n<br>\n4.2.4 使用break结束switch 74\n<br>\n4.2.5 switch的范围匹配 75\n<br>\n4.2.6 switch的元组匹配 75\n<br>\n4.2.7 case的值绑定 77\n<br>\n4.2.8 case的where子句 78\n<br>\n4.3 循环结构 79\n<br>\n4.3.1 while循环语句 79\n<br>\n4.3.2 repeat while循环语句 80\n<br>\n4.3.3 for循环 81\n<br>\n4.3.4 for-in循环 83\n<br>\n4.3.5 嵌套循环 83\n<br>\n4.4 控制循环结构 84\n<br>\n4.4.1 使用break结束循环 84\n<br>\n4.4.2 使用continue忽略本次循环的剩下语句 85\n<br>\n4.4.3 使用return结束方法 86\n<br>\n4.5 Swift 2新增的guard语句 87\n<br>\n4.6 Swift 2新增的API检查 88\n<br>\n4.7 条件编译 89\n<br>\n4.8 本章小结 90\n<br>\n第5章 集合 91\n<br>\n5.1 数组 92\n<br>\n5.1.1 声明和创建数组 92\n<br>\n5.1.2 使用数组 93\n<br>\n5.1.3 使用for-in遍历数组 95\n<br>\n5.1.4 数组的可变性和数组的修改 95\n<br>\n5.1.5 多维数组 98\n<br>\n5.1.6 数组的应用举例 101\n<br>\n5.2 Set集合 102\n<br>\n5.2.1 声明和创建Set 102\n<br>\n5.2.2 使用Set 103\n<br>\n5.2.3 使用for-in遍历Set 104\n<br>\n5.2.4 Set的可变性和Set的修改 104\n<br>\n5.2.5 Set集合元素与hashValue 106\n<br>\n5.2.6 Set支持的集合运算 106\n<br>\n5.2.7 Set集合的关系运算 107\n<br>\n5.3 字典 108\n<br>\n5.3.1 声明和创建字典 109\n<br>\n5.3.2 使用字典 110\n<br>\n5.3.3 使用for-in遍历字典 111\n<br>\n5.3.4 单独使用字典的keys或values 111\n<br>\n5.3.5 字典的可变性和字典的修改 112\n<br>\n5.3.6 字典的应用举例 113\n<br>\n5.4 集合的复制 114\n<br>\n5.4.1 数组与Set的复制 114\n<br>\n5.4.2 字典的复制 116\n<br>\n5.5 本章小结 117\n<br>\n第6章 函数和闭包 118\n<br>\n6.1 函数入门 119\n<br>\n6.1.1 定义和调用函数 119\n<br>\n6.1.2 函数返回值 120\n<br>\n6.1.3 递归函数 122\n<br>\n6.2 函数的形参 123\n<br>\n6.2.1 外部形参名 123\n<br>\n6.2.2 形参默认值 124\n<br>\n6.2.3 个数可变的形参 125\n<br>\n6.2.4 常量形参和变量形参 126\n<br>\n6.2.5 In-Out形参 126\n<br>\n6.3 函数类型 130\n<br>\n6.3.1 使用函数类型 130\n<br>\n6.3.2 使用函数类型作为形参类型 131\n<br>\n6.3.3 使用函数类型作为返回值类型 133\n<br>\n6.4 函数重载 133\n<br>\n6.5 嵌套函数 135\n<br>\n6.6 嵌套函数与闭包 137\n<br>\n6.6.1 回顾嵌套函数 137\n<br>\n6.6.2 使用闭包表达式代替嵌套函数 137\n<br>\n6.6.3 闭包的escape 138\n<br>\n6.7 闭包表达式 139\n<br>\n6.7.1 调用闭包（使用闭包返回值） 139\n<br>\n6.7.2 利用上下文推断类型 140\n<br>\n6.7.3 省略return 141\n<br>\n6.7.4 省略形参名 141\n<br>\n6.7.5 尾随闭包 142\n<br>\n6.8 捕获上下文中的变量和常量 143\n<br>\n6.9 闭包是引用类型 144\n<br>\n6.10 自动闭包 145\n<br>\n6.11 本章小结 146\n<br>\n第7章 面向对象编程（上） 147\n<br>\n7.1 Swift的面向对象支持 148\n<br>\n7.1.1 面向对象概述 148\n<br>\n7.1.2 Swift的面向对象类型 148\n<br>\n7.2 枚举 149\n<br>\n7.2.1 定义枚举 149\n<br>\n7.2.2 枚举值和switch语句 151\n<br>\n7.2.3 原始值 152\n<br>\n7.2.4 关联值 153\n<br>\n7.2.5 递归枚举 155\n<br>\n7.3 类和结构体 156\n<br>\n7.3.1 定义结构体和类 156\n<br>\n7.3.2 创建实例 160\n<br>\n7.3.3 值类型与引用类型 161\n<br>\n7.3.4 引用类型的比较 163\n<br>\n7.3.5 self关键字 165\n<br>\n7.3.6 类和结构体的选择 167\n<br>\n7.4 存储属性 167\n<br>\n7.4.1 实例存储属性与实例变量 167\n<br>\n7.4.2 结构体常量与实例属性 169\n<br>\n7.4.3 延迟存储属性 169\n<br>\n7.5 计算属性 170\n<br>\n7.5.1 定义计算属性 170\n<br>\n7.5.2 set部分的简化 172\n<br>\n7.5.3 只读的计算属性 173\n<br>\n7.6 属性观察者 173\n<br>\n7.7 方法 175\n<br>\n7.7.1 方法的所属性 176\n<br>\n7.7.2 将方法转换为函数 176\n<br>\n7.7.3 方法的外部形参名 177\n<br>\n7.7.4 Swift方法的命名习惯 179\n<br>\n7.7.5 值类型的可变方法 180\n<br>\n7.7.6 属性和方法的统一 182\n<br>\n7.8 下标 183\n<br>\n7.8.1 下标的基本用法 183\n<br>\n7.8.2 下标重载 185\n<br>\n7.9 可选链 187\n<br>\n7.9.1 使用可选链代替强制解析 187\n<br>\n7.9.2 使用可选链调用方法 189\n<br>\n7.9.3 使用可选链调用下标 190\n<br>\n7.10 类型属性和类型方法 190\n<br>\n7.10.1 类型成员的修饰符 191\n<br>\n7.10.2 值类型的类型属性 191\n<br>\n7.10.3 类的类型属性 192\n<br>\n7.10.4 值类型的类型方法 193\n<br>\n7.10.5 类的类型方法 194\n<br>\n7.11 错误处理 194\n<br>\n7.11.1 抛出错误 195\n<br>\n7.11.2 声明抛出错误 195\n<br>\n7.11.3 使用do-catch捕捉错误 196\n<br>\n7.11.4 将错误转为可选值 197\n<br>\n7.11.5 使错误失效 198\n<br>\n7.11.6 使用defer回收资源 199\n<br>\n7.12 构造器 200\n<br>\n7.12.1 类和结构体的构造器 200\n<br>\n7.12.2 构造器的外部形参名 201\n<br>\n7.12.3 使用闭包或函数为属性设置初始值 203\n<br>\n7.12.4 值类型的构造器重载 204\n<br>\n7.13 可能失败的构造器 205\n<br>\n7.13.1 结构体与可能失败的构造器 206\n<br>\n7.13.2 枚举与可能失败的构造器 207\n<br>\n7.14 本章小结 208\n<br>\n第8章 面向对象编程（下） 209\n<br>\n8.1 继承 210\n<br>\n8.1.1 继承的特点 210\n<br>\n8.1.2 重写父类的方法 211\n<br>\n8.1.3 重写父类的属性 212\n<br>\n8.1.4 重写属性观察者 214\n<br>\n8.1.5 重写父类的下标 214\n<br>\n8.1.6 使用final防止重写 215\n<br>\n8.2 类的构造与析构 217\n<br>\n8.2.1 类的指定构造器和便利构造器 217\n<br>\n8.2.2 类的构造器链 218\n<br>\n8.2.3 两段式构造 220\n<br>\n8.2.4 构造器的继承和重写 223\n<br>\n8.2.5 类与可能失败的构造器 226\n<br>\n8.2.6 可能失败的构造器的传 ', '0.0');
INSERT INTO `ot_book` (`isbn_id`, `ISBN`, `book_name`, `author`, `introduction`, `totalnum`, `remainnum`, `pub`, `pub_date`, `callnum`, `img`, `catalog`, `avg_score`) VALUES
(6, '9787302423287', '机器学习', '周志华', '《机器学习》是计算机科学与人工智能的重要分支领域。《机器学习》作为该领域的入门教材，在内容上尽可能涵盖机器学习基础知识的各方面。', 2, 1, '清华大学出版社', 0, 'TP181/742.2 ', 'https://images-cn.ssl-images-amazon.com/images/I/51oc3xxiBWL.jpg', ' 目录\n<br>\n<br>\n第1章 1\n<br>\n1.1 引言 1\n<br>\n1.2 基本术 2\n<br>\n1.3 假设空间 4\n<br>\n1.4 归纳偏好 6\n<br>\n1.5 发展历程 10\n<br>\n1.6 应用现状 13\n<br>\n1.7 阅读材料 16\n<br>\n习题 19\n<br>\n参考文献 20\n<br>\n休息一会儿 22\n<br>\n<br>\n<br>\n第2章 模型评估与选择 23\n<br>\n2.1 经验误差与过拟合 23\n<br>\n2.2 评估方法 24\n<br>\n2.2.1 留出法 25\n<br>\n2.2.2 交叉验证法 26\n<br>\n2.2.3 自助法 27\n<br>\n2.2.4 调参与最终模型 28\n<br>\n2.3 性能度量 28\n<br>\n2.3.1 错误率与精度 29\n<br>\n2.3.2 查准率、查全率与F1 30\n<br>\n2.3.3 ROC与AUC 33\n<br>\n2.3.4 代价敏感错误率与代价曲线 35\n<br>\n2.4 比较检验 37\n<br>\n2.4.1 假设检验 37\n<br>\n2.4.2 交叉验证t检验 40\n<br>\n2.4.3 McNemar检验 41\n<br>\n2.4.4 Friedman检验与后续检验 42\n<br>\n2.5 偏差与方差 44\n<br>\n2.6 阅读材料 46\n<br>\n习题 48\n<br>\n参考文献 49\n<br>\n休息一会儿 51\n<br>\n<br>\n<br>\n第3章 线性模型 53\n<br>\n3.1 基本形式 53\n<br>\n3.2 线性回归 53\n<br>\n3.3 对数几率回归 57\n<br>\n3.4 线性判别分析 60\n<br>\n3.5 多分类学习 63\n<br>\n3.6 类别不平衡问题 66\n<br>\n3.7 阅读材料 67\n<br>\n习题 69\n<br>\n参考文献 70\n<br>\n休息一会儿 72\n<br>\n<br>\n<br>\n第4章 决策树 73\n<br>\n4.1 基本流程 73\n<br>\n4.2 划分选择 75\n<br>\n4.2.1 信息增益 75\n<br>\n4.2.2 增益率 77\n<br>\n4.2.3 基尼指数 79\n<br>\n4.3 剪枝处理 79\n<br>\n4.3.1 预剪枝 80\n<br>\n4.3.2 后剪枝 82\n<br>\n4.4 连续与缺失值 83\n<br>\n4.4.1 连续值处理 83\n<br>\n4.4.2 缺失值处理 85\n<br>\n4.5 多变量决策树 88\n<br>\n4.6 阅读材料 92\n<br>\n习题 93\n<br>\n参考文献 94\n<br>\n休息一会儿 95\n<br>\n<br>\n<br>\n第5章 神经网络 97\n<br>\n5.1 神经元模型 97\n<br>\n5.2 感知机与多层网络 98\n<br>\n5.3 误差逆传播算法 101\n<br>\n5.4 全局最小与局部极小 106\n<br>\n5.5 其他常见神经网络 108\n<br>\n5.5.1 RBF网络 108\n<br>\n5.5.2 ART网络 108\n<br>\n5.5.3 SOM网络 109\n<br>\n5.5.4 级联相关网络 110\n<br>\n5.5.5 Elman网络 111\n<br>\n5.5.6 Boltzmann机 111\n<br>\n5.6 深度学习 113\n<br>\n5.7 阅读材料 115\n<br>\n习题 116\n<br>\n参考文献 117\n<br>\n休息一会儿 120\n<br>\n<br>\n<br>\n第6章 支持向量机 121\n<br>\n6.1 间隔与支持向量 121\n<br>\n6.2 对偶问题 123\n<br>\n6.3 核函数 126\n<br>\n6.4 软间隔与正则化 129\n<br>\n6.5 支持向量回归 133\n<br>\n6.6 核方法 137\n<br>\n6.7 阅读材料 139\n<br>\n习题 141\n<br>\n参考文献 142\n<br>\n休息一会儿 145\n<br>\n<br>\n<br>\n第7章 贝叶斯分类器 147\n<br>\n7.1 贝叶斯决策论 147\n<br>\n7.2 极大似然估计 149\n<br>\n7.3 朴素贝叶斯分类器 150\n<br>\n7.4 半朴素贝叶斯分类器 154\n<br>\n7.5 贝叶斯网 156\n<br>\n7.5.1 结构 157\n<br>\n7.5.2 学习 159\n<br>\n7.5.3 推断 161\n<br>\n7.6 EM算法 162\n<br>\n7.7 阅读材料 164\n<br>\n习题 166\n<br>\n参考文献 167\n<br>\n休息一会儿 169\n<br>\n<br>\n<br>\n第8章 集成学习 171\n<br>\n8.1 个体与集成 171\n<br>\n8.2 Boosting 173\n<br>\n8.3 Bagging与随机森林 178\n<br>\n8.3.1 Bagging 178\n<br>\n8.3.2 随机森林 179\n<br>\n8.4 结合策略 181\n<br>\n8.4.1 平均法 181\n<br>\n8.4.2 投票法 182\n<br>\n8.4.3 学习法 183\n<br>\n8.5 多样性 185\n<br>\n8.5.1 误差--分歧分解 185\n<br>\n8.5.2 多样性度量 186\n<br>\n8.5.3 多样性增强 188\n<br>\n8.6 阅读材料 190\n<br>\n习题 192\n<br>\n参考文献 193\n<br>\n休息一会儿 196\n<br>\n<br>\n<br>\n<br>\n第9章 聚类 197\n<br>\n9.1 聚类任务 197\n<br>\n9.2 性能度量 197\n<br>\n9.3 距离计算 199\n<br>\n9.4 原型聚类 202\n<br>\n9.4.1 k均值算法 202\n<br>\n9.4.2 学习向量量化 204\n<br>\n9.4.3 高斯混合聚类 206\n<br>\n9.5 密度聚类 211\n<br>\n9.6 层次聚类 214\n<br>\n9.7 阅读材料 217\n<br>\n习题 220\n<br>\n参考文献 221\n<br>\n休息一会儿 224\n<br>\n<br>\n<br>\n第10章 降维与度量学习 225\n<br>\n10.1 k近邻学习 225\n<br>\n10.2 低维嵌入 226\n<br>\n10.3 主成分分析 229\n<br>\n10.4 核化线性降维 232\n<br>\n10.5 流形学习 234\n<br>\n10.5.1 等度量映射 234\n<br>\n10.5.2 局部线性嵌入 235\n<br>\n10.6 度量学习 237\n<br>\n10.7 阅读材料 240\n<br>\n习题 242\n<br>\n参考文献 243\n<br>\n休息一会儿 246\n<br>\n<br>\n<br>\n第11章 特征选择与稀疏学习 247\n<br>\n11.1 子集搜索与评价 247\n<br>\n11.2 过滤式选择 249\n<br>\n11.3 包裹式选择 250\n<br>\n11.4 嵌入式选择与L$_1$正则化 252\n<br>\n11.5 稀疏表示与字典学习 254\n<br>\n11.6 压缩感知 257\n<br>\n11.7 阅读材料 260\n<br>\n习题 262\n<br>\n参考文献 263\n<br>\n休息一会儿 266\n<br>\n<br>\n<br>\n<br>\n第12章 计算学习理论 267\n<br>\n12.1 基础知识 267\n<br>\n12.2 PAC学习 268\n<br>\n12.3 有限假设空间 270\n<br>\n12.3.1 可分情形 270\n<br>\n12.3.2 不可分情形 272\n<br>\n12.4 VC维 273\n<br>\n12.5 Rademacher复杂度 279\n<br>\n12.6 稳定性 284\n<br>\n12.7 阅读材料 287\n<br>\n习题 289\n<br>\n参考文献 290\n<br>\n休息一会儿 292\n<br>\n<br>\n<br>\n第13章 半监督学习 293\n<br>\n13.1 未标记样本 293\n<br>\n13.2 生成式方法 295\n<br>\n13.3 半监督SVM 298\n<br>\n13.4 图半监督学习 300\n<br>\n13.5 基于分歧的方法 304\n<br>\n13.6 半监督聚类 307\n<br>\n13.7 阅读材料 311\n<br>\n习题 313\n<br>\n参考文献 314\n<br>\n休息一会儿 317\n<br>\n<br>\n<br>\n<br>\n第14章 概率图模型 319\n<br>\n14.1 隐马尔可夫模型 319\n<br>\n14.2 马尔可夫随机场 322\n<br>\n14.3 条件随机场 325\n<br>\n14.4 学习与推断 328\n<br>\n14.4.1 变量消去 328\n<br>\n14.4.2 信念传播 330\n<br>\n14.5 近似推断 331\n<br>\n14.5.1 MCMC采样 331\n<br>\n14.5.2 变分推断 334\n<br>\n14.6 话题模型 337\n<br>\n14.7 阅读材料 339\n<br>\n习题 341\n<br>\n参考文献 342\n<br>\n休息一会儿 345\n<br>\n<br>\n<br>\n第15章 规则学习 347\n<br>\n15.1 基本概念 347\n<br>\n15.2 序贯覆盖 349\n<br>\n15.3 剪枝优化 352\n<br>\n15.4 一阶规则学习 354\n<br>\n15.5 归纳逻辑程序设计 357\n<br>\n15.5.1 最小一般泛化 358\n<br>\n15.5.2 逆归结 359\n<br>\n15.6 阅读材料 363\n<br>\n习题 365\n<br>\n参考文献 366\n<br>\n休息一会儿 369\n<br>\n<br>\n<br>\n<br>\n第16章 强化学习 371\n<br>\n16.1 任务与奖赏 371\n<br>\n16.2 $K$-摇臂赌博机 373\n<br>\n16.2.1 探索与利用 373\n<br>\n16.2.2 $\\epsilon $-贪心 374\n<br>\n16.2.3 Softmax 375\n<br>\n16.3 有模型学习 377\n<br>\n16.3.1 策略评估 377\n<br>\n16.3.2 策略改进 379\n<br>\n16.3.3 策略迭代与值迭代 381\n<br>\n16.4 免模型学习 382\n<br>\n16.4.1 蒙特卡罗强化学习 383\n<br>\n16.4.2 时序差分学习 386\n<br>\n16.5 值函数近似 388\n<br>\n16.6 模仿学习 390\n<br>\n16.6.1 直接模仿学习 391\n<br>\n16.6.2 逆强化学习 391\n<br>\n16.7 阅读材料 393\n<br>\n习题 394\n<br>\n参考文献 395\n<br>\n休息一会儿 397\n<br>\n<br>\n<br>\n附录 399\n<br>\nA 矩阵 399\n<br>\nB 优化 403\n<br>\nC 概率分布 409\n<br>\n<br>\n后记 417\n<br>\n<br>\n索引 419\n<br>\n<br>', '5.0');

-- --------------------------------------------------------

--
-- Table structure for table `ot_bookid_isbn`
--

CREATE TABLE IF NOT EXISTS `ot_bookid_isbn` (
  `ISBN` varchar(16) NOT NULL COMMENT 'ISBN',
  `book_id` smallint(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '条码号',
  `collection` varchar(30) NOT NULL COMMENT '馆藏地',
  `state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '借阅状态',
  PRIMARY KEY (`book_id`),
  KEY `ISBN` (`ISBN`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=49 ;

--
-- Dumping data for table `ot_bookid_isbn`
--

INSERT INTO `ot_bookid_isbn` (`ISBN`, `book_id`, `collection`, `state`) VALUES
('9787115308276', 0000000001, '自然书库（3F东）', 1),
('9787115308276', 0000000002, '自然书库（3F东）', 1),
('9787115391872', 0000000003, '自然书库（3F西）', 1),
('9787115391872', 0000000004, '自然书库（3F西）', 1),
('9787115392602', 0000000005, '社会书库（4F东）', 0),
('9787115392602', 0000000006, '社会书库（4F东）', 1),
('9787121275821', 0000000007, '文一校区书库（信息工程学院）', 1),
('9787121275821', 0000000008, '文一校区书库（信息工程学院）', 1),
('9787121280764', 0000000009, '自然书库（3F东）', 1),
('9787121280764', 0000000010, '自然书库（3F东）', 1),
('9787302423287', 0000000047, '杭电图书馆', 0),
('9787302423287', 0000000048, '杭电图书馆', 1);

--
-- Triggers `ot_bookid_isbn`
--
DROP TRIGGER IF EXISTS `update_num_delete`;
DELIMITER //
CREATE TRIGGER `update_num_delete` AFTER DELETE ON `ot_bookid_isbn`
 FOR EACH ROW update ot_book set totalnum=(select count(*) from ot_bookid_isbn where isbn=old.isbn),remainnum=(select sum(state) from ot_bookid_isbn where isbn=old.isbn) where isbn=old.isbn
//
DELIMITER ;
DROP TRIGGER IF EXISTS `update_num_insert`;
DELIMITER //
CREATE TRIGGER `update_num_insert` AFTER INSERT ON `ot_bookid_isbn`
 FOR EACH ROW update ot_book set totalnum=(select count(*) from ot_bookid_isbn where isbn=new.isbn),remainnum=(select sum(state) from ot_bookid_isbn where isbn=new.isbn) where isbn=new.isbn
//
DELIMITER ;
DROP TRIGGER IF EXISTS `update_remainnum_update`;
DELIMITER //
CREATE TRIGGER `update_remainnum_update` AFTER UPDATE ON `ot_bookid_isbn`
 FOR EACH ROW if new.state!=old.state then 
update ot_book set remainnum=(select sum(state) from ot_bookid_isbn where isbn=old.isbn) where isbn=old.isbn;
end if
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `ot_bookinfo_view`
--
CREATE TABLE IF NOT EXISTS `ot_bookinfo_view` (
`callnum` varchar(20)
,`book_id` smallint(10) unsigned zerofill
,`collection` varchar(30)
,`state` tinyint(1)
,`ISBN` varchar(16)
,`back_time` int(11)
,`img` varchar(255)
);
-- --------------------------------------------------------

--
-- Table structure for table `ot_borrow`
--

CREATE TABLE IF NOT EXISTS `ot_borrow` (
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `ISBN` varchar(17) NOT NULL COMMENT 'ISBN',
  `book_id` smallint(10) unsigned zerofill NOT NULL COMMENT 'book_id',
  `borrow_time` int(11) NOT NULL COMMENT '借书时间',
  `back_time` int(11) NOT NULL COMMENT '应还时间',
  `book_name` varchar(40) NOT NULL,
  PRIMARY KEY (`user_id`,`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ot_borrow`
--

INSERT INTO `ot_borrow` (`user_id`, `ISBN`, `book_id`, `borrow_time`, `back_time`, `book_name`) VALUES
(1, '9787115392602', 0000000005, 1462683536, 1465275536, 'Swift基础教程'),
(1, '9787302423287', 0000000047, 1462679604, 1465271604, '机器学习');

--
-- Triggers `ot_borrow`
--
DROP TRIGGER IF EXISTS `update_reader_delete`;
DELIMITER //
CREATE TRIGGER `update_reader_delete` AFTER DELETE ON `ot_borrow`
 FOR EACH ROW update ot_reader set current_borrow=(select count(*) from ot_borrow where user_id=old.user_id) where user_id=old.user_id
//
DELIMITER ;
DROP TRIGGER IF EXISTS `update_reader_insert`;
DELIMITER //
CREATE TRIGGER `update_reader_insert` AFTER INSERT ON `ot_borrow`
 FOR EACH ROW update ot_reader set current_borrow=(select count(*) from ot_borrow where user_id=new.user_id) where user_id=new.user_id
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `ot_borrowrank_view`
--
CREATE TABLE IF NOT EXISTS `ot_borrowrank_view` (
`book_name` varchar(40)
,`ISBN` varchar(17)
,`rank` bigint(21)
,`img` varchar(255)
);
-- --------------------------------------------------------

--
-- Table structure for table `ot_borrow_history`
--

CREATE TABLE IF NOT EXISTS `ot_borrow_history` (
  `book_name` varchar(40) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `borrow_time` int(11) NOT NULL COMMENT '借书时间',
  `return_time` int(11) NOT NULL COMMENT '还书时间',
  `book_id` smallint(10) unsigned zerofill NOT NULL COMMENT 'book_id',
  `ISBN` varchar(17) NOT NULL COMMENT 'ISBN',
  PRIMARY KEY (`user_id`,`book_id`,`borrow_time`,`return_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `ot_borrow_history`
--
DROP TRIGGER IF EXISTS `update_readertotal_insert`;
DELIMITER //
CREATE TRIGGER `update_readertotal_insert` AFTER INSERT ON `ot_borrow_history`
 FOR EACH ROW update ot_reader set total_borrow=(select count(*) from ot_borrow_history where user_id=new.user_id) where user_id=new.user_id
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ot_category`
--

CREATE TABLE IF NOT EXISTS `ot_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL DEFAULT '' COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL DEFAULT '' COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '列表绑定模型',
  `model_sub` varchar(100) NOT NULL DEFAULT '' COMMENT '子文档绑定模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `groups` varchar(255) NOT NULL DEFAULT '' COMMENT '分组定义',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='分类表' AUTO_INCREMENT=42 ;

--
-- Dumping data for table `ot_category`
--

INSERT INTO `ot_category` (`id`, `name`, `title`, `pid`, `sort`, `list_row`, `meta_title`, `keywords`, `description`, `template_index`, `template_lists`, `template_detail`, `template_edit`, `model`, `model_sub`, `type`, `link_id`, `allow_publish`, `display`, `reply`, `check`, `reply_model`, `extend`, `create_time`, `update_time`, `status`, `icon`, `groups`) VALUES
(1, 'blog', '博客', 0, 0, 10, '', '', '', '', '', '', '', '2,3', '2', '2,1', 0, 0, 1, 0, 0, '1', '', 1379474947, 1382701539, 1, 0, ''),
(2, 'default_blog', '默认分类', 1, 1, 10, '', '', '', '', '', '', '', '2,3', '2', '2,1,3', 0, 1, 1, 0, 1, '1', '', 1379475028, 1386839751, 1, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `ot_channel`
--

CREATE TABLE IF NOT EXISTS `ot_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ot_channel`
--

INSERT INTO `ot_channel` (`id`, `pid`, `title`, `url`, `sort`, `create_time`, `update_time`, `status`, `target`) VALUES
(1, 0, '首页', 'Index/index', 1, 1379475111, 1379923177, 1, 0),
(2, 0, '个人中心', 'User/index', 2, 1379475131, 1460864091, 1, 0),
(3, 0, '后台', 'Admin/index', 3, 1379475154, 1462515183, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ot_collection`
--

CREATE TABLE IF NOT EXISTS `ot_collection` (
  `user_id` int(10) unsigned DEFAULT NULL,
  `ISBN` varchar(17) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ot_collection`
--

INSERT INTO `ot_collection` (`user_id`, `ISBN`) VALUES
(2, '9787115308276');

-- --------------------------------------------------------

--
-- Stand-in structure for view `ot_collection_view`
--
CREATE TABLE IF NOT EXISTS `ot_collection_view` (
`user_id` int(10) unsigned
,`ISBN` varchar(17)
,`book_name` varchar(40)
,`author` varchar(20)
,`pub` varchar(30)
,`pub_date` int(11)
,`callnum` varchar(20)
,`img` varchar(255)
);
-- --------------------------------------------------------

--
-- Table structure for table `ot_config`
--

CREATE TABLE IF NOT EXISTS `ot_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

--
-- Dumping data for table `ot_config`
--

INSERT INTO `ot_config` (`id`, `name`, `type`, `title`, `group`, `extra`, `remark`, `create_time`, `update_time`, `status`, `value`, `sort`) VALUES
(1, 'WEB_SITE_TITLE', 1, '网站标题', 1, '', '网站标题前台显示标题', 1378898976, 1379235274, 1, 'OneThink内容管理框架', 0),
(2, 'WEB_SITE_DESCRIPTION', 2, '网站描述', 1, '', '网站搜索引擎描述', 1378898976, 1379235841, 1, 'OneThink内容管理框架', 1),
(3, 'WEB_SITE_KEYWORD', 2, '网站关键字', 1, '', '网站搜索引擎关键字', 1378898976, 1381390100, 1, 'ThinkPHP,OneThink', 8),
(4, 'WEB_SITE_CLOSE', 4, '关闭站点', 1, '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', 1378898976, 1379235296, 1, '1', 1),
(9, 'CONFIG_TYPE_LIST', 3, '配置类型列表', 4, '', '主要用于数据解析和页面表单的生成', 1378898976, 1379235348, 1, '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', 2),
(10, 'WEB_SITE_ICP', 1, '网站备案号', 1, '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', 1378900335, 1379235859, 1, '', 9),
(11, 'DOCUMENT_POSITION', 3, '文档推荐位', 2, '', '文档推荐位，推荐到多个位置KEY值相加即可', 1379053380, 1379235329, 1, '1:列表推荐\r\n2:频道推荐\r\n4:首页推荐', 3),
(12, 'DOCUMENT_DISPLAY', 3, '文档可见性', 2, '', '文章可见性仅影响前台显示，后台不收影响', 1379056370, 1379235322, 1, '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', 4),
(13, 'COLOR_STYLE', 4, '后台色系', 1, 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', 1379122533, 1379235904, 1, 'default_color', 10),
(20, 'CONFIG_GROUP_LIST', 3, '配置分组', 4, '', '配置分组', 1379228036, 1384418383, 1, '1:基本\r\n2:内容\r\n3:用户\r\n4:系统', 4),
(21, 'HOOKS_TYPE', 3, '钩子的类型', 4, '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', 1379313397, 1379313407, 1, '1:视图\r\n2:控制器', 6),
(22, 'AUTH_CONFIG', 3, 'Auth配置', 4, '', '自定义Auth.class.php类配置', 1379409310, 1379409564, 1, 'AUTH_ON:1\r\nAUTH_TYPE:2', 8),
(23, 'OPEN_DRAFTBOX', 4, '是否开启草稿功能', 2, '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', 1379484332, 1379484591, 1, '1', 1),
(24, 'DRAFT_AOTOSAVE_INTERVAL', 0, '自动保存草稿时间', 2, '', '自动保存草稿的时间间隔，单位：秒', 1379484574, 1386143323, 1, '60', 2),
(25, 'LIST_ROWS', 0, '后台每页记录数', 2, '', '后台数据每页显示记录数', 1379503896, 1380427745, 1, '10', 10),
(26, 'USER_ALLOW_REGISTER', 4, '是否允许用户注册', 3, '0:关闭注册\r\n1:允许注册', '是否开放用户注册', 1379504487, 1379504580, 1, '1', 3),
(27, 'CODEMIRROR_THEME', 4, '预览插件的CodeMirror主题', 4, '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', 1379814385, 1384740813, 1, 'ambiance', 3),
(28, 'DATA_BACKUP_PATH', 1, '数据库备份根路径', 4, '', '路径必须以 / 结尾', 1381482411, 1381482411, 1, './Data/', 5),
(29, 'DATA_BACKUP_PART_SIZE', 0, '数据库备份卷大小', 4, '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', 1381482488, 1381729564, 1, '20971520', 7),
(30, 'DATA_BACKUP_COMPRESS', 4, '数据库备份文件是否启用压缩', 4, '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', 1381713345, 1381729544, 1, '1', 9),
(31, 'DATA_BACKUP_COMPRESS_LEVEL', 4, '数据库备份文件压缩级别', 4, '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', 1381713408, 1381713408, 1, '9', 10),
(32, 'DEVELOP_MODE', 4, '开启开发者模式', 4, '0:关闭\r\n1:开启', '是否开启开发者模式', 1383105995, 1383291877, 1, '1', 11),
(33, 'ALLOW_VISIT', 3, '不受限控制器方法', 0, '', '', 1386644047, 1386644741, 1, '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', 0),
(34, 'DENY_VISIT', 3, '超管专限控制器方法', 0, '', '仅超级管理员可访问的控制器方法', 1386644141, 1386644659, 1, '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', 0),
(35, 'REPLY_LIST_ROWS', 0, '回复列表每页条数', 2, '', '', 1386645376, 1387178083, 1, '10', 0),
(36, 'ADMIN_ALLOW_IP', 2, '后台允许访问IP', 4, '', '多个用逗号分隔，如果不配置表示不限制IP访问', 1387165454, 1387165553, 1, '', 12),
(37, 'SHOW_PAGE_TRACE', 4, '是否显示页面Trace', 4, '0:关闭\r\n1:开启', '是否显示页面Trace信息', 1387165685, 1387165685, 1, '0', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ot_document`
--

CREATE TABLE IF NOT EXISTS `ot_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `group_id` smallint(3) unsigned NOT NULL COMMENT '所属分组',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='文档模型基础表' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `ot_document`
--

INSERT INTO `ot_document` (`id`, `uid`, `name`, `title`, `category_id`, `group_id`, `description`, `root`, `pid`, `model_id`, `type`, `position`, `link_id`, `cover_id`, `display`, `deadline`, `attach`, `view`, `comment`, `extend`, `level`, `create_time`, `update_time`, `status`) VALUES
(1, 1, '', 'OneThink1.1开发版发布', 2, 0, '期待已久的OneThink最新版发布', 0, 0, 2, 2, 0, 0, 0, 1, 0, 0, 11, 0, 0, 0, 1406001413, 1406001413, 1),
(2, 1, '', 'OneThink1.1 + Bootstrap3.3.4 发布啦！【原子力量工作室】', 2, 0, '对于该版本的说明', 0, 0, 2, 2, 0, 0, 0, 1, 0, 0, 4, 0, 0, 0, 1433745780, 1433821603, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ot_document_article`
--

CREATE TABLE IF NOT EXISTS `ot_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

--
-- Dumping data for table `ot_document_article`
--

INSERT INTO `ot_document_article` (`id`, `parse`, `content`, `template`, `bookmark`) VALUES
(1, 0, '<h1>\r\n OneThink1.1开发版发布&nbsp;\r\n</h1>\r\n<p>\r\n  <br />\r\n</p>\r\n<p>\r\n <strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n 主要特性：\r\n</h2>\r\n<p>\r\n 1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n  2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n 3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n  4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n  5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n 6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n 7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n 8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n 9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n  <br />\r\n</p>\r\n<p>\r\n <strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<h2>\r\n  后台主要功能：\r\n</h2>\r\n<p>\r\n 1. 用户Passport系统\r\n</p>\r\n<p>\r\n  2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n  3. 权限控制系统\r\n</p>\r\n<p>\r\n  4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n  5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n  6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n  7. 钩子和插件系统\r\n</p>\r\n<p>\r\n 8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n  9. 数据备份和还原\r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<p>\r\n &nbsp;[ 官方下载：&nbsp;<a href="http://www.onethink.cn/download.html" target="_blank">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href="http://document.onethink.cn/" target="_blank">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n  <br />\r\n</p>\r\n<p>\r\n <strong>OneThink开发团队 2013~2014</strong> \r\n</p>', '', 0),
(2, 0, '<h3>\r\n  我们是<a target="_blank" href="http://www.cleanbing.cn">原子力量</a>工作室，互联网的尖刀兵<img src="/onethinkbt3/Public/static/kindeditor/plugins/emoticons/images/13.gif" alt="" border="0" /><img src="/onethinkbt3/Public/static/kindeditor/plugins/emoticons/images/28.gif" alt="" border="0" /> \r\n</h3>\r\n<h3>\r\n  【版本说明】<br />\r\n</h3>\r\n<h4>\r\n <span style="color:#006600;">感谢OneThink1.1为我们提供了如此强大高效的开源系统，基于ThinkPHP我们的开发突飞猛进。一个字，爽！</span> \r\n</h4>\r\n<h4>\r\n <span style="color:#337FE5;">只是当我们使用OneThink1.1的时候，发现它并没有基于最新的Bootstrap3.3.4，但我们之前很多开发都是利用了BT3的新特性，于是我们做了这样一个版本，免费贡献给大家。</span> \r\n</h4>\r\n<h4>\r\n <span style="color:#337FE5;">另外本版本多了一个tools</span><span style="color:#337FE5;">目录，里面是我们制作的windows批处理工具，完成数据库导入/导出/制作install版本等常用功能，使用前请根据自己的数据库信息修改BAT文件。</span><br />\r\n</h4>\r\n<h4>\r\n <span style="color:#337FE5;">请大家继续遵守OneThink的开源协议和版权申明，我们只是想把自己的好东西拿来与更多开发者分享，顺便加了我们的link，你完全可以去掉。（遵守协议，大部分修改都加入了带有原子力量关键字的注释）</span> \r\n</h4>\r\n<h2>\r\n 【问题反馈】<br />\r\n</h2>\r\n<h4>\r\n <span style="color:#FF9900;">我们并没有在丰富的终端和环境中完全测试，如果您在使用中遇到问题，欢迎加入我们QQ群交流：457634030</span>，<span style="color:#009900;">或者我的微信号cleanbing</span>，或者我的网站<a target="_blank" href="http://www.cleanbing.cn">http://www.cleanbing.cn</a> \r\n</h4>\r\n<h4>\r\n  <span style="color:#000000;"><strong>感谢您的阅读，与支持！</strong></span> \r\n</h4>\r\n<h3>\r\n  【资源获取】\r\n</h3>\r\n<p>\r\n  下载最新版本zip：<strong></strong> <span id="sample-permalink">http://www.cleanbing.cn/<span id="editable-post-name">otbt3</span>/</span> \r\n</p>\r\n<p>\r\n  Git@OSC源代码：<span class="clone">https://git.oschina.net/cleanbing/OnethinkBt3.git</span> \r\n</p>\r\n<p>\r\n <span class="clone"></span> \r\n</p>\r\n<h3>\r\n  【开源计划，加入我们】\r\n</h3>\r\n<p>\r\n <span style="color:#E53333;">我们计划基于Onethink1.1+BT3再做一些入门的实例，方便更多人学习PHP/ThinkPHP/Onethink/Bootstrap，也会把我们曾经做过的一些模块插件放进来开源。Leader说要支持我们原创开源<img src="/onethinkbt3/Public/static/kindeditor/plugins/emoticons/images/0.gif" alt="" border="0" />，以后会慢慢推出我们的教程/视频/学习套件，帮助更多的人！（把leader的宝典偷出来放上去<img src="/onethinkbt3/Public/static/kindeditor/plugins/emoticons/images/13.gif" alt="" border="0" />）</span> \r\n</p>\r\n<p>\r\n  <span style="color:#E53333;">如果你也有兴趣，一</span><span style="color:#E53333;">起基于</span><span style="color:#E53333;">OneThink+BT3</span><span style="color:#E53333;">做更多</span><span style="color:#E53333;">优化和开发</span><span style="color:#E53333;">，欢迎加入我们的</span><span style="color:#E53333;">开源项</span><span><span style="color:#E53333;">目</span><span style="color:#E53333;">：</span></span> \r\n</p>\r\n<p>\r\n  <a target="_blank" href="https://tower.im/join?t=c7f23f6cb244fdcec67123e2d0e19408">https://tower.im/join?t=c7f23f6cb244fdcec67123e2d0e19408</a> \r\n</p>\r\n<p>\r\n 微信扫一扫下面的二维码也可以加入该项目哦！\r\n</p>\r\n<p>\r\n  <span id="__kindeditor_bookmark_start_8__"></span>\r\n</p>\r\n<p>\r\n <img src="http://www.cleanbing.cn/wp-content/uploads/2015/06/ticket-300x300.jpg" title="Tower开源项目二维码" alt="Tower开源项目二维码" width="200" height="200" />\r\n</p>\r\n<hr />\r\n【主要修改记录】\r\n<p>\r\n <br />\r\n</p>\r\n<ul>\r\n  <li>\r\n    替换了Bootstrap核心文件为3.3.4最新版\r\n </li>\r\n <li>\r\n    修改了大部分HTML，替换为栅格自适应布局，导航栏样式替换，侧边栏样式替换，原有<span id="__kindeditor_bookmark_start_89__"></span>jumbotron等的替换。。。原则就是尽量使用BT3的内置样式\r\n </li>\r\n <li>\r\n    只修改了Home和Install，Admin的样式没有动，因为我们觉得现在的就很棒啊！\r\n </li>\r\n <li>\r\n    增加了tools目录以及下面的常用工具<br />\r\n </li>\r\n <li>\r\n    注意：现在load的是Bootstrap.css而不是bootstrap.min.css，我们好像改了Bootstrap.css的一个地方（太忙了实在记不得了也懒得去弄了哈），所以请自行生成min.css\r\n  </li>\r\n</ul>', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ot_document_download`
--

CREATE TABLE IF NOT EXISTS `ot_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';

-- --------------------------------------------------------

--
-- Table structure for table `ot_file`
--

CREATE TABLE IF NOT EXISTS `ot_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '远程地址',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ot_hooks`
--

CREATE TABLE IF NOT EXISTS `ot_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `ot_hooks`
--

INSERT INTO `ot_hooks` (`id`, `name`, `description`, `type`, `update_time`, `addons`, `status`) VALUES
(1, 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', 1, 0, '', 1),
(2, 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', 1, 0, 'ReturnTop', 1),
(3, 'documentEditForm', '添加编辑表单的 扩展内容钩子', 1, 0, 'Attachment', 1),
(4, 'documentDetailAfter', '文档末尾显示', 1, 0, 'Attachment,SocialComment', 1),
(5, 'documentDetailBefore', '页面内容前显示用钩子', 1, 0, '', 1),
(6, 'documentSaveComplete', '保存文档数据后的扩展钩子', 2, 0, 'Attachment', 1),
(7, 'documentEditFormContent', '添加编辑表单的内容显示钩子', 1, 0, 'Editor', 1),
(8, 'adminArticleEdit', '后台内容编辑页编辑器', 1, 1378982734, 'EditorForAdmin', 1),
(13, 'AdminIndex', '首页小格子个性化显示', 1, 1382596073, 'SiteStat,SystemInfo,DevTeam', 1),
(14, 'topicComment', '评论提交方式扩展钩子。', 1, 1380163518, 'Editor', 1),
(16, 'app_begin', '应用开始', 2, 1384481614, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ot_member`
--

CREATE TABLE IF NOT EXISTS `ot_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='会员表' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ot_member`
--

INSERT INTO `ot_member` (`uid`, `nickname`, `sex`, `birthday`, `qq`, `score`, `login`, `reg_ip`, `reg_time`, `last_login_ip`, `last_login_time`, `status`) VALUES
(1, 'admin', 0, '0000-00-00', '', 60, 29, 0, 1460863718, 0, 1462678898, 1),
(2, 'swc', 0, '0000-00-00', '', 20, 3, 0, 1460986400, 0, 1462611453, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ot_menu`
--

CREATE TABLE IF NOT EXISTS `ot_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=124 ;

--
-- Dumping data for table `ot_menu`
--

INSERT INTO `ot_menu` (`id`, `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`, `status`) VALUES
(1, '首页', 0, 1, 'Index/index', 0, '', '', 0, 1),
(2, '内容', 0, 2, 'Article/index', 0, '', '', 0, 1),
(3, '文档列表', 2, 0, 'article/index', 1, '', '内容', 0, 1),
(4, '新增', 3, 0, 'article/add', 0, '', '', 0, 1),
(5, '编辑', 3, 0, 'article/edit', 0, '', '', 0, 1),
(6, '改变状态', 3, 0, 'article/setStatus', 0, '', '', 0, 1),
(7, '保存', 3, 0, 'article/update', 0, '', '', 0, 1),
(8, '保存草稿', 3, 0, 'article/autoSave', 0, '', '', 0, 1),
(9, '移动', 3, 0, 'article/move', 0, '', '', 0, 1),
(10, '复制', 3, 0, 'article/copy', 0, '', '', 0, 1),
(11, '粘贴', 3, 0, 'article/paste', 0, '', '', 0, 1),
(12, '导入', 3, 0, 'article/batchOperate', 0, '', '', 0, 1),
(13, '回收站', 2, 0, 'article/recycle', 1, '', '内容', 0, 1),
(14, '还原', 13, 0, 'article/permit', 0, '', '', 0, 1),
(15, '清空', 13, 0, 'article/clear', 0, '', '', 0, 1),
(16, '用户', 0, 3, 'User/index', 0, '', '', 0, 1),
(17, '用户信息', 16, 0, 'User/index', 0, '', '用户管理', 0, 1),
(18, '新增用户', 17, 0, 'User/add', 0, '添加新用户', '', 0, 1),
(19, '用户行为', 16, 0, 'User/action', 0, '', '行为管理', 0, 1),
(20, '新增用户行为', 19, 0, 'User/addaction', 0, '', '', 0, 1),
(21, '编辑用户行为', 19, 0, 'User/editaction', 0, '', '', 0, 1),
(22, '保存用户行为', 19, 0, 'User/saveAction', 0, '"用户->用户行为"保存编辑和新增的用户行为', '', 0, 1),
(23, '变更行为状态', 19, 0, 'User/setStatus', 0, '"用户->用户行为"中的启用,禁用和删除权限', '', 0, 1),
(24, '禁用会员', 19, 0, 'User/changeStatus?method=forbidUser', 0, '"用户->用户信息"中的禁用', '', 0, 1),
(25, '启用会员', 19, 0, 'User/changeStatus?method=resumeUser', 0, '"用户->用户信息"中的启用', '', 0, 1),
(26, '删除会员', 19, 0, 'User/changeStatus?method=deleteUser', 0, '"用户->用户信息"中的删除', '', 0, 1),
(27, '权限管理', 16, 0, 'AuthManager/index', 0, '', '用户管理', 0, 1),
(28, '删除', 27, 0, 'AuthManager/changeStatus?method=deleteGroup', 0, '删除用户组', '', 0, 1),
(29, '禁用', 27, 0, 'AuthManager/changeStatus?method=forbidGroup', 0, '禁用用户组', '', 0, 1),
(30, '恢复', 27, 0, 'AuthManager/changeStatus?method=resumeGroup', 0, '恢复已禁用的用户组', '', 0, 1),
(31, '新增', 27, 0, 'AuthManager/createGroup', 0, '创建新的用户组', '', 0, 1),
(32, '编辑', 27, 0, 'AuthManager/editGroup', 0, '编辑用户组名称和描述', '', 0, 1),
(33, '保存用户组', 27, 0, 'AuthManager/writeGroup', 0, '新增和编辑用户组的"保存"按钮', '', 0, 1),
(34, '授权', 27, 0, 'AuthManager/group', 0, '"后台 \\ 用户 \\ 用户信息"列表页的"授权"操作按钮,用于设置用户所属用户组', '', 0, 1),
(35, '访问授权', 27, 0, 'AuthManager/access', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"访问授权"操作按钮', '', 0, 1),
(36, '成员授权', 27, 0, 'AuthManager/user', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"成员授权"操作按钮', '', 0, 1),
(37, '解除授权', 27, 0, 'AuthManager/removeFromGroup', 0, '"成员授权"列表页内的解除授权操作按钮', '', 0, 1),
(38, '保存成员授权', 27, 0, 'AuthManager/addToGroup', 0, '"用户信息"列表页"授权"时的"保存"按钮和"成员授权"里右上角的"添加"按钮)', '', 0, 1),
(39, '分类授权', 27, 0, 'AuthManager/category', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"分类授权"操作按钮', '', 0, 1),
(40, '保存分类授权', 27, 0, 'AuthManager/addToCategory', 0, '"分类授权"页面的"保存"按钮', '', 0, 1),
(41, '模型授权', 27, 0, 'AuthManager/modelauth', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"模型授权"操作按钮', '', 0, 1),
(42, '保存模型授权', 27, 0, 'AuthManager/addToModel', 0, '"分类授权"页面的"保存"按钮', '', 0, 1),
(43, '扩展', 0, 7, 'Addons/index', 0, '', '', 0, 1),
(44, '插件管理', 43, 1, 'Addons/index', 0, '', '扩展', 0, 1),
(45, '创建', 44, 0, 'Addons/create', 0, '服务器上创建插件结构向导', '', 0, 1),
(46, '检测创建', 44, 0, 'Addons/checkForm', 0, '检测插件是否可以创建', '', 0, 1),
(47, '预览', 44, 0, 'Addons/preview', 0, '预览插件定义类文件', '', 0, 1),
(48, '快速生成插件', 44, 0, 'Addons/build', 0, '开始生成插件结构', '', 0, 1),
(49, '设置', 44, 0, 'Addons/config', 0, '设置插件配置', '', 0, 1),
(50, '禁用', 44, 0, 'Addons/disable', 0, '禁用插件', '', 0, 1),
(51, '启用', 44, 0, 'Addons/enable', 0, '启用插件', '', 0, 1),
(52, '安装', 44, 0, 'Addons/install', 0, '安装插件', '', 0, 1),
(53, '卸载', 44, 0, 'Addons/uninstall', 0, '卸载插件', '', 0, 1),
(54, '更新配置', 44, 0, 'Addons/saveconfig', 0, '更新插件配置处理', '', 0, 1),
(55, '插件后台列表', 44, 0, 'Addons/adminList', 0, '', '', 0, 1),
(56, 'URL方式访问插件', 44, 0, 'Addons/execute', 0, '控制是否有权限通过url访问插件控制器方法', '', 0, 1),
(57, '钩子管理', 43, 2, 'Addons/hooks', 0, '', '扩展', 0, 1),
(58, '模型管理', 68, 3, 'Model/index', 0, '', '系统设置', 0, 1),
(59, '新增', 58, 0, 'model/add', 0, '', '', 0, 1),
(60, '编辑', 58, 0, 'model/edit', 0, '', '', 0, 1),
(61, '改变状态', 58, 0, 'model/setStatus', 0, '', '', 0, 1),
(62, '保存数据', 58, 0, 'model/update', 0, '', '', 0, 1),
(63, '属性管理', 68, 0, 'Attribute/index', 1, '网站属性配置。', '', 0, 1),
(64, '新增', 63, 0, 'Attribute/add', 0, '', '', 0, 1),
(65, '编辑', 63, 0, 'Attribute/edit', 0, '', '', 0, 1),
(66, '改变状态', 63, 0, 'Attribute/setStatus', 0, '', '', 0, 1),
(67, '保存数据', 63, 0, 'Attribute/update', 0, '', '', 0, 1),
(68, '系统', 0, 4, 'Config/group', 0, '', '', 0, 1),
(69, '网站设置', 68, 1, 'Config/group', 0, '', '系统设置', 0, 1),
(70, '配置管理', 68, 4, 'Config/index', 0, '', '系统设置', 0, 1),
(71, '编辑', 70, 0, 'Config/edit', 0, '新增编辑和保存配置', '', 0, 1),
(72, '删除', 70, 0, 'Config/del', 0, '删除配置', '', 0, 1),
(73, '新增', 70, 0, 'Config/add', 0, '新增配置', '', 0, 1),
(74, '保存', 70, 0, 'Config/save', 0, '保存配置', '', 0, 1),
(75, '菜单管理', 68, 5, 'Menu/index', 0, '', '系统设置', 0, 1),
(76, '导航管理', 68, 6, 'Channel/index', 0, '', '系统设置', 0, 1),
(77, '新增', 76, 0, 'Channel/add', 0, '', '', 0, 1),
(78, '编辑', 76, 0, 'Channel/edit', 0, '', '', 0, 1),
(79, '删除', 76, 0, 'Channel/del', 0, '', '', 0, 1),
(80, '分类管理', 68, 2, 'Category/index', 0, '', '系统设置', 0, 1),
(81, '编辑', 80, 0, 'Category/edit', 0, '编辑和保存栏目分类', '', 0, 1),
(82, '新增', 80, 0, 'Category/add', 0, '新增栏目分类', '', 0, 1),
(83, '删除', 80, 0, 'Category/remove', 0, '删除栏目分类', '', 0, 1),
(84, '移动', 80, 0, 'Category/operate/type/move', 0, '移动栏目分类', '', 0, 1),
(85, '合并', 80, 0, 'Category/operate/type/merge', 0, '合并栏目分类', '', 0, 1),
(86, '备份数据库', 68, 0, 'Database/index?type=export', 0, '', '数据备份', 0, 1),
(87, '备份', 86, 0, 'Database/export', 0, '备份数据库', '', 0, 1),
(88, '优化表', 86, 0, 'Database/optimize', 0, '优化数据表', '', 0, 1),
(89, '修复表', 86, 0, 'Database/repair', 0, '修复数据表', '', 0, 1),
(90, '还原数据库', 68, 0, 'Database/index?type=import', 0, '', '数据备份', 0, 1),
(91, '恢复', 90, 0, 'Database/import', 0, '数据库恢复', '', 0, 1),
(92, '删除', 90, 0, 'Database/del', 0, '删除备份文件', '', 0, 1),
(93, '其他', 0, 5, 'other', 1, '', '', 0, 1),
(96, '新增', 75, 0, 'Menu/add', 0, '', '系统设置', 0, 1),
(98, '编辑', 75, 0, 'Menu/edit', 0, '', '', 0, 1),
(106, '行为日志', 16, 0, 'Action/actionlog', 0, '', '行为管理', 0, 1),
(108, '修改密码', 16, 0, 'User/updatePassword', 1, '', '', 0, 1),
(109, '修改昵称', 16, 0, 'User/updateNickname', 1, '', '', 0, 1),
(110, '查看行为日志', 106, 0, 'action/edit', 1, '', '', 0, 1),
(112, '新增数据', 58, 0, 'think/add', 1, '', '', 0, 1),
(113, '编辑数据', 58, 0, 'think/edit', 1, '', '', 0, 1),
(114, '导入', 75, 0, 'Menu/import', 0, '', '', 0, 1),
(115, '生成', 58, 0, 'Model/generate', 0, '', '', 0, 1),
(116, '新增钩子', 57, 0, 'Addons/addHook', 0, '', '', 0, 1),
(117, '编辑钩子', 57, 0, 'Addons/edithook', 0, '', '', 0, 1),
(118, '文档排序', 3, 0, 'Article/sort', 1, '', '', 0, 1),
(119, '排序', 70, 0, 'Config/sort', 1, '', '', 0, 1),
(120, '排序', 75, 0, 'Menu/sort', 1, '', '', 0, 1),
(121, '排序', 76, 0, 'Channel/sort', 1, '', '', 0, 1),
(122, '数据列表', 58, 0, 'think/lists', 1, '', '', 0, 1),
(123, '审核列表', 3, 0, 'Article/examine', 1, '', '', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ot_model`
--

CREATE TABLE IF NOT EXISTS `ot_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text COMMENT '属性列表（表的字段）',
  `attribute_alias` varchar(255) NOT NULL DEFAULT '' COMMENT '属性别名定义',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='文档模型表' AUTO_INCREMENT=9 ;

--
-- Dumping data for table `ot_model`
--

INSERT INTO `ot_model` (`id`, `name`, `title`, `extend`, `relation`, `need_pk`, `field_sort`, `field_group`, `attribute_list`, `attribute_alias`, `template_list`, `template_add`, `template_edit`, `list_grid`, `list_row`, `search_key`, `search_list`, `create_time`, `update_time`, `status`, `engine_type`) VALUES
(1, 'document', '基础文档', 0, '', 1, '{"1":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', 0, '', '', 1383891233, 1384507827, 1, 'MyISAM'),
(2, 'article', '文章', 1, '', 1, '{"1":["3","24","2","5"],"2":["9","13","19","10","12","16","17","26","20","14","11","25"]}', '1:基础,2:扩展', '', '', '', '', '', '', 0, '', '', 1383891243, 1387260622, 1, 'MyISAM'),
(3, 'download', '下载', 1, '', 1, '{"1":["3","28","30","32","2","5","31"],"2":["13","10","27","9","12","16","17","19","11","20","14","29"]}', '1:基础,2:扩展', '', '', '', '', '', '', 0, '', '', 1383891252, 1387260449, 1, 'MyISAM');

-- --------------------------------------------------------

--
-- Table structure for table `ot_picture`
--

CREATE TABLE IF NOT EXISTS `ot_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ot_reader`
--

CREATE TABLE IF NOT EXISTS `ot_reader` (
  `user_id` int(10) unsigned NOT NULL,
  `mobile` char(11) DEFAULT '',
  `sex` tinyint(4) DEFAULT '1',
  `college` varchar(20) DEFAULT '',
  `major` varchar(20) DEFAULT '',
  `name` varchar(10) NOT NULL,
  `current_borrow` smallint(5) unsigned NOT NULL COMMENT '当前借阅',
  `total_borrow` smallint(5) unsigned NOT NULL COMMENT '累计借阅',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ot_reader`
--

INSERT INTO `ot_reader` (`user_id`, `mobile`, `sex`, `college`, `major`, `name`, `current_borrow`, `total_borrow`) VALUES
(1, '15957190991', 1, '计算机', '计算机科学与技术', '沈伟臣', 2, 24),
(2, '15957191396', 0, '计算机', '计算机科学与技术', '滕越', 0, 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `ot_reader_view`
--
CREATE TABLE IF NOT EXISTS `ot_reader_view` (
`user_id` int(10) unsigned
,`nickname` char(16)
,`name` varchar(10)
,`reg_time` int(10) unsigned
,`last_login_time` int(10) unsigned
,`mobile` char(11)
,`sex` tinyint(4)
,`college` varchar(20)
,`major` varchar(20)
,`current_borrow` smallint(5) unsigned
,`total_borrow` smallint(5) unsigned
);
-- --------------------------------------------------------

--
-- Table structure for table `ot_recommend`
--

CREATE TABLE IF NOT EXISTS `ot_recommend` (
  `isbn_id` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`isbn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ot_recommend`
--

INSERT INTO `ot_recommend` (`isbn_id`) VALUES
(0),
(1),
(2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `ot_recommend_view`
--
CREATE TABLE IF NOT EXISTS `ot_recommend_view` (
`isbn` varchar(17)
,`book_name` varchar(40)
,`img` varchar(255)
,`avg_score` decimal(2,1)
);
-- --------------------------------------------------------

--
-- Table structure for table `ot_score`
--

CREATE TABLE IF NOT EXISTS `ot_score` (
  `isbn_id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(10) unsigned NOT NULL DEFAULT '0',
  `value` smallint(5) unsigned DEFAULT '0',
  PRIMARY KEY (`isbn_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ot_score`
--

INSERT INTO `ot_score` (`isbn_id`, `user_id`, `value`) VALUES
(1, 1, 3),
(2, 1, 3),
(3, 1, 3),
(6, 1, 5);

--
-- Triggers `ot_score`
--
DROP TRIGGER IF EXISTS `insert_score`;
DELIMITER //
CREATE TRIGGER `insert_score` AFTER INSERT ON `ot_score`
 FOR EACH ROW update ot_book set avg_score=(select sum(value) from ot_score where isbn_id=new.isbn_id)/(select count(*)from ot_score where isbn_id=new.isbn_id) where isbn_id=new.isbn_id
//
DELIMITER ;
DROP TRIGGER IF EXISTS `update_score`;
DELIMITER //
CREATE TRIGGER `update_score` AFTER UPDATE ON `ot_score`
 FOR EACH ROW update ot_book set avg_score=(select sum(value) from ot_score where isbn_id=old.isbn_id)/(select count(*)from ot_score where isbn_id=old.isbn_id) where isbn_id=old.isbn_id
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ot_ucenter_admin`
--

CREATE TABLE IF NOT EXISTS `ot_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ot_ucenter_app`
--

CREATE TABLE IF NOT EXISTS `ot_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL DEFAULT '' COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL DEFAULT '' COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ot_ucenter_member`
--

CREATE TABLE IF NOT EXISTS `ot_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL DEFAULT '' COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户表' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ot_ucenter_member`
--

INSERT INTO `ot_ucenter_member` (`id`, `username`, `password`, `email`, `mobile`, `reg_time`, `reg_ip`, `last_login_time`, `last_login_ip`, `update_time`, `status`) VALUES
(1, 'admin', 'ab51f9d10187832ceb782655beae0eb3', '519589356@qq.com', '', 1460863718, 0, 1462678898, 0, 1460863718, 1),
(2, 'swc', '7c315f84bad9c7faf8f4120224ecf36d', 'last.fantasy@qq.com', '', 1460986386, 0, 1462611453, 0, 1460986386, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ot_ucenter_setting`
--

CREATE TABLE IF NOT EXISTS `ot_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ot_url`
--

CREATE TABLE IF NOT EXISTS `ot_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ot_userdata`
--

CREATE TABLE IF NOT EXISTS `ot_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure for view `ot_bookinfo_view`
--
DROP TABLE IF EXISTS `ot_bookinfo_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ot_bookinfo_view` AS select `ot_book`.`callnum` AS `callnum`,`ot_bookid_isbn`.`book_id` AS `book_id`,`ot_bookid_isbn`.`collection` AS `collection`,`ot_bookid_isbn`.`state` AS `state`,`ot_bookid_isbn`.`ISBN` AS `ISBN`,`ot_borrow`.`back_time` AS `back_time`,`ot_book`.`img` AS `img` from ((`ot_bookid_isbn` left join `ot_borrow` on((`ot_bookid_isbn`.`book_id` = `ot_borrow`.`book_id`))) join `ot_book`) where (`ot_bookid_isbn`.`ISBN` = `ot_book`.`ISBN`);

-- --------------------------------------------------------

--
-- Structure for view `ot_borrowrank_view`
--
DROP TABLE IF EXISTS `ot_borrowrank_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ot_borrowrank_view` AS select `ot_book`.`book_name` AS `book_name`,`ot_borrow_history`.`ISBN` AS `ISBN`,count(`ot_borrow_history`.`ISBN`) AS `rank`,`ot_book`.`img` AS `img` from (`ot_borrow_history` join `ot_book`) where (`ot_borrow_history`.`ISBN` = `ot_book`.`ISBN`) group by `ot_borrow_history`.`ISBN`,`ot_borrow_history`.`ISBN`;

-- --------------------------------------------------------

--
-- Structure for view `ot_collection_view`
--
DROP TABLE IF EXISTS `ot_collection_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ot_collection_view` AS select `ot_collection`.`user_id` AS `user_id`,`ot_collection`.`ISBN` AS `ISBN`,`ot_book`.`book_name` AS `book_name`,`ot_book`.`author` AS `author`,`ot_book`.`pub` AS `pub`,`ot_book`.`pub_date` AS `pub_date`,`ot_book`.`callnum` AS `callnum`,`ot_book`.`img` AS `img` from (`ot_collection` join `ot_book` on((`ot_collection`.`ISBN` = `ot_book`.`ISBN`)));

-- --------------------------------------------------------

--
-- Structure for view `ot_reader_view`
--
DROP TABLE IF EXISTS `ot_reader_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ot_reader_view` AS select `ot_member`.`uid` AS `user_id`,`ot_member`.`nickname` AS `nickname`,`ot_reader`.`name` AS `name`,`ot_member`.`reg_time` AS `reg_time`,`ot_member`.`last_login_time` AS `last_login_time`,`ot_reader`.`mobile` AS `mobile`,`ot_reader`.`sex` AS `sex`,`ot_reader`.`college` AS `college`,`ot_reader`.`major` AS `major`,`ot_reader`.`current_borrow` AS `current_borrow`,`ot_reader`.`total_borrow` AS `total_borrow` from (`ot_member` left join `ot_reader` on((`ot_member`.`uid` = `ot_reader`.`user_id`)));

-- --------------------------------------------------------

--
-- Structure for view `ot_recommend_view`
--
DROP TABLE IF EXISTS `ot_recommend_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ot_recommend_view` AS select `ot_book`.`ISBN` AS `isbn`,`ot_book`.`book_name` AS `book_name`,`ot_book`.`img` AS `img`,`ot_book`.`avg_score` AS `avg_score` from (`ot_recommend` join `ot_book` on((`ot_recommend`.`isbn_id` = `ot_book`.`isbn_id`)));

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ot_bookid_isbn`
--
ALTER TABLE `ot_bookid_isbn`
  ADD CONSTRAINT `ISBN` FOREIGN KEY (`ISBN`) REFERENCES `ot_book` (`ISBN`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
