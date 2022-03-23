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

-- Schema CSC4001
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CSC4001` ;

-- -----------------------------------------------------
-- Schema CSC4001
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CSC4001` DEFAULT CHARACTER SET utf8 ;
USE `CSC4001` ;

--
-- Table structure for table `Our_project_blog_answers`
--

DROP TABLE IF EXISTS `Our_project_blog_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_blog_answers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `father_answer_id` int DEFAULT NULL,
  `content` varchar(20000) NOT NULL,
  `content_format` varchar(45) DEFAULT NULL,
  `like` int(10) unsigned zerofill NOT NULL,
  `author_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id_idx` (`question_id`),
  KEY `father_answer_id_idx` (`father_answer_id`),
  KEY `id_of_author_idx` (`author_id`),
  CONSTRAINT `id_of_author` FOREIGN KEY (`author_id`) REFERENCES `Our_project_user` (`id`),
  CONSTRAINT `question_id` FOREIGN KEY (`question_id`) REFERENCES `Our_project_blog_questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_blog_answers`
--

LOCK TABLES `Our_project_blog_answers` WRITE;
/*!40000 ALTER TABLE `Our_project_blog_answers` DISABLE KEYS */;
INSERT INTO `Our_project_blog_answers` VALUES (1,1,NULL,'just try filling the data base name with the schema name. Then write the host with your server IP, the host as the user name of database on server  ','Markdown',0000000007,5),(2,1,1,'Thank You!! I will try','Markdown',0000000001,1),(3,4,NULL,'Mark一下，有答案了踢一下我','Markdown',0000000000,2),(4,5,NULL,'亲测10GB也是没问题的','Markdown',0000000003,1);
/*!40000 ALTER TABLE `Our_project_blog_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_blog_questions`
--

DROP TABLE IF EXISTS `Our_project_blog_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_blog_questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `author_id` int NOT NULL,
  `group_type` varchar(45) NOT NULL,
  `sub_group_type` int NOT NULL,
  `content` varchar(20000) DEFAULT NULL,
  `content_format` varchar(45) DEFAULT NULL,
  `like` int(10) unsigned zerofill NOT NULL,
  `follow` int(10) unsigned zerofill NOT NULL,
  `hot` int(10) unsigned zerofill NOT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `views` int(10) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sub_group_name_idx` (`sub_group_type`),
  KEY `email_idx` (`author_id`),
  KEY `group_type_idx` (`group_type`),
  CONSTRAINT `author_id` FOREIGN KEY (`author_id`) REFERENCES `Our_project_user` (`id`),
  CONSTRAINT `group_type` FOREIGN KEY (`group_type`) REFERENCES `Our_project_group` (`group_name`),
  CONSTRAINT `sub_group_type` FOREIGN KEY (`sub_group_type`) REFERENCES `Our_project_sub_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_blog_questions`
--

LOCK TABLES `Our_project_blog_questions` WRITE;
/*!40000 ALTER TABLE `Our_project_blog_questions` DISABLE KEYS */;
INSERT INTO `Our_project_blog_questions` VALUES (1,'Question about the Django setings.py',1,'CSC4001',1,'I am a neophyte to Django, and now I am taking CSC4001, I don\'t know how to write the settings.py to set my dataBase.','Markdown',0000000002,0000000007,0000000010,NULL,'2022-03-22 14:52:36.168559',0000000113),(2,'Anybody know how to solve this problem of npm run dev?',2,'CSC4001',1,'When I using the npm run dev, it gives me an error about `webpack-dev-server --inline --progress --config build/webp','Markdown',0000000004,0000000004,0000000009,NULL,NULL,0000000057),(3,'What\'s the meaning of two-direction association in UML',1,'CSC4001',2,'Actually, I don\'t know what\'s the meaning of two-direction in the description of assignment1','Markdown',0000000000,0000000009,0000000005,NULL,'2022-03-22 15:06:59.295262',0000000060),(4,'Building Kernel fail.',3,'CSC3150',3,'When I run make, it gives me a error about `permission denied`, why?','Markdown',0000000002,0000000009,0000000002,NULL,'2022-03-22 15:07:13.093680',0000000201),(5,'How many storage should I assign to VM?',4,'CSC3150',3,'Is 10GB assigned to VM enough? cause my computer doesn\'t have much storage left.','Markdown',0000000010,0000000015,0000000020,NULL,'2022-03-22 15:03:24.927691',0000000055);
/*!40000 ALTER TABLE `Our_project_blog_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_file`
--

DROP TABLE IF EXISTS `Our_project_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_file` (
  `id` int NOT NULL,
  `url` char(100) NOT NULL,
  `corresponding_question` int DEFAULT NULL,
  `corresponding_answer` int DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id_idx` (`corresponding_question`),
  KEY `answer_id_idx` (`corresponding_answer`),
  CONSTRAINT `corresponding_answer` FOREIGN KEY (`corresponding_answer`) REFERENCES `Our_project_blog_answers` (`id`),
  CONSTRAINT `corresponding_question` FOREIGN KEY (`corresponding_question`) REFERENCES `Our_project_blog_questions` (`id`)
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
-- Table structure for table `Our_project_group`
--

DROP TABLE IF EXISTS `Our_project_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_group` (
  `id` int DEFAULT NULL,
  `group_name` varchar(45) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `amount_of_follows` int DEFAULT NULL,
  PRIMARY KEY (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_group`
--

LOCK TABLES `Our_project_group` WRITE;
/*!40000 ALTER TABLE `Our_project_group` DISABLE KEYS */;
INSERT INTO `Our_project_group` VALUES (1,'CSC3150','Operating System',NULL,NULL,131),(2,'CSC4001','Soft Engineering course',NULL,NULL,111);
/*!40000 ALTER TABLE `Our_project_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_picture`
--

DROP TABLE IF EXISTS `Our_project_picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_picture` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(100) NOT NULL,
  `question` int DEFAULT NULL,
  `answer` int DEFAULT NULL,
  `group_name` varchar(45) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id_idx` (`question`),
  KEY `answer_id_idx` (`answer`),
  KEY `group_name_index_idx` (`group_name`),
  CONSTRAINT `answer` FOREIGN KEY (`answer`) REFERENCES `Our_project_blog_answers` (`id`),
  CONSTRAINT `group_name_index` FOREIGN KEY (`group_name`) REFERENCES `Our_project_group` (`group_name`),
  CONSTRAINT `question` FOREIGN KEY (`question`) REFERENCES `Our_project_blog_questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_picture`
--

LOCK TABLES `Our_project_picture` WRITE;
/*!40000 ALTER TABLE `Our_project_picture` DISABLE KEYS */;
INSERT INTO `Our_project_picture` VALUES (1,'http://175.178.34.84/pics/Django_DB.JPG',1,NULL,NULL,NULL),(2,'http://175.178.34.84/pics/double_dir.JPG',3,NULL,NULL,NULL),(3,'http://175.178.34.84/pics/npm_run_dev.png',2,NULL,NULL,NULL),(4,'http://175.178.34.84/pics/permission_deny.jpg',4,NULL,NULL,NULL),(5,'http://175.178.34.84/pics/VM_storage.jpg',5,NULL,NULL,NULL),(6,'http://175.178.34.84/pics/DB_ANSWER1.JPG',NULL,1,NULL,NULL),(7,'http://175.178.34.84/pics/csc4001.jpg',NULL,NULL,'CSC4001',NULL),(8,'http://175.178.34.84/pics/CSC3150.JPG',NULL,NULL,'CSC3150',NULL);
/*!40000 ALTER TABLE `Our_project_picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_sub_group`
--

DROP TABLE IF EXISTS `Our_project_sub_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_sub_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(45) NOT NULL,
  `sub_group_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_group_name_UNIQUE` (`sub_group_name`),
  KEY `group_NAME_idx` (`group_name`),
  CONSTRAINT `group_NAME` FOREIGN KEY (`group_name`) REFERENCES `Our_project_group` (`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_sub_group`
--

LOCK TABLES `Our_project_sub_group` WRITE;
/*!40000 ALTER TABLE `Our_project_sub_group` DISABLE KEYS */;
INSERT INTO `Our_project_sub_group` VALUES (1,'CSC4001','Project'),(2,'CSC4001','Assignment1'),(3,'CSC3150','Project1');
/*!40000 ALTER TABLE `Our_project_sub_group` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `Index_user_name` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_user`
--

LOCK TABLES `Our_project_user` WRITE;
/*!40000 ALTER TABLE `Our_project_user` DISABLE KEYS */;
INSERT INTO `Our_project_user` VALUES (1,'119010249@link.cuhk.edu.cn','qpr','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2022-03-11 07:04:49.493694','2022-03-11 07:04:49.493694'),(2,'119010249@link.cuhk.edu.cn','1234','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2022-03-11 07:12:25.407426','2022-03-11 07:12:25.407459'),(3,'119010249@link.cuhk.edu.cn','qqq','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2022-03-11 07:13:10.849469','2022-03-11 07:13:10.849469'),(4,'119010249@link.cuhk.edu.cn','yyy','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2022-03-11 07:13:51.020685','2022-03-11 07:13:51.020720'),(5,'123456789@link.cuhk.edu.cn','nobody','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2022-03-17 05:24:12.726320','2022-03-17 05:24:12.726353'),(6,'119011111@link.cuhk.edu.cn','不会起名','caf1a3dfb505ffed0d024130f58c5cfa',NULL,NULL,NULL,'2022-03-17 10:04:44.401660','2022-03-17 10:04:44.401695'),(7,'123456789@link.cuhk.edu.cn','5555','827ccb0eea8a706c4c34a16891f84e7b',NULL,NULL,NULL,'2022-03-17 10:09:53.288498','2022-03-17 10:09:53.288530'),(8,'119010249@link.cuhk.edu.cn','qweqwe','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2022-03-22 14:41:28.790265','2022-03-22 14:41:28.790332');
/*!40000 ALTER TABLE `Our_project_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_user_follow_group`
--

DROP TABLE IF EXISTS `Our_project_user_follow_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_user_follow_group` (
  `id` int NOT NULL,
  `group_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`group_name`),
  KEY `fk_Our_project_user_has_Our_project_Group_Our_project_user1_idx` (`id`),
  KEY `fk_Our_project_user_has_Our_project_Group_Our_project_user2_idx` (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_user_follow_group`
--

LOCK TABLES `Our_project_user_follow_group` WRITE;
/*!40000 ALTER TABLE `Our_project_user_follow_group` DISABLE KEYS */;
INSERT INTO `Our_project_user_follow_group` VALUES (1,'CSC3150'),(1,'CSC4001'),(2,'CSC3150'),(3,'CSC4001'),(4,'CSC4001'),(5,'CSC4001'),(6,'CSC3150'),(6,'CSC4001');
/*!40000 ALTER TABLE `Our_project_user_follow_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_user_follow_question`
--

DROP TABLE IF EXISTS `Our_project_user_follow_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_user_follow_question` (
  `id` int NOT NULL,
  `question_id` int NOT NULL,
  PRIMARY KEY (`id`,`question_id`),
  KEY `Index_questionid_idx` (`question_id`),
  CONSTRAINT `Index_questionid` FOREIGN KEY (`question_id`) REFERENCES `Our_project_blog_questions` (`id`),
  CONSTRAINT `Index_userid` FOREIGN KEY (`id`) REFERENCES `Our_project_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_user_follow_question`
--

LOCK TABLES `Our_project_user_follow_question` WRITE;
/*!40000 ALTER TABLE `Our_project_user_follow_question` DISABLE KEYS */;
INSERT INTO `Our_project_user_follow_question` VALUES (1,1),(5,1),(4,2),(7,2),(1,3),(7,3),(2,4),(3,4),(1,5);
/*!40000 ALTER TABLE `Our_project_user_follow_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_user_like_answer`
--

DROP TABLE IF EXISTS `Our_project_user_like_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_user_like_answer` (
  `id` int NOT NULL,
  `answer_id` int NOT NULL,
  PRIMARY KEY (`id`,`answer_id`),
  KEY `index_a_id_idx` (`answer_id`),
  CONSTRAINT `index_a_id` FOREIGN KEY (`answer_id`) REFERENCES `Our_project_blog_answers` (`id`),
  CONSTRAINT `index_u_id` FOREIGN KEY (`id`) REFERENCES `Our_project_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_user_like_answer`
--

LOCK TABLES `Our_project_user_like_answer` WRITE;
/*!40000 ALTER TABLE `Our_project_user_like_answer` DISABLE KEYS */;
INSERT INTO `Our_project_user_like_answer` VALUES (4,1),(5,1),(2,2),(5,2),(3,3),(1,4),(3,4),(4,4);
/*!40000 ALTER TABLE `Our_project_user_like_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_user_like_question`
--

DROP TABLE IF EXISTS `Our_project_user_like_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_user_like_question` (
  `id` int NOT NULL,
  `question_id` int NOT NULL,
  PRIMARY KEY (`id`,`question_id`),
  KEY `Index_question_id_idx` (`question_id`),
  CONSTRAINT `Index_question_id` FOREIGN KEY (`question_id`) REFERENCES `Our_project_blog_questions` (`id`),
  CONSTRAINT `Index_user_id` FOREIGN KEY (`id`) REFERENCES `Our_project_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_user_like_question`
--

LOCK TABLES `Our_project_user_like_question` WRITE;
/*!40000 ALTER TABLE `Our_project_user_like_question` DISABLE KEYS */;
INSERT INTO `Our_project_user_like_question` VALUES (4,1),(1,2),(3,2),(3,3),(1,4),(6,4),(2,5),(5,5),(6,5);
/*!40000 ALTER TABLE `Our_project_user_like_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Our_project_user_view_question`
--

DROP TABLE IF EXISTS `Our_project_user_view_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Our_project_user_view_question` (
  `id` int NOT NULL,
  `question_id` int NOT NULL,
  `time` int(10) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`id`,`question_id`),
  KEY `iNDEX_QUESTION_idx` (`question_id`),
  CONSTRAINT `iNDEX_QUESTION` FOREIGN KEY (`question_id`) REFERENCES `Our_project_blog_questions` (`id`),
  CONSTRAINT `iNDEX_USER` FOREIGN KEY (`id`) REFERENCES `Our_project_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_user_view_question`
--

LOCK TABLES `Our_project_user_view_question` WRITE;
/*!40000 ALTER TABLE `Our_project_user_view_question` DISABLE KEYS */;
INSERT INTO `Our_project_user_view_question` VALUES (1,1,0000000010),(1,2,0000000004),(1,4,0000000005),(1,5,0000000017),(2,1,0000000003),(2,2,0000000020),(3,1,0000000001),(3,3,0000000004),(4,5,0000000010),(5,5,0000000010);
/*!40000 ALTER TABLE `Our_project_user_view_question` ENABLE KEYS */;
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
INSERT INTO `django_session` VALUES ('tm5f9jwnlhc1dxy3tp5a5505d5l21hrs','eyJ1c2VybmFtZSI6InF3ZXF3ZSIsInVpZCI6OH0:1nWfhQ:_iApBo33raHvMsyofTBr3qyv_UYXpW-6gFVdNioJyNg','2022-04-05 14:41:28.811535'),('vnhtb1ta5poofxgvhw2beqayrxounqe4','eyJ1c2VybmFtZSI6IjEyMzQiLCJ1aWQiOjJ9:1nSZRp:ZPU_Kmp8qjXcRAqOxMoLsuljaDqP7Bka6kVWpX0Cyjs','2022-03-25 07:12:25.431922'),('zktqnu0h74t9ey8blqae4rtk4el26gcq','eyJ1c2VybmFtZSI6InFxcSIsInVpZCI6M30:1nSZSZ:tNg8UMYRlG_pgZsalVXm3v3HheKXFHgsUJe8n0vmJqg','2022-03-25 07:13:11.065469');
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

-- Dump completed on 2022-03-23 12:05:58

DROP EVENT IF EXISTS refresh_hot; 

CREATE EVENT refresh_hot 
ON SCHEDULE EVERY 1 day STARTS DATE_ADD(DATE(CURDATE() + 1),  INTERVAL 0 HOUR)
ON COMPLETION PRESERVE

DO
  UPDATE `CSC4001`.`Our_project_blog_questions` SET `hot` = `hot`/2;
