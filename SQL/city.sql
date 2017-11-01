/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50633
Source Host           : 127.0.0.1:3336
Source Database       : mytool

Target Server Type    : MYSQL
Target Server Version : 50633
File Encoding         : 65001

Date: 2017-11-01 14:20:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `pinyin` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `xiecheng` varchar(100) NOT NULL,
  `xiechengnum` int(8) NOT NULL,
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '1删除 0正常',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of city
-- ----------------------------
INSERT INTO `city` VALUES ('1', 'Beijing', '北京', 'BJS', '1', '0');
INSERT INTO `city` VALUES ('2', 'Shanghai', '上海', 'SHA', '2', '0');
INSERT INTO `city` VALUES ('3', 'Guangzhou', '广州', 'CAN', '32', '0');
INSERT INTO `city` VALUES ('4', 'Shenzhen', '深圳', 'SZX', '30', '0');
INSERT INTO `city` VALUES ('5', 'Chengdu', '成都', 'CTU', '28', '0');
INSERT INTO `city` VALUES ('6', 'Hangzhou', '杭州', 'HGH', '17', '0');
INSERT INTO `city` VALUES ('7', 'Wuhan', '武汉', 'WUH', '477', '0');
INSERT INTO `city` VALUES ('8', 'Xian', '西安', 'SIA', '10', '0');
INSERT INTO `city` VALUES ('9', 'Chongqing', '重庆', 'CKG', '4', '0');
INSERT INTO `city` VALUES ('10', 'Qingdao', '青岛', 'TAO', '7', '0');
INSERT INTO `city` VALUES ('11', 'Changsha', '长沙', 'CSX', '206', '0');
INSERT INTO `city` VALUES ('12', 'Nanjing', '南京', 'NKG', '12', '0');
INSERT INTO `city` VALUES ('13', 'Xiamen', '厦门', 'XMN', '25', '0');
INSERT INTO `city` VALUES ('14', 'Kunming', '昆明', 'KMG', '34', '0');
INSERT INTO `city` VALUES ('15', 'Dalian', '大连', 'DLC', '6', '0');
INSERT INTO `city` VALUES ('16', 'Tianjin', '天津', 'TSN', '3', '0');
INSERT INTO `city` VALUES ('17', 'Zhengzhou', '郑州', 'CGO', '559', '0');
INSERT INTO `city` VALUES ('18', 'Sanya', '三亚', 'SYX', '43', '0');
INSERT INTO `city` VALUES ('19', 'Jinan', '济南', 'TNA', '144', '0');
INSERT INTO `city` VALUES ('20', 'Fuzhou', '福州', 'FOC', '258', '0');
INSERT INTO `city` VALUES ('21', 'Aletai', '阿勒泰', 'AAT', '175', '0');
INSERT INTO `city` VALUES ('22', 'Aksu', '阿克苏', 'AKU', '173', '0');
INSERT INTO `city` VALUES ('23', 'Anshan', '鞍山', 'AOG', '178', '0');
INSERT INTO `city` VALUES ('24', 'Anqing', '安庆', 'AQG', '177', '0');
INSERT INTO `city` VALUES ('25', 'Anshun', '安顺', 'AVA', '179', '0');
INSERT INTO `city` VALUES ('26', 'Alashanzuoqi', '阿拉善左旗', 'AXF', '21269', '0');
INSERT INTO `city` VALUES ('27', 'Macau', '澳门', 'MFM', '59', '0');
INSERT INTO `city` VALUES ('28', 'Ali', '阿里', 'NGQ', '97', '0');
INSERT INTO `city` VALUES ('29', 'Alashanyouqi', '阿拉善右旗', 'RHT', '21863', '0');
INSERT INTO `city` VALUES ('30', 'Aershan', '阿尔山', 'YIE', '1658', '0');
INSERT INTO `city` VALUES ('31', 'Baise', '百色', 'AEB', '1140', '0');
INSERT INTO `city` VALUES ('32', 'Baotou', '包头', 'BAV', '141', '0');
INSERT INTO `city` VALUES ('33', 'Bijie', '毕节', 'BFJ', '22031', '0');
INSERT INTO `city` VALUES ('34', 'Beihai', '北海', 'BHY', '189', '0');
INSERT INTO `city` VALUES ('35', 'Beijing', '北京', 'BJS', '1', '1');
INSERT INTO `city` VALUES ('36', 'Beijing(NANYUAN)', '北京', 'BJS,NAY', '1', '0');
INSERT INTO `city` VALUES ('37', 'Beijing(CAPITAL)', '北京', 'BJS,PEK', '1', '0');
INSERT INTO `city` VALUES ('38', 'Bole', '博乐', 'BPL', '2548', '0');
INSERT INTO `city` VALUES ('39', 'Baoshan', '保山', 'BSD', '197', '0');
INSERT INTO `city` VALUES ('40', 'Baicheng', '白城', 'DBC', '1116', '0');
INSERT INTO `city` VALUES ('41', 'Burqin', '布尔津', 'KJI', '3326', '0');
INSERT INTO `city` VALUES ('42', 'Baishan', '白山', 'NBS', '199', '0');
INSERT INTO `city` VALUES ('43', 'Bayan Nur', '巴彦淖尔', 'RLK', '3887', '0');
INSERT INTO `city` VALUES ('44', 'Qamdo', '昌都', 'BPX', '575', '0');
INSERT INTO `city` VALUES ('45', 'Chengde', '承德', 'CDE', '562', '0');
INSERT INTO `city` VALUES ('46', 'Changde', '常德', 'CGD', '201', '0');
INSERT INTO `city` VALUES ('47', 'Changchun', '长春', 'CGQ', '158', '0');
INSERT INTO `city` VALUES ('48', 'Chaoyang', '朝阳', 'CHG', '211', '0');
INSERT INTO `city` VALUES ('49', 'Chifeng', '赤峰', 'CIF', '202', '0');
INSERT INTO `city` VALUES ('50', 'Changzhi', '长治', 'CIH', '137', '0');
INSERT INTO `city` VALUES ('51', 'Chongqing', '重庆', 'CKG', '4', '1');
INSERT INTO `city` VALUES ('52', 'Changsha', '长沙', 'CSX', '206', '1');
INSERT INTO `city` VALUES ('53', 'Chengdu', '成都', 'CTU', '28', '1');
INSERT INTO `city` VALUES ('54', 'Cangyuan', '沧源', 'CWJ', '21741', '0');
INSERT INTO `city` VALUES ('55', 'Changzhou', '常州', 'CZX', '213', '0');
INSERT INTO `city` VALUES ('56', 'Chizhou', '池州', 'JUH', '218', '0');
INSERT INTO `city` VALUES ('57', 'Chaozhou', '潮州', 'SWA', '215', '0');
INSERT INTO `city` VALUES ('58', 'Chaoshan', '潮汕', 'SWA', '956', '0');
INSERT INTO `city` VALUES ('59', 'Datong', '大同', 'DAT', '136', '0');
INSERT INTO `city` VALUES ('60', 'Daxian', '达县', 'DAX', '234', '0');
INSERT INTO `city` VALUES ('61', 'Dazhou', '达州', 'DAX', '234', '1');
INSERT INTO `city` VALUES ('62', 'Daocheng', '稻城', 'DCY', '1222', '0');
INSERT INTO `city` VALUES ('63', 'Dandong', '丹东', 'DDG', '221', '0');
INSERT INTO `city` VALUES ('64', 'Diqing', '迪庆', 'DIG', '93', '0');
INSERT INTO `city` VALUES ('65', 'Dalian', '大连', 'DLC', '6', '1');
INSERT INTO `city` VALUES ('66', 'Dali', '大理', 'DLU', '36', '0');
INSERT INTO `city` VALUES ('67', 'Dunhuang', '敦煌', 'DNH', '11', '0');
INSERT INTO `city` VALUES ('68', 'Dongying', '东营', 'DOY', '236', '0');
INSERT INTO `city` VALUES ('69', 'Daqing', '大庆', 'DQA', '231', '0');
INSERT INTO `city` VALUES ('70', 'Delingha', '德令哈', 'HXD', '2542', '0');
INSERT INTO `city` VALUES ('71', 'Dehong', '德宏', 'LUM', '3997', '0');
INSERT INTO `city` VALUES ('72', 'Ordos', '鄂尔多斯', 'DSN', '3976', '0');
INSERT INTO `city` VALUES ('73', 'Ejinaqi', '额济纳旗', 'EJN', '21339', '0');
INSERT INTO `city` VALUES ('74', 'Enshi', '恩施', 'ENH', '245', '0');
INSERT INTO `city` VALUES ('75', 'Erenhot', '二连浩特', 'ERL', '7626', '0');
INSERT INTO `city` VALUES ('76', 'Fuzhou', '福州', 'FOC', '258', '1');
INSERT INTO `city` VALUES ('77', 'Fuyang', '阜阳', 'FUG', '257', '0');
INSERT INTO `city` VALUES ('78', 'Foshan', '佛山', 'FUO', '251', '0');
INSERT INTO `city` VALUES ('79', 'Fuyuan', '抚远', 'FYJ', '21943', '0');
INSERT INTO `city` VALUES ('80', 'Fuyun', '富蕴', 'FYN', '255', '0');
INSERT INTO `city` VALUES ('81', 'Guangzhou', '广州', 'CAN', '32', '1');
INSERT INTO `city` VALUES ('82', 'Golog', '果洛', 'GMQ', '21862', '0');
INSERT INTO `city` VALUES ('83', 'Golmud', '格尔木', 'GOQ', '132', '0');
INSERT INTO `city` VALUES ('84', 'Guangyuan', '广元', 'GYS', '267', '0');
INSERT INTO `city` VALUES ('85', 'Guyuan', '固原', 'GYU', '321', '0');
INSERT INTO `city` VALUES ('86', 'Kaohsiung', '高雄', 'KHH', '720', '0');
INSERT INTO `city` VALUES ('87', 'Ganzhou', '赣州', 'KOW', '268', '0');
INSERT INTO `city` VALUES ('88', 'Guiyang', '贵阳', 'KWE', '38', '0');
INSERT INTO `city` VALUES ('89', 'Guilin', '桂林', 'KWL', '33', '0');
INSERT INTO `city` VALUES ('90', 'Hongyuan', '红原', 'AHJ', '7835', '0');
INSERT INTO `city` VALUES ('91', 'Haikou', '海口', 'HAK', '42', '0');
INSERT INTO `city` VALUES ('92', 'Hechi', '河池', 'HCJ', '3969', '0');
INSERT INTO `city` VALUES ('93', 'Handan', '邯郸', 'HDG', '275', '0');
INSERT INTO `city` VALUES ('94', 'Heihe', '黑河', 'HEK', '281', '0');
INSERT INTO `city` VALUES ('95', 'Hohhot', '呼和浩特', 'HET', '103', '0');
INSERT INTO `city` VALUES ('96', 'Hefei', '合肥', 'HFE', '278', '0');
INSERT INTO `city` VALUES ('97', 'Hangzhou', '杭州', 'HGH', '17', '1');
INSERT INTO `city` VALUES ('98', 'Huai\'an', '淮安', 'HIA', '577', '0');
INSERT INTO `city` VALUES ('99', 'Huaihua', '怀化', 'HJJ', '282', '0');
INSERT INTO `city` VALUES ('100', 'Hailar', '海拉尔', 'HLD', '142', '0');
INSERT INTO `city` VALUES ('101', 'Hami', '哈密', 'HMI', '285', '0');
INSERT INTO `city` VALUES ('102', 'Hengyang', '衡阳', 'HNY', '297', '0');
INSERT INTO `city` VALUES ('103', 'Harbin', '哈尔滨', 'HRB', '5', '0');
INSERT INTO `city` VALUES ('104', 'Hotan', '和田', 'HTN', '294', '0');
INSERT INTO `city` VALUES ('105', 'HUATUGOU', '花土沟', 'HTT', '83679', '0');
INSERT INTO `city` VALUES ('106', 'Hualien', '花莲', 'HUN', '6954', '0');
INSERT INTO `city` VALUES ('107', 'huolinguole', '霍林郭勒', 'HUO', '21091', '0');
INSERT INTO `city` VALUES ('108', 'Huizhou', '惠州', 'HUZ', '299', '0');
INSERT INTO `city` VALUES ('109', 'Hanzhong', '汉中', 'HZG', '129', '0');
INSERT INTO `city` VALUES ('110', 'Huangshan', '黄山', 'TXN', '23', '0');
INSERT INTO `city` VALUES ('111', 'Chiayi', '嘉义', 'CYI', '5152', '0');
INSERT INTO `city` VALUES ('112', 'Jingdezhen', '景德镇', 'JDZ', '305', '0');
INSERT INTO `city` VALUES ('113', 'Jiagedaqi', '加格达奇', 'JGD', '1143', '0');
INSERT INTO `city` VALUES ('114', 'Jiayuguan', '嘉峪关', 'JGN', '326', '0');
INSERT INTO `city` VALUES ('115', 'Jinggangshan', '井冈山', 'JGS', '307', '0');
INSERT INTO `city` VALUES ('116', 'Jinghong', '景洪', 'JHG', '35', '0');
INSERT INTO `city` VALUES ('117', 'Jinchang', '金昌', 'JIC', '1158', '0');
INSERT INTO `city` VALUES ('118', 'Jiujiang', '九江', 'JIU', '24', '0');
INSERT INTO `city` VALUES ('119', 'Jinjiang', '晋江', 'JJN', '406', '0');
INSERT INTO `city` VALUES ('120', 'Jiamusi', '佳木斯', 'JMU', '317', '0');
INSERT INTO `city` VALUES ('121', 'Jining', '济宁', 'JNG', '318', '0');
INSERT INTO `city` VALUES ('122', 'Jinzhou', '锦州', 'JNZ', '327', '0');
INSERT INTO `city` VALUES ('123', 'Jixi', '鸡西', 'JXA', '157', '0');
INSERT INTO `city` VALUES ('124', 'Jiuzhaigou', '九寨沟', 'JZH', '91', '0');
INSERT INTO `city` VALUES ('125', 'Kinmen', '金门', 'KNH', '7203', '0');
INSERT INTO `city` VALUES ('126', 'Jieyang', '揭阳', 'SWA', '956', '0');
INSERT INTO `city` VALUES ('127', 'Jinan', '济南', 'TNA', '144', '1');
INSERT INTO `city` VALUES ('128', 'Kuqa', '库车', 'KCA', '329', '0');
INSERT INTO `city` VALUES ('129', 'Kangding', '康定', 'KGT', '4130', '0');
INSERT INTO `city` VALUES ('130', 'Kashgar', '喀什', 'KHG', '109', '0');
INSERT INTO `city` VALUES ('131', 'Kaili', '凯里', 'KJH', '333', '0');
INSERT INTO `city` VALUES ('132', 'Kunming', '昆明', 'KMG', '34', '1');
INSERT INTO `city` VALUES ('133', 'Korla', '库尔勒', 'KRL', '330', '0');
INSERT INTO `city` VALUES ('134', 'Karamay', '克拉玛依', 'KRY', '166', '0');
INSERT INTO `city` VALUES ('135', 'Liping', '黎平', 'HZH', '3852', '0');
INSERT INTO `city` VALUES ('136', 'Lancang', '澜沧', 'JMJ', '21596', '0');
INSERT INTO `city` VALUES ('137', 'Longyan', '龙岩', 'LCX', '348', '0');
INSERT INTO `city` VALUES ('138', 'Linfen', '临汾', 'LFQ', '139', '0');
INSERT INTO `city` VALUES ('139', 'Lanzhou', '兰州', 'LHW', '100', '0');
INSERT INTO `city` VALUES ('140', 'Lijiang', '丽江', 'LJG', '37', '0');
INSERT INTO `city` VALUES ('141', 'Libo', '荔波', 'LLB', '1708', '0');
INSERT INTO `city` VALUES ('142', 'Lvliang', '吕梁', 'LLV', '7631', '0');
INSERT INTO `city` VALUES ('143', 'Lincang', '临沧', 'LNJ', '1236', '0');
INSERT INTO `city` VALUES ('144', 'Liupanshui', '六盘水', 'LPF', '605', '0');
INSERT INTO `city` VALUES ('145', 'Lhasa', '拉萨', 'LXA', '41', '0');
INSERT INTO `city` VALUES ('146', 'Luoyang', '洛阳', 'LYA', '350', '0');
INSERT INTO `city` VALUES ('147', 'Lianyungang', '连云港', 'LYG', '353', '0');
INSERT INTO `city` VALUES ('148', 'Linyi', '临沂', 'LYI', '569', '0');
INSERT INTO `city` VALUES ('149', 'Liuzhou', '柳州', 'LZH', '354', '0');
INSERT INTO `city` VALUES ('150', 'Luzhou', '泸州', 'LZO', '355', '0');
INSERT INTO `city` VALUES ('151', 'Nyingtri', '林芝', 'LZY', '108', '0');
INSERT INTO `city` VALUES ('152', 'Mangshi', '芒市', 'LUM', '3997', '1');
INSERT INTO `city` VALUES ('153', 'Mudanjiang', '牡丹江', 'MDG', '150', '0');
INSERT INTO `city` VALUES ('154', 'MATSU', '马祖', 'MFK', '7808', '0');
INSERT INTO `city` VALUES ('155', 'Mianyang', '绵阳', 'MIG', '370', '0');
INSERT INTO `city` VALUES ('156', 'Meizhou', '梅州', 'MXZ', '3053', '0');
INSERT INTO `city` VALUES ('157', 'MAKUNG', '马公', 'MZG', '5383', '0');
INSERT INTO `city` VALUES ('158', 'Manzhouli', '满洲里', 'NZH', '1083', '0');
INSERT INTO `city` VALUES ('159', 'Mohe', '漠河', 'OHE', '155', '0');
INSERT INTO `city` VALUES ('160', 'Nanchang', '南昌', 'KHN', '376', '0');
INSERT INTO `city` VALUES ('161', 'Nangan', '南竿', 'LZN', '91804', '0');
INSERT INTO `city` VALUES ('162', 'Nanchong', '南充', 'NAO', '377', '0');
INSERT INTO `city` VALUES ('163', 'Ningbo', '宁波', 'NGB', '375', '0');
INSERT INTO `city` VALUES ('164', 'Nanjing', '南京', 'NKG', '12', '1');
INSERT INTO `city` VALUES ('165', 'Ninglang', '宁蒗', 'NLH', '1161', '0');
INSERT INTO `city` VALUES ('166', 'Nanning', '南宁', 'NNG', '380', '0');
INSERT INTO `city` VALUES ('167', 'Nanyang', '南阳', 'NNY', '385', '0');
INSERT INTO `city` VALUES ('168', 'Nantong', '南通', 'NTG', '82', '0');
INSERT INTO `city` VALUES ('169', 'Penghu Islands', '澎湖列岛', 'MZG', '5383', '1');
INSERT INTO `city` VALUES ('170', 'Panzhihua', '攀枝花', 'PZI', '1097', '0');
INSERT INTO `city` VALUES ('171', 'Pu\'er', '普洱', 'SYM', '3996', '0');
INSERT INTO `city` VALUES ('172', 'Qionghai', '琼海', 'BAR', '52', '0');
INSERT INTO `city` VALUES ('173', 'Qinhuangdao', '秦皇岛', 'BPE', '147', '0');
INSERT INTO `city` VALUES ('174', 'Qiemo', '且末', 'IQM', '399', '0');
INSERT INTO `city` VALUES ('175', 'Qingyang', '庆阳', 'IQN', '404', '0');
INSERT INTO `city` VALUES ('176', 'Qianjiang', '黔江', 'JIQ', '7708', '0');
INSERT INTO `city` VALUES ('177', 'Quanzhou', '泉州', 'JJN', '406', '1');
INSERT INTO `city` VALUES ('178', 'Quzhou', '衢州', 'JUZ', '407', '0');
INSERT INTO `city` VALUES ('179', 'Qiqihar', '齐齐哈尔', 'NDG', '149', '0');
INSERT INTO `city` VALUES ('180', 'Qingdao', '青岛', 'TAO', '7', '1');
INSERT INTO `city` VALUES ('181', 'Rizhao', '日照', 'RIZ', '1106', '0');
INSERT INTO `city` VALUES ('182', 'Rikaze', '日喀则', 'RKZ', '92', '0');
INSERT INTO `city` VALUES ('183', 'Shennongjia', '神农架', 'HPG', '657', '0');
INSERT INTO `city` VALUES ('184', 'Shache', '莎车', 'QSZ', '21827', '0');
INSERT INTO `city` VALUES ('185', 'Shanghai', '上海', 'SHA', '2', '1');
INSERT INTO `city` VALUES ('186', 'Shanghai(PU DONG)', '上海', 'SHA,PVG', '2', '0');
INSERT INTO `city` VALUES ('187', 'Shanghai(HONGQIAO)', '上海', 'SHA,SHA', '2', '0');
INSERT INTO `city` VALUES ('188', 'Shenyang', '沈阳', 'SHE', '451', '0');
INSERT INTO `city` VALUES ('189', 'Shihezi', '石河子', 'SHF', '426', '0');
INSERT INTO `city` VALUES ('190', 'Shijiazhuang', '石家庄', 'SJW', '428', '0');
INSERT INTO `city` VALUES ('191', 'Shangrao', '上饶', 'SQD', '411', '0');
INSERT INTO `city` VALUES ('192', 'Sanming', '三明', 'SQJ', '437', '0');
INSERT INTO `city` VALUES ('193', 'Shantou', '汕头', 'SWA', '447', '1');
INSERT INTO `city` VALUES ('194', 'Sanya', '三亚', 'SYX', '43', '1');
INSERT INTO `city` VALUES ('195', 'Shenzhen', '深圳', 'SZX', '30', '1');
INSERT INTO `city` VALUES ('196', 'SHIYAN', '十堰', 'WDS', '452', '0');
INSERT INTO `city` VALUES ('197', 'Shaoyang', '邵阳', 'WGN', '1111', '0');
INSERT INTO `city` VALUES ('198', 'Taizhou', '台州', 'HYN', '578', '0');
INSERT INTO `city` VALUES ('199', 'Taichung', '台中', 'RMQ', '3849', '0');
INSERT INTO `city` VALUES ('200', 'Tacheng', '塔城', 'TCG', '455', '0');
INSERT INTO `city` VALUES ('201', 'Tengchong', '腾冲', 'TCZ', '1819', '0');
INSERT INTO `city` VALUES ('202', 'Tongren', '铜仁', 'TEN', '1227', '0');
INSERT INTO `city` VALUES ('203', 'Tongliao', '通辽', 'TGO', '458', '0');
INSERT INTO `city` VALUES ('204', 'Tianshui', '天水', 'THQ', '464', '0');
INSERT INTO `city` VALUES ('205', 'Tulufan', '吐鲁番', 'TLQ', '21811', '0');
INSERT INTO `city` VALUES ('206', 'Tonghua', '通化', 'TNH', '456', '0');
INSERT INTO `city` VALUES ('207', 'Tainan', '台南', 'TNN', '3847', '0');
INSERT INTO `city` VALUES ('208', 'Taipei', '台北', 'TPE', '617', '0');
INSERT INTO `city` VALUES ('209', 'Tianjin', '天津', 'TSN', '3', '1');
INSERT INTO `city` VALUES ('210', 'Taitung', '台东', 'TTT', '3848', '0');
INSERT INTO `city` VALUES ('211', 'Tangshan', '唐山', 'TVS', '468', '0');
INSERT INTO `city` VALUES ('212', 'Taiyuan', '太原', 'TYN', '105', '0');
INSERT INTO `city` VALUES ('213', 'Taizhou', '泰州', 'YTY', '15', '0');
INSERT INTO `city` VALUES ('214', 'Ulan Hot', '乌兰浩特', 'HLH', '484', '0');
INSERT INTO `city` VALUES ('215', 'ULANQAB', '乌兰察布', 'UCB', '7518', '0');
INSERT INTO `city` VALUES ('216', 'Urumqi', '乌鲁木齐', 'URC', '39', '0');
INSERT INTO `city` VALUES ('217', 'Weifang', '潍坊', 'WEF', '475', '0');
INSERT INTO `city` VALUES ('218', 'Weihai', '威海', 'WEH', '479', '0');
INSERT INTO `city` VALUES ('219', 'Wenshan', '文山', 'WNH', '1342', '0');
INSERT INTO `city` VALUES ('220', 'Wenzhou', '温州', 'WNZ', '491', '0');
INSERT INTO `city` VALUES ('221', 'Wuhai', '乌海', 'WUA', '1133', '0');
INSERT INTO `city` VALUES ('222', 'Wuhan', '武汉', 'WUH', '477', '1');
INSERT INTO `city` VALUES ('223', 'Wuyishan', '武夷山', 'WUS', '26', '0');
INSERT INTO `city` VALUES ('224', 'Wuxi', '无锡', 'WUX', '13', '0');
INSERT INTO `city` VALUES ('225', 'Wuzhou', '梧州', 'WUZ', '492', '0');
INSERT INTO `city` VALUES ('226', 'Wanzhou', '万州', 'WXN', '487', '0');
INSERT INTO `city` VALUES ('227', 'Xingyi', '兴义', 'ACX', '1139', '0');
INSERT INTO `city` VALUES ('228', 'Xiahe', '夏河', 'GXH', '497', '0');
INSERT INTO `city` VALUES ('229', 'Hong Kong', '香港', 'HKG', '58', '0');
INSERT INTO `city` VALUES ('230', 'Xishuangbanna', '西双版纳', 'JHG', '35', '1');
INSERT INTO `city` VALUES ('231', 'Xinyuan', '新源', 'NLT', '3360', '0');
INSERT INTO `city` VALUES ('232', 'Xi\'an', '西安', 'SIA', '10', '1');
INSERT INTO `city` VALUES ('233', 'Xinzhou', '忻州', 'WUT', '513', '0');
INSERT INTO `city` VALUES ('234', 'Xiangyang', '襄阳', 'XFN', '496', '0');
INSERT INTO `city` VALUES ('235', 'Xichang', '西昌', 'XIC', '494', '0');
INSERT INTO `city` VALUES ('236', 'Xilinhot', '锡林浩特', 'XIL', '500', '0');
INSERT INTO `city` VALUES ('237', 'Xiamen', '厦门', 'XMN', '25', '1');
INSERT INTO `city` VALUES ('238', 'Xining', '西宁', 'XNN', '124', '0');
INSERT INTO `city` VALUES ('239', 'Xuzhou', '徐州', 'XUZ', '512', '0');
INSERT INTO `city` VALUES ('240', 'Yan\'an', '延安', 'ENY', '110', '0');
INSERT INTO `city` VALUES ('241', 'Yinchuan', '银川', 'INC', '99', '0');
INSERT INTO `city` VALUES ('242', 'Yichun', '伊春', 'LDS', '517', '0');
INSERT INTO `city` VALUES ('243', 'Yongzhou', '永州', 'LLF', '970', '0');
INSERT INTO `city` VALUES ('244', 'Yulin', '榆林', 'UYN', '527', '0');
INSERT INTO `city` VALUES ('245', 'Yibin', '宜宾', 'YBP', '514', '0');
INSERT INTO `city` VALUES ('246', 'Yuncheng', '运城', 'YCU', '140', '0');
INSERT INTO `city` VALUES ('247', 'Yichun', '宜春', 'YIC', '518', '0');
INSERT INTO `city` VALUES ('248', 'Yichang', '宜昌', 'YIH', '515', '0');
INSERT INTO `city` VALUES ('249', 'Yining', '伊宁', 'YIN', '529', '0');
INSERT INTO `city` VALUES ('250', 'Yiwu', '义乌', 'YIW', '536', '0');
INSERT INTO `city` VALUES ('251', 'Yingkou', '营口', 'YKH', '1300', '0');
INSERT INTO `city` VALUES ('252', 'Yanji', '延吉', 'YNJ', '523', '0');
INSERT INTO `city` VALUES ('253', 'Yantai', '烟台', 'YNT', '533', '0');
INSERT INTO `city` VALUES ('254', 'Yancheng', '盐城', 'YNZ', '1200', '0');
INSERT INTO `city` VALUES ('255', 'Yangzhou', '扬州', 'YTY', '15', '1');
INSERT INTO `city` VALUES ('256', 'Yushu', '玉树', 'YUS', '7582', '0');
INSERT INTO `city` VALUES ('257', 'Zhengzhou', '郑州', 'CGO', '559', '1');
INSERT INTO `city` VALUES ('258', 'Zhangjiajie', '张家界', 'DYG', '27', '0');
INSERT INTO `city` VALUES ('259', 'Zhoushan', '舟山', 'HSN', '19', '0');
INSERT INTO `city` VALUES ('260', 'Zhalantun', '扎兰屯', 'NZL', '1135', '0');
INSERT INTO `city` VALUES ('261', 'ZHANGYE', '张掖', 'YZY', '663', '0');
INSERT INTO `city` VALUES ('262', 'ZHAOTONG', '昭通', 'ZAT', '555', '0');
INSERT INTO `city` VALUES ('263', 'ZHANJIANG', '湛江', 'ZHA', '547', '0');
INSERT INTO `city` VALUES ('264', 'ZHONGWEI', '中卫', 'ZHY', '556', '0');
INSERT INTO `city` VALUES ('265', 'Zhangjiakou', '张家口', 'ZQZ', '550', '0');
INSERT INTO `city` VALUES ('266', 'Zhuhai', '珠海', 'ZUH', '31', '0');
INSERT INTO `city` VALUES ('267', 'Zunyi', '遵义', 'ZYI', '558', '0');
