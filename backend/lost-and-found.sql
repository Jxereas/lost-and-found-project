-- MySQL dump 10.13  Distrib 9.1.0, for Linux (x86_64)
--
-- Host: localhost    Database: LostAndFoundProjectTest
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Administrator`
--

DROP TABLE IF EXISTS `Administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Administrator` (
  `PersonID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(15) NOT NULL,
  `Password` varchar(15) NOT NULL,
  PRIMARY KEY (`PersonID`),
  UNIQUE KEY `Username` (`Username`),
  CONSTRAINT `Administrator_ibfk_1` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Administrator`
--

LOCK TABLES `Administrator` WRITE;
/*!40000 ALTER TABLE `Administrator` DISABLE KEYS */;
INSERT INTO `Administrator` VALUES (1,'admin1','pass123'),(2,'admin2','secure456');
/*!40000 ALTER TABLE `Administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ClaimedItemsWithClaimers`
--

DROP TABLE IF EXISTS `ClaimedItemsWithClaimers`;
/*!50001 DROP VIEW IF EXISTS `ClaimedItemsWithClaimers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ClaimedItemsWithClaimers` AS SELECT 
 1 AS `FirstName`,
 1 AS `LastName`,
 1 AS `Email`,
 1 AS `Phone`,
 1 AS `ClaimedItem`,
 1 AS `DateReported`,
 1 AS `DateClaimed`,
 1 AS `TimeClaimed`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Claimer`
--

DROP TABLE IF EXISTS `Claimer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Claimer` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PersonID` int NOT NULL,
  `DateClaimed` date NOT NULL,
  `TimeClaimed` time NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `PersonID` (`PersonID`),
  CONSTRAINT `Claimer_ibfk_1` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Claimer`
--

