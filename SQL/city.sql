/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50714
Source Host           : 127.0.0.1:3306
Source Database       : mytool

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-03-24 17:45:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `city` varchar(255) NOT NULL,
  `suoxie` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of city
-- ----------------------------
INSERT INTO `city` VALUES ('1', '北京', 'BJS');
INSERT INTO `city` VALUES ('2', '上海', 'SHA');
INSERT INTO `city` VALUES ('3', '天津', 'TSN');
INSERT INTO `city` VALUES ('4', '青岛', 'TAO');
INSERT INTO `city` VALUES ('5', '南京', 'NKG');
INSERT INTO `city` VALUES ('6', '杭州', 'HGH');
INSERT INTO `city` VALUES ('7', '厦门', 'XMN');
INSERT INTO `city` VALUES ('8', '成都', 'CTU');
INSERT INTO `city` VALUES ('9', '深圳', 'SZX');
INSERT INTO `city` VALUES ('10', '广州', 'CAN');
INSERT INTO `city` VALUES ('11', '沈阳', 'SHE');
INSERT INTO `city` VALUES ('12', '武汉', 'WUH');
INSERT INTO `city` VALUES ('13', '安庆', 'AQG');
INSERT INTO `city` VALUES ('14', '鞍山', 'AOG');
INSERT INTO `city` VALUES ('15', '安阳', '');
INSERT INTO `city` VALUES ('17', '宝鸡', '');
INSERT INTO `city` VALUES ('18', '包头', 'BAV');
INSERT INTO `city` VALUES ('19', '蚌埠', '');
INSERT INTO `city` VALUES ('20', '保定', '');
INSERT INTO `city` VALUES ('21', '北海', 'BHY');
INSERT INTO `city` VALUES ('22', '亳州', '');
INSERT INTO `city` VALUES ('23', '本溪', '');
INSERT INTO `city` VALUES ('24', '滨州', '');
INSERT INTO `city` VALUES ('25', '重庆', 'CKG');
INSERT INTO `city` VALUES ('27', '长治', 'CIH');
INSERT INTO `city` VALUES ('28', '长春', 'CGQ');
INSERT INTO `city` VALUES ('29', '常德', 'CGD');
INSERT INTO `city` VALUES ('30', '赤峰', 'CIF');
INSERT INTO `city` VALUES ('31', '长沙', 'CSX');
INSERT INTO `city` VALUES ('32', '朝阳', 'CHG');
INSERT INTO `city` VALUES ('33', '常州', 'CZX');
INSERT INTO `city` VALUES ('34', '滁州', '');
INSERT INTO `city` VALUES ('35', '潮州', '');
INSERT INTO `city` VALUES ('36', '沧州', '');
INSERT INTO `city` VALUES ('37', '池州', '');
INSERT INTO `city` VALUES ('38', '承德', '');
INSERT INTO `city` VALUES ('39', '巢湖', '');
INSERT INTO `city` VALUES ('40', '郴州', '');
INSERT INTO `city` VALUES ('41', '大连', 'DLC');
INSERT INTO `city` VALUES ('42', '大同', 'DAT');
INSERT INTO `city` VALUES ('43', '丹东', 'DDG');
INSERT INTO `city` VALUES ('44', '东莞', '');
INSERT INTO `city` VALUES ('45', '大庆', 'DQA');
INSERT INTO `city` VALUES ('46', '东营', 'DOY');
INSERT INTO `city` VALUES ('47', '德阳', '');
INSERT INTO `city` VALUES ('48', '达州', 'DAX');
INSERT INTO `city` VALUES ('49', '德州', '');
INSERT INTO `city` VALUES ('50', '大理', 'DLU');
INSERT INTO `city` VALUES ('51', '恩施', 'ENH');
INSERT INTO `city` VALUES ('52', '鄂州', '');
INSERT INTO `city` VALUES ('53', '佛山', 'FUO');
INSERT INTO `city` VALUES ('54', '抚顺', '');
INSERT INTO `city` VALUES ('55', '阜新', '');
INSERT INTO `city` VALUES ('56', '阜阳', 'FUG');
INSERT INTO `city` VALUES ('57', '福州', 'FOC');
INSERT INTO `city` VALUES ('58', '防城港', '');
INSERT INTO `city` VALUES ('59', '抚州', '');
INSERT INTO `city` VALUES ('61', '桂林', 'KWL');
INSERT INTO `city` VALUES ('62', '贵阳', 'KWE');
INSERT INTO `city` VALUES ('63', '广元', 'GYS');
INSERT INTO `city` VALUES ('64', '赣州', 'KOW');
INSERT INTO `city` VALUES ('65', '贵港', '');
INSERT INTO `city` VALUES ('66', '哈尔滨', 'HRB');
INSERT INTO `city` VALUES ('68', '黄山', 'TXN');
INSERT INTO `city` VALUES ('69', '海口', 'HAK');
INSERT INTO `city` VALUES ('70', '湖州', '');
INSERT INTO `city` VALUES ('71', '呼和浩特', 'HET');
INSERT INTO `city` VALUES ('72', '汉中', 'HZG');
INSERT INTO `city` VALUES ('73', '海拉尔', 'HLD');
INSERT INTO `city` VALUES ('74', '邯郸', 'HDG');
INSERT INTO `city` VALUES ('75', '合肥', 'HFE');
INSERT INTO `city` VALUES ('76', '怀化', '');
INSERT INTO `city` VALUES ('77', '淮南', '');
INSERT INTO `city` VALUES ('78', '衡水', '');
INSERT INTO `city` VALUES ('79', '黄石', '');
INSERT INTO `city` VALUES ('80', '衡阳', 'HNY');
INSERT INTO `city` VALUES ('81', '惠州', 'HUZ');
INSERT INTO `city` VALUES ('82', '河源', '');
INSERT INTO `city` VALUES ('83', '鹤壁', '');
INSERT INTO `city` VALUES ('84', '葫芦岛', '');
INSERT INTO `city` VALUES ('85', '菏泽', '');
INSERT INTO `city` VALUES ('86', '黄冈', '');
INSERT INTO `city` VALUES ('87', '呼伦贝尔', '');
INSERT INTO `city` VALUES ('88', '九江', 'JIU');
INSERT INTO `city` VALUES ('89', '九寨沟', '');
INSERT INTO `city` VALUES ('90', '济南', 'TNA');
INSERT INTO `city` VALUES ('91', '吉林', 'JIL');
INSERT INTO `city` VALUES ('92', '景德镇', 'JDZ');
INSERT INTO `city` VALUES ('93', '金华', '');
INSERT INTO `city` VALUES ('94', '江门', '');
INSERT INTO `city` VALUES ('95', '佳木斯', 'JMU');
INSERT INTO `city` VALUES ('96', '济宁', 'JNG');
INSERT INTO `city` VALUES ('97', '嘉峪关', 'JGN');
INSERT INTO `city` VALUES ('98', '锦州', 'JNZ');
INSERT INTO `city` VALUES ('99', '荆州', '');
INSERT INTO `city` VALUES ('100', '嘉兴', '');
INSERT INTO `city` VALUES ('101', '酒泉', 'CHW');
INSERT INTO `city` VALUES ('102', '吉安', '');
INSERT INTO `city` VALUES ('103', '揭阳', '');
INSERT INTO `city` VALUES ('104', '晋城', '');
INSERT INTO `city` VALUES ('105', '焦作', '');
INSERT INTO `city` VALUES ('106', '荆门', '');
INSERT INTO `city` VALUES ('107', '晋中', '');
INSERT INTO `city` VALUES ('108', '济源', '');
INSERT INTO `city` VALUES ('109', '昆明', 'KMG');
INSERT INTO `city` VALUES ('110', '喀什市', '');
INSERT INTO `city` VALUES ('111', '克拉玛依', 'KRY');
INSERT INTO `city` VALUES ('112', '开封', '');
INSERT INTO `city` VALUES ('113', '丽江', 'LJG');
INSERT INTO `city` VALUES ('114', '拉萨', 'LXA');
INSERT INTO `city` VALUES ('115', '兰州', 'LHW');
INSERT INTO `city` VALUES ('116', '临汾', '');
INSERT INTO `city` VALUES ('117', '廊坊', '');
INSERT INTO `city` VALUES ('118', '乐山', '');
INSERT INTO `city` VALUES ('119', '丽水', '');
INSERT INTO `city` VALUES ('120', '龙岩', '');
INSERT INTO `city` VALUES ('121', '洛阳', 'LYA');
INSERT INTO `city` VALUES ('122', '辽阳', '');
INSERT INTO `city` VALUES ('123', '辽源', '');
INSERT INTO `city` VALUES ('124', '连云港', 'LYG');
INSERT INTO `city` VALUES ('125', '柳州', 'LZH');
INSERT INTO `city` VALUES ('126', '泸州', 'LZO');
INSERT INTO `city` VALUES ('127', '六盘水', '');
INSERT INTO `city` VALUES ('128', '娄底', '');
INSERT INTO `city` VALUES ('129', '聊城', '');
INSERT INTO `city` VALUES ('130', '漯河', '');
INSERT INTO `city` VALUES ('131', '莱芜', '');
INSERT INTO `city` VALUES ('132', '六安', '');
INSERT INTO `city` VALUES ('133', '吕梁', '');
INSERT INTO `city` VALUES ('134', '牡丹江', 'MDG');
INSERT INTO `city` VALUES ('135', '绵阳', 'MIG');
INSERT INTO `city` VALUES ('136', '眉山', '');
INSERT INTO `city` VALUES ('137', '梅州', '');
INSERT INTO `city` VALUES ('139', '南通', 'NTG');
INSERT INTO `city` VALUES ('140', '宁波', 'NGB');
INSERT INTO `city` VALUES ('141', '南昌', 'KHN');
INSERT INTO `city` VALUES ('142', '南充', 'NAO');
INSERT INTO `city` VALUES ('143', '宁德', '');
INSERT INTO `city` VALUES ('144', '南宁', 'NNG');
INSERT INTO `city` VALUES ('145', '南阳', 'NNY');
INSERT INTO `city` VALUES ('146', '南平', '');
INSERT INTO `city` VALUES ('147', '内江', '');
INSERT INTO `city` VALUES ('148', '盘锦', '');
INSERT INTO `city` VALUES ('149', '莆田', '');
INSERT INTO `city` VALUES ('150', '攀枝花', 'PZI');
INSERT INTO `city` VALUES ('151', '濮阳', '');
INSERT INTO `city` VALUES ('152', '萍乡', '');
INSERT INTO `city` VALUES ('153', '平顶山', '');
INSERT INTO `city` VALUES ('155', '秦皇岛', 'SHP');
INSERT INTO `city` VALUES ('156', '齐齐哈尔', 'NDG');
INSERT INTO `city` VALUES ('157', '泉州', '');
INSERT INTO `city` VALUES ('158', '衢州', 'JUZ');
INSERT INTO `city` VALUES ('159', '曲靖', '');
INSERT INTO `city` VALUES ('160', '清远', '');
INSERT INTO `city` VALUES ('161', '钦州', '');
INSERT INTO `city` VALUES ('162', '日照', '');
INSERT INTO `city` VALUES ('164', '苏州', '');
INSERT INTO `city` VALUES ('165', '绍兴', '');
INSERT INTO `city` VALUES ('167', '三亚', 'SYX');
INSERT INTO `city` VALUES ('168', '上饶', '');
INSERT INTO `city` VALUES ('169', '韶关', '');
INSERT INTO `city` VALUES ('170', '石河子', '');
INSERT INTO `city` VALUES ('171', '石家庄', 'SJW');
INSERT INTO `city` VALUES ('172', '三明', '');
INSERT INTO `city` VALUES ('173', '四平', '');
INSERT INTO `city` VALUES ('174', '商丘', '');
INSERT INTO `city` VALUES ('175', '汕头', 'SWA');
INSERT INTO `city` VALUES ('177', '十堰', '');
INSERT INTO `city` VALUES ('178', '宿州', '');
INSERT INTO `city` VALUES ('179', '邵阳', '');
INSERT INTO `city` VALUES ('180', '绥化', '');
INSERT INTO `city` VALUES ('181', '松原', '');
INSERT INTO `city` VALUES ('182', '朔州', '');
INSERT INTO `city` VALUES ('183', '遂宁', '');
INSERT INTO `city` VALUES ('184', '汕尾', '');
INSERT INTO `city` VALUES ('185', '宿迁', '');
INSERT INTO `city` VALUES ('186', '石嘴山', '');
INSERT INTO `city` VALUES ('188', '太原', 'TYN');
INSERT INTO `city` VALUES ('189', '泰安', '');
INSERT INTO `city` VALUES ('190', '通化', 'TNH');
INSERT INTO `city` VALUES ('191', '通辽', 'TGO');
INSERT INTO `city` VALUES ('192', '铜陵', '');
INSERT INTO `city` VALUES ('193', '唐山', 'TVS');
INSERT INTO `city` VALUES ('194', '台州', 'HYN');
INSERT INTO `city` VALUES ('195', '铁岭', '');
INSERT INTO `city` VALUES ('196', '无锡', 'WUX');
INSERT INTO `city` VALUES ('197', '乌鲁木齐', 'URC');
INSERT INTO `city` VALUES ('198', '潍坊', 'WEF');
INSERT INTO `city` VALUES ('200', '芜湖', '');
INSERT INTO `city` VALUES ('201', '威海', 'WEH');
INSERT INTO `city` VALUES ('202', '万州', 'WXN');
INSERT INTO `city` VALUES ('203', '温州', 'WNZ');
INSERT INTO `city` VALUES ('204', '梧州', 'WUZ');
INSERT INTO `city` VALUES ('205', '渭南', '');
INSERT INTO `city` VALUES ('206', '西安', 'SIA');
INSERT INTO `city` VALUES ('208', '西双版纳', 'JHG');
INSERT INTO `city` VALUES ('209', '咸阳', '');
INSERT INTO `city` VALUES ('210', '西宁', 'XNN');
INSERT INTO `city` VALUES ('211', '西昌', 'XIC');
INSERT INTO `city` VALUES ('212', '襄阳', 'XFN');
INSERT INTO `city` VALUES ('213', '新乡', '');
INSERT INTO `city` VALUES ('214', '信阳', '');
INSERT INTO `city` VALUES ('215', '徐州', 'XUZ');
INSERT INTO `city` VALUES ('216', '忻州', '');
INSERT INTO `city` VALUES ('217', '湘潭', '');
INSERT INTO `city` VALUES ('218', '新余', '');
INSERT INTO `city` VALUES ('219', '咸宁', '');
INSERT INTO `city` VALUES ('220', '邢台', '');
INSERT INTO `city` VALUES ('221', '宣城', '');
INSERT INTO `city` VALUES ('222', '许昌', '');
INSERT INTO `city` VALUES ('223', '孝感', '');
INSERT INTO `city` VALUES ('224', '仙桃', '');
INSERT INTO `city` VALUES ('225', '扬州', 'YTY');
INSERT INTO `city` VALUES ('226', '银川', 'INC');
INSERT INTO `city` VALUES ('227', '运城', 'YCU');
INSERT INTO `city` VALUES ('228', '玉溪', '');
INSERT INTO `city` VALUES ('229', '宜宾', 'YBP');
INSERT INTO `city` VALUES ('230', '宜昌', 'YIH');
INSERT INTO `city` VALUES ('231', '宜春', '');
INSERT INTO `city` VALUES ('232', '延吉', 'YNJ');
INSERT INTO `city` VALUES ('233', '榆林', 'UYN');
INSERT INTO `city` VALUES ('234', '烟台', 'YNT');
INSERT INTO `city` VALUES ('235', '鹰潭', '');
INSERT INTO `city` VALUES ('236', '义乌', 'YIW');
INSERT INTO `city` VALUES ('237', '岳阳', '');
INSERT INTO `city` VALUES ('238', '阳泉', '');
INSERT INTO `city` VALUES ('239', '永州', 'LLF');
INSERT INTO `city` VALUES ('240', '玉林', '');
INSERT INTO `city` VALUES ('241', '益阳', '');
INSERT INTO `city` VALUES ('242', '盐城', 'YNZ');
INSERT INTO `city` VALUES ('243', '营口', '');
INSERT INTO `city` VALUES ('244', '镇江', '');
INSERT INTO `city` VALUES ('245', '舟山', 'HSN');
INSERT INTO `city` VALUES ('246', '张家界', 'DYG');
INSERT INTO `city` VALUES ('247', '珠海', 'ZUH');
INSERT INTO `city` VALUES ('248', '淄博', '');
INSERT INTO `city` VALUES ('249', '自贡', '');
INSERT INTO `city` VALUES ('250', '湛江', 'ZHA');
INSERT INTO `city` VALUES ('251', '张家口', '');
INSERT INTO `city` VALUES ('252', '驻马店', '');
INSERT INTO `city` VALUES ('253', '肇庆', '');
INSERT INTO `city` VALUES ('254', '中山', '');
INSERT INTO `city` VALUES ('255', '遵义', 'ZYI');
INSERT INTO `city` VALUES ('256', '郑州', 'CGO');
INSERT INTO `city` VALUES ('257', '漳州', '');
INSERT INTO `city` VALUES ('258', '株洲', '');
INSERT INTO `city` VALUES ('259', '枣庄', '');
INSERT INTO `city` VALUES ('260', '张掖', '');
INSERT INTO `city` VALUES ('261', '资阳', '');
INSERT INTO `city` VALUES ('262', '周口', '');
