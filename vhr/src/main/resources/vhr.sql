/*
 Navicat Premium Data Transfer

 Source Server         : docker01
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : 121.37.185.192:3306
 Source Schema         : vhr

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 14/07/2021 16:58:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for adjust_salary
-- ----------------------------
DROP TABLE IF EXISTS `adjust_salary`;
CREATE TABLE `adjust_salary`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `eid` int(0) NULL DEFAULT NULL,
  `asDate` date NULL DEFAULT NULL COMMENT '调薪日期',
  `beforeSalary` int(0) NULL DEFAULT NULL COMMENT '调前薪资',
  `afterSalary` int(0) NULL DEFAULT NULL COMMENT '调后薪资',
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调薪原因',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `adjust_salary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of adjust_salary
-- ----------------------------

-- ----------------------------
-- Table structure for appraise
-- ----------------------------
DROP TABLE IF EXISTS `appraise`;
CREATE TABLE `appraise`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `eid` int(0) NULL DEFAULT NULL,
  `appDate` date NULL DEFAULT NULL COMMENT '考评日期',
  `appResult` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考评结果',
  `appContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考评内容',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `appraise_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appraise
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `parent_id` int(0) NULL DEFAULT NULL COMMENT '父部门',
  `dep_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门层级',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `is_parent` tinyint(1) NULL DEFAULT 0 COMMENT '是否是父部门，即下面是否有子部门',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '股东会', -1, '.1', 1, 1);
INSERT INTO `department` VALUES (4, '董事会', 1, '.1.4', 1, 1);
INSERT INTO `department` VALUES (5, '总办', 4, '.1.4.5', 1, 1);
INSERT INTO `department` VALUES (8, '财务部', 5, '.1.4.5.8', 1, 0);
INSERT INTO `department` VALUES (78, '市场部', 5, '.1.4.5.78', 1, 1);
INSERT INTO `department` VALUES (81, '华北市场部', 78, '.1.4.5.78.81', 1, 1);
INSERT INTO `department` VALUES (82, '华南市场部', 78, '.1.4.5.78.82', 1, 0);
INSERT INTO `department` VALUES (85, '石家庄市场部', 81, '.1.4.5.78.81.85', 1, 0);
INSERT INTO `department` VALUES (86, '西北市场部', 78, '.1.4.5.78.86', 1, 1);
INSERT INTO `department` VALUES (87, '西安市场', 86, '.1.4.5.78.86.87', 1, 1);
INSERT INTO `department` VALUES (89, '莲湖区市场', 87, '.1.4.5.78.86.87.89', 1, 0);
INSERT INTO `department` VALUES (91, '技术部', 5, '.1.4.5.91', 1, 0);
INSERT INTO `department` VALUES (92, '运维部', 5, '.1.4.5.92', 1, 1);
INSERT INTO `department` VALUES (93, '运维1部', 92, '.1.4.5.92.93', 1, 0);
INSERT INTO `department` VALUES (94, '运维2部', 92, '.1.4.5.92.94', 1, 0);
INSERT INTO `department` VALUES (96, 'bbb', 1, '.1.96', 1, 1);
INSERT INTO `department` VALUES (104, '111', 96, '.1.96.104', 1, 0);

-- ----------------------------
-- Table structure for emp_salary
-- ----------------------------
DROP TABLE IF EXISTS `emp_salary`;
CREATE TABLE `emp_salary`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `eid` int(0) NULL DEFAULT NULL,
  `sid` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `eid`(`eid`) USING BTREE,
  INDEX `empsalary_ibfk_2`(`sid`) USING BTREE,
  CONSTRAINT `emp_salary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `emp_salary_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `salary` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工薪资关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emp_salary
-- ----------------------------
INSERT INTO `emp_salary` VALUES (6, 4, 10);
INSERT INTO `emp_salary` VALUES (10, 5, 9);
INSERT INTO `emp_salary` VALUES (11, 6, 13);
INSERT INTO `emp_salary` VALUES (12, 7, 13);
INSERT INTO `emp_salary` VALUES (14, 8, 10);
INSERT INTO `emp_salary` VALUES (15, 9, 10);
INSERT INTO `emp_salary` VALUES (20, 10, 13);
INSERT INTO `emp_salary` VALUES (21, 11, 9);
INSERT INTO `emp_salary` VALUES (22, 3, 13);
INSERT INTO `emp_salary` VALUES (24, 2, 9);
INSERT INTO `emp_salary` VALUES (25, 1, 13);
INSERT INTO `emp_salary` VALUES (26, 33, 10);
INSERT INTO `emp_salary` VALUES (28, 34, 9);
INSERT INTO `emp_salary` VALUES (29, 44, 10);
INSERT INTO `emp_salary` VALUES (30, 45, 10);
INSERT INTO `emp_salary` VALUES (31, 43, 10);
INSERT INTO `emp_salary` VALUES (32, 47, 10);
INSERT INTO `emp_salary` VALUES (33, 52, 13);
INSERT INTO `emp_salary` VALUES (34, 53, 10);
INSERT INTO `emp_salary` VALUES (35, 54, 10);
INSERT INTO `emp_salary` VALUES (36, 56, 10);
INSERT INTO `emp_salary` VALUES (38, 21, 9);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `gender` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `id_card` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `wedlock` enum('已婚','未婚','离异') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `nation_id` int(0) NULL DEFAULT NULL COMMENT '民族',
  `native_place` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '籍贯',
  `politic_id` int(0) NULL DEFAULT NULL COMMENT '政治面貌',
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `department_id` int(0) NULL DEFAULT NULL COMMENT '所属部门',
  `job_level_id` int(0) NULL DEFAULT NULL COMMENT '职称ID',
  `pos_id` int(0) NULL DEFAULT NULL COMMENT '职位ID',
  `engage_form` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '聘用形式',
  `tiptop_degree` enum('博士','硕士','本科','大专','高中','初中','小学','其他') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最高学历',
  `specialty` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属专业',
  `school` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业院校',
  `begin_date` date NULL DEFAULT NULL COMMENT '入职日期',
  `work_state` enum('在职','离职') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '在职' COMMENT '在职状态',
  `work_id` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号',
  `contract_term` double NULL DEFAULT NULL COMMENT '合同期限',
  `conversion_time` date NULL DEFAULT NULL COMMENT '转正日期',
  `not_work_date` date NULL DEFAULT NULL COMMENT '离职日期',
  `begin_contract` date NULL DEFAULT NULL COMMENT '合同起始日期',
  `end_contract` date NULL DEFAULT NULL COMMENT '合同终止日期',
  `work_age` int(0) NULL DEFAULT NULL COMMENT '工龄',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `departmentId`(`department_id`) USING BTREE,
  INDEX `jobId`(`job_level_id`) USING BTREE,
  INDEX `dutyId`(`pos_id`) USING BTREE,
  INDEX `nationId`(`nation_id`) USING BTREE,
  INDEX `politicId`(`politic_id`) USING BTREE,
  INDEX `workID_key`(`work_id`) USING BTREE,
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`job_level_id`) REFERENCES `job_level` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`pos_id`) REFERENCES `position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_4` FOREIGN KEY (`nation_id`) REFERENCES `nation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_5` FOREIGN KEY (`politic_id`) REFERENCES `politics_status` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1942 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 2, '2018-04-01', NULL, '2018-01-01', '2020-01-01', NULL);
INSERT INTO `employee` VALUES (2, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 91, 12, 29, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (3, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (4, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (5, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '硕士', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (6, '云星', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000006', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (7, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (8, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (9, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (10, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (11, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (12, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (13, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (14, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (15, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (16, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (17, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (18, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (19, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (20, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (21, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (22, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (24, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (25, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (26, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (27, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (28, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (29, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (31, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (32, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (33, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (34, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (35, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (36, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (37, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (38, '张黎明2', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000038', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (39, '薛磊4', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000039', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (40, '张洁4', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000040', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (41, '江南一点雨5', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000041', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (42, '陈静5', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000042', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (43, '赵琳浩5', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000043', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (44, '鹿存亮5', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000044', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (45, '姚森5', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000045', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (46, '云星5', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000046', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (47, '贾旭明5', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000047', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (48, '张黎明5', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000048', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (49, '薛磊5', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000049', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (50, '张洁5', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000050', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (51, '江南一点雨6', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000051', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (52, '陈静6', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000052', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (53, '赵琳浩6', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000053', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (54, '鹿存亮6', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000054', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (55, '姚森6', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000055', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (56, '云星6', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000056', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1351, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1352, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1353, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1354, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1355, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1357, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1358, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1359, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1360, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1361, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1362, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1363, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1364, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1365, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1366, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1367, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1368, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1369, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1370, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1371, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1372, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1373, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1374, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1375, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1376, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1377, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1378, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1379, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1380, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1381, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1382, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1383, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1384, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1385, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1411, '谢工', '女', '1970-01-01', '618177197001011234', '离异', 1, '江苏', 1, '584991843@qq.com', '18558887788', '北京', 91, 12, 29, '劳动合同', '本科', '计算机软件', '南华大学', '2018-01-01', '在职', '00000038', 5, '2019-01-01', NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1412, '林昭亮', '男', '1990-01-01', '610122199809091234', '已婚', 1, '广东', 13, '584991843@qq.com', '16767776654', '广东深圳', 91, 15, 33, '劳动合同', '大专', '计算机软件', '广东职业技术学院', '2018-01-01', '在职', '00000039', 5, '2018-04-01', NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1413, '11', '男', '2018-01-01', '610122201801011234', '已婚', 1, '1', 1, '584991843@qq.com', '111', '1', 89, 9, 29, '劳动合同', '本科', '1', '1', '2018-01-01', '在职', '00000040', 4, '2018-04-01', NULL, '2018-01-01', '2022-01-26', NULL);
INSERT INTO `employee` VALUES (1414, '1', '男', '2018-01-01', '610188199809091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 89, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000041', 1, '2018-01-31', NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1415, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000042', 1, '2018-01-31', NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1416, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 81, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000043', 0, '2018-01-31', NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1417, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 87, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000044', 0, '2018-01-01', NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1418, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000045', 0, '2018-01-01', NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1419, '林伯渠', '男', '2018-01-01', '610122199909099999', '未婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000046', 0, '2018-01-31', NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1420, '1', '男', '2018-01-01', '610122199909091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000047', 0, '2018-01-31', NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1421, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 2, NULL, NULL, '2018-01-01', '2020-01-01', NULL);
INSERT INTO `employee` VALUES (1422, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 8, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1423, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1424, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1425, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '硕士', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1426, '云星', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000006', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1427, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1428, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1429, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1430, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1431, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1432, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1433, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1434, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1435, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1436, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1437, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1438, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1439, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1440, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1441, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1442, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1443, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1444, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1445, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1446, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1447, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1448, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1449, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1450, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1451, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1452, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1453, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1454, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1455, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1456, '张黎明2', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000038', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1457, '薛磊4', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000039', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1458, '张洁4', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000040', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1459, '江南一点雨5', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000041', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1460, '陈静5', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000042', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1461, '赵琳浩5', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000043', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1462, '鹿存亮5', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000044', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1463, '姚森5', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000045', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1464, '云星5', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000046', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1465, '贾旭明5', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000047', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1466, '张黎明5', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000048', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1467, '薛磊5', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000049', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1468, '张洁5', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000050', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1469, '江南一点雨6', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000051', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1470, '陈静6', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000052', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1471, '赵琳浩6', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000053', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1472, '鹿存亮6', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000054', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1473, '姚森6', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000055', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1474, '云星6', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000056', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1475, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1476, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1477, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1478, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1479, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1480, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1481, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1482, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1483, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1484, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1485, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1486, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1487, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1488, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1489, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1490, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1491, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1492, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1493, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1494, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1495, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1496, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1497, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1498, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1499, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1500, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1501, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1502, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1503, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1504, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1505, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1506, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1507, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1508, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1509, '谢工', '女', '1970-01-01', '618177197001011234', '离异', 1, '江苏', 1, '584991843@qq.com', '18558887788', '北京', 91, 12, 29, '劳动合同', '本科', '计算机软件', '南华大学', '2018-01-01', '在职', '00000038', 5, NULL, NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1510, '林昭亮', '男', '1990-01-01', '610122199809091234', '已婚', 1, '广东', 13, '584991843@qq.com', '16767776654', '广东深圳', 91, 15, 33, '劳动合同', '大专', '计算机软件', '广东职业技术学院', '2018-01-01', '在职', '00000039', 5, NULL, NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1511, '11', '男', '2018-01-01', '610122201801011234', '已婚', 1, '1', 1, '584991843@qq.com', '111', '1', 89, 9, 29, '劳动合同', '本科', '1', '1', '2018-01-01', '在职', '00000040', 4, NULL, NULL, '2018-01-01', '2022-01-26', NULL);
INSERT INTO `employee` VALUES (1512, '1', '男', '2018-01-01', '610188199809091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 89, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000041', 1, NULL, NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1513, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000042', 1, NULL, NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1514, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 81, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000043', 0, NULL, NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1515, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 87, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000044', 0, NULL, NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1516, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000045', 0, NULL, NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1517, '林伯渠', '男', '2018-01-01', '610122199909099999', '未婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000046', 0, NULL, NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1518, '1', '男', '2018-01-01', '610122199909091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000047', 0, NULL, NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1519, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000057', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1520, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 93, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2019-11-05', '在职', '00000058', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1521, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 93, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2019-11-05', '在职', '00000059', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1522, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowan@123.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000060', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1523, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowan@123.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000060', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1526, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000061', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1527, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000062', 6.17, '2018-03-31', NULL, '2017-12-31', '2024-02-29', NULL);
INSERT INTO `employee` VALUES (1528, 'javaboy666', '男', '2019-11-10', '610122199911111111', '已婚', 1, '广东', 13, '123@qq.com', '12345678901', '广东深圳', 78, 9, 29, '劳动合同', '本科', '信管', '深圳大学', '2019-11-10', '在职', '00000063', 3.25, '2020-02-10', NULL, '2019-11-10', '2023-02-22', NULL);
INSERT INTO `employee` VALUES (1529, 'javaboy666', '男', '2019-11-10', '610122199911111111', '已婚', 1, '广东', 13, '123@qq.com', '12345678901', '广东深圳', 78, 9, 29, '劳动合同', '本科', '信管', '深圳大学', '2019-11-10', '在职', '00000063', 3.25, '2020-02-10', NULL, '2019-11-10', '2023-02-22', NULL);
INSERT INTO `employee` VALUES (1530, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 2, '2018-04-01', NULL, '2018-01-01', '2020-01-01', NULL);
INSERT INTO `employee` VALUES (1531, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 91, 12, 29, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1532, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1533, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1534, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '硕士', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1535, '云星', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000006', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1536, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1537, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1538, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1539, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1540, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1541, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1542, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1543, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1544, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1545, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1546, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1547, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1548, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1549, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1550, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1551, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1552, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1553, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1554, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1555, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1556, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1557, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1558, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1559, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1560, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1561, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1562, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1563, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1564, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1565, '张黎明2', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000038', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1566, '薛磊4', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000039', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1567, '张洁4', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000040', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1568, '江南一点雨5', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000041', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1569, '陈静5', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000042', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1570, '赵琳浩5', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000043', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1571, '鹿存亮5', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000044', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1572, '姚森5', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000045', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1573, '云星5', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000046', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1574, '贾旭明5', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000047', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1575, '张黎明5', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000048', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1576, '薛磊5', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000049', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1577, '张洁5', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000050', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1578, '江南一点雨6', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000051', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1579, '陈静6', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000052', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1580, '赵琳浩6', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000053', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1581, '鹿存亮6', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000054', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1582, '姚森6', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000055', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1583, '云星6', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000056', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1584, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1585, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1586, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1587, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1588, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1589, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1590, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1591, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1592, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1593, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1594, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1595, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1596, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1597, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1598, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1599, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1600, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1601, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1602, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1603, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1604, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1605, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1606, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1607, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1608, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1609, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1610, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1611, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1612, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1613, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1614, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1615, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1616, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1617, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1618, '谢工', '女', '1970-01-01', '618177197001011234', '离异', 1, '江苏', 1, '584991843@qq.com', '18558887788', '北京', 91, 12, 29, '劳动合同', '本科', '计算机软件', '南华大学', '2018-01-01', '在职', '00000038', 5, '2019-01-01', NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1619, '林昭亮', '男', '1990-01-01', '610122199809091234', '已婚', 1, '广东', 13, '584991843@qq.com', '16767776654', '广东深圳', 91, 15, 33, '劳动合同', '大专', '计算机软件', '广东职业技术学院', '2018-01-01', '在职', '00000039', 5, '2018-04-01', NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1620, '11', '男', '2018-01-01', '610122201801011234', '已婚', 1, '1', 1, '584991843@qq.com', '111', '1', 89, 9, 29, '劳动合同', '本科', '1', '1', '2018-01-01', '在职', '00000040', 4, '2018-04-01', NULL, '2018-01-01', '2022-01-26', NULL);
INSERT INTO `employee` VALUES (1621, '1', '男', '2018-01-01', '610188199809091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 89, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000041', 1, '2018-01-31', NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1622, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000042', 1, '2018-01-31', NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1623, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 81, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000043', 0, '2018-01-31', NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1624, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 87, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000044', 0, '2018-01-01', NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1625, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000045', 0, '2018-01-01', NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1626, '林伯渠', '男', '2018-01-01', '610122199909099999', '未婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000046', 0, '2018-01-31', NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1627, '1', '男', '2018-01-01', '610122199909091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000047', 0, '2018-01-31', NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1628, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 2, NULL, NULL, '2018-01-01', '2020-01-01', NULL);
INSERT INTO `employee` VALUES (1629, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 8, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1630, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1631, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1632, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '硕士', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1633, '云星', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000006', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1634, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1635, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1636, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1637, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1638, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1639, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1640, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1641, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1642, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1643, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1644, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1645, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1646, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1647, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1648, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1649, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1650, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1651, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1652, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1653, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1654, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1655, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1656, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1657, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1658, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1659, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1660, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1661, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1662, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1663, '张黎明2', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000038', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1664, '薛磊4', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000039', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1665, '张洁4', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000040', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1666, '江南一点雨5', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000041', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1667, '陈静5', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000042', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1668, '赵琳浩5', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000043', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1669, '鹿存亮5', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000044', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1670, '姚森5', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000045', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1671, '云星5', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000046', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1672, '贾旭明5', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000047', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1673, '张黎明5', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000048', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1674, '薛磊5', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000049', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1675, '张洁5', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000050', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1676, '江南一点雨6', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000051', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1677, '陈静6', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000052', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1678, '赵琳浩6', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000053', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1679, '鹿存亮6', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000054', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1680, '姚森6', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000055', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1681, '云星6', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000056', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1682, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1683, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1684, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1685, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1686, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1687, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1688, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1689, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1690, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1691, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1692, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1693, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1694, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1695, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1696, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1697, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1698, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1699, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1700, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1701, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1702, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1703, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1704, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1705, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1706, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1707, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1708, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1709, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1710, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1711, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1712, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1713, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1714, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1715, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1716, '谢工', '女', '1970-01-01', '618177197001011234', '离异', 1, '江苏', 1, '584991843@qq.com', '18558887788', '北京', 91, 12, 29, '劳动合同', '本科', '计算机软件', '南华大学', '2018-01-01', '在职', '00000038', 5, NULL, NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1717, '林昭亮', '男', '1990-01-01', '610122199809091234', '已婚', 1, '广东', 13, '584991843@qq.com', '16767776654', '广东深圳', 91, 15, 33, '劳动合同', '大专', '计算机软件', '广东职业技术学院', '2018-01-01', '在职', '00000039', 5, NULL, NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1718, '11', '男', '2018-01-01', '610122201801011234', '已婚', 1, '1', 1, '584991843@qq.com', '111', '1', 89, 9, 29, '劳动合同', '本科', '1', '1', '2018-01-01', '在职', '00000040', 4, NULL, NULL, '2018-01-01', '2022-01-26', NULL);
INSERT INTO `employee` VALUES (1719, '1', '男', '2018-01-01', '610188199809091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 89, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000041', 1, NULL, NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1720, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000042', 1, NULL, NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1721, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 81, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000043', 0, NULL, NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1722, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 87, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000044', 0, NULL, NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1723, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000045', 0, NULL, NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1724, '林伯渠', '男', '2018-01-01', '610122199909099999', '未婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000046', 0, NULL, NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1725, '1', '男', '2018-01-01', '610122199909091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000047', 0, NULL, NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1726, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000057', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1727, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 93, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2019-11-05', '在职', '00000058', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1728, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 93, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2019-11-05', '在职', '00000059', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1729, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowan@123.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000060', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1730, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowan@123.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000060', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1731, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000061', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1732, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000062', 6.17, '2018-03-31', NULL, '2017-12-31', '2024-02-29', NULL);
INSERT INTO `employee` VALUES (1733, 'javaboy666', '男', '2019-11-10', '610122199911111111', '已婚', 1, '广东', 13, '123@qq.com', '12345678901', '广东深圳', 78, 9, 29, '劳动合同', '本科', '信管', '深圳大学', '2019-11-10', '在职', '00000063', 3.25, '2020-02-10', NULL, '2019-11-10', '2023-02-22', NULL);
INSERT INTO `employee` VALUES (1734, 'javaboy666', '男', '2019-11-10', '610122199911111111', '已婚', 1, '广东', 13, '123@qq.com', '12345678901', '广东深圳', 78, 9, 29, '劳动合同', '本科', '信管', '深圳大学', '2019-11-10', '在职', '00000063', 3.25, '2020-02-10', NULL, '2019-11-10', '2023-02-22', NULL);
INSERT INTO `employee` VALUES (1735, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 2, '2018-04-01', NULL, '2018-01-01', '2020-01-01', NULL);
INSERT INTO `employee` VALUES (1736, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 91, 12, 29, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1737, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1738, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1739, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '硕士', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1740, '云星', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000006', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1741, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1742, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1743, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1744, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1745, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1746, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1747, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1748, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1749, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1750, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1751, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1752, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1753, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1754, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1755, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1756, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1757, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1758, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1759, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1760, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1761, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1762, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1763, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1764, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1765, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1766, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1767, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1768, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1769, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1770, '张黎明2', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000038', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1771, '薛磊4', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000039', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1772, '张洁4', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000040', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1773, '江南一点雨5', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000041', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1774, '陈静5', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000042', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1775, '赵琳浩5', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000043', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1776, '鹿存亮5', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000044', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1777, '姚森5', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000045', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1778, '云星5', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000046', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1779, '贾旭明5', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000047', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1780, '张黎明5', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000048', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1781, '薛磊5', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000049', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1782, '张洁5', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000050', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1783, '江南一点雨6', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000051', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1784, '陈静6', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000052', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1785, '赵琳浩6', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000053', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1786, '鹿存亮6', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000054', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1787, '姚森6', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000055', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1788, '云星6', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000056', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1789, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1790, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1791, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1792, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1793, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1794, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1795, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1796, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1797, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1798, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1799, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1800, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1801, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1802, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1803, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1804, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1805, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1806, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1807, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1808, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1809, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1810, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1811, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1812, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1813, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1814, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1815, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1816, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1817, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1818, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1819, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1820, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1821, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1822, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1823, '谢工', '女', '1970-01-01', '618177197001011234', '离异', 1, '江苏', 1, '584991843@qq.com', '18558887788', '北京', 91, 12, 29, '劳动合同', '本科', '计算机软件', '南华大学', '2018-01-01', '在职', '00000038', 5, '2019-01-01', NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1824, '林昭亮', '男', '1990-01-01', '610122199809091234', '已婚', 1, '广东', 13, '584991843@qq.com', '16767776654', '广东深圳', 91, 15, 33, '劳动合同', '大专', '计算机软件', '广东职业技术学院', '2018-01-01', '在职', '00000039', 5, '2018-04-01', NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1825, '11', '男', '2018-01-01', '610122201801011234', '已婚', 1, '1', 1, '584991843@qq.com', '111', '1', 89, 9, 29, '劳动合同', '本科', '1', '1', '2018-01-01', '在职', '00000040', 4, '2018-04-01', NULL, '2018-01-01', '2022-01-26', NULL);
INSERT INTO `employee` VALUES (1826, '1', '男', '2018-01-01', '610188199809091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 89, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000041', 1, '2018-01-31', NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1827, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000042', 1, '2018-01-31', NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1828, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 81, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000043', 0, '2018-01-31', NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1829, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 87, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000044', 0, '2018-01-01', NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1830, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000045', 0, '2018-01-01', NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1831, '林伯渠', '男', '2018-01-01', '610122199909099999', '未婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000046', 0, '2018-01-31', NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1832, '1', '男', '2018-01-01', '610122199909091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000047', 0, '2018-01-31', NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1833, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 2, NULL, NULL, '2018-01-01', '2020-01-01', NULL);
INSERT INTO `employee` VALUES (1834, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 8, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1835, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1836, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1837, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '硕士', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1838, '云星', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000006', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1839, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1840, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1841, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1842, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1843, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1844, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1845, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1846, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1847, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1848, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1849, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1850, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1851, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1852, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1853, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1854, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1855, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1856, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1857, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1858, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1859, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1860, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1861, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1862, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1863, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1864, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1865, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1866, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1867, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1868, '张黎明2', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000038', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1869, '薛磊4', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000039', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1870, '张洁4', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000040', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1871, '江南一点雨5', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000041', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1872, '陈静5', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000042', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1873, '赵琳浩5', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000043', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1874, '鹿存亮5', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000044', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1875, '姚森5', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000045', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1876, '云星5', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000046', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1877, '贾旭明5', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000047', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1878, '张黎明5', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000048', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1879, '薛磊5', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000049', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1880, '张洁5', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000050', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1881, '江南一点雨6', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000051', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1882, '陈静6', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000052', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1883, '赵琳浩6', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000053', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1884, '鹿存亮6', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000054', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1885, '姚森6', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000055', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1886, '云星6', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000056', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1887, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1888, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1889, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1890, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1891, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1892, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1893, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1894, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1895, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1896, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1897, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1898, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1899, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1900, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1901, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1902, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1903, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1904, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1905, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1906, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1907, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1908, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1909, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1910, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1911, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1912, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, NULL, NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (1913, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, NULL, NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1914, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, NULL, NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1915, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, NULL, NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (1916, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1917, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, NULL, NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (1918, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, NULL, NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (1919, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1920, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, NULL, NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (1921, '谢工', '女', '1970-01-01', '618177197001011234', '离异', 1, '江苏', 1, '584991843@qq.com', '18558887788', '北京', 91, 12, 29, '劳动合同', '本科', '计算机软件', '南华大学', '2018-01-01', '在职', '00000038', 5, NULL, NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1922, '林昭亮', '男', '1990-01-01', '610122199809091234', '已婚', 1, '广东', 13, '584991843@qq.com', '16767776654', '广东深圳', 91, 15, 33, '劳动合同', '大专', '计算机软件', '广东职业技术学院', '2018-01-01', '在职', '00000039', 5, NULL, NULL, '2018-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (1923, '11', '男', '2018-01-01', '610122201801011234', '已婚', 1, '1', 1, '584991843@qq.com', '111', '1', 89, 9, 29, '劳动合同', '本科', '1', '1', '2018-01-01', '在职', '00000040', 4, NULL, NULL, '2018-01-01', '2022-01-26', NULL);
INSERT INTO `employee` VALUES (1924, '1', '男', '2018-01-01', '610188199809091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 89, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000041', 1, NULL, NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1925, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000042', 1, NULL, NULL, '2018-01-31', '2019-01-31', NULL);
INSERT INTO `employee` VALUES (1926, '1', '男', '2018-01-01', '610122199909090000', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 81, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000043', 0, NULL, NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1927, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 87, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000044', 0, NULL, NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1928, '1', '男', '2018-01-01', '610122199909099999', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 78, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-01', '在职', '00000045', 0, NULL, NULL, '2018-01-01', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1929, '林伯渠', '男', '2018-01-01', '610122199909099999', '未婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000046', 0, NULL, NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1930, '1', '男', '2018-01-01', '610122199909091234', '已婚', 1, '1', 1, '584991843@qq.com', '1', '1', 8, 9, 29, '劳动合同', '大专', '1', '1', '2018-01-31', '在职', '00000047', 0, NULL, NULL, '2018-01-31', '2018-01-31', NULL);
INSERT INTO `employee` VALUES (1931, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000057', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1932, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 93, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2019-11-05', '在职', '00000058', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1933, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 93, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2019-11-05', '在职', '00000059', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1934, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowan@123.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000060', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1935, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowan@123.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000060', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1936, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000061', 2, '2018-03-31', NULL, '2017-12-31', '2019-12-31', NULL);
INSERT INTO `employee` VALUES (1937, 'javaboy', '男', '1989-12-31', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000062', 6.17, '2018-03-31', NULL, '2017-12-31', '2024-02-29', NULL);
INSERT INTO `employee` VALUES (1938, 'javaboy666', '男', '2019-11-10', '610122199911111111', '已婚', 1, '广东', 13, '123@qq.com', '12345678901', '广东深圳', 78, 9, 29, '劳动合同', '本科', '信管', '深圳大学', '2019-11-10', '在职', '00000063', 3.25, '2020-02-10', NULL, '2019-11-10', '2023-02-22', NULL);
INSERT INTO `employee` VALUES (1939, 'javaboy666', '男', '2019-11-10', '610122199911111111', '已婚', 1, '广东', 13, '123@qq.com', '12345678901', '广东深圳', 78, 9, 29, '劳动合同', '本科', '信管', '深圳大学', '2019-11-10', '在职', '00000063', 3.25, '2020-02-10', NULL, '2019-11-10', '2023-02-22', NULL);
INSERT INTO `employee` VALUES (1940, 'javaboy', '男', '2017-11-01', '610144199905059999', '已婚', 1, '广东', 13, '584991843@qq.com', '18564447789', '广东深圳', 85, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2019-11-24', '在职', '00000064', 3, '2020-01-10', NULL, '2019-11-24', '2022-11-27', NULL);
INSERT INTO `employee` VALUES (1941, 'javaboy', '男', '2019-11-24', '610144199905056666', '已婚', 1, '广东', 13, '584991843@qq.com', '18566667777', '广东深圳', 89, 9, 29, '劳动合同', '本科', '计算机科学', '深圳大学', '2019-11-24', '在职', '00000065', 3, '2020-02-23', NULL, '2019-11-24', '2022-11-27', NULL);

-- ----------------------------
-- Table structure for employee_ec
-- ----------------------------
DROP TABLE IF EXISTS `employee_ec`;
CREATE TABLE `employee_ec`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `eid` int(0) NULL DEFAULT NULL COMMENT '员工编号',
  `ecDate` date NULL DEFAULT NULL COMMENT '奖罚日期',
  `ecReason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '奖罚原因',
  `ecPoint` int(0) NULL DEFAULT NULL COMMENT '奖罚分',
  `ecType` int(0) NULL DEFAULT NULL COMMENT '奖罚类别，0：奖，1：罚',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `employee_ec_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee_ec
-- ----------------------------

-- ----------------------------
-- Table structure for employee_remove
-- ----------------------------
DROP TABLE IF EXISTS `employee_remove`;
CREATE TABLE `employee_remove`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `eid` int(0) NULL DEFAULT NULL,
  `afterDepId` int(0) NULL DEFAULT NULL COMMENT '调动后部门',
  `afterJobId` int(0) NULL DEFAULT NULL COMMENT '调动后职位',
  `removeDate` date NULL DEFAULT NULL COMMENT '调动日期',
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调动原因',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `employee_remove_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee_remove
-- ----------------------------

-- ----------------------------
-- Table structure for employee_train
-- ----------------------------
DROP TABLE IF EXISTS `employee_train`;
CREATE TABLE `employee_train`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `eid` int(0) NULL DEFAULT NULL COMMENT '员工编号',
  `trainDate` date NULL DEFAULT NULL COMMENT '培训日期',
  `trainContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '培训内容',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `employee_train_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee_train
-- ----------------------------

-- ----------------------------
-- Table structure for hr
-- ----------------------------
DROP TABLE IF EXISTS `hr`;
CREATE TABLE `hr`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'hrID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `telephone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '住宅电话',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `userface` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'hr 表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hr
-- ----------------------------
INSERT INTO `hr` VALUES (3, '系统管理员', '18568887789', '029-82881234', '深圳南山', 1, 'admin', '$2a$10$ySG2lkvjFHY5O0./CPIE1OI8VJsuKYEzOYzqIa7AJR6sEgSzUFOAm', 'http://bpic.588ku.com/element_pic/01/40/00/64573ce2edc0728.jpg', NULL);
INSERT INTO `hr` VALUES (5, '李白', '18568123489', '029-82123434', '海口美兰', 1, 'libai', '$2a$10$ySG2lkvjFHY5O0./CPIE1OI8VJsuKYEzOYzqIa7AJR6sEgSzUFOAm', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', NULL);
INSERT INTO `hr` VALUES (10, '韩愈', '18568123666', '029-82111555', '广州番禺', 1, 'hanyu', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517070040185&di=be0375e0c3db6c311b837b28c208f318&imgtype=0&src=http%3A%2F%2Fimg2.soyoung.com%2Fpost%2F20150213%2F6%2F20150213141918532.jpg', NULL);
INSERT INTO `hr` VALUES (11, '柳宗元', '18568123377', '029-82111333', '广州天河', 1, 'liuzongyuan', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1515233756&di=0856d923a0a37a87fd26604a2c871370&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.qqzhi.com%2Fuploadpic%2F2014-09-27%2F041716704.jpg', NULL);
INSERT INTO `hr` VALUES (12, '曾巩', '18568128888', '029-82111222', '广州越秀', 1, 'zenggong', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517070040185&di=be0375e0c3db6c311b837b28c208f318&imgtype=0&src=http%3A%2F%2Fimg2.soyoung.com%2Fpost%2F20150213%2F6%2F20150213141918532.jpg', NULL);

-- ----------------------------
-- Table structure for hr_role
-- ----------------------------
DROP TABLE IF EXISTS `hr_role`;
CREATE TABLE `hr_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `hrid` int(0) NULL DEFAULT NULL,
  `rid` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  INDEX `hr_role_ibfk_1`(`hrid`) USING BTREE,
  CONSTRAINT `hr_role_ibfk_1` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `hr_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hr_role
-- ----------------------------
INSERT INTO `hr_role` VALUES (35, 12, 4);
INSERT INTO `hr_role` VALUES (36, 12, 3);
INSERT INTO `hr_role` VALUES (37, 12, 2);
INSERT INTO `hr_role` VALUES (43, 11, 3);
INSERT INTO `hr_role` VALUES (44, 11, 2);
INSERT INTO `hr_role` VALUES (45, 11, 4);
INSERT INTO `hr_role` VALUES (46, 11, 5);
INSERT INTO `hr_role` VALUES (48, 10, 3);
INSERT INTO `hr_role` VALUES (49, 10, 4);
INSERT INTO `hr_role` VALUES (75, 5, 1);
INSERT INTO `hr_role` VALUES (76, 5, 2);
INSERT INTO `hr_role` VALUES (77, 5, 3);
INSERT INTO `hr_role` VALUES (78, 5, 4);
INSERT INTO `hr_role` VALUES (79, 5, 5);
INSERT INTO `hr_role` VALUES (80, 5, 6);
INSERT INTO `hr_role` VALUES (81, 5, 13);
INSERT INTO `hr_role` VALUES (87, 3, 6);

-- ----------------------------
-- Table structure for job_level
-- ----------------------------
DROP TABLE IF EXISTS `job_level`;
CREATE TABLE `job_level`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职称名称',
  `title_level` enum('正高级','副高级','中级','初级','员级') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '职称表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_level
-- ----------------------------
INSERT INTO `job_level` VALUES (9, '教授', '正高级', '2018-01-11 00:00:00', 1);
INSERT INTO `job_level` VALUES (10, '副教授', '副高级', '2018-01-11 21:19:20', 1);
INSERT INTO `job_level` VALUES (12, '助教', '初级', '2018-01-11 21:35:39', 1);
INSERT INTO `job_level` VALUES (13, '讲师', '中级', '2018-01-11 00:00:00', 0);
INSERT INTO `job_level` VALUES (14, '初级工程师', '初级', '2018-01-14 00:00:00', 1);
INSERT INTO `job_level` VALUES (15, '中级工程师66', '中级', '2018-01-14 00:00:00', 1);
INSERT INTO `job_level` VALUES (16, '高级工程师', '副高级', '2018-01-14 16:19:14', 1);
INSERT INTO `job_level` VALUES (17, '骨灰级工程师', '正高级', '2018-01-14 16:19:24', 1);

-- ----------------------------
-- Table structure for mail_send_log
-- ----------------------------
DROP TABLE IF EXISTS `mail_send_log`;
CREATE TABLE `mail_send_log`  (
  `msgId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `empId` int(0) NULL DEFAULT NULL,
  `status` int(0) NULL DEFAULT 0 COMMENT '0发送中，1发送成功，2发送失败',
  `routeKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `exchange` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `count` int(0) NULL DEFAULT NULL COMMENT '重试次数',
  `tryTime` date NULL DEFAULT NULL COMMENT '第一次重试时间',
  `createTime` date NULL DEFAULT NULL,
  `updateTime` date NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mail_send_log
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口路径',
  `path` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端组件路径',
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端组件名称',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `icon_cls` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'icon',
  `keep_alive` tinyint(1) NULL DEFAULT NULL,
  `require_auth` tinyint(1) NULL DEFAULT NULL,
  `parent_id` int(0) NULL DEFAULT NULL COMMENT '父级菜单',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启动，0启动，1禁用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parentId`(`parent_id`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '/', NULL, NULL, '所有', NULL, NULL, NULL, NULL, 1);
INSERT INTO `menu` VALUES (2, '/', '/home', 'Home', '员工资料', 'fa fa-user-circle-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (3, '/', '/home', 'Home', '人事管理', 'fa fa-address-card-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (4, '/', '/home', 'Home', '薪资管理', 'fa fa-money', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (5, '/', '/home', 'Home', '统计管理', 'fa fa-bar-chart', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (6, '/', '/home', 'Home', '系统管理', 'fa fa-windows', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (7, '/employee/basic/**', '/emp/basic', 'EmpBasic', '基本资料', NULL, NULL, 1, 2, 1);
INSERT INTO `menu` VALUES (8, '/employee/advanced/**', '/emp/adv', 'EmpAdv', '高级资料', NULL, NULL, 1, 2, 1);
INSERT INTO `menu` VALUES (9, '/personnel/emp/**', '/per/emp', 'PerEmp', '员工资料', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (10, '/personnel/ec/**', '/per/ec', 'PerEc', '员工奖惩', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (11, '/personnel/train/**', '/per/train', 'PerTrain', '员工培训', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (12, '/personnel/salary/**', '/per/salary', 'PerSalary', '员工调薪', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (13, '/personnel/remove/**', '/per/mv', 'PerMv', '员工调动', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (14, '/salary/sob/**', '/sal/sob', 'SalSob', '工资账套管理', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (15, '/salary/sobcfg/**', '/sal/sobcfg', 'SalSobCfg', '员工账套设置', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (16, '/salary/table/**', '/sal/table', 'SalTable', '工资表管理', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (17, '/salary/month/**', '/sal/month', 'SalMonth', '月末处理', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (18, '/salary/search/**', '/sal/search', 'SalSearch', '工资表查询', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (19, '/statistics/all/**', '/sta/all', 'StaAll', '综合信息统计', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (20, '/statistics/score/**', '/sta/score', 'StaScore', '员工积分统计', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (21, '/statistics/personnel/**', '/sta/pers', 'StaPers', '人事信息统计', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (22, '/statistics/recored/**', '/sta/record', 'StaRecord', '人事记录统计', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (23, '/system/basic/**', '/sys/basic', 'SysBasic', '基础信息设置', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (24, '/system/cfg/**', '/sys/cfg', 'SysCfg', '系统管理', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (25, '/system/log/**', '/sys/log', 'SysLog', '操作日志管理', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (26, '/system/hr/**', '/sys/hr', 'SysHr', '操作员管理', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (27, '/system/data/**', '/sys/data', 'SysData', '备份恢复数据库', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (28, '/system/init/**', '/sys/init', 'SysInit', '初始化数据库', NULL, NULL, 1, 6, 1);

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `mid` int(0) NULL DEFAULT NULL,
  `rid` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mid`(`mid`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  CONSTRAINT `menu_role_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `menu_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 283 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES (161, 7, 3);
INSERT INTO `menu_role` VALUES (247, 7, 4);
INSERT INTO `menu_role` VALUES (248, 8, 4);
INSERT INTO `menu_role` VALUES (249, 11, 4);
INSERT INTO `menu_role` VALUES (250, 7, 2);
INSERT INTO `menu_role` VALUES (251, 8, 2);
INSERT INTO `menu_role` VALUES (252, 9, 2);
INSERT INTO `menu_role` VALUES (253, 10, 2);
INSERT INTO `menu_role` VALUES (254, 12, 2);
INSERT INTO `menu_role` VALUES (255, 13, 2);
INSERT INTO `menu_role` VALUES (256, 7, 1);
INSERT INTO `menu_role` VALUES (257, 8, 1);
INSERT INTO `menu_role` VALUES (258, 9, 1);
INSERT INTO `menu_role` VALUES (259, 10, 1);
INSERT INTO `menu_role` VALUES (260, 11, 1);
INSERT INTO `menu_role` VALUES (261, 12, 1);
INSERT INTO `menu_role` VALUES (262, 13, 1);
INSERT INTO `menu_role` VALUES (263, 14, 1);
INSERT INTO `menu_role` VALUES (264, 15, 1);
INSERT INTO `menu_role` VALUES (265, 16, 1);
INSERT INTO `menu_role` VALUES (266, 17, 1);
INSERT INTO `menu_role` VALUES (267, 18, 1);
INSERT INTO `menu_role` VALUES (268, 19, 1);
INSERT INTO `menu_role` VALUES (269, 20, 1);
INSERT INTO `menu_role` VALUES (270, 21, 1);
INSERT INTO `menu_role` VALUES (271, 22, 1);
INSERT INTO `menu_role` VALUES (272, 23, 1);
INSERT INTO `menu_role` VALUES (273, 24, 1);
INSERT INTO `menu_role` VALUES (274, 25, 1);
INSERT INTO `menu_role` VALUES (275, 26, 1);
INSERT INTO `menu_role` VALUES (276, 27, 1);
INSERT INTO `menu_role` VALUES (277, 28, 1);
INSERT INTO `menu_role` VALUES (280, 7, 14);
INSERT INTO `menu_role` VALUES (281, 8, 14);
INSERT INTO `menu_role` VALUES (282, 9, 14);
INSERT INTO `menu_role` VALUES (283, 7, 6);
INSERT INTO `menu_role` VALUES (284, 8, 6);
INSERT INTO `menu_role` VALUES (285, 9, 6);
INSERT INTO `menu_role` VALUES (286, 10, 6);
INSERT INTO `menu_role` VALUES (287, 11, 6);
INSERT INTO `menu_role` VALUES (288, 12, 6);
INSERT INTO `menu_role` VALUES (289, 13, 6);
INSERT INTO `menu_role` VALUES (290, 14, 6);
INSERT INTO `menu_role` VALUES (291, 15, 6);
INSERT INTO `menu_role` VALUES (292, 16, 6);
INSERT INTO `menu_role` VALUES (293, 17, 6);
INSERT INTO `menu_role` VALUES (294, 18, 6);
INSERT INTO `menu_role` VALUES (295, 19, 6);
INSERT INTO `menu_role` VALUES (296, 20, 6);
INSERT INTO `menu_role` VALUES (297, 21, 6);
INSERT INTO `menu_role` VALUES (298, 22, 6);
INSERT INTO `menu_role` VALUES (299, 23, 6);
INSERT INTO `menu_role` VALUES (300, 24, 6);
INSERT INTO `menu_role` VALUES (301, 25, 6);
INSERT INTO `menu_role` VALUES (302, 26, 6);
INSERT INTO `menu_role` VALUES (303, 27, 6);
INSERT INTO `menu_role` VALUES (304, 28, 6);

-- ----------------------------
-- Table structure for msg_content
-- ----------------------------
DROP TABLE IF EXISTS `msg_content`;
CREATE TABLE `msg_content`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createDate` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of msg_content
-- ----------------------------
INSERT INTO `msg_content` VALUES (14, '2222222222', '11111111111111111', '2018-02-02 20:46:19');
INSERT INTO `msg_content` VALUES (15, '22222222', '3333333333333333333333', '2018-02-02 21:45:57');
INSERT INTO `msg_content` VALUES (16, '通知标题1', '通知内容1', '2018-02-03 11:41:39');
INSERT INTO `msg_content` VALUES (17, '通知标题2', '通知内容2', '2018-02-03 11:52:37');
INSERT INTO `msg_content` VALUES (18, '通知标题3', '通知内容3', '2018-02-03 12:19:41');

-- ----------------------------
-- Table structure for nation
-- ----------------------------
DROP TABLE IF EXISTS `nation`;
CREATE TABLE `nation`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '民族表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nation
-- ----------------------------
INSERT INTO `nation` VALUES (1, '汉族');
INSERT INTO `nation` VALUES (2, '蒙古族');
INSERT INTO `nation` VALUES (3, '回族');
INSERT INTO `nation` VALUES (4, '藏族');
INSERT INTO `nation` VALUES (5, '维吾尔族');
INSERT INTO `nation` VALUES (6, '苗族');
INSERT INTO `nation` VALUES (7, '彝族');
INSERT INTO `nation` VALUES (8, '壮族');
INSERT INTO `nation` VALUES (9, '布依族');
INSERT INTO `nation` VALUES (10, '朝鲜族');
INSERT INTO `nation` VALUES (11, '满族');
INSERT INTO `nation` VALUES (12, '侗族');
INSERT INTO `nation` VALUES (13, '瑶族');
INSERT INTO `nation` VALUES (14, '白族');
INSERT INTO `nation` VALUES (15, '土家族');
INSERT INTO `nation` VALUES (16, '哈尼族');
INSERT INTO `nation` VALUES (17, '哈萨克族');
INSERT INTO `nation` VALUES (18, '傣族');
INSERT INTO `nation` VALUES (19, '黎族');
INSERT INTO `nation` VALUES (20, '傈僳族');
INSERT INTO `nation` VALUES (21, '佤族');
INSERT INTO `nation` VALUES (22, '畲族');
INSERT INTO `nation` VALUES (23, '高山族');
INSERT INTO `nation` VALUES (24, '拉祜族');
INSERT INTO `nation` VALUES (25, '水族');
INSERT INTO `nation` VALUES (26, '东乡族');
INSERT INTO `nation` VALUES (27, '纳西族');
INSERT INTO `nation` VALUES (28, '景颇族');
INSERT INTO `nation` VALUES (29, '柯尔克孜族');
INSERT INTO `nation` VALUES (30, '土族');
INSERT INTO `nation` VALUES (31, '达斡尔族');
INSERT INTO `nation` VALUES (32, '仫佬族');
INSERT INTO `nation` VALUES (33, '羌族');
INSERT INTO `nation` VALUES (34, '布朗族');
INSERT INTO `nation` VALUES (35, '撒拉族');
INSERT INTO `nation` VALUES (36, '毛难族');
INSERT INTO `nation` VALUES (37, '仡佬族');
INSERT INTO `nation` VALUES (38, '锡伯族');
INSERT INTO `nation` VALUES (39, '阿昌族');
INSERT INTO `nation` VALUES (40, '普米族');
INSERT INTO `nation` VALUES (41, '塔吉克族');
INSERT INTO `nation` VALUES (42, '怒族');
INSERT INTO `nation` VALUES (43, '乌孜别克族');
INSERT INTO `nation` VALUES (44, '俄罗斯族');
INSERT INTO `nation` VALUES (45, '鄂温克族');
INSERT INTO `nation` VALUES (46, '崩龙族');
INSERT INTO `nation` VALUES (47, '保安族');
INSERT INTO `nation` VALUES (48, '裕固族');
INSERT INTO `nation` VALUES (49, '京族');
INSERT INTO `nation` VALUES (50, '塔塔尔族');
INSERT INTO `nation` VALUES (51, '独龙族');
INSERT INTO `nation` VALUES (52, '鄂伦春族');
INSERT INTO `nation` VALUES (53, '赫哲族');
INSERT INTO `nation` VALUES (54, '门巴族');
INSERT INTO `nation` VALUES (55, '珞巴族');
INSERT INTO `nation` VALUES (56, '基诺族');

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `addDate` date NULL DEFAULT NULL COMMENT '添加日期',
  `operate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `hrid` int(0) NULL DEFAULT NULL COMMENT '操作员ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `hrid`(`hrid`) USING BTREE,
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oplog
-- ----------------------------

-- ----------------------------
-- Table structure for politics_status
-- ----------------------------
DROP TABLE IF EXISTS `politics_status`;
CREATE TABLE `politics_status`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '政治面貌表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of politics_status
-- ----------------------------
INSERT INTO `politics_status` VALUES (1, '中共党员');
INSERT INTO `politics_status` VALUES (2, '中共预备党员');
INSERT INTO `politics_status` VALUES (3, '共青团员');
INSERT INTO `politics_status` VALUES (4, '民革党员');
INSERT INTO `politics_status` VALUES (5, '民盟盟员');
INSERT INTO `politics_status` VALUES (6, '民建会员');
INSERT INTO `politics_status` VALUES (7, '民进会员');
INSERT INTO `politics_status` VALUES (8, '农工党党员');
INSERT INTO `politics_status` VALUES (9, '致公党党员');
INSERT INTO `politics_status` VALUES (10, '九三学社社员');
INSERT INTO `politics_status` VALUES (11, '台盟盟员');
INSERT INTO `politics_status` VALUES (12, '无党派民主人士');
INSERT INTO `politics_status` VALUES (13, '普通公民');

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位',
  `create_date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '职位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of position
-- ----------------------------
INSERT INTO `position` VALUES (29, '技术总监', '2018-01-11 21:13:42', 1);
INSERT INTO `position` VALUES (30, '运营总监', '2018-01-11 21:13:48', 1);
INSERT INTO `position` VALUES (31, '市场总监', '2018-01-11 00:00:00', 1);
INSERT INTO `position` VALUES (33, '研发工程师', '2018-01-14 00:00:00', 0);
INSERT INTO `position` VALUES (34, '运维工程师', '2018-01-14 16:11:41', 1);
INSERT INTO `position` VALUES (36, 'Java研发经理', '2019-10-01 00:00:00', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nameZh` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ROLE_manager', '部门经理');
INSERT INTO `role` VALUES (2, 'ROLE_personnel', '人事专员');
INSERT INTO `role` VALUES (3, 'ROLE_recruiter', '招聘主管');
INSERT INTO `role` VALUES (4, 'ROLE_train', '培训主管');
INSERT INTO `role` VALUES (5, 'ROLE_performance', '薪酬绩效主管');
INSERT INTO `role` VALUES (6, 'ROLE_admin', '系统管理员');
INSERT INTO `role` VALUES (13, 'ROLE_test2', '测试角色2');
INSERT INTO `role` VALUES (14, 'ROLE_test1', '测试角色1');
INSERT INTO `role` VALUES (17, 'ROLE_test3', '测试角色3');
INSERT INTO `role` VALUES (18, 'ROLE_test4', '测试角色4');
INSERT INTO `role` VALUES (19, 'ROLE_test4', '测试角色4');
INSERT INTO `role` VALUES (20, 'ROLE_test5', '测试角色5');
INSERT INTO `role` VALUES (21, 'ROLE_test6', '测试角色6');

-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `basic_salary` int(0) NULL DEFAULT NULL COMMENT '基本工资',
  `bonus` int(0) NULL DEFAULT NULL COMMENT '奖金',
  `lunch_salary` int(0) NULL DEFAULT NULL COMMENT '午餐补助',
  `traffic_salary` int(0) NULL DEFAULT NULL COMMENT '交通补助',
  `all_salary` int(0) NULL DEFAULT NULL COMMENT '应发工资',
  `pension_base` int(0) NULL DEFAULT NULL COMMENT '养老金基数',
  `pension_per` float NULL DEFAULT NULL COMMENT '养老金比率',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '启用时间',
  `medical_base` int(0) NULL DEFAULT NULL COMMENT '医疗基数',
  `medical_per` float NULL DEFAULT NULL COMMENT '医疗保险比率',
  `accumulation_fund_base` int(0) NULL DEFAULT NULL COMMENT '公积金基数',
  `accumulation_fund_per` float NULL DEFAULT NULL COMMENT '公积金比率',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '薪资表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salary
-- ----------------------------
INSERT INTO `salary` VALUES (9, 9000, 4000, 800, 500, NULL, 2000, 0.07, '2018-01-24 00:00:00', 2000, 0.07, 2000, 0.07, '市场部工资账套');
INSERT INTO `salary` VALUES (10, 2000, 2000, 400, 1000, NULL, 2000, 0.07, '2018-01-01 00:00:00', 2000, 0.07, 2000, 0.07, '人事部工资账套');
INSERT INTO `salary` VALUES (13, 20000, 3000, 500, 500, NULL, 4000, 0.07, '2018-01-25 00:00:00', 4000, 0.07, 4000, 0.07, '运维部工资账套');

-- ----------------------------
-- Table structure for sysmsg
-- ----------------------------
DROP TABLE IF EXISTS `sysmsg`;
CREATE TABLE `sysmsg`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `mid` int(0) NULL DEFAULT NULL COMMENT '消息id',
  `type` int(0) NULL DEFAULT 0 COMMENT '0表示群发消息',
  `hrid` int(0) NULL DEFAULT NULL COMMENT '这条消息是给谁的',
  `state` int(0) NULL DEFAULT 0 COMMENT '0 未读 1 已读',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `hrid`(`hrid`) USING BTREE,
  INDEX `sysmsg_ibfk_1`(`mid`) USING BTREE,
  CONSTRAINT `sysmsg_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `msg_content` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sysmsg_ibfk_2` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sysmsg
-- ----------------------------
INSERT INTO `sysmsg` VALUES (57, 14, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (58, 14, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (59, 14, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (60, 14, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (61, 14, 0, 12, 0);
INSERT INTO `sysmsg` VALUES (62, 15, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (63, 15, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (64, 15, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (65, 15, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (66, 15, 0, 12, 0);
INSERT INTO `sysmsg` VALUES (67, 16, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (68, 16, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (69, 16, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (70, 16, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (71, 16, 0, 12, 0);
INSERT INTO `sysmsg` VALUES (72, 17, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (73, 17, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (74, 17, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (75, 17, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (76, 17, 0, 12, 0);
INSERT INTO `sysmsg` VALUES (77, 18, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (78, 18, 0, 5, 0);
INSERT INTO `sysmsg` VALUES (79, 18, 0, 10, 0);
INSERT INTO `sysmsg` VALUES (80, 18, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (81, 18, 0, 12, 0);

-- ----------------------------
-- Procedure structure for addDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `addDep`;
delimiter ;;
CREATE PROCEDURE `addDep`(in depName varchar(32),in parentId int,in enabled boolean,out result int,out result2 int)
begin
  declare did int;
  declare pDepPath varchar(64);
  insert into department set name=depName,parentId=parentId,enabled=enabled;
  select row_count() into result;
  select last_insert_id() into did;
  set result2=did;
  select depPath into pDepPath from department where id=parentId;
  update department set depPath=concat(pDepPath,'.',did) where id=did;
  update department set isParent=true where id=parentId;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for deleteDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteDep`;
delimiter ;;
CREATE PROCEDURE `deleteDep`(in did int,out result int)
begin
  declare ecount int;
  declare pid int;
  declare pcount int;
  declare a int;
  select count(*) into a from department where id=did and isParent=false;
  if a=0 then set result=-2;
  else
  select count(*) into ecount from employee where departmentId=did;
  if ecount>0 then set result=-1;
  else
  select parentId into pid from department where id=did;
  delete from department where id=did and isParent=false;
  select row_count() into result;
  select count(*) into pcount from department where parentId=pid;
  if pcount=0 then update department set isParent=false where id=pid;
  end if;
  end if;
  end if;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