LOCK TABLES `Claimer` WRITE;
/*!40000 ALTER TABLE `Claimer` DISABLE KEYS */;
INSERT INTO `Claimer` VALUES (1,3,'2025-05-14','12:09:06'),(2,4,'2025-05-22','23:48:06');
/*!40000 ALTER TABLE `Claimer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Item` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(15) NOT NULL,
  `Color` varchar(15) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Item`
--

LOCK TABLES `Item` WRITE;
/*!40000 ALTER TABLE `Item` DISABLE KEYS */;
INSERT INTO `Item` VALUES (1,'Wallet','Black','Leather wallet with UVA ID'),(2,'Backpack','Blue','Laptop inside main pocket'),(3,'Keys','Silver','Set of house and car keys'),(4,'Umbrella','Red','Foldable umbrella with polka dots'),(5,'Jacket','Green','Hooded waterproof jacket');
/*!40000 ALTER TABLE `Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ItemTag`
--

DROP TABLE IF EXISTS `ItemTag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ItemTag` (
  `TagID` int NOT NULL,
  `ItemID` int NOT NULL,
  PRIMARY KEY (`TagID`,`ItemID`),
  KEY `ItemID` (`ItemID`),
  CONSTRAINT `ItemTag_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ID`),
  CONSTRAINT `ItemTag_ibfk_2` FOREIGN KEY (`TagID`) REFERENCES `Tag` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ItemTag`
--

LOCK TABLES `ItemTag` WRITE;
/*!40000 ALTER TABLE `ItemTag` DISABLE KEYS */;
INSERT INTO `ItemTag` VALUES (1,1),(3,1),(1,2);
/*!40000 ALTER TABLE `ItemTag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ItemTagDetails`
--

DROP TABLE IF EXISTS `ItemTagDetails`;
/*!50001 DROP VIEW IF EXISTS `ItemTagDetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ItemTagDetails` AS SELECT 
 1 AS `ItemName`,
 1 AS `Description`,
 1 AS `TagName`,
 1 AS `TagDescription`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Location` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `BuildingName` varchar(20) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `StreetAddress` varchar(50) NOT NULL,
  `City` varchar(25) NOT NULL,
  `State` varchar(15) NOT NULL,
  `Zipcode` varchar(9) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
INSERT INTO `Location` VALUES (1,'Newcomb Hall','Front Desk','180 McCormick Rd','Charlottesville','Virginia','1356'),(2,'Clemons Library','Study Area','850 College Dr','Charlottesville','Virginia','1820'),(3,'Slaughter Rec','Lost and Found Locker','505 Edgemont Rd','Charlottesville','Virginia','1739');
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LostItem`
--

DROP TABLE IF EXISTS `LostItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LostItem` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `AdministratorID` int NOT NULL,
  `ReporterID` int NOT NULL,
  `ClaimerID` int DEFAULT NULL,
  `ItemID` int NOT NULL,
  `LocationID` int NOT NULL,
  `IsClaimed` enum('Y','N') NOT NULL,
  `Notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `AdministratorID` (`AdministratorID`),
  KEY `ReporterID` (`ReporterID`),
  KEY `ClaimerID` (`ClaimerID`),
  KEY `ItemID` (`ItemID`),
  KEY `LocationID` (`LocationID`),
  CONSTRAINT `LostItem_ibfk_1` FOREIGN KEY (`AdministratorID`) REFERENCES `Administrator` (`PersonID`),
  CONSTRAINT `LostItem_ibfk_2` FOREIGN KEY (`ReporterID`) REFERENCES `Reporter` (`ID`),
  CONSTRAINT `LostItem_ibfk_3` FOREIGN KEY (`ClaimerID`) REFERENCES `Claimer` (`ID`),
  CONSTRAINT `LostItem_ibfk_4` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ID`),
  CONSTRAINT `LostItem_ibfk_5` FOREIGN KEY (`LocationID`) REFERENCES `Location` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LostItem`
--

LOCK TABLES `LostItem` WRITE;
/*!40000 ALTER TABLE `LostItem` DISABLE KEYS */;
INSERT INTO `LostItem` VALUES (1,1,1,NULL,1,1,'N','Reported lost near the vending machines.'),(2,2,2,1,2,2,'Y','Found under a desk.'),(3,1,3,NULL,3,3,'N','Left at the gym locker.');
/*!40000 ALTER TABLE `LostItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Person` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(15) NOT NULL,
  `LastName` varchar(15) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `StreetAddress` varchar(50) NOT NULL,
  `City` varchar(25) NOT NULL,
  `State` varchar(15) NOT NULL,
  `Zipcode` varchar(9) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES (1,'Alice','Smith','alice@virginia.edu','434-555-1111','1823 Waterfall Rd','Haymarket','Virginia','20169'),(2,'John','Doe','johndoe@virginia.edu','434-555-2222','300 Emmet St','Charlottesville','Virginia','8192'),(3,'Emily','Nguyen','emily.nguyen@virginia.edu','434-555-3333','1201 Grasslane St','Charlottesville','Virginia','1023'),(4,'Marcus','Lee','mlee@virginia.edu','434-555-4444','425 Brandon Ave','Charlottesville','Virginia','1853'),(5,'Sophia','Patel','sophia.p@virginia.edu','434-555-5555','101 Rugby Rd','Charlottesville','Virginia','1831'),(6,'Andrew','Chen','achen@virginia.edu','434-555-6666','200 Ivy Rd','Charlottesville','Virginia','1923'),(7,'Isabella','Rodriguez','isa.r@virginia.edu','434-555-7777','99 Fontaine Ave','Charlottesville','Virginia','8421');
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reporter`
--

DROP TABLE IF EXISTS `Reporter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reporter` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PersonID` int NOT NULL,
  `DateReported` date NOT NULL,
  `TimeReported` time NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `PersonID` (`PersonID`),
  CONSTRAINT `Reporter_ibfk_1` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reporter`
--

LOCK TABLES `Reporter` WRITE;
/*!40000 ALTER TABLE `Reporter` DISABLE KEYS */;
INSERT INTO `Reporter` VALUES (1,5,'2025-05-18','03:41:06'),(2,6,'2025-05-12','16:16:06'),(3,2,'2025-05-11','09:22:06');
/*!40000 ALTER TABLE `Reporter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tag`
--

DROP TABLE IF EXISTS `Tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tag` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(15) NOT NULL,
  `Description` varchar(75) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tag`
--

LOCK TABLES `Tag` WRITE;
/*!40000 ALTER TABLE `Tag` DISABLE KEYS */;
INSERT INTO `Tag` VALUES (1,'Valuable','Monetary or sentimental value'),(2,'Urgent','Needs immediate return'),(3,'ID-related','Contains identifying information'),(4,'Electronic','Gadget or device'),(5,'Clothing','Wearable item');
/*!40000 ALTER TABLE `Tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add administrator',7,'add_administrator'),(26,'Can change administrator',7,'change_administrator'),(27,'Can delete administrator',7,'delete_administrator'),(28,'Can view administrator',7,'view_administrator'),(29,'Can add auth group',8,'add_authgroup'),(30,'Can change auth group',8,'change_authgroup'),(31,'Can delete auth group',8,'delete_authgroup'),(32,'Can view auth group',8,'view_authgroup'),(33,'Can add auth group permissions',9,'add_authgrouppermissions'),(34,'Can change auth group permissions',9,'change_authgrouppermissions'),(35,'Can delete auth group permissions',9,'delete_authgrouppermissions'),(36,'Can view auth group permissions',9,'view_authgrouppermissions'),(37,'Can add auth permission',10,'add_authpermission'),(38,'Can change auth permission',10,'change_authpermission'),(39,'Can delete auth permission',10,'delete_authpermission'),(40,'Can view auth permission',10,'view_authpermission'),(41,'Can add auth user',11,'add_authuser'),(42,'Can change auth user',11,'change_authuser'),(43,'Can delete auth user',11,'delete_authuser'),(44,'Can view auth user',11,'view_authuser'),(45,'Can add auth user groups',12,'add_authusergroups'),(46,'Can change auth user groups',12,'change_authusergroups'),(47,'Can delete auth user groups',12,'delete_authusergroups'),(48,'Can view auth user groups',12,'view_authusergroups'),(49,'Can add auth user user permissions',13,'add_authuseruserpermissions'),(50,'Can change auth user user permissions',13,'change_authuseruserpermissions'),(51,'Can delete auth user user permissions',13,'delete_authuseruserpermissions'),(52,'Can view auth user user permissions',13,'view_authuseruserpermissions'),(53,'Can add claimer',14,'add_claimer'),(54,'Can change claimer',14,'change_claimer'),(55,'Can delete claimer',14,'delete_claimer'),(56,'Can view claimer',14,'view_claimer'),(57,'Can add django admin log',15,'add_djangoadminlog'),(58,'Can change django admin log',15,'change_djangoadminlog'),(59,'Can delete django admin log',15,'delete_djangoadminlog'),(60,'Can view django admin log',15,'view_djangoadminlog'),(61,'Can add django content type',16,'add_djangocontenttype'),(62,'Can change django content type',16,'change_djangocontenttype'),(63,'Can delete django content type',16,'delete_djangocontenttype'),(64,'Can view django content type',16,'view_djangocontenttype'),(65,'Can add django migrations',17,'add_djangomigrations'),(66,'Can change django migrations',17,'change_djangomigrations'),(67,'Can delete django migrations',17,'delete_djangomigrations'),(68,'Can view django migrations',17,'view_djangomigrations'),(69,'Can add django session',18,'add_djangosession'),(70,'Can change django session',18,'change_djangosession'),(71,'Can delete django session',18,'delete_djangosession'),(72,'Can view django session',18,'view_djangosession'),(73,'Can add item',19,'add_item'),(74,'Can change item',19,'change_item'),(75,'Can delete item',19,'delete_item'),(76,'Can view item',19,'view_item'),(77,'Can add itemtag',20,'add_itemtag'),(78,'Can change itemtag',20,'change_itemtag'),(79,'Can delete itemtag',20,'delete_itemtag'),(80,'Can view itemtag',20,'view_itemtag'),(81,'Can add location',21,'add_location'),(82,'Can change location',21,'change_location'),(83,'Can delete location',21,'delete_location'),(84,'Can view location',21,'view_location'),(85,'Can add lostitemreport',22,'add_lostitemreport'),(86,'Can change lostitemreport',22,'change_lostitemreport'),(87,'Can delete lostitemreport',22,'delete_lostitemreport'),(88,'Can view lostitemreport',22,'view_lostitemreport'),(89,'Can add person',23,'add_person'),(90,'Can change person',23,'change_person'),(91,'Can delete person',23,'delete_person'),(92,'Can view person',23,'view_person'),(93,'Can add tag',24,'add_tag'),(94,'Can change tag',24,'change_tag'),(95,'Can delete tag',24,'delete_tag'),(96,'Can view tag',24,'view_tag');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'api','administrator'),(8,'api','authgroup'),(9,'api','authgrouppermissions'),(10,'api','authpermission'),(11,'api','authuser'),(12,'api','authusergroups'),(13,'api','authuseruserpermissions'),(14,'api','claimer'),(15,'api','djangoadminlog'),(16,'api','djangocontenttype'),(17,'api','djangomigrations'),(18,'api','djangosession'),(19,'api','item'),(20,'api','itemtag'),(21,'api','location'),(22,'api','lostitemreport'),(23,'api','person'),(24,'api','tag'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-06-12 08:56:53.979555'),(2,'auth','0001_initial','2025-06-12 08:56:54.294119'),(3,'admin','0001_initial','2025-06-12 08:56:54.365849'),(4,'admin','0002_logentry_remove_auto_add','2025-06-12 08:56:54.372203'),(5,'admin','0003_logentry_add_action_flag_choices','2025-06-12 08:56:54.392642'),(6,'api','0001_initial','2025-06-12 08:56:54.401115'),(7,'contenttypes','0002_remove_content_type_name','2025-06-12 08:56:54.452103'),(8,'auth','0002_alter_permission_name_max_length','2025-06-12 08:56:54.482864'),(9,'auth','0003_alter_user_email_max_length','2025-06-12 08:56:54.496039'),(10,'auth','0004_alter_user_username_opts','2025-06-12 08:56:54.505968'),(11,'auth','0005_alter_user_last_login_null','2025-06-12 08:56:54.545111'),(12,'auth','0006_require_contenttypes_0002','2025-06-12 08:56:54.547310'),(13,'auth','0007_alter_validators_add_error_messages','2025-06-12 08:56:54.556559'),(14,'auth','0008_alter_user_username_max_length','2025-06-12 08:56:54.590126'),(15,'auth','0009_alter_user_last_name_max_length','2025-06-12 08:56:54.618673'),(16,'auth','0010_alter_group_name_max_length','2025-06-12 08:56:54.629485'),(17,'auth','0011_update_proxy_permissions','2025-06-12 08:56:54.637037'),(18,'auth','0012_alter_user_first_name_max_length','2025-06-12 08:56:54.666097'),(19,'sessions','0001_initial','2025-06-12 08:56:54.682323');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('exvkuaiti9an2faz8aes2yc250k5gpe3','eyJhZG1pbl9pZCI6MX0:1uPolU:opph4pHX1WWYS9x2FPtos1JEYTzETGUq14u0H4L4WJM','2025-06-26 20:43:12.482348');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `ClaimedItemsWithClaimers`
--

/*!50001 DROP VIEW IF EXISTS `ClaimedItemsWithClaimers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ClaimedItemsWithClaimers` AS select `p`.`FirstName` AS `FirstName`,`p`.`LastName` AS `LastName`,`p`.`Email` AS `Email`,`p`.`Phone` AS `Phone`,`i`.`Name` AS `ClaimedItem`,`r`.`DateReported` AS `DateReported`,`c`.`DateClaimed` AS `DateClaimed`,`c`.`TimeClaimed` AS `TimeClaimed` from ((((`Claimer` `c` join `Person` `p` on((`c`.`ID` = `p`.`ID`))) join `LostItem` `li` on((`li`.`ClaimerID` = `c`.`ID`))) join `Reporter` `r` on((`r`.`ID` = `li`.`ReporterID`))) join `Item` `i` on((`li`.`ItemID` = `i`.`ID`))) where (`li`.`IsClaimed` = 'Y') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ItemTagDetails`
--

/*!50001 DROP VIEW IF EXISTS `ItemTagDetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ItemTagDetails` AS select `i`.`Name` AS `ItemName`,`i`.`Description` AS `Description`,`t`.`Name` AS `TagName`,`t`.`Description` AS `TagDescription` from ((`ItemTag` `it` join `Item` `i` on((`it`.`ItemID` = `i`.`ID`))) join `Tag` `t` on((`it`.`TagID` = `t`.`ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-12 16:53:28
