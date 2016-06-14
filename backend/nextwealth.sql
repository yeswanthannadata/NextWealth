-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: nextwealth
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.12.04.2

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
-- Table structure for table `SPOC_table`
--

DROP TABLE IF EXISTS `SPOC_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SPOC_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `name_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `SPOC_table_company_id_a01886f2_fk_company_id` (`company_id`),
  KEY `SPOC_table_location_id_f8da50f3_fk_location_id` (`location_id`),
  KEY `SPOC_table_name_id_c2f6563b_fk_auth_user_id` (`name_id`),
  CONSTRAINT `SPOC_table_name_id_c2f6563b_fk_auth_user_id` FOREIGN KEY (`name_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `SPOC_table_company_id_a01886f2_fk_company_id` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `SPOC_table_location_id_f8da50f3_fk_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SPOC_table`
--

LOCK TABLES `SPOC_table` WRITE;
/*!40000 ALTER TABLE `SPOC_table` DISABLE KEYS */;
INSERT INTO `SPOC_table` VALUES (1,1,1,2);
/*!40000 ALTER TABLE `SPOC_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agent`
--

DROP TABLE IF EXISTS `agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agent_name_id_fa6ec010_fk_auth_user_id` (`name_id`),
  CONSTRAINT `agent_name_id_fa6ec010_fk_auth_user_id` FOREIGN KEY (`name_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent`
--

LOCK TABLES `agent` WRITE;
/*!40000 ALTER TABLE `agent` DISABLE KEYS */;
INSERT INTO `agent` VALUES (1,3);
/*!40000 ALTER TABLE `agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Admin'),(2,'Agent');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_0e939a4f` (`group_id`),
  KEY `auth_group_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_417f1b1c` (`content_type_id`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add location',7,'add_location'),(20,'Can change location',7,'change_location'),(21,'Can delete location',7,'delete_location'),(22,'Can add company',8,'add_company'),(23,'Can change company',8,'change_company'),(24,'Can delete company',8,'delete_company'),(25,'Can add agent',9,'add_agent'),(26,'Can change agent',9,'change_agent'),(27,'Can delete agent',9,'delete_agent'),(28,'Can add spoc',10,'add_spoc'),(29,'Can change spoc',10,'change_spoc'),(30,'Can delete spoc',10,'delete_spoc'),(31,'Can add jd',11,'add_jd'),(32,'Can change jd',11,'change_jd'),(33,'Can delete jd',11,'delete_jd'),(34,'Can add candidate',12,'add_candidate'),(35,'Can change candidate',12,'change_candidate'),(36,'Can delete candidate',12,'delete_candidate');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$24000$cyFDwW19kUQw$xSXQvEVRBr2LwX3r/geIaso0lpZyds4Zr4AEaes+0ns=','2016-06-06 15:17:59',1,'root','','','',1,1,'2016-06-03 13:46:20'),(2,'pbkdf2_sha256$24000$ixprXy91y559$u/KUOcSmh+iWWQRc+jjwAqW+8Md3CKYvrrCJNcBCd3M=','2016-06-06 13:50:10',0,'wipro1','','','',0,1,'2016-06-06 04:59:35'),(3,'pbkdf2_sha256$24000$YnsyMxZ2FOa4$QUFL+lOOf4uRsFLbHBiHxgDc53/QsvUk77ymqOvxL5U=','2016-06-06 14:56:38',0,'Agent1','','','',0,1,'2016-06-06 04:59:56'),(4,'pbkdf2_sha256$24000$1fxBDf96JSJW$wzUuaoVetYIde3ahc/rQbpGDAUk+nO2q4ZYogG6s9Qw=',NULL,0,'Agent2','','','',0,1,'2016-06-06 15:23:47');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_e8701ad4` (`user_id`),
  KEY `auth_user_groups_0e939a4f` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (1,1,1),(2,3,2);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_e8701ad4` (`user_id`),
  KEY `auth_user_user_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate`
--

DROP TABLE IF EXISTS `candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `walk_in_date` datetime NOT NULL,
  `status` varchar(20) NOT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `jd_id` int(11),
  `spoc_id` int(11),
  PRIMARY KEY (`id`),
  KEY `candidate_agent_id_fe0a7897_fk_agent_id` (`agent_id`),
  KEY `candidate_1f4b69fc` (`jd_id`),
  KEY `candidate_3561d8b8` (`spoc_id`),
  CONSTRAINT `candidate_spoc_id_8407e8e6_fk_SPOC_table_id` FOREIGN KEY (`spoc_id`) REFERENCES `SPOC_table` (`id`),
  CONSTRAINT `candidate_agent_id_fe0a7897_fk_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`id`),
  CONSTRAINT `candidate_jd_id_7acbebcd_fk_jd_table_id` FOREIGN KEY (`jd_id`) REFERENCES `jd_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate`
