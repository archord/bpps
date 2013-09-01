/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50516
Source Host           : localhost:3306
Source Database       : hgbh

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2012-07-16 17:01:06
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `disease`
-- ----------------------------
DROP TABLE IF EXISTS `disease`;
CREATE TABLE `disease` (
  `dis_id` int(11) NOT NULL AUTO_INCREMENT,
  `dis_name` varchar(100) DEFAULT NULL,
  `dis_name_en` varchar(100) DEFAULT NULL,
  `dis_introduction` varchar(1000) DEFAULT NULL,
  `dis_content` text,
  PRIMARY KEY (`dis_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `picture`
-- ----------------------------
DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture` (
  `pic_id` int(11) NOT NULL AUTO_INCREMENT,
  `pos_id` int(11) DEFAULT NULL,
  `dis_id` int(11) DEFAULT NULL,
  `pic_path` varchar(100) NOT NULL,
  PRIMARY KEY (`pic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of picture
-- ----------------------------

-- ----------------------------
-- Table structure for `position`
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
  `pos_id` int(11) NOT NULL AUTO_INCREMENT,
  `pos_name` varchar(40) DEFAULT NULL,
  `pos_describe` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`pos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `position_disease`
-- ----------------------------
DROP TABLE IF EXISTS `position_disease`;
CREATE TABLE `position_disease` (
  `pos_dis_id` int(11) NOT NULL AUTO_INCREMENT,
  `pos_id` int(11) NOT NULL,
  `dis_id` int(11) NOT NULL,
  `pos_dis_flag` int(10) unsigned zerofill NOT NULL,
  PRIMARY KEY (`pos_dis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of position_disease
-- ----------------------------

-- ----------------------------
-- Table structure for `position_symptom`
-- ----------------------------
DROP TABLE IF EXISTS `position_symptom`;
CREATE TABLE `position_symptom` (
  `pos_sym_id` int(11) NOT NULL AUTO_INCREMENT,
  `pos_id` int(11) NOT NULL,
  `sym_id` int(11) NOT NULL,
  PRIMARY KEY (`pos_sym_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of position_symptom
-- ----------------------------

-- ----------------------------
-- Table structure for `symptom`
-- ----------------------------
DROP TABLE IF EXISTS `symptom`;
CREATE TABLE `symptom` (
  `sym_id` int(11) NOT NULL AUTO_INCREMENT,
  `pos_id` int(11) NOT NULL,
  `sym_name` varchar(40) DEFAULT NULL,
  `sym_property` int(11) DEFAULT NULL,
  PRIMARY KEY (`sym_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `symptom_disease`
-- ----------------------------
DROP TABLE IF EXISTS `symptom_disease`;
CREATE TABLE `symptom_disease` (
  `sym_dis_id` int(11) NOT NULL AUTO_INCREMENT,
  `sym_id` int(11) NOT NULL,
  `dis_id` int(11) NOT NULL,
  `sym_dis_discribe` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`sym_dis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of symptom_disease
-- ----------------------------
