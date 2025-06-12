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
-- Database creation for 'LostAndFoundProjectTest'
--

CREATE DATABASE IF NOT EXISTS LostAndFoundProjectTest;

USE LostAndFoundProjectTest;

--
-- Table structure for table `Administrator`
--


DROP TABLE IF EXISTS `Administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Administrator` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(15) NOT NULL,
  `Password` varchar(15) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Username` (`Username`),
  CONSTRAINT `Administrator_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `Person` (`ID`)
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
-- Table structure for table `Claimer`
--

DROP TABLE IF EXISTS `Claimer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Claimer` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `DateClaimed` date NOT NULL,
  `TimeClaimed` time NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `Claimer_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `Person` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Claimer`
--

LOCK TABLES `Claimer` WRITE;
/*!40000 ALTER TABLE `Claimer` DISABLE KEYS */;
INSERT INTO `Claimer` VALUES (3,'2025-05-14','12:09:06'),(4,'2025-05-22','23:48:06');
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
  `Description` varchar(50) DEFAULT NULL,
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
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Location` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `StreetAddress` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `State` varchar(50) NOT NULL,
  `Zipcode` int NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
INSERT INTO `Location` VALUES (1,'Newcomb Hall','Front Desk','180 McCormick Rd','Charlottesville','Virginia',1356),(2,'Clemons Library','Study Area','850 College Dr','Charlottesville','Virginia',1820),(3,'Slaughter Rec','Lost and Found Locker','505 Edgemont Rd','Charlottesville','Virginia',1739);
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
  `DateReported` date NOT NULL,
  `TimeReported` time NOT NULL,
  `AdministratorID` int NOT NULL,
  `ReporterID` int NOT NULL,
  `ClaimerID` int NOT NULL,
  `ItemID` int NOT NULL,
  `LocationID` int NOT NULL,
  `IsClaimed` enum('Y','N') NOT NULL,
  `Notes` varchar(255) DEFAULT NULL,
  `LastSeen` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `AdministratorID` (`AdministratorID`),
  KEY `ReporterID` (`ReporterID`),
  KEY `ClaimerID` (`ClaimerID`),
  KEY `ItemID` (`ItemID`),
  KEY `LocationID` (`LocationID`),
  CONSTRAINT `LostItem_ibfk_1` FOREIGN KEY (`AdministratorID`) REFERENCES `Administrator` (`ID`),
  CONSTRAINT `LostItem_ibfk_2` FOREIGN KEY (`ReporterID`) REFERENCES `Person` (`ID`),
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
INSERT INTO `LostItem` VALUES (1,'2025-05-18','03:41:06',1,5,3,1,1,'N','Reported lost near the vending machines.'),(2,'2025-05-12','16:16:06',2,6,3,2,2,'Y','Found under a desk.'),(3,'2025-05-11','09:22:06',1,2,4,3,3,'N','Left at the gym locker.');
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
  `City` varchar(50) NOT NULL,
  `State` varchar(50) NOT NULL,
  `Zipcode` int NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES (1,'Alice','Smith','alice@virginia.edu','434-555-1111','1823 Waterfall Rd','Haymarket','Virginia',20169),(2,'John','Doe','johndoe@virginia.edu','434-555-2222','300 Emmet St','Charlottesville','Virginia',8192),(3,'Emily','Nguyen','emily.nguyen@virginia.edu','434-555-3333','1201 Grasslane St','Charlottesville','Virginia',1023),(4,'Marcus','Lee','mlee@virginia.edu','434-555-4444','425 Brandon Ave','Charlottesville','Virginia',1853),(5,'Sophia','Patel','sophia.p@virginia.edu','434-555-5555','101 Rugby Rd','Charlottesville','Virginia',1831),(6,'David','Chen','dchen@virginia.edu','434-555-6666','200 Ivy Rd','Charlottesville','Virginia',1923),(7,'Isabella','Rodriguez','isa.r@virginia.edu','434-555-7777','99 Fontaine Ave','Charlottesville','Virginia',8421);
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tag`
--

DROP TABLE IF EXISTS `Tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tag` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Description` varchar(50) NOT NULL,
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-08 14:17:46
