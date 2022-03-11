-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: CSC4001
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

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

-- -----------------------------------------------------
-- Schema CSC4001
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CSC4001` ;

-- -----------------------------------------------------
-- Schema CSC4001
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CSC4001` DEFAULT CHARACTER SET utf8 ;
USE `CSC4001` ;

--
-- Table structure for table `Our_project_Blog_Questions`
--

DROP TABLE IF EXISTS `Our_project_Blog_Questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_Blog_Questions` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `author_id` int NOT NULL,
  `group_type` varchar(45) NOT NULL,
  `sub_group_type` int NOT NULL,
  `content` varchar(20000) DEFAULT NULL,
  `content_format` varchar(45) DEFAULT NULL,
  `like` int(10) unsigned zerofill NOT NULL,
  `follow` int(10) unsigned zerofill NOT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  KEY `group_name_idx` (`group_type`),
  KEY `sub_group_name_idx` (`sub_group_type`),
  KEY `email_idx` (`author_id`),
  CONSTRAINT `author_id` FOREIGN KEY (`author_id`) REFERENCES `Our_project_user` (`id`),
  CONSTRAINT `group_type` FOREIGN KEY (`group_type`) REFERENCES `Our_project_Group` (`group_name`),
  CONSTRAINT `sub_group_type` FOREIGN KEY (`sub_group_type`) REFERENCES `Our_project_Sub_group` (`sub_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_Blog_Questions`
--

LOCK TABLES `Our_project_Blog_Questions` WRITE;
/*!40000 ALTER TABLE `Our_project_Blog_Questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Our_project_Blog_Questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_Blog_answers`
--

DROP TABLE IF EXISTS `Our_project_Blog_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_Blog_answers` (
  `answer_id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `father_answer_id` int DEFAULT NULL,
  `content` varchar(20000) NOT NULL,
  `content_format` varchar(45) DEFAULT NULL,
  `like` int(10) unsigned zerofill NOT NULL,
  `follow` int(10) unsigned zerofill NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `question_id_idx` (`question_id`),
  KEY `father_answer_id_idx` (`father_answer_id`),
  KEY `id_of_author_idx` (`author_id`),
  CONSTRAINT `father_answer_id` FOREIGN KEY (`father_answer_id`) REFERENCES `Our_project_Blog_answers` (`answer_id`),
  CONSTRAINT `id_of_author` FOREIGN KEY (`author_id`) REFERENCES `Our_project_user` (`id`),
  CONSTRAINT `question_id` FOREIGN KEY (`question_id`) REFERENCES `Our_project_Blog_Questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_Blog_answers`
--

LOCK TABLES `Our_project_Blog_answers` WRITE;
/*!40000 ALTER TABLE `Our_project_Blog_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Our_project_Blog_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_Group`
--

DROP TABLE IF EXISTS `Our_project_Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_Group` (
  `group_name` varchar(45) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `amount_of_follows` int DEFAULT NULL,
  PRIMARY KEY (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_Group`
--

LOCK TABLES `Our_project_Group` WRITE;
/*!40000 ALTER TABLE `Our_project_Group` DISABLE KEYS */;
/*!40000 ALTER TABLE `Our_project_Group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_Sub_group`
--

DROP TABLE IF EXISTS `Our_project_Sub_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_Sub_group` (
  `sub_group_id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(45) NOT NULL,
  `sub_group_name` varchar(45) NOT NULL,
  PRIMARY KEY (`sub_group_id`),
  UNIQUE KEY `sub_group_name_UNIQUE` (`sub_group_name`),
  KEY `group_name_idx` (`group_name`),
  CONSTRAINT `group_name` FOREIGN KEY (`group_name`) REFERENCES `Our_project_Group` (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_Sub_group`
--

LOCK TABLES `Our_project_Sub_group` WRITE;
/*!40000 ALTER TABLE `Our_project_Sub_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `Our_project_Sub_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_file`
--

DROP TABLE IF EXISTS `Our_project_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_file` (
  `url` char(100) NOT NULL,
  `corresponding_question` int DEFAULT NULL,
  `corresponding_answer` int DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`url`),
  KEY `question_id_idx` (`corresponding_question`),
  KEY `answer_id_idx` (`corresponding_answer`),
  CONSTRAINT `corresponding_answer` FOREIGN KEY (`corresponding_answer`) REFERENCES `Our_project_Blog_answers` (`answer_id`),
  CONSTRAINT `corresponding_question` FOREIGN KEY (`corresponding_question`) REFERENCES `Our_project_Blog_Questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_file`
--

LOCK TABLES `Our_project_file` WRITE;
/*!40000 ALTER TABLE `Our_project_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `Our_project_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_picture`
--

DROP TABLE IF EXISTS `Our_project_picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_picture` (
  `url` varchar(100) NOT NULL,
  `question` int DEFAULT NULL,
  `answer` int DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`url`),
  KEY `question_id_idx` (`question`),
  KEY `answer_id_idx` (`answer`),
  CONSTRAINT `answer` FOREIGN KEY (`answer`) REFERENCES `Our_project_Blog_answers` (`answer_id`),
  CONSTRAINT `question` FOREIGN KEY (`question`) REFERENCES `Our_project_Blog_Questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_picture`
--

LOCK TABLES `Our_project_picture` WRITE;
/*!40000 ALTER TABLE `Our_project_picture` DISABLE KEYS */;
/*!40000 ALTER TABLE `Our_project_picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_user`
--

DROP TABLE IF EXISTS `Our_project_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `major` varchar(45) DEFAULT NULL,
  `grade` int DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_user`
--

LOCK TABLES `Our_project_user` WRITE;
/*!40000 ALTER TABLE `Our_project_user` DISABLE KEYS */;
INSERT INTO `Our_project_user` VALUES (1,'119010249@link.cuhk.edu.cn','qpr','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2022-03-11 07:04:49.493694','2022-03-11 07:04:49.493694'),(2,'119010249@link.cuhk.edu.cn','1234','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2022-03-11 07:12:25.407426','2022-03-11 07:12:25.407459'),(3,'119010249@link.cuhk.edu.cn','qqq','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2022-03-11 07:13:10.849469','2022-03-11 07:13:10.849469'),(4,'119010249@link.cuhk.edu.cn','yyy','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2022-03-11 07:13:51.020685','2022-03-11 07:13:51.020720');
/*!40000 ALTER TABLE `Our_project_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_user_has_Our_project_Group`
--

DROP TABLE IF EXISTS `Our_project_user_has_Our_project_Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_user_has_Our_project_Group` (
  `Our_project_user_id` int NOT NULL,
  `Our_project_Group_group_name` varchar(45) NOT NULL,
  PRIMARY KEY (`Our_project_user_id`,`Our_project_Group_group_name`),
  KEY `fk_Our_project_user_has_Our_project_Group_Our_project_Group_idx` (`Our_project_Group_group_name`),
  KEY `fk_Our_project_user_has_Our_project_Group_Our_project_user1_idx` (`Our_project_user_id`),
  CONSTRAINT `fk_Our_project_user_has_Our_project_Group_Our_project_Group1` FOREIGN KEY (`Our_project_Group_group_name`) REFERENCES `Our_project_Group` (`group_name`),
  CONSTRAINT `fk_Our_project_user_has_Our_project_Group_Our_project_user1` FOREIGN KEY (`Our_project_user_id`) REFERENCES `Our_project_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_user_has_Our_project_Group`
--

LOCK TABLES `Our_project_user_has_Our_project_Group` WRITE;
/*!40000 ALTER TABLE `Our_project_user_has_Our_project_Group` DISABLE KEYS */;
/*!40000 ALTER TABLE `Our_project_user_has_Our_project_Group` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-03-11 07:11:34.974747'),(2,'auth','0001_initial','2022-03-11 07:11:41.011300'),(3,'admin','0001_initial','2022-03-11 07:11:42.715557'),(4,'admin','0002_logentry_remove_auto_add','2022-03-11 07:11:42.874254'),(5,'admin','0003_logentry_add_action_flag_choices','2022-03-11 07:11:43.026694'),(6,'contenttypes','0002_remove_content_type_name','2022-03-11 07:11:43.738714'),(7,'auth','0002_alter_permission_name_max_length','2022-03-11 07:11:44.098629'),(8,'auth','0003_alter_user_email_max_length','2022-03-11 07:11:44.521290'),(9,'auth','0004_alter_user_username_opts','2022-03-11 07:11:44.739734'),(10,'auth','0005_alter_user_last_login_null','2022-03-11 07:11:45.049893'),(11,'auth','0006_require_contenttypes_0002','2022-03-11 07:11:45.221009'),(12,'auth','0007_alter_validators_add_error_messages','2022-03-11 07:11:45.393398'),(13,'auth','0008_alter_user_username_max_length','2022-03-11 07:11:45.736116'),(14,'auth','0009_alter_user_last_name_max_length','2022-03-11 07:11:46.057713'),(15,'auth','0010_alter_group_name_max_length','2022-03-11 07:11:46.376126'),(16,'auth','0011_update_proxy_permissions','2022-03-11 07:11:46.789969'),(17,'auth','0012_alter_user_first_name_max_length','2022-03-11 07:11:47.197715'),(18,'sessions','0001_initial','2022-03-11 07:11:47.816226');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('tm5f9jwnlhc1dxy3tp5a5505d5l21hrs','eyJ1c2VybmFtZSI6Inl5eSIsInVpZCI6NH0:1nSZTD:IjCrbg_l-CdSTNOW1zve2Fhgrt6TpA8cV0Em9WYUYzE','2022-03-25 07:13:51.044842'),('vnhtb1ta5poofxgvhw2beqayrxounqe4','eyJ1c2VybmFtZSI6IjEyMzQiLCJ1aWQiOjJ9:1nSZRp:ZPU_Kmp8qjXcRAqOxMoLsuljaDqP7Bka6kVWpX0Cyjs','2022-03-25 07:12:25.431922'),('zktqnu0h74t9ey8blqae4rtk4el26gcq','eyJ1c2VybmFtZSI6InFxcSIsInVpZCI6M30:1nSZSZ:tNg8UMYRlG_pgZsalVXm3v3HheKXFHgsUJe8n0vmJqg','2022-03-25 07:13:11.065469');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-11 15:25:35
