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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'user1@123.com','2018-10-13 00:00:00','hahaha',2),(2,'user2@123.com','2018-10-14 00:00:00','lueluelue',2),(3,'user1@123.com','2018-10-08 00:00:00','hehehe',3),(4,'user1@123.com','2018-10-13 00:00:00','hahaha',1),(6,'user2@123.com','2018-10-14 00:00:00','lueluelue',1),(7,'user1@123.com','2018-10-08 00:00:00','hehehe',1),(8,'user3@123.com','2018-11-10 23:14:11','123321',1),(9,'user3@123.com','2018-11-10 23:14:17','123321',1),(10,'user3@123.com','2018-11-10 23:15:20','324122',1),(11,'user3@123.com','2018-11-10 23:15:23','3454',1),(12,'user3@123.com','2018-11-11 21:49:36','isis',1),(13,'user2@123.com','2018-11-11 21:58:02','user2 comment',1),(14,'user2@123.com','2018-11-11 21:58:10','user2',1),(15,'user2@123.com','2018-11-11 22:00:41','user latest',1),(16,'user2@123.com','2018-11-11 22:44:13','2132',40),(17,'user2@123.com','2018-11-12 01:36:37','sddsd',2),(18,'user3@123.com','2018-11-12 01:58:44','sasdas',5),(19,'user4@123.com','2018-11-14 03:27:12','hhh',8);
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corkboard`
--

LOCK TABLES `corkboard` WRITE;
/*!40000 ALTER TABLE `corkboard` DISABLE KEYS */;
INSERT INTO `corkboard` VALUES (1,'user1@123.com','Education','user1-cork1','2018-11-11 14:20:31'),(2,'user2@123.com','Architecture','user2-cork2','2018-10-15 00:00:00'),(3,'user3@123.com','Education','user3-cork3','2018-11-11 15:04:40'),(4,'user3@123.com','Architecture','user3-cork4','2018-10-02 00:00:00'),(5,'user3@123.com','Architecture','user3-cork5','2018-10-25 00:00:00'),(6,'user4@123.com','Education','user4-cork6','2018-10-28 00:00:00'),(10,'user9@123.com','Home&Garden','123','2018-11-15 00:00:00'),(11,'test@test.com','Architecture','12334','2018-11-13 00:00:00'),(13,'user3@123.com','Education','Test_CB','2018-11-01 00:00:00'),(16,'user3@123.com','Education','Test_CB2','2018-11-11 14:24:44'),(17,'user3@123.com','Education','Test_CB3',NULL),(18,'user3@123.com','Education','private 33',NULL),(19,'user3@123.com','Education','public333',NULL),(20,'user3@123.com','Education','public7',NULL),(21,'user3@123.com','Education','newPublic',NULL),(22,'user3@123.com','Education','private test',NULL),(23,'user3@123.com','Education','1',NULL),(24,'user1@123.com','Education','user1_private',NULL),(25,'user2@123.com','Architecture','user2_new',NULL),(26,'user2@123.com','Education','user2_private_new','2018-11-11 17:49:21'),(27,'user4@123.com','Architecture','afterdeletePublic',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES (1,'user1@123.com','user2@123.com'),(2,'user3@123.com','user1@123.com'),(3,'user3@123.com','user2@123.com'),(6,'user3@123.com','user4@123.com'),(7,'user2@123.com','user1@123.com'),(8,'xiaoshan@123.com','user1@123.com'),(9,'user4@123.com','user4@123.com');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,'user1@123.com',3),(2,'user2@123.com',2),(3,'user1@123.com',5),(4,'user4@123.com',6),(5,'user3@123.com',5),(6,'user3@123.com',1),(7,'user2@123.com',1),(8,'user2@123.com',40),(9,'user4@123.com',8);
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
INSERT INTO `privatecorkboard` VALUES (2,NULL,'1234'),(16,'2018-11-11 14:24:44','123321'),(18,NULL,'1224'),(22,NULL,'1234'),(24,NULL,'1234'),(26,'2018-11-11 17:49:21','1234');
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
INSERT INTO `publiccorkboard` VALUES (1,'2018-11-11 14:20:31'),(3,'2018-11-11 15:04:40'),(4,NULL),(5,NULL),(6,NULL),(10,NULL),(11,NULL),(13,NULL),(17,NULL),(19,NULL),(20,NULL),(21,NULL),(23,NULL),(25,NULL);
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
  KEY `fk_PushPin_corkBoardID_CorkBoard_corkBoardID` (`corkBoardID`),
  KEY `image_URL` (`image_URL`) USING BTREE,
  CONSTRAINT `fk_PushPin_corkBoardID_CorkBoard_corkBoardID` FOREIGN KEY (`corkBoardID`) REFERENCES `corkboard` (`corkBoardID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pushpin`
--

LOCK TABLES `pushpin` WRITE;
/*!40000 ALTER TABLE `pushpin` DISABLE KEYS */;
INSERT INTO `pushpin` VALUES (1,1,'https://images.pexels.com/photos/248797/pexels-photo-248797.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','first image','2018-10-13 00:00:00'),(2,1,'http://wowslider.com/sliders/demo-81/data1/images/redkite50498.jpg','first image','2018-10-17 00:00:00'),(3,2,'https://images.pexels.com/photos/248797/pexels-photo-248797.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','ppp first image','2018-10-05 00:00:00'),(4,2,'https://images.pexels.com/photos/127073/pexels-photo-127073.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','ppp first image','2018-10-31 00:00:00'),(5,3,'https://images.pexels.com/photos/236293/pexels-photo-236293.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','asdf','2018-10-14 00:00:00'),(6,4,'https://medicine.llu.edu/sites/medicine.llu.edu/files/images/Technology.jpg','asdf','2018-10-02 00:00:00'),(7,5,'https://images.pexels.com/photos/6349/red-love-heart-typography.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxITEhUSEhMVFhUVFRgWFxYVFRUVFRUVFRUWFxUVFRUYHSggGBolHRUVITEhJSkrLi4uFx8zODMtNyg','gfg','2018-10-25 00:00:00'),(8,6,'https://images.pexels.com/photos/127073/pexels-photo-127073.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','sdfg','2018-10-08 00:00:00'),(9,3,'https://images.pexels.com/photos/6349/red-love-heart-typography.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260https://cdn.pixabay.com/photo/2018/02/09/21/46/rose-3142529__340.jpg','test1','2018-11-09 02:55:43'),(11,3,'http://muawia.com/wp-content/uploads/2018/07/trace-3157431__340.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','test1','2018-11-09 02:56:56'),(17,10,'https://images.pexels.com/photos/236293/pexels-photo-236293.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','test1','2018-11-07 00:00:00'),(18,11,'https://images.pexels.com/photos/6349/red-love-heart-typography.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','test222','2018-11-29 00:00:00'),(19,16,'https://images.pexels.com/photos/127073/pexels-photo-127073.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','private test','2018-11-07 00:00:00'),(26,3,'https://images.pexels.com/photos/236293/pexels-photo-236293.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','1231','2018-11-11 18:33:24'),(27,3,'https://images.pexels.com/photos/127073/pexels-photo-127073.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','1231','2018-11-11 18:33:36'),(28,16,'https://images.pexels.com/photos/6349/red-love-heart-typography.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260https://www.imore.com/sites/imore.com/files/styles/xlarge/public/field/image/2016/09/ios-10-hero-photos-picture-pikachu.jpg?itok=YaO_4O0R','test_update time in corkboard','2018-11-11 18:39:16'),(29,3,'https://images.pexels.com/photos/127073/pexels-photo-127073.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','232','2018-11-11 18:44:56'),(30,3,'https://images.pexels.com/photos/236293/pexels-photo-236293.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260https://www.manatt.com/Manatt/media/Media/Images/Jumbotron/media_smart_TV_concept.jpg?ext=.jpg','123','2018-11-11 19:01:36'),(31,3,'http://muawia.com/wp-content/uploads/2018/07/trace-3157431__340.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','123','2018-11-11 19:05:16'),(32,3,'https://images.pexels.com/photos/6349/red-love-heart-typography.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoVa8iO7Eh9b9XLb2jjEg098xy6seaec0P8NHqyBntE8IZe26HIg','123','2018-11-11 19:05:25'),(33,1,'https://images.pexels.com/photos/127073/pexels-photo-127073.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','2','2018-11-11 19:11:02'),(34,1,'https://images.pexels.com/photos/236293/pexels-photo-236293.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','2','2018-11-11 19:12:23'),(35,1,'https://images.pexels.com/photos/127073/pexels-photo-127073.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','2','2018-11-11 19:13:31'),(36,1,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoVa8iO7Eh9b9XLb2jjEg098xy6seaec0P8NHqyBntE8IZe26HIgauto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','123','2018-11-11 19:20:32'),(37,16,'https://images.pexels.com/photos/127073/pexels-photo-127073.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','123','2018-11-11 19:22:03'),(38,16,'https://images.pexels.com/photos/459225/pexels-photo-459225.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','32','2018-11-11 19:24:44'),(39,3,'https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','parse tags','2018-11-11 20:04:40'),(40,26,'https://images.pexels.com/photos/459225/pexels-photo-459225.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','user2_private','2018-11-11 22:23:15'),(41,26,'https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260','ssssda','2018-11-11 22:49:22');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,1,'tag1'),(2,1,'tag2'),(7,27,'2322'),(8,28,'update time'),(9,29,'123'),(10,30,'12'),(11,31,'12'),(12,32,'12'),(13,33,'1'),(14,34,'1'),(15,35,'1'),(16,36,'123'),(17,37,'123'),(18,38,'1233'),(19,39,'p1'),(20,39,'p2'),(21,39,'p3'),(22,40,'u2'),(23,40,'u333'),(24,40,'u44'),(25,41,'http'),(26,5,'new tag 5');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1@123.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','user1'),(2,'user2@123.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','user2'),(3,'user3@123.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','user3'),(4,'user4@123.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','user4'),(5,'test@test.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','test'),(6,'test2@test.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','test2'),(7,'user9@123.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','user9'),(8,'xiaoshan@123.com','$2b$12$RnRuhEmysdKCdFqFD5ldF.xYSBPwV0glU5k9guG2Fp2Ue6Aa1PXEG','xiaoshan');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watch`
--

LOCK TABLES `watch` WRITE;
/*!40000 ALTER TABLE `watch` DISABLE KEYS */;
INSERT INTO `watch` VALUES (4,'user3@123.com',6),(5,'user3@123.com',1);
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

-- Dump completed on 2018-11-14 22:03:51