--

LOCK TABLES `candidate` WRITE;
/*!40000 ALTER TABLE `candidate` DISABLE KEYS */;
INSERT INTO `candidate` VALUES (1,'Abhi','2016-06-06 05:28:55','New_Candidate',1,1,1),(2,'Sujith','2016-06-06 05:29:48','New_Candidate',1,2,1),(122,'Hitha','2016-06-07 00:00:00','New_Candidate',NULL,3,NULL);
/*!40000 ALTER TABLE `candidate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'Wipro');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_417f1b1c` (`content_type_id`),
  KEY `django_admin_log_e8701ad4` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-06-04 12:06:03','1','Admin',1,'Added.',3,1),(2,'2016-06-04 12:06:16','2','Agent',1,'Added.',3,1),(3,'2016-06-04 12:06:32','1','root',2,'Changed groups.',4,1),(4,'2016-06-06 04:58:35','1','Banglore',1,'Added.',7,1),(5,'2016-06-06 04:58:51','1','Wipro',1,'Added.',8,1),(6,'2016-06-06 04:59:35','2','wipro1',1,'Added.',4,1),(7,'2016-06-06 04:59:37','1','wipro1',1,'Added.',10,1),(8,'2016-06-06 04:59:56','3','Agent1',1,'Added.',4,1),(9,'2016-06-06 04:59:58','1','Agent1',1,'Added.',9,1),(10,'2016-06-06 05:00:56','1','Java Developer',1,'Added.',11,1),(11,'2016-06-06 05:28:49','2','Chennai',1,'Added.',7,1),(12,'2016-06-06 05:28:59','1','Abhi',1,'Added.',12,1),(13,'2016-06-06 05:29:15','2','Python Developer',1,'Added.',11,1),(14,'2016-06-06 05:30:42','2','Sujith',1,'Added.',12,1),(15,'2016-06-06 11:03:08','3','Ban',1,'Added.',7,1),(16,'2016-06-06 11:03:18','3','Bangalore',2,'Changed name.',7,1),(17,'2016-06-06 11:03:26','3','Android Developer',1,'Added.',11,1),(18,'2016-06-06 15:20:49','4','PHP Developer',1,'Added.',11,1),(19,'2016-06-06 15:23:47','4','Agent2',1,'Added.',4,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(9,'api','agent'),(12,'api','candidate'),(8,'api','company'),(11,'api','jd'),(7,'api','location'),(10,'api','spoc'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-06-03 13:39:55'),(2,'auth','0001_initial','2016-06-03 13:39:59'),(3,'admin','0001_initial','2016-06-03 13:40:00'),(4,'admin','0002_logentry_remove_auto_add','2016-06-03 13:40:00'),(5,'contenttypes','0002_remove_content_type_name','2016-06-03 13:40:04'),(6,'auth','0002_alter_permission_name_max_length','2016-06-03 13:40:06'),(7,'auth','0003_alter_user_email_max_length','2016-06-03 13:40:06'),(8,'auth','0004_alter_user_username_opts','2016-06-03 13:40:06'),(9,'auth','0005_alter_user_last_login_null','2016-06-03 13:40:07'),(10,'auth','0006_require_contenttypes_0002','2016-06-03 13:40:07'),(11,'auth','0007_alter_validators_add_error_messages','2016-06-03 13:40:07'),(12,'sessions','0001_initial','2016-06-03 13:40:08'),(13,'api','0001_initial','2016-06-03 13:45:10');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0qbaecpb152ql4d99p1fpzvoem3y0je3','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:40:10'),('0r6pfq3q5vxagrv5z5lgcfm5zr6u93gz','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:45:49'),('0vcidj87in4ijz215in71yz39fnumfql','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 12:45:09'),('14eqc9xcg30tq28avxvb37psi4f56j6h','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 14:07:03'),('19wy1dv1hr1pzxhu946fh2z0rx4cpmuw','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:51:47'),('2pdr94wzc2hp35mwkj6exp3pi35mqnjo','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:25:57'),('2s2dz1kdpj2slk0thx995vud89mbwr8r','YzJhNWQwYzY0NjY4N2QxZWFlMDI0ZjY0YjgxOGRkZmQwMzQ0ZTMyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0YzA2ZWU0N2MxZTY1YmNmMmQ0ZjNjZGM4ZWFjM2VhZjdjMGE0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=','2016-06-20 14:27:16'),('3q4kmxw7xxg5flyiiqqmv3wyrtxi6ojh','ZDlmNzg2OTZlMWJiYzA3MjE0MTRjNDY5YWY2MjZjNGZjOTNhYmY4Mjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0YzA2ZWU0N2MxZTY1YmNmMmQ0ZjNjZGM4ZWFjM2VhZjdjMGE0NWUiLCJfYXV0aF91c2VyX2lkIjoiMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2016-06-20 13:21:11'),('4p97iug0gsfgv7ture9n1j2p91k6jplm','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 10:53:23'),('5cdsxd3agnzqru5hd4ix21zukk77gw2u','YzJhNWQwYzY0NjY4N2QxZWFlMDI0ZjY0YjgxOGRkZmQwMzQ0ZTMyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0YzA2ZWU0N2MxZTY1YmNmMmQ0ZjNjZGM4ZWFjM2VhZjdjMGE0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=','2016-06-20 14:46:59'),('62y6w7fmr2vhnewp7pfab7trh04fl75g','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:33:39'),('67krnzs1nvzcjl8658bcyrdtd6pu6q7e','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 07:06:55'),('798vs3x82yxz66fkh5mbp7p9eaqo9eac','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 10:38:51'),('7errerx8tq4bf5m9dg95t3r1ax7vdb6o','YzJhNWQwYzY0NjY4N2QxZWFlMDI0ZjY0YjgxOGRkZmQwMzQ0ZTMyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0YzA2ZWU0N2MxZTY1YmNmMmQ0ZjNjZGM4ZWFjM2VhZjdjMGE0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=','2016-06-20 14:14:20'),('7id1iumxibzte1wq1wmm41gq67irkehv','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 08:47:59'),('7vipruntwima7iwq3g7qcz0lcn8o4a96','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 14:12:15'),('8pzrz88ja7l1bw535p79kafqalogvr37','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 13:40:11'),('93ftgoolkysxj4qidwyvvls0cmj9ynip','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 06:26:19'),('bepicp9fah1sbvv99x8teehl51mrxbmf','YzJhNWQwYzY0NjY4N2QxZWFlMDI0ZjY0YjgxOGRkZmQwMzQ0ZTMyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0YzA2ZWU0N2MxZTY1YmNmMmQ0ZjNjZGM4ZWFjM2VhZjdjMGE0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=','2016-06-20 14:26:00'),('bow0wnrfrtwk4ab6s0qdiqifwsvw3jyg','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 06:06:13'),('ci3ntcgfp0b4pkviw470oppxp7s5w16q','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 10:53:12'),('co1e3i07ga1mtxvs2h8q5w7nb9zh9rxs','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 10:52:31'),('d4cekpj7f9tt78gowyfz3p95j212iae1','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 06:08:53'),('drralgae3cezba0t7qn3h14ehh0ozurg','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:29:57'),('dydiqg3xn7q6edqgqp2iplutfgewkv2z','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 08:41:32'),('dzpcpnp1qq6xsl4sg0sl2rzuc7mxm4qg','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:47:21'),('ed1lo095kcj2rj12egel1jkuxxc269by','YzJhNWQwYzY0NjY4N2QxZWFlMDI0ZjY0YjgxOGRkZmQwMzQ0ZTMyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0YzA2ZWU0N2MxZTY1YmNmMmQ0ZjNjZGM4ZWFjM2VhZjdjMGE0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=','2016-06-20 12:56:03'),('ed3k5zs30sca8cyww9qdtksajf3r3g58','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 07:17:02'),('feaxl3yv5qzvt2abt8vgtopw3rssa8tg','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-17 15:25:12'),('fzvqlvzk8v11ul96itvn0pc2ligbnnej','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 13:22:46'),('g5nihggapdm4pkxffw9akvyh6vmtqwl4','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 07:24:50'),('gkjz6enbba59ksjhdans6cfhcpwxyo94','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 06:28:13'),('h7ycxg8u1g5l0gpxaw0tk30gdao1pjmv','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 06:34:41'),('hfyg3ysemxnwzu77qmfvwk6fd0vzxvid','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:58:26'),('i1maujpr1r0kl9myw0oq05fne8m6q39k','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:57:46'),('icxase9kn5l1wcod3o22ja774n6zsc2k','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:37:26'),('jet4ig1c4ljvo62h0ha6cfae5n6kxpn1','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:35:46'),('kjrrm8mpthapdllx3jt7prd09hgbotg8','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 15:02:58'),('ksni3dp4ojktg03w8ngkg25vv1p2l34p','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 15:10:27'),('kywjq3x6nj9nujs50dynoc8i4wqb1dml','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:51:07'),('l472cgp3tz47x1akdnx8y26694ifyg2p','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:27:35'),('lkm8cnd6ap5wk61nkhy6964ax5w2acb3','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-18 10:08:49'),('lsbzoh6f5xviqrqihy2f681tyg4stir2','YzJhNWQwYzY0NjY4N2QxZWFlMDI0ZjY0YjgxOGRkZmQwMzQ0ZTMyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0YzA2ZWU0N2MxZTY1YmNmMmQ0ZjNjZGM4ZWFjM2VhZjdjMGE0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=','2016-06-20 14:28:27'),('mcigtn2z6a9e6qe3ok4r39zda4jewsmu','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:53:58'),('mh91l13ubr9go1amog38uqww3klwbiv2','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 10:58:21'),('mo3copzy67k1yyupsmwdwa5cabyv9zx2','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:00:01'),('mvpqzypkey45t1u5hr7o7d0m7visci95','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 14:01:31'),('mwict0wlx8n94jnos9z6oxupw96fmerv','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:59:11'),('nq0uhsw9xb7j83y7wvdat52jib7x8g7g','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:44:10'),('oap4uje8s96qec919mjokaq99al00960','YzJhNWQwYzY0NjY4N2QxZWFlMDI0ZjY0YjgxOGRkZmQwMzQ0ZTMyNzp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0YzA2ZWU0N2MxZTY1YmNmMmQ0ZjNjZGM4ZWFjM2VhZjdjMGE0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=','2016-06-20 13:39:56'),('p05cxwa0q1qusp46kiv1nrfswkaktyq4','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:56:02'),('r2uj1j1k8w0btmg393r9a3ahadzvvx16','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 13:28:28'),('r5mc4txutf2p1d4uf5qitlua52iyil84','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 12:38:11'),('ra0zc7xfe3qltla8x92bcs4sshme09qi','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 09:28:02'),('rdzjj8csfn7003bw76itd7hcefel3e5y','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 10:48:21'),('rk6zaks14ql1jtmyntlrwgs62yi85uuz','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 15:17:59'),('tyq1o9yx3x0cv0e7xuk8k0lii8n64trc','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 14:11:37'),('vomil6vwpdgllwpowdjyxtwtfjv98mhu','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 14:33:48'),('wlv4vhmxz3d4dcs8udf1xyg8l9l99t7s','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:37:37'),('x1ng2pzw47d37v9dxz1z45i370p5viky','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 11:47:54'),('x37n4upf30bd12o81mv6uz5bbvxvpxuo','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 14:13:26'),('xjl35tw3edo5anxqy5g6u5hikilkwf1k','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 06:07:02'),('y69btlrtx47aqxmg70npblwyohr0smxo','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 06:49:13'),('ze790d4gykud6o4b9h7tmuyufxscfhpv','MjE0MDExMzQxZDIzZmI4NDg3ZGYxNWMxODJiNjNhMjI1ZjYyN2U4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2016-06-20 12:36:26'),('zedd0l7uy5b0wbqvrec4ctqjjird2r2j','MjAzNzBiNjM5ODEyMmMxN2VjN2FkYjg5NWM2ZjFiM2NlMzNmZDJmNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwZTE4OWQwODMxMjY2MzgzZDI5NDgxNDM3NmU4OTdhYTRhMjE2YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-20 06:57:03');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jd_table`
--

DROP TABLE IF EXISTS `jd_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jd_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_title` varchar(255) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jd_table_e274a5da` (`location_id`),
  CONSTRAINT `jd_table_location_id_0ee852c9_fk_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jd_table`
--

LOCK TABLES `jd_table` WRITE;
/*!40000 ALTER TABLE `jd_table` DISABLE KEYS */;
INSERT INTO `jd_table` VALUES (1,'Java Developer','2016-06-06 05:00:31','2016-06-06 05:00:33',1),(2,'Python Developer','2016-06-06 05:28:34','2016-06-06 05:28:37',2),(3,'Android Developer','2016-06-06 11:02:59','2016-06-06 11:03:02',3),(4,'PHP Developer','2016-06-06 15:20:27','2016-06-06 15:20:28',1);
/*!40000 ALTER TABLE `jd_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jd_table_SPOC`
--

DROP TABLE IF EXISTS `jd_table_SPOC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jd_table_SPOC` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jd_id` int(11) NOT NULL,
  `spoc_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jd_table_SPOC_jd_id_0982fc96_uniq` (`jd_id`,`spoc_id`),
  KEY `jd_table_SPOC_spoc_id_26f3fbb3_fk_SPOC_table_id` (`spoc_id`),
  CONSTRAINT `jd_table_SPOC_spoc_id_26f3fbb3_fk_SPOC_table_id` FOREIGN KEY (`spoc_id`) REFERENCES `SPOC_table` (`id`),
  CONSTRAINT `jd_table_SPOC_jd_id_61b81c33_fk_jd_table_id` FOREIGN KEY (`jd_id`) REFERENCES `jd_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jd_table_SPOC`
--

LOCK TABLES `jd_table_SPOC` WRITE;
/*!40000 ALTER TABLE `jd_table_SPOC` DISABLE KEYS */;
INSERT INTO `jd_table_SPOC` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1);
/*!40000 ALTER TABLE `jd_table_SPOC` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jd_table_agent`
--

DROP TABLE IF EXISTS `jd_table_agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jd_table_agent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jd_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jd_table_agent_jd_id_644436f2_uniq` (`jd_id`,`agent_id`),
  KEY `jd_table_agent_agent_id_1586cb94_fk_agent_id` (`agent_id`),
  CONSTRAINT `jd_table_agent_agent_id_1586cb94_fk_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`id`),
  CONSTRAINT `jd_table_agent_jd_id_2607fd08_fk_jd_table_id` FOREIGN KEY (`jd_id`) REFERENCES `jd_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jd_table_agent`
--

LOCK TABLES `jd_table_agent` WRITE;
/*!40000 ALTER TABLE `jd_table_agent` DISABLE KEYS */;
INSERT INTO `jd_table_agent` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1);
/*!40000 ALTER TABLE `jd_table_agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Banglore'),(2,'Chennai'),(3,'Bangalore');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-06 18:42:59
