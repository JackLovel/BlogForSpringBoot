/*
Navicat MySQL Data Transfer

Source Server         : demo
Source Server Version : 80001
Source Host           : localhost:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 80001
File Encoding         : 65001

Date: 2020-02-05 14:13:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for hibernate_sequence
-- ----------------------------
DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of hibernate_sequence
-- ----------------------------
INSERT INTO `hibernate_sequence` VALUES ('11');
INSERT INTO `hibernate_sequence` VALUES ('11');

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appreciation` bit(1) NOT NULL,
  `commentabled` bit(1) NOT NULL,
  `content` longtext CHARACTER SET utf8,
  `create_time` datetime(6) DEFAULT NULL,
  `first_picture` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `flag` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `published` bit(1) NOT NULL,
  `recommend` bit(1) NOT NULL,
  `share_statement` bit(1) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `views` int(11) DEFAULT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK292449gwg5yf7ocdlmswv9w4j` (`type_id`),
  KEY `FK8ky5rrsxh01nkhctmo7d48p82` (`user_id`),
  CONSTRAINT `FK292449gwg5yf7ocdlmswv9w4j` FOREIGN KEY (`type_id`) REFERENCES `t_type` (`id`),
  CONSTRAINT `FK8ky5rrsxh01nkhctmo7d48p82` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES ('2', '', '', 'ssssssssssssssssss', '2020-02-02 06:42:43.238000', 'https://dss0.baidu.com/73x1bjeh1BF3odCf/it/u=915195712,2959754453&fm=85&s=FE0FA044C00423769AD73B800300E08C', '', '', '', '', 's', '2020-02-02 06:42:43.238000', '1', '1', '1', null);
INSERT INTO `t_blog` VALUES ('3', '', '', 'ssssssssssssssssssssssssssssssssssssssssssssssssssssss', '2020-02-02 06:57:41.407000', 'https://dss0.baidu.com/73x1bjeh1BF3odCf/it/u=915195712,2959754453&fm=85&s=FE0FA044C00423769AD73B800300E08C', '', '', '', '', 'sssssssssssk', '2020-02-02 06:57:41.407000', '0', '1', '1', null);
INSERT INTO `t_blog` VALUES ('4', '', '', '##kkk', '2020-02-02 06:58:25.670000', 'https://dss0.baidu.com/73x1bjeh1BF3odCf/it/u=915195712,2959754453&fm=85&s=FE0FA044C00423769AD73B800300E08C', '原创', '', '', '', 'doyou', '2020-02-03 07:41:48.334000', '1', '1', '1', 'ssssssssssssssss');
INSERT INTO `t_blog` VALUES ('5', '', '', '## Markdown 结果测试', '2020-02-03 08:29:51.467000', 'https://dss0.baidu.com/73x1bjeh1BF3odCf/it/u=915195712,2959754453&fm=85&s=FE0FA044C00423769AD73B800300E08C', '原创', '', '', '', 'Markdown 测试', '2020-02-03 08:30:27.007000', '4', '1', '1', 'Markdown 结果进行测试');

-- ----------------------------
-- Table structure for t_blog_tags
-- ----------------------------
DROP TABLE IF EXISTS `t_blog_tags`;
CREATE TABLE `t_blog_tags` (
  `blogs_id` bigint(20) NOT NULL,
  `tags_id` bigint(20) NOT NULL,
  KEY `FK5feau0gb4lq47fdb03uboswm8` (`tags_id`),
  KEY `FKh4pacwjwofrugxa9hpwaxg6mr` (`blogs_id`),
  CONSTRAINT `FK5feau0gb4lq47fdb03uboswm8` FOREIGN KEY (`tags_id`) REFERENCES `t_tag` (`id`),
  CONSTRAINT `FKh4pacwjwofrugxa9hpwaxg6mr` FOREIGN KEY (`blogs_id`) REFERENCES `t_blog` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_blog_tags
-- ----------------------------
INSERT INTO `t_blog_tags` VALUES ('2', '1');
INSERT INTO `t_blog_tags` VALUES ('3', '1');
INSERT INTO `t_blog_tags` VALUES ('4', '1');
INSERT INTO `t_blog_tags` VALUES ('5', '1');

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` bigint(20) NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `parent_comment_id` bigint(20) DEFAULT NULL,
  `admin_comment` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKke3uogd04j4jx316m1p51e05u` (`blog_id`),
  KEY `FK4jj284r3pb7japogvo6h72q95` (`parent_comment_id`),
  CONSTRAINT `FK4jj284r3pb7japogvo6h72q95` FOREIGN KEY (`parent_comment_id`) REFERENCES `t_comment` (`id`),
  CONSTRAINT `FKke3uogd04j4jx316m1p51e05u` FOREIGN KEY (`blog_id`) REFERENCES `t_blog` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES ('1', '/images/avatar.png', 'hahah', '2020-02-04 03:29:56.438000', '22@qq.com', 'wocao', '5', null, '\0');
INSERT INTO `t_comment` VALUES ('2', '/images/avatar.png', 'wocao', '2020-02-04 03:30:49.908000', 'wocao@qq.com', 'wocao', '4', null, '\0');
INSERT INTO `t_comment` VALUES ('3', '/images/avatar.png', 'haha', '2020-02-04 03:31:03.941000', 'wocao@qq.com', 'wocao', '4', null, '\0');
INSERT INTO `t_comment` VALUES ('4', '/images/avatar.png', '小白', '2020-02-04 03:35:21.133000', 'wocao@qq.com', '小白', '5', null, '\0');
INSERT INTO `t_comment` VALUES ('5', '/images/avatar.png', '小白', '2020-02-04 03:42:51.917000', '2@163.com', '2222222222', '5', null, '\0');
INSERT INTO `t_comment` VALUES ('6', '/images/avatar.png', '小白', '2020-02-04 03:45:55.463000', 'ali@qq.com', '小白', '5', null, '\0');
INSERT INTO `t_comment` VALUES ('7', '/images/avatar.png', '这是一个@小白的一评论', '2020-02-04 03:58:03.439000', 'xh@qq.com', '小红', '5', '6', '\0');
INSERT INTO `t_comment` VALUES ('8', '/images/avatar.png', 'hahah', '2020-02-04 04:10:01.922000', 'xlu@163.com', '小绿', '5', null, '\0');
INSERT INTO `t_comment` VALUES ('9', '/images/avatar.png', '小绿你好', '2020-02-04 05:29:56.181000', 'b@qq.com', '小黑', '5', '8', '');
INSERT INTO `t_comment` VALUES ('10', 'https://unsplash.it/100/100?image=1005', '这是 gog 的个人评论', '2020-02-04 09:29:24.935000', 'gog@qq.com', 'gog', '5', null, '');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES ('1', 'Js');
INSERT INTO `t_tag` VALUES ('2', 'ss');

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO `t_type` VALUES ('1', 'Java');
INSERT INTO `t_type` VALUES ('2', '2');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'https://unsplash.it/100/100?image=1005', '2020-02-02 13:46:56.000000', 'gog@qq.com', 'gog', '68f96eefa7b34346670149f370c7af5a', '1', '2020-02-02 13:56:37.000000', 'gog');
