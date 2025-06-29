CREATE DATABASE  IF NOT EXISTS `chatbot_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `chatbot_db`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: chatbot_db
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admission`
--

DROP TABLE IF EXISTS `admission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `notice` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission`
--

LOCK TABLES `admission` WRITE;
/*!40000 ALTER TABLE `admission` DISABLE KEYS */;
INSERT INTO `admission` VALUES (1,'Admissions for the 2025 academic year are now open. Apply online through our website.'),(2,'Prestige College offers a wide range of undergraduate and postgraduate courses. Apply now!'),(3,'The last date to submit admission forms for the current academic session is April 30, 2025.'),(4,'Scholarships are available for eligible students. Check our website for more details.'),(5,'Admission applications for the BCA program are open. Don\'t miss out!'),(6,'Join the prestigious Computer Science and Business Administration programs at Prestige College.'),(7,'Entrance exams will be held on May 15, 2025. Make sure to register before the deadline.'),(8,'Visit our campus for a guided tour. Admissions staff will be available for assistance.');
/*!40000 ALTER TABLE `admission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applicants`
--

DROP TABLE IF EXISTS `applicants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applicants` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` varchar(10) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `notification` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applicants`
--

LOCK TABLES `applicants` WRITE;
/*!40000 ALTER TABLE `applicants` DISABLE KEYS */;
INSERT INTO `applicants` VALUES (1,'Suryajith SS','suryajithcr07@gmail.com','7356639749','2002-08-26','Male','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-02-07 11:24:22.465774','2025-03-18 21:14:59.746627',NULL),(2,'Aravind VM','aravind@gamil.com','7563289462','2004-11-10','Male','password','2025-02-23 09:44:34.027864','2025-04-24 10:02:46.075368','The course allotted for you is bcom'),(3,'Sushama K B','sushamakb1978@gmail.com','8046725985','2004-07-21','Male','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-02 19:58:14.260438','2025-04-23 19:29:24.191421','A gentle reminder to complete your application process.'),(4,'John Doe','john.doe@example.com','1234567890','1990-05-12','Male','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-03 01:36:29.000000','2025-03-03 01:36:29.000000',NULL),(5,'Jane Smith','jane.smith@example.com','1234567891','1992-03-15','Female','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-03 01:36:29.000000','2025-04-24 10:03:04.784509','Your application has been approved'),(6,'Alice Johnson','alice.j@example.com','1234567892','1995-06-20','Female','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-03 01:36:29.000000','2025-03-03 01:36:29.000000',NULL),(7,'Bob Brown','bob.b@example.com','1234567893','1988-09-23','Male','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-03 01:36:29.000000','2025-03-03 01:36:29.000000',NULL),(8,'Charlie Davis','charlie.d@example.com','1234567894','1991-01-30','Other','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-03 01:36:29.000000','2025-03-03 01:36:29.000000',NULL),(9,'Eva Green','eva.g@example.com','1234567895','1993-07-19','Female','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-03 01:36:29.000000','2025-03-03 01:36:29.000000',NULL),(10,'David White','david.w@example.com','1234567896','1990-12-04','Male','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-03 01:36:29.000000','2025-03-03 01:36:29.000000',NULL),(11,'Fiona Black','fiona.b@example.com','1234567897','1987-04-22','Female','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-03 01:36:29.000000','2025-03-03 01:36:29.000000',NULL),(12,'George King','george.k@example.com','1234567898','1994-11-10','Male','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-03 01:36:29.000000','2025-03-03 01:36:29.000000',NULL),(13,'Hannah Lee','hannah.l@example.com','1234567899','1992-08-08','Female','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-03 01:36:29.000000','2025-03-03 01:36:29.000000',NULL),(14,'Arun Mohan','arun21@gmail.com','123456789','2004-09-21','male','pbkdf2_sha256$600000$yBaawtNX0aUtW5H73ySDcg$jNKWq01q9l5mUCaTU1Cm4+mK8+drPLQ0FdSJ/V57Su8=','2025-03-04 06:19:48.867158','2025-03-04 06:19:48.867158',NULL),(15,'Arjun A V','arjunav01@gmail.com','3656585426','2001-05-05','male','pbkdf2_sha256$600000$qC3MOr1EWaIKzFTLGpWDR4$YlLdakyOZ/XPhuzeWjmNr0n5voBVkEYDJAhtpuamllM=','2025-04-24 04:34:46.283908','2025-04-24 04:39:05.868227','Your application deadline is approaching. Please complete it soon.');
/*!40000 ALTER TABLE `applicants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `date_of_birth` date NOT NULL,
  `mother_tongue` varchar(20) NOT NULL,
  `nationality` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `fathers_guardians_mobile_number` varchar(15) NOT NULL,
  `admission_for` varchar(100) NOT NULL,
  `academic_year` varchar(9) NOT NULL,
  `priority_1` varchar(20) NOT NULL,
  `priority_2` varchar(20) NOT NULL,
  `priority_3` varchar(20) NOT NULL,
  `admission_quota` varchar(20) NOT NULL,
  `tenth_board` varchar(20) NOT NULL,
  `tenth_register_number` varchar(50) NOT NULL,
  `tenth_year_of_passing` varchar(4) NOT NULL,
  `tenth_total_score` int NOT NULL,
  `sslc_percentage` double NOT NULL,
  `higher_secondary_school_name` varchar(200) NOT NULL,
  `higher_secondary_board` varchar(20) NOT NULL,
  `higher_secondary_year_of_passing` varchar(4) NOT NULL,
  `physics_percentage` double DEFAULT NULL,
  `chemistry_percentage` double DEFAULT NULL,
  `maths_percentage` double DEFAULT NULL,
  `computer_science_percentage` double DEFAULT NULL,
  `total_percentage` double NOT NULL,
  `applicant_id` varchar(10001) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `application_number` varchar(255) DEFAULT NULL,
  `alloted_course` varchar(255) DEFAULT NULL,
  `applicant_photo` varchar(100) DEFAULT NULL,
  `tenth_mark_list` varchar(100) DEFAULT NULL,
  `twelfth_mark_list` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `application_number` (`application_number`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES (6,'Alan George','male','2004-11-19','malayalam','India','123456789','alangeorge18@gmail.com','07356639749','Alan George','2025','bca','bcom','bsc_phy','management','hse_kerala','1234569758','2017',585,90,'SNDP HSS','hse_kerala','2019',78,80,98,98,86.5,'1','Approved','APP82E045DA81','bcom','applicant_photos/P1_MwNoAcm.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-03-18 21:14:59.751628'),(7,'Albert John','male','2004-02-08','malayalam','India','1234567890','albertj12@gmail.com','1234569870','Albert John','2025','bcom','ba_eng','bba','management','cbse','1234569758','2017',585,90,'SNDP HSS','hse_kerala','2019',78,80,98,98,86.5,'2','Approved','APP0F11D3BC9B','bcom','applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-04-24 10:02:46.080088'),(8,'John Doe','Male','1990-05-12','english','Indian','1234567890','john.doe@example.com','9876543210','Undergraduate','2025-2026','bca','bcom','bba','management','cbse','CBSE123456','2006',500,83.3,'St. Thomas HSS','cbse','2008',85,80,82,90,84.25,'4','Pending','APPF3A9C57BDA',NULL,'applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-03-07 06:22:23.762062'),(9,'Jane Smith','female','1992-03-15','hindi','Indian','1234567891','jane.smith@example.com','9876543211','Undergraduate','2025-2026','ba_eng','bba','bcom','management','cbse','CBSE223456','2008',510,85,'Delhi Public School','cbse','2010',88,84,86,89,86.75,'5','Approved','APPACB1E9D3F1',NULL,'applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-04-24 10:03:04.808599'),(10,'Alice Johnson','Female','1995-06-20','english','Indian','1234567892','alice.j@example.com','9876543212','Undergraduate','2025-2026','bsc_phy','bca','bcom','management','icse','ICSE334567','2010',530,88.3,'Modern School','icse','2012',82,79,83,85,82.25,'6','Pending','APP98C1D2B3A4',NULL,'applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-03-07 06:22:23.762062'),(11,'Bob Brown','Male','1988-09-23','english','Indian','1234567893','bob.b@example.com','9876543213','Undergraduate','2025-2026','bcom','bba','ba_eng','management','hse_kerala','HSE123456','2005',495,82.5,'St. Joseph HSS','hse_kerala','2007',80,78,79,77,78.5,'7','Pending','APP5B6A7C8D9E',NULL,'applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-03-07 06:22:23.762062'),(12,'Charlie Davis','Other','1991-01-30','english','Indian','1234567894','charlie.d@example.com','9876543214','Undergraduate','2025-2026','bba','bca','bsc_phy','management','cbse','CBSE556677','2007',505,84.2,'National School','cbse','2009',81,83,85,82,82.75,'8','Pending','APP1D2C3B4A5E',NULL,'applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-03-07 06:22:23.762062'),(13,'Eva Green','Female','1993-07-19','english','Indian','1234567895','eva.g@example.com','9876543215','Undergraduate','2025-2026','ba_eng','bcom','bba','management','cbse','CBSE998877','2009',520,86.7,'Springfield School','cbse','2011',84,85,83,87,84.75,'9','Pending','APP9A8B7C6D5E',NULL,'applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-03-07 06:22:23.762062'),(14,'David White','Male','1990-12-04','english','Indian','1234567896','david.w@example.com','9876543216','Undergraduate','2025-2026','bca','bcom','bba','management','cbse','CBSE667788','2006',490,81.7,'Ryan International','cbse','2008',79,78,80,81,79.5,'10','Pending','APP4D3E2C1B5A',NULL,'applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-03-07 06:22:23.762062'),(15,'Fiona Black','Female','1987-04-22','english','Indian','1234567897','fiona.b@example.com','9876543217','Undergraduate','2025-2026','bsc_phy','ba_eng','bcom','management','icse','ICSE556677','2004',485,80.8,'International School','icse','2006',76,78,75,77,76.5,'11','Pending','APP7C6D5E4B3A',NULL,'applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-03-07 06:22:23.762062'),(16,'George King','Male','1994-11-10','english','Indian','1234567898','george.k@example.com','9876543218','Undergraduate','2025-2026','bcom','bba','bca','management','cbse','CBSE334455','2011',500,83.3,'Public School','cbse','2013',81,79,82,80,80.5,'12','Rejected','APP6E5D4C3B2A',NULL,'applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-03-07 06:22:23.762062'),(17,'Hannah Lee','Female','1992-08-08','english','Indian','1234567899','hannah.l@example.com','9876543219','Undergraduate','2025-2026','ba_eng','bba','bcom','management','cbse','CBSE889900','2008',510,85,'Greenwood School','cbse','2010',82,83,81,84,82.5,'13','Pending','APPB2A3C4D5E6',NULL,'applicant_photos/P1.jpg','tenth_mark_lists/10.jpg','twelfth_mark_lists/12.jpg','2025-03-07 06:22:23.600735','2025-03-07 06:22:23.762062');
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add admission',7,'add_admission'),(26,'Can change admission',7,'change_admission'),(27,'Can delete admission',7,'delete_admission'),(28,'Can view admission',7,'view_admission'),(29,'Can add chatbot response',8,'add_chatbotresponse'),(30,'Can change chatbot response',8,'change_chatbotresponse'),(31,'Can delete chatbot response',8,'delete_chatbotresponse'),(32,'Can view chatbot response',8,'view_chatbotresponse'),(33,'Can add chat log',9,'add_chatlog'),(34,'Can change chat log',9,'change_chatlog'),(35,'Can delete chat log',9,'delete_chatlog'),(36,'Can view chat log',9,'view_chatlog'),(37,'Can add contact',10,'add_contact'),(38,'Can change contact',10,'change_contact'),(39,'Can delete contact',10,'delete_contact'),(40,'Can view contact',10,'view_contact'),(41,'Can add course',11,'add_course'),(42,'Can change course',11,'change_course'),(43,'Can delete course',11,'delete_course'),(44,'Can view course',11,'view_course'),(45,'Can add fees',12,'add_fees'),(46,'Can change fees',12,'change_fees'),(47,'Can delete fees',12,'delete_fees'),(48,'Can view fees',12,'view_fees'),(49,'Can add chatbot_query',13,'add_chatbot_query'),(50,'Can change chatbot_query',13,'change_chatbot_query'),(51,'Can delete chatbot_query',13,'delete_chatbot_query'),(52,'Can view chatbot_query',13,'view_chatbot_query'),(53,'Can add chat bot_querries',14,'add_chatbot_querries'),(54,'Can change chat bot_querries',14,'change_chatbot_querries'),(55,'Can delete chat bot_querries',14,'delete_chatbot_querries'),(56,'Can view chat bot_querries',14,'view_chatbot_querries'),(57,'Can add applications',15,'add_applications'),(58,'Can change applications',15,'change_applications'),(59,'Can delete applications',15,'delete_applications'),(60,'Can view applications',15,'view_applications'),(61,'Can add applicant',16,'add_applicant'),(62,'Can change applicant',16,'change_applicant'),(63,'Can delete applicant',16,'delete_applicant'),(64,'Can view applicant',16,'view_applicant'),(65,'Can add college management',17,'add_collegemanagement'),(66,'Can change college management',17,'change_collegemanagement'),(67,'Can delete college management',17,'delete_collegemanagement'),(68,'Can view college management',17,'view_collegemanagement'),(69,'Can add payment',18,'add_payment'),(70,'Can change payment',18,'change_payment'),(71,'Can delete payment',18,'delete_payment'),(72,'Can view payment',18,'view_payment'),(73,'Can add payment method',19,'add_paymentmethod'),(74,'Can change payment method',19,'change_paymentmethod'),(75,'Can delete payment method',19,'delete_paymentmethod'),(76,'Can view payment method',19,'view_paymentmethod'),(77,'Can add reminder',20,'add_reminder'),(78,'Can change reminder',20,'change_reminder'),(79,'Can delete reminder',20,'delete_reminder'),(80,'Can view reminder',20,'view_reminder');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$MhP3vQenCpYHJPBt989k6M$PhXJddcQifmibdh2/yN0Z+0IbQdIYctS+OOd8Ojtsz0=','2025-03-06 19:04:26.198153',1,'admin','','','admin@prestige.com',1,1,'2025-02-23 09:06:45.161982');
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
-- Table structure for table `chatbot_payment`
--

DROP TABLE IF EXISTS `chatbot_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot_payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `status` varchar(20) NOT NULL,
  `reference_id` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `billing_address` longtext,
  `shipping_address` longtext,
  `notes` longtext,
  `payment_method_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_id` (`reference_id`),
  KEY `chatBot_payment_payment_method_id_1751e4fd_fk_chatBot_p` (`payment_method_id`),
  KEY `chatBot_payment_user_id_51b5d472_fk_auth_user_id` (`user_id`),
  CONSTRAINT `chatBot_payment_payment_method_id_1751e4fd_fk_chatBot_p` FOREIGN KEY (`payment_method_id`) REFERENCES `chatbot_paymentmethod` (`id`),
  CONSTRAINT `chatBot_payment_user_id_51b5d472_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_payment`
--

LOCK TABLES `chatbot_payment` WRITE;
/*!40000 ALTER TABLE `chatbot_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatbot_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot_paymentmethod`
--

DROP TABLE IF EXISTS `chatbot_paymentmethod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot_paymentmethod` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `payment_type` varchar(20) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `processing_fee` decimal(5,2) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_paymentmethod`
--

LOCK TABLES `chatbot_paymentmethod` WRITE;
/*!40000 ALTER TABLE `chatbot_paymentmethod` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatbot_paymentmethod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot_querries`
--

DROP TABLE IF EXISTS `chatbot_querries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot_querries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `query` varchar(555) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_querries`
--

LOCK TABLES `chatbot_querries` WRITE;
/*!40000 ALTER TABLE `chatbot_querries` DISABLE KEYS */;
INSERT INTO `chatbot_querries` VALUES (1,'Hi I\'m ChatBot, here to assist you. What is your name?');
/*!40000 ALTER TABLE `chatbot_querries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbotresponse`
--

DROP TABLE IF EXISTS `chatbotresponse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbotresponse` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL,
  `response` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3018 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbotresponse`
--

LOCK TABLES `chatbotresponse` WRITE;
/*!40000 ALTER TABLE `chatbotresponse` DISABLE KEYS */;
INSERT INTO `chatbotresponse` VALUES (1,'[\"hello\", \"hey\", \"greetings\"]','Hello! How can I assist you today with Prestige College information?'),(2,'[\"hi\", \"hiya\", \"hello there\"]','Hi there! How can I help you with Prestige College inquiries?'),(3,'[\"courses\", \"programs\", \"degrees\", \"majors\", \"what courses\", \"course offerings\"]','We offer a wide range of undergraduate courses including Business, Engineering, Arts, and Sciences. Which field are you interested in?'),(4,'[\"admission\", \"admissions\", \"enroll\", \"join\"]','Our admissions are open for the upcoming semester. Would you like to know about the process, requirements, or deadlines?'),(5,'[\"fees\", \"fee structure\", \"tuition\", \"cost\", \"how much\",\"fees structure\", \"semester fees\"]','The fee structure is as follows: Semester 1 - ₹15,000, Semester 2 - ₹15,500, Semester 3 - ₹16,000, Semester 4 - ₹16,500, Semester 5 - ₹17,000, and Semester 6 - ₹17,500. Additional laboratory or activity fees may apply for certain courses.'),(6,'[\"contact\", \"reach out\", \"email\", \"phone\", \"call\", \"contact details\"]','You can contact Prestige College at prestige.college@example.com or call +1 (123) 456-7890. Our administrative office is open Monday to Friday from 9 AM to 5 PM.'),(7,'[\"thank you\", \"thanks\", \"appreciate it\", \"grateful\"]','You\'re welcome! Feel free to ask if you need any more information about Prestige College. I\'m here to help!'),(8,'[\"bye\", \"goodbye\", \"see you\", \"farewell\"]','Goodbye! Have a great day! Feel free to return if you have more questions about Prestige College.'),(9,'[\"name\", \"who are you\", \"chatbot name\", \"your name\"]','I am the Prestige College virtual assistant. I can answer questions about admissions, courses, campus facilities, and other college-related information.'),(10,'[\"campus\", \"college grounds\", \"premises\"]','Our main campus is located at 123 College Avenue, Prestige City, Country, 56789. The campus spans 50 acres with modern academic buildings, sports facilities, and green spaces.'),(11,'[\"opening hours\", \"office hours\", \"timing\", \"when open\", \"college hours\"]','Our administrative offices are open Monday to Friday from 9 AM to 5 PM. The library is open from 8 AM to 10 PM on weekdays and 10 AM to 6 PM on weekends.'),(12,'[\"location\", \"address\", \"where located\", \"directions\", \"college address\"]','Prestige College is located at 123 College Avenue, Prestige City, Country, 56789. We are near the Central Park and approximately 3 miles from the city center.'),(13,'[\"campus infrastructure\", \"facilities\", \"college facilities\", \"amenities\", \"campus amenities\"]','Our campus features modern infrastructure including smart classrooms, digital libraries, research laboratories, sports complexes (indoor and outdoor), student center, cafeteria, health center, and Wi-Fi throughout the campus.'),(14,'[\"public transport\", \"college transport\", \"how to reach\", \"bus route\", \"transportation\"]','The college is easily accessible by public transport. City bus routes 101, 203, and 305 stop directly at the campus entrance. The nearest metro station is Central Station, a 10-minute walk from campus. We also offer shuttle services from major transportation hubs.'),(15,'[\"extracurricular activities\", \"college events\", \"activities\", \"clubs\", \"student organizations\"]','We offer a diverse range of extracurricular activities including sports teams, cultural clubs, academic societies, debate club, music ensemble, drama club, and volunteering opportunities. Annual events include the Cultural Festival, Sports Week, and Academic Symposium.'),(17,'[\"transcript\", \"marks transcript\", \"get transcript\", \"academic records\", \"grade report\"]','You can request a transcript of your academic records from the Academic Records Office or through the student portal. Processing typically takes 3-5 business days, and a nominal fee may apply for additional copies.'),(18,'[\"internships\", \"student internships\", \"internship opportunities\", \"work experience\", \"industry experience\"]','Prestige College offers robust internship programs in collaboration with over 100 partner companies across various industries. Our Career Services Office can help you find and apply for internships relevant to your field of study.'),(19,'[\"how to apply\", \"apply for admission\", \"college application\", \"register\", \"start application\"]','To apply for admission, please visit our admissions portal at apply.prestigecollege.example.com and complete the online application form. <a href=\'application\'>Click here</a> to start your application process.'),(20,'[\"admission process\", \"steps for admission\", \"admission procedure\", \"application steps\"]','The admission process involves: 1) Completing the online application form, 2) Submitting required documents, 3) Paying the application fee, 4) Taking entrance tests if required for your program, 5) Attending an interview if shortlisted, and 6) Receiving an admission decision.'),(21,'[\"eligibility criteria\", \"who can apply\", \"admission requirements\", \"qualifications needed\", \"minimum requirements\"]','Eligibility criteria vary by program. Generally, undergraduate programs require completion of high school with a minimum of 60% aggregate marks. Specific programs may have additional requirements such as mathematics or science prerequisites. Please check the program-specific details on our website.'),(22,'[\"deadline\", \"admission deadline\", \"last date to apply\", \"application timeline\", \"closing date\"]','The standard application deadline for fall semester admission is May 31, and for spring semester is November 30. Early application deadlines are March 15 and September 15 respectively. Some specialized programs may have different deadlines.'),(23,'[\"documents required\", \"admission documents\", \"documents for admission\", \"required paperwork\", \"application documents\"]','Required documents include completed application form, high school transcripts, standardized test scores (if applicable), identification proof (passport/national ID), passport-sized photographs, and program-specific documents. International students must also provide proof of English proficiency.'),(24,'[\"entrance exam\", \"is there an entrance exam\", \"admission test\", \"entrance test\", \"aptitude test\"]','Many of our programs require an entrance examination. The Prestige College Aptitude Test (PCAT) evaluates candidates on logical reasoning, verbal ability, quantitative skills, and subject knowledge relevant to the chosen program. Practice materials are available on our website.'),(25,'[\"interview process\", \"admission interview\", \"is there an interview\", \"interview questions\", \"selection interview\"]','Shortlisted candidates for certain programs will be invited for an interview. The interview assesses your academic background, program fit, communication skills, and career goals. Interviews may be conducted in-person or virtually depending on your location.'),(40,'[\"admission form\", \"where to get admission form\", \"how to get admission form\", \"application form location\"]','The admission form is available exclusively online through our admissions portal at apply.prestigecollege.example.com. If you face any technical difficulties, our admissions office can provide assistance.'),(41,'[\"application fee\", \"is there an application fee\", \"admission application fee\", \"fee for applying\", \"processing fee\"]','Yes, there is a non-refundable application fee of ₹1,500 for domestic students and $50 for international students. Fee waivers may be available for eligible candidates based on financial need.'),(42,'[\"admission status\", \"check admission status\", \"how to check status\", \"application progress\", \"decision status\"]','You can check your admission status by logging into the admissions portal with your application ID and password. Status updates are also sent via email at key stages of the application process.'),(43,'[\"course availability\", \"is the course available\", \"course offered\", \"program availability\", \"seat availability\"]','Course availability varies by semester and is subject to minimum enrollment requirements. The upcoming semester offerings are listed in the course catalog on our website. Popular programs fill quickly, so early application is recommended.'),(44,'[\"admission dates\", \"admission schedule\", \"when is admission\", \"application period\", \"intake dates\"]','Prestige College has two main admission cycles: Fall (August intake) with applications open from January to May, and Spring (January intake) with applications open from August to November. Some specialized programs may have only one intake per year.'),(45,'[\"admission confirmation\", \"how to confirm admission\", \"admission confirmation steps\", \"accept offer\", \"secure admission\"]','After receiving an admission offer, you must confirm your acceptance by logging into the admissions portal, accepting the offer, and paying the confirmation fee of ₹10,000 (adjustable against first semester fees) within the deadline specified in your offer letter.'),(46,'[\"reservation category\", \"reserved category admission\", \"reservation for admission\", \"quota system\", \"affirmative action\"]','Prestige College follows government guidelines for reservations in admissions. Categories include Scheduled Castes (15%), Scheduled Tribes (7.5%), Other Backward Classes (27%), and Persons with Disabilities (5%). Eligible candidates should submit relevant certificates during application.'),(47,'[\"admission update\", \"admission notification\", \"how to receive updates\", \"application alerts\", \"status notifications\"]','You will receive admission updates via email and SMS. Ensure your contact details in the application are accurate. You can also opt for push notifications through our mobile app or check for updates on the admissions portal.'),(48,'[\"course fees\", \"admission fee structure\", \"fees details\", \"program cost\", \"tuition breakdown\"]','Comprehensive fee details for each program include tuition fees, development fees, examination fees, and other applicable charges. The full breakdown is available on the admissions page and will be included in your offer letter.'),(49,'[\"admission interview questions\", \"common interview questions\", \"what will be asked in interview\", \"interview preparation\", \"interview tips\"]','Admission interviews typically cover your academic background, reasons for choosing Prestige College and your specific program, your understanding of the field, career aspirations, and relevant experiences. Be prepared to discuss your resume and answer program-specific questions.'),(50,'[\"waitlist\", \"admission waitlist\", \"am I on the waitlist\", \"waitlist status\", \"waitlist chances\"]','Waitlisted candidates are notified by email. Your position on the waitlist is updated in real-time on the admissions portal. Waitlist movement typically occurs within 2-4 weeks after initial admission decisions as accepted candidates confirm or decline their offers.'),(51,'[\"admission for international students\", \"international student admission\", \"admission requirements for international students\", \"foreign student application\", \"overseas applicants\"]','International students must submit additional documents including passport copy, visa documentation, English proficiency test scores (TOEFL/IELTS/PTE), and educational certificates with official translations if not in English. We offer specialized orientation programs for international students.'),(52,'[\"hostel availability\", \"hostel for admission\", \"is there a hostel for students\", \"accommodation\", \"dormitory\"]','Prestige College offers on-campus housing in six residence halls with both single and shared room options. First-year students are guaranteed housing if applications are submitted by the priority deadline. Hostel fees range from ₹60,000 to ₹90,000 per academic year depending on room type.'),(53,'[\"admission confirmation email\", \"confirmation letter\", \"received confirmation\", \"acceptance letter\", \"offer letter\"]','Upon confirmation of your admission, you will receive an official confirmation letter via email with important information about orientation, registration, and next steps. A hard copy will also be mailed to your postal address.'),(54,'[\"defer admission\", \"can I defer admission\", \"defer admission request\", \"postpone enrollment\", \"gap year\"]','Admitted students may request to defer their admission for up to one academic year. Submit a deferral request letter explaining your reasons to the admissions office. Deferral requests are considered on a case-by-case basis, and the confirmation fee must be paid to hold your place.'),(55,'[\"admission fees payment\", \"pay admission fees\", \"how to pay admission fees\", \"tuition payment\", \"fee submission\"]','Admission fees can be paid through multiple methods: online payment via the college portal (credit/debit cards, net banking), direct bank transfer to the college account, or demand draft in favor of \"Prestige College.\" Payment details are provided in your offer letter.'),(56,'[\"admission for distance learning\", \"distance education admission\", \"online course admission\", \"remote learning programs\", \"off-campus study\"]','Prestige College offers distance learning options for select undergraduate and postgraduate programs. The application process for distance education is similar to regular programs but with different fee structures and more flexible scheduling options.'),(57,'[\"admission details\", \"admission brochure\", \"admission information\", \"prospectus\", \"program guide\"]','Our comprehensive admission brochure contains detailed information about all programs, eligibility criteria, fee structures, scholarships, and campus facilities. Download it from our website or request a physical copy by contacting the admissions office.'),(58,'[\"admission query\", \"admission doubts\", \"admission questions\", \"application help\", \"admission support\"]','For specific admission queries, you can email admissions@prestigecollege.example.com, call our helpline at +1 (123) 456-7899, visit our FAQ section online, or schedule a virtual meeting with an admissions counselor through our website.'),(59,'[\"admission guidelines\", \"admission rules\", \"how to apply guidelines\", \"application instructions\", \"admission protocol\"]','Detailed admission guidelines are available on our admissions portal. These include step-by-step application instructions, document requirements, important dates, selection criteria, and program-specific information to help you navigate the admission process.'),(60,'[\"admission result\", \"how to know admission result\", \"when will the result be announced\", \"selection results\", \"admission decisions\"]','Admission decisions are typically announced within 4-6 weeks after the application deadline. Results are published on the admissions portal and sent via email. You can also check your status by logging into your application account.'),(61,'[\"late admission\", \"admission after deadline\", \"late application\", \"missed deadline\", \"extended deadline\"]','Late applications may be considered on a case-by-case basis if seats remain available. A late application fee of ₹2,500 will apply. Contact the admissions office at lateadmission@prestigecollege.example.com to inquire about late admission possibilities for your program of interest.');
/*!40000 ALTER TABLE `chatbotresponse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatlog`
--

DROP TABLE IF EXISTS `chatlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatlog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bot_response` longtext NOT NULL,
  `user_query` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatlog`
--

LOCK TABLES `chatlog` WRITE;
/*!40000 ALTER TABLE `chatlog` DISABLE KEYS */;
INSERT INTO `chatlog` VALUES (1,'We offer a wide range of courses. Would you like to know more about them?','What are the courses availanle here','2025-02-06 15:54:38.720800','32ecf1b2-0c09-4c28-b5e3-288623b1e738','Alen'),(2,'You\'re welcome! Feel free to ask if you need any more help.','thank you','2025-02-06 15:54:48.693681','32ecf1b2-0c09-4c28-b5e3-288623b1e738','Alen'),(3,'We offer a wide range of undergraduate courses.','What are the course here','2025-02-06 16:15:28.790322','c4be12f2-6454-4978-bd3d-3fd15195c713','Ben'),(4,'Sorry, I couldn\'t find any relevant information. Could you please clarify?','How can i contact','2025-02-06 16:15:46.519004','c4be12f2-6454-4978-bd3d-3fd15195c713','Ben'),(5,'You can contact us at prestige.college@example.com or call +1 (123) 456-7890.','contact','2025-02-06 16:16:04.648451','c4be12f2-6454-4978-bd3d-3fd15195c713','Ben'),(6,'Sorry, I couldn\'t find any relevant information. Could you please clarify?','Whom to contact','2025-02-06 16:18:57.041387','1106711c-60b6-4ec8-8717-367117b014ac','Aron'),(7,'You can contact us at prestige.college@example.com or call +1 (123) 456-7890.','contact','2025-02-06 16:19:04.052846','1106711c-60b6-4ec8-8717-367117b014ac','Aron'),(8,'Sorry, I couldn\'t find any relevant information. Could you please clarify?','whom to contact','2025-02-06 16:21:55.260483','38e76e28-637d-4652-ab31-2578825e44a1','Manu'),(9,'Ben, You can contact us at prestige.college@example.com or call +1 (123) 456-7890.','contact','2025-02-06 16:22:05.014911','38e76e28-637d-4652-ab31-2578825e44a1','Manu'),(13,'Our campus has modern infrastructure including well-equipped classrooms, libraries, sports facilities, and a cafeteria.','campus infrastructure','2025-02-06 16:33:48.918986','fc147ed5-3d7c-4242-8109-3f7bd7bd4cdc','Mark'),(14,'The fee structure for each course is available on the admissions page. You can view the full breakdown there.','details about campus infrastructure','2025-02-06 16:36:27.785924','109f6ce2-5201-478f-aec9-f3ed6e6ca5d7','Mark'),(15,'Our campus has modern infrastructure including well-equipped classrooms, libraries, sports facilities, and a cafeteria.','infrastructure','2025-02-06 16:37:40.916133','ea56de2e-7b0d-43a3-bdd9-1922197de6b4','Mark'),(16,'Sorry, I couldn\'t find any relevant information. Could you please clarify?','How can register','2025-02-07 08:43:13.316966','b5529e49-7bc2-4156-a051-a649c76fe877','Manu'),(17,'<a href=\'#admissions\'>Admission Registration</a>','register','2025-02-07 08:43:38.330224','b5529e49-7bc2-4156-a051-a649c76fe877','Manu'),(18,'<a href=\'register.html\'>Updated Admission Registration</a>','register','2025-02-07 08:48:02.897158','11cc9f73-b31e-4674-bc52-af9c5a1cf673','Manu'),(19,'<a href=\'register.html\'>Updated Admission Registration</a>','register','2025-02-07 08:50:53.786831','b387fe69-eb3f-4ed7-8e42-dd1a17991406','Manu'),(20,'Sorry, I couldn\'t find any relevant information. Could you please clarify?','how can I register','2025-02-07 08:56:25.185991','7a90ce9f-9c3d-4a46-85fd-e27515f487cd','Ron'),(21,'<a href=\'register\'>Admission Registration</a>','register','2025-02-07 08:56:28.237433','7a90ce9f-9c3d-4a46-85fd-e27515f487cd','Ron'),(22,'<a href=\'register\'>Admission Registration</a>','how can I register','2025-02-07 09:05:41.253243','0f1e223b-2ec1-4e47-be32-db81950e3d0d','Don'),(23,'Our campus has modern infrastructure including well-equipped classrooms, libraries, sports facilities, and a cafeteria.','what are the campus infrastructure','2025-02-07 09:05:58.088174','0f1e223b-2ec1-4e47-be32-db81950e3d0d','Don'),(24,'You can contact us at prestige.college@example.com or call +1 (123) 456-7890.','whom to conttact','2025-02-07 09:06:08.779395','0f1e223b-2ec1-4e47-be32-db81950e3d0d','Don'),(25,'The fees vary depending on the course. Which course are you interested in?','fees structurw','2025-02-07 09:06:19.426239','0f1e223b-2ec1-4e47-be32-db81950e3d0d','Don'),(26,'<a href=\'register\'>Admission Registration</a>','How can i register','2025-02-07 09:24:37.226127','8f87745c-c65b-4ece-8959-6e59ede7a828','Don'),(27,'For application registration <a href=\'application\'>click here</a>','How can i register myself','2025-02-07 10:12:47.489784','990f7424-fea2-4ee6-b37e-e7a78a30e81f','Tony'),(28,'For application registration <a href=\'application\'>click here</a>','How can I register','2025-02-11 04:33:09.803755','b597414d-9c47-491d-931f-4a546e47997b','Ashley'),(29,'Sorry, I couldn\'t find any relevant information. Could you please clarify?','2+2','2025-02-11 04:33:30.898844','b597414d-9c47-491d-931f-4a546e47997b','Ashley'),(30,'Hello! How can I assist you today?','','2025-02-13 08:17:37.872475','babf9970-50a2-4392-b628-305bff943fcc','Suryajith SS'),(31,'You can apply for a hostel room through the online portal or by visiting the hostel office directly.','How can i register the application','2025-02-23 06:34:11.749425','28ad95a3-96f1-4a20-81c4-63e9e9a94670','Alan'),(32,'You can apply for a hostel room through the online portal or by visiting the hostel office directly.','Not hostel, college application','2025-02-23 06:34:37.465061','28ad95a3-96f1-4a20-81c4-63e9e9a94670','Alan'),(33,'Our campus has modern infrastructure including well-equipped classrooms, libraries, sports facilities, and a cafeteria.','How can i regiter fot college','2025-02-23 06:35:11.151690','28ad95a3-96f1-4a20-81c4-63e9e9a94670','Alan'),(34,'Our campus has modern infrastructure including well-equipped classrooms, libraries, sports facilities, and a cafeteria.','How can i register fot college','2025-02-23 06:35:24.910673','28ad95a3-96f1-4a20-81c4-63e9e9a94670','Alan'),(35,'For application registration <a href=\'application\'>click here</a>','register','2025-02-23 06:35:32.136029','28ad95a3-96f1-4a20-81c4-63e9e9a94670','Alan'),(36,'You can apply for a hostel room through the online portal or by visiting the hostel office directly.','How can i register my college application','2025-02-27 12:57:59.442253','a8858d2e-2888-4820-98cf-66d1e06e5cc3','Surya'),(37,'Yes, there is an application fee. The fee amount is listed on the admissions portal.','How can i register my college application','2025-02-27 13:03:52.863345','a8858d2e-2888-4820-98cf-66d1e06e5cc3','Surya'),(38,'To apply for admission, please visit our admissions portal and fill out the application form.<a href=\'application\'>click here</a> to apply.','How to apply','2025-02-27 13:04:09.935299','a8858d2e-2888-4820-98cf-66d1e06e5cc3','Surya'),(39,'To apply for admission, please visit our admissions portal and fill out the application form. <a href=\'application\'>click here</a> to apply.','How can i register my college application','2025-02-27 13:14:43.988562','a8858d2e-2888-4820-98cf-66d1e06e5cc3','Surya'),(40,'Hi Surya, Yes, there is an application fee. The fee amount is listed on the admissions portal.','is there any application fee','2025-02-27 13:15:09.397057','a8858d2e-2888-4820-98cf-66d1e06e5cc3','Surya'),(41,'Hi there! How can I help you?','','2025-02-27 13:15:44.732889','a8858d2e-2888-4820-98cf-66d1e06e5cc3','Surya'),(42,'From what I know, To apply for admission, please visit our admissions portal and fill out the application form. <a href=\'application\'>click here</a> to apply.','Where can I regeister my college application','2025-02-27 13:16:11.277753','a8858d2e-2888-4820-98cf-66d1e06e5cc3','Surya'),(43,'To apply for admission, please visit our admissions portal and fill out the application form. <a href=\'application\'>click here</a> to apply.','How can i register','2025-03-04 05:41:27.874320','0dc532b6-04f3-4319-bd1a-83ca563c7dac','Surya'),(44,'Hi there! How can I help you?','','2025-03-04 05:48:44.479614','0dc532b6-04f3-4319-bd1a-83ca563c7dac','Surya'),(45,'Hi there! How can I help you?','','2025-03-04 05:48:51.148766','0dc532b6-04f3-4319-bd1a-83ca563c7dac','Surya'),(46,'Hi Surya, Sorry for the inconvenience. Our system is experiencing a hiccup. Please try again.','courses','2025-03-04 05:53:49.068387','3c639c9a-7e47-4987-9941-f84570b8fd64','Surya'),(47,'I believe Sorry for the inconvenience. Our system is experiencing a hiccup. Please try again. Do you have any other questions?','','2025-03-04 06:04:27.199012','3c639c9a-7e47-4987-9941-f84570b8fd64','Surya'),(48,'Hi Surya, The admission interview generally focuses on your academic background, reasons for choosing the course, and future goals.','What are the courses available','2025-03-04 06:05:05.344685','3c639c9a-7e47-4987-9941-f84570b8fd64','Surya'),(49,'To apply for admission, please visit our admissions portal and fill out the application form. <a href=\'application\'>click here</a> to apply.','How can i register','2025-03-04 06:13:19.936580','d43a30d3-0732-4151-a0e3-15605d038286','Surya'),(50,'Let me see... Surya, We offer a wide range of undergraduate courses.','course','2025-03-04 06:14:16.200841','d43a30d3-0732-4151-a0e3-15605d038286','Surya'),(51,'We offer a wide range of undergraduate courses. What else would you like to know about our college?','What about the fees','2025-03-04 06:14:40.719147','d43a30d3-0732-4151-a0e3-15605d038286','Surya'),(52,'According to our information, Hi Surya, The fee structure is as follows: Semester 1 - ₹15,000, Semester 2 - ₹15,500, Semester 3 - ₹16,000, Semester 4 - ₹16,500, Semester 5 - ₹17,000, and Semester 6 - ₹17,500.','fee','2025-03-04 06:14:58.028825','d43a30d3-0732-4151-a0e3-15605d038286','Surya'),(53,'Our main campus is located at 123 College Avenue, Prestige City, Country, 56789. The campus spans 50 acres with modern academic buildings, sports facilities, and green spaces.','Where exactly the college is at?','2025-03-14 10:43:36.497013','2cae2ce6-a765-43fd-bae3-fdd73ae9ae82','Suryajith'),(54,'From what I know, Well Suryajith, We offer a wide range of undergraduate courses including Business, Engineering, Arts, and Sciences. Which field are you interested in?','What are the courses you provide','2025-03-14 10:44:42.636397','2cae2ce6-a765-43fd-bae3-fdd73ae9ae82','Suryajith'),(55,'I apologize, but something went wrong. Please try again in a moment.','Can you tell me more about the fees structure','2025-03-14 10:45:18.502647','2cae2ce6-a765-43fd-bae3-fdd73ae9ae82','Suryajith'),(56,'The fee structure is as follows: Semester 1 - ₹15,000, Semester 2 - ₹15,500, Semester 3 - ₹16,000, Semester 4 - ₹16,500, Semester 5 - ₹17,000, and Semester 6 - ₹17,500. Additional laboratory or activity fees may apply for certain courses. What else would you like to know about our college?','Can you tell me more about the fee structure','2025-03-14 10:45:33.388243','2cae2ce6-a765-43fd-bae3-fdd73ae9ae82','Suryajith'),(57,'To apply for admission, please visit our admissions portal at apply.prestigecollege.example.com and complete the online application form. <a href=\'application\'>Click here</a> to start your application process.','How can i apply?','2025-03-14 10:46:18.677231','2cae2ce6-a765-43fd-bae3-fdd73ae9ae82','Suryajith'),(58,'Hi Suryajith, You\'re welcome! Feel free to ask if you need any more information about Prestige College. I\'m here to help!','Thank you','2025-03-14 10:46:26.921436','2cae2ce6-a765-43fd-bae3-fdd73ae9ae82','Suryajith'),(59,'Hi Suryajith, Goodbye! Have a great day! Feel free to return if you have more questions about Prestige College.','Ok good','2025-03-14 10:49:05.798441','2cae2ce6-a765-43fd-bae3-fdd73ae9ae82','Suryajith'),(60,'From what I know, Well Suryajith, You\'re welcome! Feel free to ask if you need any more information about Prestige College. I\'m here to help!','bye','2025-03-14 10:49:17.221649','2cae2ce6-a765-43fd-bae3-fdd73ae9ae82','Suryajith'),(61,'Hi Sam, Prestige College is located at 123 College Avenue, Prestige City, Country, 56789. We are near the Central Park and approximately 3 miles from the city center.','where is campus located','2025-03-16 20:14:27.317030','6c86f51f-a80b-4fdb-8a56-a69df8abf4f5','Sam'),(62,'Hi Surya, Our admissions are open for the upcoming semester. Would you like to know about the process, requirements, or deadlines?','i need an admission','2025-03-19 03:51:34.290605','3ff773f6-03b5-41d8-a909-703902fd8db4','Surya'),(63,'Hi Kamala, Our main campus is located at 123 College Avenue, Prestige City, Country, 56789. The campus spans 50 acres with modern academic buildings, sports facilities, and green spaces.','Where is the cllege situated','2025-04-23 17:46:03.051191','f0244733-6894-4e95-ba9f-66bb2fd71084','Kamala'),(64,'To apply for admission, please visit our admissions portal at apply.prestigecollege.example.com and complete the online application form. <a href=\'application\'>Click here</a> to start your application process.','How cann I appli','2025-04-23 18:52:36.712508','949d37f1-d25d-40d9-9402-b8825ac1cdc5','Melvin'),(65,'I believe Our main campus is located at 123 College Avenue, Prestige City, Country, 56789. The campus spans 50 acres with modern academic buildings, sports facilities, and green spaces. Is there anything else you\'d like to know?','where is the cllege situated','2025-04-24 04:22:10.279295','96c429f2-307c-4eba-93cd-f79b76d9a460','Manu'),(66,'To apply for admission, please visit our admissions portal at apply.prestigecollege.example.com and complete the online application form. <a href=\'application\'>Click here</a> to start your application process. What else would you like to know about our college?','how cn i appy','2025-04-24 04:24:09.435170','96c429f2-307c-4eba-93cd-f79b76d9a460','Manu'),(67,'Prestige College is located at 123 College Avenue, Prestige City, Country, 56789. We are near the Central Park and approximately 3 miles from the city center.','wher is th campus lcated','2025-04-24 06:45:33.360770','c53be512-ce21-4a27-b2fb-3ff485fd2c65','Aron'),(68,'Aron, To apply for admission, please visit our admissions portal at apply.prestigecollege.example.com and complete the online application form. <a href=\'application\'>Click here</a> to start your application process.','how to appy','2025-04-24 06:47:31.661651','c53be512-ce21-4a27-b2fb-3ff485fd2c65','Aron'),(69,'Our main campus is located at 123 College Avenue, Prestige City, Country, 56789. The campus spans 50 acres with modern academic buildings, sports facilities, and green spaces.','','2025-04-24 06:59:54.259334','c53be512-ce21-4a27-b2fb-3ff485fd2c65','Aron'),(70,'Oops! There seems to be a technical issue. Please try again shortly.','','2025-04-24 07:00:02.101633','c53be512-ce21-4a27-b2fb-3ff485fd2c65','Aron'),(71,'Our main campus is located at 123 College Avenue, Prestige City, Country, 56789. The campus spans 50 acres with modern academic buildings, sports facilities, and green spaces.','wher is the collg situated','2025-04-24 08:46:55.902469','13d45a00-214e-44db-9fa3-69e13feb3126','Abhay'),(72,'I believe Abhay, The fee structure is as follows: Semester 1 - ₹15,000, Semester 2 - ₹15,500, Semester 3 - ₹16,000, Semester 4 - ₹16,500, Semester 5 - ₹17,000, and Semester 6 - ₹17,500. Additional laboratory or activity fees may apply for certain courses.','fee','2025-04-24 08:47:10.517033','13d45a00-214e-44db-9fa3-69e13feb3126','Abhay'),(73,'I believe Oops! There seems to be a technical issue. Please try again shortly. Can I help you with anything else?','','2025-04-24 08:47:25.898896','13d45a00-214e-44db-9fa3-69e13feb3126','Abhay'),(74,'The fee structure is as follows: Semester 1 - ₹15,000, Semester 2 - ₹15,500, Semester 3 - ₹16,000, Semester 4 - ₹16,500, Semester 5 - ₹17,000, and Semester 6 - ₹17,500. Additional laboratory or activity fees may apply for certain courses. What else would you like to know about our college?','','2025-04-24 08:47:37.821415','13d45a00-214e-44db-9fa3-69e13feb3126','Abhay'),(75,'I don\'t have specific information about that. Can you ask something else about our college?','','2025-04-24 08:47:55.538095','13d45a00-214e-44db-9fa3-69e13feb3126','Abhay'),(76,'I\'m not sure I understood. Could you rephrase that or provide more context?','','2025-04-24 08:48:42.943448','13d45a00-214e-44db-9fa3-69e13feb3126','Abhay'),(77,'Well Do, We offer a wide range of undergraduate courses including Business, Engineering, Arts, and Sciences. Which field are you interested in?','Do you have bca course','2025-04-24 09:58:36.391884','3906d041-8fe9-46e6-91be-6c8f49d226fa','Do'),(78,'Prestige College is located at 123 College Avenue, Prestige City, Country, 56789. We are near the Central Park and approximately 3 miles from the city center.','wher is collrge located','2025-04-24 09:59:47.381270','3906d041-8fe9-46e6-91be-6c8f49d226fa','Do'),(79,'To apply for admission, please visit our admissions portal at apply.prestigecollege.example.com and complete the online application form. <a href=\'application\'>Click here</a> to start your application process.','How to apply','2025-04-24 10:00:08.290291','3906d041-8fe9-46e6-91be-6c8f49d226fa','Do');
/*!40000 ALTER TABLE `chatlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` longtext NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (1,'123 College Avenue, Prestige City, Country, 56789','+91 12345 67890','prestige.college@example.com');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `seats` int DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `tag` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Bachelor of Science in Computer Science','This course provides in-depth knowledge of computer science, covering programming, algorithms, databases, and emerging technologies like AI and data science.',59,'BCA','bca'),(2,'Bachelor of Arts in English Literature','This course explores classic and contemporary literary works, critical analysis, creative writing, and the cultural significance of literature.',60,'BA ENG','ba_eng'),(3,'Bachelor of Commerce','This course focuses on core aspects of commerce, including accounting, taxation, finance, business law, and entrepreneurship development.',58,'BCOM','bcom'),(4,'Bachelor of Business Administration','This course prepares students for management roles by teaching business strategy, marketing, organizational behavior, and financial management.',60,'BBA','bba'),(5,'Bachelor of Science in Physics','This course delves into the principles of physics, including mechanics, electromagnetism, quantum physics, and experimental techniques for scientific research.',59,'BSC PHY','bsc_phy');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-02-23 09:11:48.775748','7','Albert John (2025)',1,'[{\"added\": {}}]',15,1),(2,'2025-02-23 09:30:09.403801','7','Albert John (2025)',2,'[{\"changed\": {\"fields\": [\"Applicant id\", \"Application number\"]}}]',15,1),(3,'2025-02-23 09:44:34.034882','2','Aravind VM',1,'[{\"added\": {}}]',16,1),(4,'2025-02-23 09:45:09.908419','1','Suryajith SS',2,'[{\"changed\": {\"fields\": [\"Gender\"]}}]',16,1),(5,'2025-03-02 19:58:14.266755','3','Sushama K B',1,'[{\"added\": {}}]',16,1),(6,'2025-03-02 19:58:54.197226','7','Albert John (2025)',2,'[{\"changed\": {\"fields\": [\"Applicant id\"]}}]',15,1),(7,'2025-03-06 18:52:16.602977','6','Alan George (2025)',2,'[{\"changed\": {\"fields\": [\"Status\", \"Applicant photo\", \"Twelfth mark list\", \"Tenth mark list\"]}}]',15,1),(8,'2025-03-06 19:18:04.561518','6','Alan George (2025)',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',15,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(7,'chatBot','admission'),(16,'chatBot','applicant'),(15,'chatBot','applications'),(14,'chatBot','chatbot_querries'),(13,'chatBot','chatbot_query'),(8,'chatBot','chatbotresponse'),(9,'chatBot','chatlog'),(17,'chatBot','collegemanagement'),(10,'chatBot','contact'),(11,'chatBot','course'),(12,'chatBot','fees'),(18,'chatBot','payment'),(19,'chatBot','paymentmethod'),(20,'chatBot','reminder'),(5,'contenttypes','contenttype'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-01-17 08:30:07.958147'),(2,'auth','0001_initial','2025-01-17 08:30:08.457499'),(3,'admin','0001_initial','2025-01-17 08:30:08.588165'),(4,'admin','0002_logentry_remove_auto_add','2025-01-17 08:30:08.593397'),(5,'admin','0003_logentry_add_action_flag_choices','2025-01-17 08:30:08.599600'),(6,'contenttypes','0002_remove_content_type_name','2025-01-17 08:30:08.660827'),(7,'auth','0002_alter_permission_name_max_length','2025-01-17 08:30:08.711571'),(8,'auth','0003_alter_user_email_max_length','2025-01-17 08:30:08.727306'),(9,'auth','0004_alter_user_username_opts','2025-01-17 08:30:08.733723'),(10,'auth','0005_alter_user_last_login_null','2025-01-17 08:30:08.773403'),(11,'auth','0006_require_contenttypes_0002','2025-01-17 08:30:08.776533'),(12,'auth','0007_alter_validators_add_error_messages','2025-01-17 08:30:08.782024'),(13,'auth','0008_alter_user_username_max_length','2025-01-17 08:30:08.838452'),(14,'auth','0009_alter_user_last_name_max_length','2025-01-17 08:30:08.889124'),(15,'auth','0010_alter_group_name_max_length','2025-01-17 08:30:08.903373'),(16,'auth','0011_update_proxy_permissions','2025-01-17 08:30:08.908601'),(17,'auth','0012_alter_user_first_name_max_length','2025-01-17 08:30:08.958272'),(18,'chatBot','0001_initial','2025-01-17 08:30:09.022256'),(19,'chatBot','0002_alter_admission_table_alter_chatbotresponse_table_and_more','2025-01-17 08:30:09.067214'),(20,'sessions','0001_initial','2025-01-17 08:30:09.099371'),(21,'chatBot','0003_fees','2025-01-18 05:30:15.581209'),(22,'chatBot','0004_remove_fees_sem7_remove_fees_sem8','2025-01-18 06:14:34.194477'),(23,'chatBot','0005_chatbot_query','2025-01-18 09:41:43.005216'),(24,'chatBot','0005_chatbot_querries','2025-01-18 10:04:48.977333'),(25,'chatBot','0006_alter_chatbotresponse_response','2025-01-31 06:48:44.949634'),(26,'chatBot','0007_alter_chatlog_age_alter_chatlog_email_and_more','2025-02-06 14:57:43.541247'),(27,'chatBot','0008_rename_query_chatlog_bot_response_and_more','2025-02-06 15:54:10.376470'),(28,'chatBot','0009_applications','2025-02-07 09:47:36.542445'),(29,'chatBot','0010_alter_applications_table_alter_chatlog_table','2025-02-07 09:47:36.605285'),(30,'chatBot','0011_applicant','2025-02-07 10:27:34.223123'),(31,'chatBot','0012_alter_applicant_table','2025-02-07 10:27:34.359811'),(32,'chatBot','0013_applications_applicant_id','2025-02-07 12:45:47.750799'),(33,'chatBot','0014_applications_status','2025-02-13 07:28:12.414634'),(34,'chatBot','0015_applications_application_number_and_more','2025-02-20 15:03:22.324313'),(35,'chatBot','0016_alter_applications_applicant_id','2025-02-20 15:03:22.404987'),(36,'chatBot','0016_alter_applications_application_number','2025-02-20 15:36:20.764258'),(37,'chatBot','0017_collegemanagement_and_more','2025-02-22 14:39:22.987453'),(38,'chatBot','0018_applications_application_number','2025-02-22 14:46:09.234112'),(39,'chatBot','0019_applications_alloted_course_course_seats','2025-02-23 06:16:12.755100'),(40,'chatBot','0020_course_name','2025-02-24 04:15:30.879041'),(41,'chatBot','0021_course_tag','2025-02-24 04:28:34.701584'),(42,'chatBot','0022_applications_applicant_photo_and_more','2025-03-06 18:23:55.109219'),(43,'chatBot','0023_paymentmethod_payment','2025-03-07 05:48:14.664292'),(44,'chatBot','0024_applications_created_at_applications_updated_at','2025-03-07 06:22:23.806099'),(45,'chatBot','0025_reminder','2025-03-18 17:57:12.094486'),(46,'chatBot','0026_alter_reminder_table','2025-03-18 17:59:14.305710'),(47,'chatBot','0027_applicant_notification','2025-03-18 19:40:41.847148'),(48,'chatBot','0025_reminder_applicant_notification_delete_payment_and_more','2025-04-23 19:13:34.959581'),(49,'chatBot','0028_merge_20250423_2344','2025-04-23 19:13:35.044551'),(50,'chatBot','0029_alter_applicant_notification','2025-04-23 19:27:34.139233');
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
INSERT INTO `django_session` VALUES ('49696j23ewj51pcdv7mrkbsjgseqwr41','eyJ1c2VyX25hbWUiOiJDYW1wdXMiLCJhd2FpdGluZ19uYW1lIjpmYWxzZX0:1tdlV9:h-J9bTKDYw-Tj02OxlbOeUbF0Kd9Ayq43tBQUI1_pkM','2025-02-14 07:31:43.329935'),('bes1m5iyiacnjy043yexb8zzyhh7w4lg','eyJhd2FpdGluZ19uYW1lIjpmYWxzZSwidXNlcl9uYW1lIjoiU3VyeWEifQ:1tdnQq:D5j_sCkOz_z_wkyp4_gZkeGQ-7zAnR1Y6xsqfRLJsUY','2025-01-31 09:36:24.301741');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fees`
--

DROP TABLE IF EXISTS `fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fees` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sem1` int NOT NULL,
  `sem2` int NOT NULL,
  `sem3` int NOT NULL,
  `sem4` int NOT NULL,
  `sem5` int NOT NULL,
  `sem6` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fees`
--

LOCK TABLES `fees` WRITE;
/*!40000 ALTER TABLE `fees` DISABLE KEYS */;
INSERT INTO `fees` VALUES (1,15000,15500,16000,16500,17000,17500);
/*!40000 ALTER TABLE `fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `management`
--

DROP TABLE IF EXISTS `management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `management` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(225) NOT NULL,
  `email` varchar(254) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `management`
--

LOCK TABLES `management` WRITE;
/*!40000 ALTER TABLE `management` DISABLE KEYS */;
INSERT INTO `management` VALUES (1,'8086706578','Kiran Varma','kiranvarma1811@gmail.com','pbkdf2_sha256$600000$Akt3BuZ45dDTtVHM0YxeTy$TgKyTLTIEzVDWd2IN5tsbIp2cym68C4kRGLM5MEsM4c=');
/*!40000 ALTER TABLE `management` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminder`
--

DROP TABLE IF EXISTS `reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reminder` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reminderId` int NOT NULL,
  `reminder` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminder`
--

LOCK TABLES `reminder` WRITE;
/*!40000 ALTER TABLE `reminder` DISABLE KEYS */;
INSERT INTO `reminder` VALUES (1,1,'A gentle reminder to complete your application process.'),(2,2,'Your application deadline is approaching. Please complete it soon.'),(3,3,'This is your final reminder to complete your application before the deadline.');
/*!40000 ALTER TABLE `reminder` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-25 14:17:23
