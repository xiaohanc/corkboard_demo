-- MySQL dump 10.13  Distrib 5.6.34, for Win32 (AMD64)
--
-- Host: localhost    Database: corkboard1
-- ------------------------------------------------------
-- Server version	5.6.34-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `categoryID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(250) NOT NULL,
  PRIMARY KEY (`categoryID`),
  UNIQUE KEY `cat_name` (`cat_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (2,'Architecture'),(12,'Art'),(1,'Education'),(11,'Food& Drink'),(3,'Home&Garden'),(10,'Other'),(4,'People'),(8,'Pets'),(6,'Photography'),(7,'Sports'),(9,'Technology'),(5,'Travel');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `commentID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `added_time` datetime NOT NULL,
  `content` varchar(250) DEFAULT NULL,
  `pushPinID` int(16) unsigned NOT NULL,
  PRIMARY KEY (`commentID`),
  KEY `fk_Comment_email_User_email` (`email`),
  KEY `fk_Comment_pushPinID_PushPin_pushPinID` (`pushPinID`),
  CONSTRAINT `fk_Comment_email_User_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`),
  CONSTRAINT `fk_Comment_pushPinID_PushPin_pushPinID` FOREIGN KEY (`pushPinID`) REFERENCES `pushpin` (`pushpinid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (21,'user1@123.com','2018-11-25 15:32:10','Looks deliciouse!',62),(22,'user2@123.com','2018-11-25 15:39:14','Yes, it does',62),(23,'user3@123.com','2018-11-25 16:17:08','Cute Dog!',67),(24,'user3@123.com','2018-11-25 16:17:44','Great Picture!',54),(25,'user3@123.com','2018-11-25 16:18:01','I like Mac!',63),(26,'user3@123.com','2018-11-25 16:18:17','I would like to buy a Mac!',63),(27,'user4@123.com','2018-11-25 16:18:39','Thank you!',67),(28,'user4@123.com','2018-11-25 16:18:57','Old Machine!',65),(29,'user4@123.com','2018-11-25 16:19:08','Spacious!',64),(30,'user5@123.com','2018-11-25 16:19:31','Who is this guy?',49),(31,'user5@123.com','2018-11-25 16:19:47','Leo looks young!',50),(32,'user6@123.com','2018-11-25 16:20:43','Very old style!',52),(33,'user6@123.com','2018-11-25 16:21:00','Nice sign!',56);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corkboard`
--

DROP TABLE IF EXISTS `corkboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corkboard` (
  `corkBoardID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `cat_name` varchar(250) NOT NULL,
  `title` varchar(250) NOT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`corkBoardID`),
  UNIQUE KEY `title` (`title`),
  KEY `fk_CorkBoard_email_User_email` (`email`),
  KEY `fk_CorkBoard_cat_name_Category_cat_name` (`cat_name`),
  CONSTRAINT `fk_CorkBoard_cat_name_Category_cat_name` FOREIGN KEY (`cat_name`) REFERENCES `category` (`cat_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_CorkBoard_email_User_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corkboard`
--

LOCK TABLES `corkboard` WRITE;
/*!40000 ALTER TABLE `corkboard` DISABLE KEYS */;
INSERT INTO `corkboard` VALUES (29,'user1@123.com','Education','User1_Education','2018-11-25 09:43:58'),(30,'user1@123.com','People','user1_People','2018-11-25 09:46:15'),(31,'user2@123.com','Architecture','user2_Architecture','2018-11-25 09:53:35'),(32,'user3@123.com','Sports','user3_Sports','2018-11-25 09:58:53'),(33,'user4@123.com','Food& Drink','user4_Food& Drink','2018-11-25 10:00:15'),(34,'user5@123.com','Technology','user5_Technology','2018-11-25 10:03:18'),(35,'user5@123.com','Pets','user5_Pets','2018-11-25 10:04:36'),(37,'user6@123.com','Travel','user6_Travel','2018-11-25 10:30:13');
/*!40000 ALTER TABLE `corkboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `follow` (
  `followID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `owner_email` varchar(250) NOT NULL,
  PRIMARY KEY (`followID`),
  KEY `fk_Follow_email_User_email` (`email`),
  KEY `fk_Follow_owner_email_User_email` (`owner_email`),
  CONSTRAINT `fk_Follow_email_User_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Follow_owner_email_User_email` FOREIGN KEY (`owner_email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES (1,'user1@123.com','user2@123.com'),(10,'user1@123.com','user3@123.com'),(11,'user2@123.com','user3@123.com'),(12,'user2@123.com','user4@123.com'),(13,'user3@123.com','user4@123.com'),(14,'user3@123.com','user5@123.com'),(15,'user4@123.com','user5@123.com'),(16,'user4@123.com','user6@123.com'),(17,'user5@123.com','user6@123.com'),(18,'user5@123.com','user1@123.com'),(19,'user6@123.com','user1@123.com'),(22,'user6@123.com','user2@123.com');
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `LikesID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `pushPinID` int(16) unsigned NOT NULL,
  PRIMARY KEY (`LikesID`),
  KEY `fk_Likes_email_User_email` (`email`),
  KEY `fk_Likes_pushPinID_PushPin_pushPinID` (`pushPinID`),
  CONSTRAINT `fk_Likes_email_User_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Likes_pushPinID_PushPin_pushPinID` FOREIGN KEY (`pushPinID`) REFERENCES `pushpin` (`pushpinid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (10,'user1@123.com',62),(12,'user1@123.com',61),(13,'user2@123.com',62),(14,'user3@123.com',62),(15,'user3@123.com',67),(16,'user3@123.com',54),(17,'user3@123.com',63),(18,'user4@123.com',64),(19,'user5@123.com',50),(20,'user6@123.com',52),(21,'user6@123.com',56);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privatecorkboard`
--

DROP TABLE IF EXISTS `privatecorkboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privatecorkboard` (
  `corkBoardID` int(16) unsigned NOT NULL,
  `last_update` datetime DEFAULT NULL,
  `password` varchar(60) NOT NULL,
  PRIMARY KEY (`corkBoardID`),
  CONSTRAINT `fk_PrivateCorkBoard_corkBoardID_CorkBoard_corkBoardID` FOREIGN KEY (`corkBoardID`) REFERENCES `corkboard` (`corkBoardID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privatecorkboard`
--

LOCK TABLES `privatecorkboard` WRITE;
/*!40000 ALTER TABLE `privatecorkboard` DISABLE KEYS */;
INSERT INTO `privatecorkboard` VALUES (30,'2018-11-25 09:46:15','1234'),(35,'2018-11-25 10:04:36','1234');
/*!40000 ALTER TABLE `privatecorkboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pushpin`
--

DROP TABLE IF EXISTS `pushpin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pushpin` (
  `pushPinID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `corkBoardID` int(16) unsigned NOT NULL,
  `image_URL` varchar(250) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `pinned_time` datetime NOT NULL,
  PRIMARY KEY (`pushPinID`),
  KEY `fk_PushPin_corkBoardID_CorkBoard_corkBoardID` (`corkBoardID`),
  KEY `image_URL` (`image_URL`) USING BTREE,
  CONSTRAINT `fk_PushPin_corkBoardID_CorkBoard_corkBoardID` FOREIGN KEY (`corkBoardID`) REFERENCES `corkboard` (`corkBoardID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pushpin`
--

LOCK TABLES `pushpin` WRITE;
/*!40000 ALTER TABLE `pushpin` DISABLE KEYS */;
INSERT INTO `pushpin` VALUES (45,29,'https://www.cc.gatech.edu/sites/default/files/images/mercury/oms-cs-web-rotator_2_0_3.jpeg',' OMSCS program logo','2018-11-25 14:42:16'),(46,29,'http://www.buzzcard.gatech.edu/sites/default/files/uploads/images/superblock_images/img_2171.jpg ','Description: student ID for Georgia Tech','2018-11-25 14:43:00'),(47,29,'https://www.news.gatech.edu/sites/default/files/uploads/mercury_images/piazza-icon.png','logo for Piazza','2018-11-25 14:43:17'),(48,29,'http://www.comm.gatech.edu/sites/default/files/images/brand-graphics/gt-seal.png','official seal of Georgia Tech','2018-11-25 14:43:59'),(49,30,'http://www.me.gatech.edu/sites/default/files/styles/180_240/public/gpburdell.jpg','the struggle is real!','2018-11-25 14:45:20'),(50,30,'https://www.cc.gatech.edu/projects/XMLApe/people/imgs/leo.jpg','Leo Mark, CS 6400 professor','2018-11-25 14:45:58'),(51,30,'https://www.cc.gatech.edu/sites/default/files/images/27126038747_06d417015b_z.jpg','fearless leader of OMSCS','2018-11-25 14:46:16'),(52,31,'http://daily.gatech.edu/sites/default/files/styles/1170_x_x/public/hgt-tower-crop.jpg','Tech Tower interior photo','2018-11-25 14:47:46'),(53,31,'http://www.livinghistory.gatech.edu/s/1481/images/content_images/techtower1_636215523842964533.jpg','Tech Tower exterior photo','2018-11-25 14:48:01'),(54,31,'https://www.ece.gatech.edu/sites/default/files/styles/1500_x_scale/public/images/mercury/kessler2.0442077-p16-49.jpg','Kessler Campanile at Georgia Tech','2018-11-25 14:52:42'),(55,31,'https://www.scs.gatech.edu/sites/scs.gatech.edu/files/files/klaus-building.jpg','Klaus building','2018-11-25 14:53:17'),(56,31,'https://www.news.gatech.edu/sites/default/files/styles/740_x_scale/public/uploads/mercury_images/Tech_Tower_WebFeature_1.jpg','Tech tower sign','2018-11-25 14:53:36'),(57,32,'http://traditions.gatech.edu/images/mantle-reck3.jpg','Ramblin’ wreck today','2018-11-25 14:57:58'),(58,32,'http://www.swag.gatech.edu/sites/default/files/buzz-android-tablet.jpg','Driving the mini wreck','2018-11-25 14:58:17'),(59,32,'http://www.livinghistory.gatech.edu/s/1481/images/content_images/ramblinwreck1_636215542678295357.jpg','Ramblin’ Wreck of the past','2018-11-25 14:58:33'),(60,32,'https://www.news.gatech.edu/sites/default/files/uploads/mercury_images/screen_shot_2016-08-11_at_12.45.48_pm_10.png','Bobby Dodd stadium','2018-11-25 14:58:54'),(61,33,'http://www.livinghistory.gatech.edu/s/1481/images/content_images/thevarsity1_636215546286483906.jpg','The Varsity','2018-11-25 14:59:53'),(62,33,'http://blogs.iac.gatech.edu/food14/files/2014/09/wafflefries2.jpg','Chick-fil-a Waffle Fries','2018-11-25 15:00:15'),(63,34,'http://it.studentlife.gatech.edu/sites/default/files/uploads/images/superblock_images/it_imac.png','iMac','2018-11-25 15:02:38'),(64,34,'https://pe.gatech.edu/sites/pe.gatech.edu/files/component_assets/Computer_Lab_Tech_750_x_500.jpg','Computer lab','2018-11-25 15:03:02'),(65,34,'https://www.scs.gatech.edu/sites/scs.gatech.edu/files/files/cs-research-databases.jpg','Database server','2018-11-25 15:03:19'),(66,35,' https://hr.gatech.edu/sites/default/files/uploads/images/superblock_images/nee-buzz.jpg','Buzz','2018-11-25 15:04:00'),(67,35,'https://georgiadogs.com/images/2018/4/6/18_Uga_VIII.jpg','Uga the “dog\"','2018-11-25 15:04:21'),(68,35,'https://www.news.gatech.edu/sites/default/files/pictures/feature_images/running%20sideways.jpg','Sideways the dog','2018-11-25 15:04:36'),(69,37,'https://pbs.twimg.com/media/DZzi7dyU8AAUSJe.jpg','Georgia Tech Transette','2018-11-25 15:06:48'),(70,37,'https://www.calendar.gatech.edu/sites/default/files/events/related-images/mini_500_0_0.jpg','Mini 500','2018-11-25 15:07:04'),(71,37,'https://www.gatech.edu/sites/default/files/uploads/images/superblock_images/tech-trolly.png','Tech Trolley','2018-11-25 15:07:20');
/*!40000 ALTER TABLE `pushpin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `tagID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `pushPinID` int(16) unsigned NOT NULL,
  `tag` varchar(20) NOT NULL,
  PRIMARY KEY (`tagID`),
  KEY `fk_Tag_pushPinID_PushPin_pushPinID` (`pushPinID`),
  CONSTRAINT `fk_Tag_pushPinID_PushPin_pushPinID` FOREIGN KEY (`pushPinID`) REFERENCES `pushpin` (`pushPinID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (31,45,' OMSCS'),(32,46,'buzzcard'),(33,47,'Piazza'),(34,48,'Georgia tech seal'),(35,48,' great seal'),(36,48,' official'),(37,49,'burdell'),(38,49,' george p burdell'),(39,49,' student'),(40,50,'database faculty'),(41,50,' computing'),(42,50,' gtcomputing'),(43,51,'zvi'),(44,51,' dean'),(45,51,' computer science'),(46,51,' computing'),(47,51,' gtcomputing'),(48,52,'administration'),(49,52,' facilities'),(50,53,'administration'),(51,53,' facilities'),(53,55,'student facilities'),(54,55,' computing'),(55,55,' gtcomputing'),(57,57,'tohellwithgeorgia'),(58,57,' decked out'),(59,57,' parade'),(60,58,'ramblin wreck'),(61,58,' buzz'),(62,58,' mascot'),(63,58,' parade'),(64,59,'football game'),(65,59,' parade'),(66,60,'football'),(67,60,' game day'),(68,60,' tohellwithgeorgia'),(69,61,'traditions'),(70,62,'delicious'),(71,63,'Macintosh'),(72,63,' computer'),(73,63,' macOS'),(74,64,'PCs'),(75,64,' student facilities'),(76,64,' gtcomputing'),(77,65,'computing'),(78,65,' blades'),(79,66,'mascot'),(80,67,'tohellwithgeorgia'),(81,67,' dawgs'),(82,67,' not our mascot'),(83,68,'mascot'),(84,68,' traditions'),(85,69,'rapid transit'),(86,69,' historical oddity'),(87,70,'tricycle'),(88,70,' race'),(89,70,' traditions'),(90,71,'free'),(91,71,' transit'),(92,71,' connections');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `userID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `pin` varchar(60) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1@123.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','user1'),(2,'user2@123.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','user2'),(3,'user3@123.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','user3'),(4,'user4@123.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','user4'),(9,'user5@123.com','$2b$12$QZuoe4KcbfpQ/HIMpSju0eFenb8L1xJfbsBgNVApAS54YVDHaLa3q','user5'),(10,'user6@123.com','$2b$12$sHHqTJSSq.8WNVdBZnY0A.XuHzsdjPbBWe7WW8ckvmSsYAHhhutz.','user6');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watch`
--

DROP TABLE IF EXISTS `watch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watch` (
  `WatchID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `corkBoardID` int(16) unsigned NOT NULL,
  PRIMARY KEY (`WatchID`),
  KEY `fk_Watch_email_User_email` (`email`),
  KEY `fk_Watch_corkBoardID_CorkBoard_corkBoardID` (`corkBoardID`),
  CONSTRAINT `fk_Watch_corkBoardID_CorkBoard_corkBoardID` FOREIGN KEY (`corkBoardID`) REFERENCES `corkboard` (`corkBoardID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Watch_email_User_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watch`
--

LOCK TABLES `watch` WRITE;
/*!40000 ALTER TABLE `watch` DISABLE KEYS */;
INSERT INTO `watch` VALUES (6,'user1@123.com',31),(7,'user1@123.com',33),(8,'user2@123.com',29),(9,'user2@123.com',34),(10,'user3@123.com',31),(11,'user3@123.com',34),(12,'user4@123.com',37),(13,'user4@123.com',31),(14,'user5@123.com',37),(15,'user5@123.com',29),(16,'user6@123.com',33),(17,'user6@123.com',32);
/*!40000 ALTER TABLE `watch` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-25 11:22:58
