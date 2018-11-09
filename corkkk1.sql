-- MySQL dump 10.13  Distrib 8.0.12, for macos10.13 (x86_64)
--
-- Host: localhost    Database: corkboard1
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Category` (
  `categoryID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(250) NOT NULL,
  PRIMARY KEY (`categoryID`),
  UNIQUE KEY `cat_name` (`cat_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
INSERT INTO `Category` VALUES (1,'cat1'),(2,'cat2'),(3,'cat3');
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Comment`
--

DROP TABLE IF EXISTS `Comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Comment` (
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
-- Dumping data for table `Comment`
--

LOCK TABLES `Comment` WRITE;
/*!40000 ALTER TABLE `Comment` DISABLE KEYS */;
INSERT INTO `Comment` VALUES (1,'user1@123.com','2018-10-13 00:00:00','hahaha',2),(2,'user2@123.com','2018-10-14 00:00:00','lueluelue',2),(3,'user1@123.com','2018-10-08 00:00:00','hehehe',3);
/*!40000 ALTER TABLE `Comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CorkBoard`
--

DROP TABLE IF EXISTS `CorkBoard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `CorkBoard` (
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CorkBoard`
--

LOCK TABLES `CorkBoard` WRITE;
/*!40000 ALTER TABLE `CorkBoard` DISABLE KEYS */;
INSERT INTO `CorkBoard` VALUES (1,'user1@123.com','cat1','user1-cork1',NULL),(2,'user2@123.com','cat2','user2-cork2',NULL),(3,'user3@123.com','cat1','user3-cork3',NULL),(4,'user3@123.com','cat2','user3-cork4',NULL),(5,'user3@123.com','cat2','user3-cork5',NULL),(6,'user4@123.com','cat1','user4-cork6',NULL);
/*!40000 ALTER TABLE `CorkBoard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Follow`
--

DROP TABLE IF EXISTS `Follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Follow` (
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
-- Dumping data for table `Follow`
--

LOCK TABLES `Follow` WRITE;
/*!40000 ALTER TABLE `Follow` DISABLE KEYS */;
INSERT INTO `Follow` VALUES (1,'user1@123.com','user2@123.com'),(2,'user3@123.com','user1@123.com'),(3,'user3@123.com','user2@123.com');
/*!40000 ALTER TABLE `Follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Likes`
--

DROP TABLE IF EXISTS `Likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Likes` (
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
-- Dumping data for table `Likes`
--

LOCK TABLES `Likes` WRITE;
/*!40000 ALTER TABLE `Likes` DISABLE KEYS */;
INSERT INTO `Likes` VALUES (1,'user1@123.com',3),(2,'user2@123.com',2),(3,'user1@123.com',5),(4,'user4@123.com',6);
/*!40000 ALTER TABLE `Likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PrivateCorkBoard`
--

DROP TABLE IF EXISTS `PrivateCorkBoard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `PrivateCorkBoard` (
  `corkBoardID` int(16) unsigned NOT NULL,
  `last_update` datetime DEFAULT NULL,
  `password` varchar(60) NOT NULL,
  PRIMARY KEY (`corkBoardID`),
  CONSTRAINT `fk_PrivateCorkBoard_corkBoardID_CorkBoard_corkBoardID` FOREIGN KEY (`corkBoardID`) REFERENCES `corkboard` (`corkboardid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PrivateCorkBoard`
--

LOCK TABLES `PrivateCorkBoard` WRITE;
/*!40000 ALTER TABLE `PrivateCorkBoard` DISABLE KEYS */;
INSERT INTO `PrivateCorkBoard` VALUES (2,NULL,'1234');
/*!40000 ALTER TABLE `PrivateCorkBoard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PublicCorkBoard`
--

DROP TABLE IF EXISTS `PublicCorkBoard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `PublicCorkBoard` (
  `corkBoardID` int(16) unsigned NOT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`corkBoardID`),
  CONSTRAINT `fk_PublicCorkBoard_corkBoardID_CorkBoard_corkBoardID` FOREIGN KEY (`corkBoardID`) REFERENCES `corkboard` (`corkboardid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PublicCorkBoard`
--

LOCK TABLES `PublicCorkBoard` WRITE;
/*!40000 ALTER TABLE `PublicCorkBoard` DISABLE KEYS */;
INSERT INTO `PublicCorkBoard` VALUES (1,NULL),(3,NULL),(4,NULL),(5,NULL),(6,NULL);
/*!40000 ALTER TABLE `PublicCorkBoard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PushPin`
--

DROP TABLE IF EXISTS `PushPin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `PushPin` (
  `pushPinID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `corkBoardID` int(16) unsigned NOT NULL,
  `image_URL` varchar(250) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `pinned_time` datetime NOT NULL,
  PRIMARY KEY (`pushPinID`),
  UNIQUE KEY `image_URL` (`image_URL`),
  KEY `fk_PushPin_corkBoardID_CorkBoard_corkBoardID` (`corkBoardID`),
  CONSTRAINT `fk_PushPin_corkBoardID_CorkBoard_corkBoardID` FOREIGN KEY (`corkBoardID`) REFERENCES `corkboard` (`corkboardid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PushPin`
--

LOCK TABLES `PushPin` WRITE;
/*!40000 ALTER TABLE `PushPin` DISABLE KEYS */;
INSERT INTO `PushPin` VALUES (1,1,'image_1_1','first image','2018-10-13 00:00:00'),(2,1,'image_1_2','first image','2018-10-17 00:00:00'),(3,2,'pimage_2_3','ppp first image','2018-10-05 00:00:00'),(4,2,'pimage_2_4','ppp first image','2018-10-31 00:00:00'),(5,3,'image_3_5','asdf','2018-10-14 00:00:00'),(6,4,'image_4_6','asdf','2018-10-02 00:00:00'),(7,5,'image_5_7','gfg','2018-10-25 00:00:00'),(8,6,'image_6_8','sdfg','2018-10-08 00:00:00');
/*!40000 ALTER TABLE `PushPin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tag`
--

DROP TABLE IF EXISTS `Tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Tag` (
  `tagID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `pushPinID` int(16) unsigned NOT NULL,
  `tag` varchar(250) NOT NULL,
  PRIMARY KEY (`tagID`),
  KEY `fk_Tag_pushPinID_PushPin_pushPinID` (`pushPinID`),
  CONSTRAINT `fk_Tag_pushPinID_PushPin_pushPinID` FOREIGN KEY (`pushPinID`) REFERENCES `pushpin` (`pushpinid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tag`
--

LOCK TABLES `Tag` WRITE;
/*!40000 ALTER TABLE `Tag` DISABLE KEYS */;
INSERT INTO `Tag` VALUES (1,1,'pu1_tag1'),(2,1,'pu1_tag2');
/*!40000 ALTER TABLE `Tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `User` (
  `userID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `pin` varchar(60) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'user1@123.com','$2b$12$mAotxDa9vc9Dczu/nhG7leK2t9rzhR.GI1WYrgoux5iAL3mHcel4q','user1'),(2,'user2@123.com','$2b$12$mAotxDa9vc9Dczu/nhG7leK2t9rzhR.GI1WYrgoux5iAL3mHcel4q','user2'),(3,'user3@123.com','$2b$12$mAotxDa9vc9Dczu/nhG7leK2t9rzhR.GI1WYrgoux5iAL3mHcel4q','user3'),(4,'user4@123.com','$2b$12$mAotxDa9vc9Dczu/nhG7leK2t9rzhR.GI1WYrgoux5iAL3mHcel4q','user4');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Watch`
--

DROP TABLE IF EXISTS `Watch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Watch` (
  `WatchID` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `corkBoardID` int(16) unsigned NOT NULL,
  PRIMARY KEY (`WatchID`),
  KEY `fk_Watch_email_User_email` (`email`),
  KEY `fk_Watch_corkBoardID_CorkBoard_corkBoardID` (`corkBoardID`),
  CONSTRAINT `fk_Watch_corkBoardID_CorkBoard_corkBoardID` FOREIGN KEY (`corkBoardID`) REFERENCES `corkboard` (`corkboardid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Watch_email_User_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Watch`
--

LOCK TABLES `Watch` WRITE;
/*!40000 ALTER TABLE `Watch` DISABLE KEYS */;
INSERT INTO `Watch` VALUES (1,'user2@123.com',1),(2,'user3@123.com',1),(3,'user3@123.com',6);
/*!40000 ALTER TABLE `Watch` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-05 17:36:25
