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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'cat1'),(2,'cat2'),(3,'cat3');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'user1@123.com','2018-10-13 00:00:00','hahaha',2),(2,'user2@123.com','2018-10-14 00:00:00','lueluelue',2),(3,'user1@123.com','2018-10-08 00:00:00','hehehe',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corkboard`
--

LOCK TABLES `corkboard` WRITE;
/*!40000 ALTER TABLE `corkboard` DISABLE KEYS */;
INSERT INTO `corkboard` VALUES (1,'user1@123.com','cat1','user1-cork1','2018-10-17 00:00:00'),(2,'user2@123.com','cat2','user2-cork2','2018-10-15 00:00:00'),(3,'user3@123.com','cat1','user3-cork3','2018-10-31 00:00:00'),(4,'user3@123.com','cat2','user3-cork4','2018-10-02 00:00:00'),(5,'user3@123.com','cat2','user3-cork5','2018-10-25 00:00:00'),(6,'user4@123.com','cat1','user4-cork6','2018-10-28 00:00:00'),(13,'user3@123.com','cat1','Test_CB',NULL),(16,'user3@123.com','cat1','Test_CB2',NULL),(17,'user3@123.com','cat1','Test_CB3',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES (1,'user1@123.com','user2@123.com'),(2,'user3@123.com','user1@123.com'),(3,'user3@123.com','user2@123.com');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,'user1@123.com',3),(2,'user2@123.com',2),(3,'user1@123.com',5),(4,'user4@123.com',6);
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
INSERT INTO `privatecorkboard` VALUES (2,NULL,'1234'),(16,NULL,'123321');
/*!40000 ALTER TABLE `privatecorkboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publiccorkboard`
--

DROP TABLE IF EXISTS `publiccorkboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publiccorkboard` (
  `corkBoardID` int(16) unsigned NOT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`corkBoardID`),
  CONSTRAINT `fk_PublicCorkBoard_corkBoardID_CorkBoard_corkBoardID` FOREIGN KEY (`corkBoardID`) REFERENCES `corkboard` (`corkBoardID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publiccorkboard`
--

LOCK TABLES `publiccorkboard` WRITE;
/*!40000 ALTER TABLE `publiccorkboard` DISABLE KEYS */;
INSERT INTO `publiccorkboard` VALUES (1,NULL),(3,NULL),(4,NULL),(5,NULL),(6,NULL),(13,NULL),(17,NULL);
/*!40000 ALTER TABLE `publiccorkboard` ENABLE KEYS */;
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
  `description` varchar(250) DEFAULT NULL,
  `pinned_time` datetime NOT NULL,
  PRIMARY KEY (`pushPinID`),
  UNIQUE KEY `image_URL` (`image_URL`),
  KEY `fk_PushPin_corkBoardID_CorkBoard_corkBoardID` (`corkBoardID`),
  CONSTRAINT `fk_PushPin_corkBoardID_CorkBoard_corkBoardID` FOREIGN KEY (`corkBoardID`) REFERENCES `corkboard` (`corkBoardID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pushpin`
--

LOCK TABLES `pushpin` WRITE;
/*!40000 ALTER TABLE `pushpin` DISABLE KEYS */;
INSERT INTO `pushpin` VALUES (1,1,'image_1_1','first image','2018-10-13 00:00:00'),(2,1,'image_1_2','first image','2018-10-17 00:00:00'),(3,2,'pimage_2_3','ppp first image','2018-10-05 00:00:00'),(4,2,'pimage_2_4','ppp first image','2018-10-31 00:00:00'),(5,3,'image_3_5','asdf','2018-10-14 00:00:00'),(6,4,'image_4_6','asdf','2018-10-02 00:00:00'),(7,5,'image_5_7','gfg','2018-10-25 00:00:00'),(8,6,'image_6_8','sdfg','2018-10-08 00:00:00'),(9,3,'image_URL_test','test1','2018-11-09 02:55:43'),(11,3,'image_URL_test22','test1','2018-11-09 02:56:56');
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
  `tag` varchar(250) NOT NULL,
  PRIMARY KEY (`tagID`),
  KEY `fk_Tag_pushPinID_PushPin_pushPinID` (`pushPinID`),
  CONSTRAINT `fk_Tag_pushPinID_PushPin_pushPinID` FOREIGN KEY (`pushPinID`) REFERENCES `pushpin` (`pushPinID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,1,'pu1_tag1'),(2,1,'pu1_tag2');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1@123.com','$2b$12$mAotxDa9vc9Dczu/nhG7leK2t9rzhR.GI1WYrgoux5iAL3mHcel4q','user1'),(2,'user2@123.com','$2b$12$mAotxDa9vc9Dczu/nhG7leK2t9rzhR.GI1WYrgoux5iAL3mHcel4q','user2'),(3,'user3@123.com','$2b$12$mAotxDa9vc9Dczu/nhG7leK2t9rzhR.GI1WYrgoux5iAL3mHcel4q','user3'),(4,'user4@123.com','$2b$12$mAotxDa9vc9Dczu/nhG7leK2t9rzhR.GI1WYrgoux5iAL3mHcel4q','user4'),(5,'test@test.com','$2b$12$5.YpbB6cpuVg92VHveiVveYoPcTD46G6xMQhUbYaWbngon70iNRq.','test'),(6,'test2@test.com','$2b$12$mAotxDa9vc9Dczu/nhG7leK2t9rzhR.GI1WYrgoux5iAL3mHcel4q','test2'),(7,'user9@123.com','$2b$12$BK5z00ZKctFOmenVIz8v7eIkEM2hpR..SpCIEGA2l42h8EKcabF9q','user9');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watch`
--

LOCK TABLES `watch` WRITE;
/*!40000 ALTER TABLE `watch` DISABLE KEYS */;
INSERT INTO `watch` VALUES (1,'user2@123.com',1),(2,'user3@123.com',1),(3,'user3@123.com',6);
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

-- Dump completed on 2018-11-08 23:35:37
