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
  `code` varchar(1500) DEFAULT NULL,
  `lang` varchar(45) DEFAULT NULL,
  `content_format` varchar(45) DEFAULT NULL,
  `like` int(10) unsigned zerofill NOT NULL,
  `author_id` int DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id_idx` (`question_id`),
  KEY `father_answer_id_idx` (`father_answer_id`),
  KEY `id_of_author_idx` (`author_id`),
  CONSTRAINT `id_of_author` FOREIGN KEY (`author_id`) REFERENCES `Our_project_user` (`id`),
  CONSTRAINT `question_id` FOREIGN KEY (`question_id`) REFERENCES `Our_project_blog_questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_blog_answers`
--

LOCK TABLES `Our_project_blog_answers` WRITE;
/*!40000 ALTER TABLE `Our_project_blog_answers` DISABLE KEYS */;
INSERT INTO `Our_project_blog_answers` VALUES (1,1,NULL,'just try filling the data base name with the schema name. Then write the host with your server IP, the host as the user name of database on server  ',NULL,NULL,'Markdown',0000000007,5,NULL),(2,1,1,'Thank You!! I will try',NULL,NULL,'Markdown',0000000001,1,NULL),(3,4,NULL,'Mark一下，有答案了踢一下我',NULL,NULL,'Markdown',0000000000,2,NULL),(4,5,NULL,'亲测10GB也是没问题的',NULL,NULL,'Markdown',0000000003,1,NULL),(5,1,NULL,'你可以试试把Django升级一下',NULL,NULL,'Markdown',0000000000,6,NULL),(6,1,5,'请问要升到哪个版本比较合适呢？',NULL,NULL,'Markdown',0000000000,1,NULL),(7,1,NULL,'我也遇到了相同的问题，我是想连接服务器上的Django，但总是连不上，后来发现是shcema name输错了...','setting:{\\n    host:127.0.0.1,\\n    password:********,\\n    database: 4001_project,\\n} ','Python','Markdown',0000000003,8,NULL),(8,1,2,'Never mind~',NULL,NULL,'Markdown',0000000000,5,NULL),(9,1,6,'我是2.0.0. 你可以用pip装一下',NULL,NULL,'Markdown',0000000005,6,NULL),(10,1,5,'但是我升级之后它还是报的一样的错',NULL,NULL,'Markdown',0000000000,10,NULL);
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
  `code` varchar(1400) DEFAULT NULL,
  `lang` varchar(45) DEFAULT NULL,
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
INSERT INTO `Our_project_blog_questions` VALUES (1,'Question about the Django setings.py',1,'CSC4001',1,'#### This question annoys me a lot  \r ---  \r + I am a neotype of Django, and I am curious about how to write my \'setting.py\' to connect to my **MySQL** Database.  \r + The below is my code:  \r  \r + I also include a snapshot below, and attach this file. I would appreciate a lot if someone could help.\r ','setting{\\n    host: localhost\\n    password: *****\\n    database: cuhksz-stackoverflow\\n}','Python','Markdown',0000000005,0000000009,0001323580,NULL,'2022-04-09 05:59:29.748478',0000000113),(2,'Anybody know how to solve this problem of npm run dev?',2,'CSC4001',1,'When I using the npm run dev, it gives me an error about `webpack-dev-server --inline --progress --config build/webp',NULL,NULL,'Markdown',0000000005,0000000006,0001013605,NULL,'2022-04-06 14:02:40.504595',0000000057),(3,'What\'s the meaning of two-direction association in UML',1,'CSC4001',2,'Actually, I don\'t know what\'s the meaning of two-direction in the description of assignment1',NULL,NULL,'Markdown',0000000002,0000000009,0000385100,NULL,'2022-03-23 16:23:39.437189',0000000060),(4,'Building Kernel fail.',3,'CSC3150',3,'When I run make, it gives me a error about `permission denied`, why?',NULL,NULL,'Markdown',0000000002,0000000009,0001079205,NULL,'2022-04-10 13:49:59.936665',0000000201),(5,'How many storage should I assign to VM?',4,'CSC3150',3,'Is 10GB assigned to VM enough? cause my computer doesn\'t have much storage left.',NULL,NULL,'Markdown',0000000013,0000000017,0002965144,NULL,'2022-04-10 13:49:47.079056',0000000055);
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
INSERT INTO `Our_project_file` VALUES (1,'http://175.178.34.84/fs/user1_settings.py',1,NULL,NULL),(2,'http://175.178.34.84/fs/4001_DB.sql',NULL,7,NULL);
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
INSERT INTO `Our_project_group` VALUES (1,'CSC3150','Operating System',NULL,'2022-04-09 15:06:25.385070',132),(2,'CSC4001','Soft Engineering course',NULL,'2022-04-08 15:24:30.602062',112);
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
  KEY `group_NAME_idx` (`group_name`),
  CONSTRAINT `group_NAME` FOREIGN KEY (`group_name`) REFERENCES `Our_project_group` (`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_sub_group`
--

LOCK TABLES `Our_project_sub_group` WRITE;
/*!40000 ALTER TABLE `Our_project_sub_group` DISABLE KEYS */;
INSERT INTO `Our_project_sub_group` VALUES (1,'CSC4001','Project'),(2,'CSC4001','Assignment1'),(3,'CSC3150','Project1'),(4,'CSC3150','Project2'),(5,'CSC3150','Project3'),(6,'CSC3150','Project4'),(7,'CSC4001','Assignment2'),(8,'CSC3150','Final'),(9,'CSC4001','Final');
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
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Our_project_user`
--

LOCK TABLES `Our_project_user` WRITE;
/*!40000 ALTER TABLE `Our_project_user` DISABLE KEYS */;
INSERT INTO `Our_project_user` VALUES (1,'122010249@link.cuhk.edu.cn','qpr','35ad0d1a8496bc378ed73fc9f098e559','http://175.178.34.84/profiles/1649253091630.jpg',NULL,NULL,'2022-03-11 07:04:49.493694','2022-04-07 06:49:24.009012'),(2,'122010249@link.cuhk.edu.cn','1234','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-03-11 07:12:25.407426','2022-03-11 07:12:25.407459'),(3,'122010249@link.cuhk.edu.cn','qqq','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-03-11 07:13:10.849469','2022-03-11 07:13:10.849469'),(4,'122010249@link.cuhk.edu.cn','yyy','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-03-11 07:13:51.020685','2022-03-11 07:13:51.020720'),(5,'122456789@link.cuhk.edu.cn','nobody','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-03-17 05:24:12.726320','2022-03-17 05:24:12.726353'),(6,'122011111@link.cuhk.edu.cn','不会起名','caf1a3dfb505ffed0d024130f58c5cfa','',NULL,NULL,'2022-03-17 10:04:44.401660','2022-03-17 10:04:44.401695'),(7,'123456789@link.cuhk.edu.cn','5555','827ccb0eea8a706c4c34a16891f84e7b','',NULL,NULL,'2022-03-17 10:09:53.288498','2022-03-17 10:09:53.288530'),(8,'119010249@link.cuhk.edu.cn','qweqwe','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-03-22 14:41:28.790265','2022-03-22 14:41:28.790332'),(9,'119010167@link.cuhk.edu.cn','lzh','202cb962ac59075b964b07152d234b70','http://175.178.34.84/profiles/1648912734658.jpg',NULL,NULL,'2022-03-23 15:17:57.395887','2022-04-02 15:18:54.962571'),(10,'119010249@link.cuhk.edu.cn','qpr_real','35ad0d1a8496bc378ed73fc9f098e559','',NULL,NULL,'2022-03-23 15:22:37.641848','2022-03-23 15:22:37.641882'),(11,'119010249@link.cuhk.edu.cn','hihi','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-03-23 15:49:53.286947','2022-03-23 15:49:53.286978'),(12,'119010249@link.cuhk.edu.cn','123','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-03-23 15:50:17.597738','2022-03-23 15:50:17.597785'),(13,'119010249@link.cuhk.edu.cn','1233','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-03-23 15:50:40.549364','2022-03-23 15:50:40.549403'),(16,'119010108@link.cuhk.edu.cn','Demario_huang','9003d1df22eb4d3820015070385194c8','http://175.178.34.84/profiles/1648882656776.jpg',NULL,NULL,'2022-04-02 06:56:08.791225','2022-04-02 06:57:38.957615'),(17,'119010167@link.cuhk.edu.cn','lzh111','698d51a19d8a121ce581499d7b701668','',NULL,NULL,'2022-04-02 15:09:37.278488','2022-04-02 15:09:37.278520'),(42,'119010108@link.cuhk.edu.cn','huangwawa','ad57484016654da87125db86f4227ea3','',NULL,NULL,'2022-04-06 13:55:43.788519','2022-04-06 13:55:43.788556'),(43,'119010108@link.cuhk.edu.cn','das','ad57484016654da87125db86f4227ea3','',NULL,NULL,'2022-04-06 13:57:17.835799','2022-04-06 13:57:17.835834'),(44,'119010108@link.cuhk.edu.cn','dd','8277e0910d750195b448797616e091ad','',NULL,NULL,'2022-04-06 13:58:22.634205','2022-04-06 13:58:22.634249'),(45,'119010108@link.cuhk.edu.cn','ddddd','1aabac6d068eef6a7bad3fdf50a05cc8','',NULL,NULL,'2022-04-06 14:06:34.648143','2022-04-06 14:06:34.648190'),(46,'119010108@link.cuhk.edu.cn','demo','5f02f0889301fd7be1ac972c11bf3e7d','',NULL,NULL,'2022-04-06 14:19:15.293637','2022-04-06 14:19:15.293669'),(47,'119010108@link.cuhk.edu.cn','的点点滴滴','e34a8899ef6468b74f8a1048419ccc8b','',NULL,NULL,'2022-04-06 14:21:19.066411','2022-04-06 14:21:19.066447'),(48,'119010108@link.cuhk.edu.cn','adds','ad57484016654da87125db86f4227ea3','',NULL,NULL,'2022-04-06 14:27:21.362191','2022-04-06 14:27:21.362226'),(49,'119010108@link.cuhk.edu.cn','ddddddasd','ad57484016654da87125db86f4227ea3','',NULL,NULL,'2022-04-06 14:29:34.896173','2022-04-06 14:29:34.896209'),(50,'119010108@link.cuhk.edu.cn','dash','c389f0f28ae2d2055b0749d13edf426c','',NULL,NULL,'2022-04-06 14:31:07.780857','2022-04-06 14:31:07.780888'),(51,'119010108@link.cuhk.edu.cn','ccc','4eae35f1b35977a00ebd8086c259d4c9','',NULL,NULL,'2022-04-06 14:32:03.874752','2022-04-06 14:32:03.874784'),(52,'119010108@link.cuhk.edu.cn','aaaaa','ad57484016654da87125db86f4227ea3','',NULL,NULL,'2022-04-06 14:33:56.944176','2022-04-06 14:33:56.944218'),(53,'119010108@link.cuhk.edu.cn','dacsac','5ca2aa845c8cd5ace6b016841f100d82','',NULL,NULL,'2022-04-06 14:38:36.078721','2022-04-06 14:38:36.078754'),(54,'119010108@link.cuhk.edu.cn','casaca','3691308f2a4c2f6983f2880d32e29c84','',NULL,NULL,'2022-04-06 14:39:17.788479','2022-04-06 14:39:17.788510'),(55,'119010108@link.cuhk.edu.cn','dasdada','0cc175b9c0f1b6a831c399e269772661','',NULL,NULL,'2022-04-06 14:39:40.939626','2022-04-06 14:39:40.939660'),(56,'119010108@link.cuhk.edu.cn','dada','03c7c0ace395d80182db07ae2c30f034','',NULL,NULL,'2022-04-06 14:44:23.795160','2022-04-06 14:44:23.795200'),(57,'119010108@link.cuhk.edu.cn','dasdasdas','77963b7a931377ad4ab5ad6a9cd718aa','',NULL,NULL,'2022-04-06 15:00:22.692703','2022-04-06 15:00:22.692735'),(58,'119010108@link.cuhk.edu.cn','dasdasdasd','77963b7a931377ad4ab5ad6a9cd718aa','',NULL,NULL,'2022-04-06 15:01:05.590290','2022-04-06 15:01:05.590325'),(59,'119010108@link.cuhk.edu.cn','dhsacaa','9f6e6800cfae7749eb6c486619254b9c','',NULL,NULL,'2022-04-06 15:05:12.987036','2022-04-06 15:05:12.987082'),(60,'119010108@link.cuhk.edu.cn','dasds','ad57484016654da87125db86f4227ea3','',NULL,NULL,'2022-04-06 15:07:02.742770','2022-04-06 15:07:02.742805'),(61,'119010108@link.cuhk.edu.cn','dasdacxz','3691308f2a4c2f6983f2880d32e29c84','',NULL,NULL,'2022-04-06 15:16:43.874508','2022-04-06 15:16:43.874543'),(62,'119010108@link.cuhk.edu.cn','Huang','2ff6fa084fae5c0c94af6cd63b08f92b','',NULL,NULL,'2022-04-06 15:19:52.416868','2022-04-06 15:19:52.416899'),(63,'119010108@link.cuhk.edu.cn','Demario_Huang123','2ff6fa084fae5c0c94af6cd63b08f92b','',NULL,NULL,'2022-04-06 15:22:11.366095','2022-04-06 15:22:11.366126'),(64,'119010108@link.cuhk.edu.cn','PJL123','deabdd21fa0b246936317d461c41ee4b','',NULL,NULL,'2022-04-06 15:30:38.404877','2022-04-06 15:30:38.404911'),(65,'119010249@link.cuhk.edu.cn','QPPPPP','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-04-06 17:31:30.353544','2022-04-06 17:31:30.353586'),(66,'119010108@link.cuhk.edu.cn','pdwa','1aabac6d068eef6a7bad3fdf50a05cc8','',NULL,NULL,'2022-04-07 01:34:02.806533','2022-04-07 01:34:02.806565'),(67,'119010108@link.cuhk.edu.cn','lllsss','c68c559d956d4ca20f435ed74a6e71e6','',NULL,NULL,'2022-04-07 01:37:26.628159','2022-04-07 01:37:26.628190'),(68,'119010108@link.cuhk.edu.cn','wa','c68c559d956d4ca20f435ed74a6e71e6','',NULL,NULL,'2022-04-07 01:37:37.592051','2022-04-07 01:37:37.592085'),(69,'119010108@link.cuhk.edu.cn','xzczcxzc','b2ca678b4c936f905fb82f2733f5297f','',NULL,NULL,'2022-04-07 01:39:09.863217','2022-04-07 01:39:09.863249'),(70,'119010108@link.cuhk.edu.cn','carrie','2ff6fa084fae5c0c94af6cd63b08f92b','',NULL,NULL,'2022-04-07 02:21:19.067398','2022-04-07 02:26:23.385475'),(71,'119010108@link.cuhk.edu.cn','HuangPengxiang','2ff6fa084fae5c0c94af6cd63b08f92b','',NULL,NULL,'2022-04-07 02:34:02.082016','2022-04-07 02:34:02.082078'),(72,'119010108@link.cuhk.edu.cn','HPX123','2ff6fa084fae5c0c94af6cd63b08f92b','',NULL,NULL,'2022-04-07 02:34:26.768676','2022-04-07 03:04:32.385030'),(73,'119010167@link.cuhk.edu.cn','l2','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-04-07 03:56:50.334188','2022-04-07 03:56:50.334250'),(74,'119010249@link.cuhk.edu.cn','hehfei','202cb962ac59075b964b07152d234b70','',NULL,NULL,'2022-04-07 04:15:32.720849','2022-04-07 04:15:32.720883'),(75,'119010108@link.cuhk.edu.cn','Huang1234','2ff6fa084fae5c0c94af6cd63b08f92b','',NULL,NULL,'2022-04-07 06:47:44.600830','2022-04-07 06:47:44.600861'),(76,'119010108@link.cuhk.edu.cn','HuangPengxiang1234','2ff6fa084fae5c0c94af6cd63b08f92b','',NULL,NULL,'2022-04-07 06:55:37.063247','2022-04-10 13:14:27.504918'),(77,'119010249@link.cuhk.edu.cn','admin','324123','',NULL,NULL,'2022-04-10 11:53:31.047049','2022-04-10 11:54:08.193751');
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
INSERT INTO `Our_project_user_follow_group` VALUES (1,'CSC3150'),(1,'CSC4001'),(2,'CSC3150'),(3,'CSC4001'),(4,'CSC4001'),(5,'CSC4001'),(6,'CSC3150'),(6,'CSC4001'),(9,'CSC3150');
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
INSERT INTO `Our_project_user_follow_question` VALUES (1,1),(2,1),(5,1),(65,1),(1,2),(2,2),(4,2),(7,2),(1,3),(7,3),(2,4),(3,4),(1,5),(2,5),(9,5);
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
INSERT INTO `Our_project_user_like_question` VALUES (1,1),(2,1),(4,1),(16,1),(1,2),(2,2),(3,2),(1,3),(2,3),(3,3),(1,4),(6,4),(1,5),(2,5),(5,5),(6,5),(16,5),(65,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$320000$E2vxUM0wcvoJGlIUG7xOlB$N3ZDKSJwwqEhJtdlfiznzI/aRtFp7MgYinkvwjT/Q+M=','2022-04-10 12:49:02.111574',1,'4001','','','1190101249@link.cuhk.edu.cn',1,1,'2022-04-10 11:46:07.920554');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2022-04-10 11:53:31.060367','77','Useradmin',1,'[{\"added\": {}}]',7,1),(2,'2022-04-10 11:54:08.208177','77','Useradmin',2,'[{\"changed\": {\"fields\": [\"PASSWD\"]}}]',7,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(9,'Our_project','blog_questions'),(8,'Our_project','group'),(7,'Our_project','user'),(6,'sessions','session');
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
INSERT INTO `django_session` VALUES ('08y7mrmq1tu69o0v7rnzpp85m5g7ep1z','eyJ1c2VybmFtZSI6ImRhc2Rhc2Rhc2QiLCJ1aWQiOjU4fQ:1nc79d:DxxzA5eje1n_WWK4jdH6a2qHZo7D5m1d945q03qU6jg','2022-04-20 15:01:05.609874'),('1uder37otrpf42yo95m39qwtxatrchu2','eyJ1c2VybmFtZSI6Ikh1YW5nUGVuZ3hpYW5nMTIzNCIsInVpZCI6NzZ9:1nd1Yq:Deup-96g2Y0jgPBZcvWg_vwej-CBj2jqm__RavUobZM','2022-04-23 03:14:52.450456'),('1wv7y8pqegmp3vp9kgo5zoxd9y7vovnp','eyJ1c2VybmFtZSI6ImNhcnJpZSIsInVpZCI6NzB9:1ncHlv:DfnMQ36dlOrhtY82S2McDZCFvqYIHL7SeQFivm9VjR4','2022-04-21 02:21:19.088226'),('2j67hm5herm05nrvkckmh5a8bdl412f9','eyJ1c2VybmFtZSI6Imh1YW5nMSIsInVpZCI6MjB9:1nasjD:PYv4cJ5yRsfvWeh2PyKZ_SEQil5FmgLdJvxxoMKTa1M','2022-04-17 05:24:43.869717'),('2u8meo1uuexlci6xcluxm25w2vn0cbkk','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nX3di:zxSslnjDyzED6EetuhJDu6p54x1tu6BApafdYkJVIgQ','2022-04-06 16:15:14.148394'),('2zhbzk1hyalx9ak5nv0a6txt0ggk71jm','eyJ1c2VybmFtZSI6Imh1YW5nIiwidWlkIjoxOX0:1narF4:Gq35t6q9UBVkkBG2ZimkOEidY47AATFuW8QBk7jdsPE','2022-04-17 03:49:30.018899'),('3wmraknouydztvh7dhgoan7avveh408h','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nYSjO:nsAcfNDVCfD2oWIPFCfYW3aENJnfPg9XTuIpXZxFyiU','2022-04-10 13:14:54.003193'),('4j2udmbi9i106knr80wjrzaqy4ul1j0d','eyJ1c2VybmFtZSI6IlBKTDEyMyIsInVpZCI6NjR9:1nc7cE:v8F36CK68lvILwCUZPsPAPa25T7nMiRmQVBq9ONskLg','2022-04-20 15:30:38.423278'),('4t1b0mecwg5umcmg6fnfv81mofo21qym','eyJ1c2VybmFtZSI6Ikh1YW5nUGVuZ3hpYW5nMTIzNCIsInVpZCI6NzZ9:1ncdik:evHe1kgBZ387ccDNSSnp6U3b1BbRTmIXJQntYnGkLRA','2022-04-22 01:47:30.514899'),('56yklsp1sw2csmaiqfajx8ie0o9rhe9d','eyJ1c2VybmFtZSI6ImRhc2RzIiwidWlkIjo2MH0:1nc7FO:kJysDpnE9wQD54fhIOw2WGqtOi0y7qInOLBcdyfo58k','2022-04-20 15:07:02.760249'),('5il59xt66wqm2za0zo9l1wvno9aw5t6j','eyJ1c2VybmFtZSI6Imx6aDEyMyIsInVpZCI6OX0:1nYUL5:n0JTKTJgO-sOKleZOJd54KYVvZnK319OclhyGnsCqrg','2022-04-10 14:57:55.062453'),('6f94198e0wiqzcb5x8hcvoz0hd4z7y0x','eyJ1c2VybmFtZSI6ImNhcnJpZSIsInVpZCI6NzB9:1ncLv3:AXRXw_xbJyBbEew9qzKy9Q8s9kv5a1XIOMZvhRUpzdQ','2022-04-21 06:47:01.753410'),('6p5p985dt6fg7ski20syfpwskmbpnehd','eyJ1c2VybmFtZSI6Ikh1YW5nUGVuZ3hpYW5nMTIzNCIsInVpZCI6NzZ9:1ndCeM:zON9NsgDhtbz66q37PXY9U57Krc4q3AjKI4LFdoVonw','2022-04-23 15:05:18.350229'),('830kebkpheuqjiaey9xy72mae4hhw455','eyJ1c2VybmFtZSI6ImhlbGxvIiwidWlkIjozNH0:1nc57K:tox7Dp7zrWqAgdDwI-OzD77X_v1HQZMarkSEPXUEUiI','2022-04-20 12:50:34.493886'),('83fuq2sce2w4j99b0oljo1icu5ap2e2r','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nX3fr:RkoxOIiw1MihPiroenFeTXOiWwRuVd0U4EUEoBsemwo','2022-04-06 16:17:27.081187'),('8kepeug2foxd15trfpkw9x3pngd2v88c','eyJ1c2VybmFtZSI6ImRlbW8iLCJ1aWQiOjM2fQ:1nc5b5:3kFrc8IqOm_Sp3asi8WJlF-DXyHv1nb_0mUWcZvj_HI','2022-04-20 13:21:19.525035'),('8l3awe3ylkp0mulp2e1s4u1iwuuyo7m7','eyJ1c2VybmFtZSI6ImRkZGRkZGFzZCIsInVpZCI6NDl9:1nc6f8:mRmeGvbi8tYniTTjbUepbgTjcdKvUU3rlp4I8yVjbbk','2022-04-20 14:29:34.915413'),('8ovtyohd63sr6m20zxiqnws57dcb2zgv','eyJ1c2VybmFtZSI6Imh1YW5nMTMyIiwidWlkIjoyNX0:1natMY:2qnj4QOWXOn_KZyTGnyzxRl1bgj1czbwHW2D3c65DnQ','2022-04-17 06:05:22.191911'),('8snn83x9mepvxhfft5ow1g02cwg912rg','eyJ1c2VybmFtZSI6IkRlbWFyaW9fSHVhbmcxMjMiLCJ1aWQiOjYzfQ:1nc7U3:GzG7eFgbt5IIGedoJpqo6w_sJzQVp33YufBpXse5O3s','2022-04-20 15:22:11.384812'),('8yk7hzjp9armie1qmo4h5zqbw7eacjri','eyJ1c2VybmFtZSI6ImhoaCIsInVpZCI6NDB9:1nc5nj:72v0oGiqRdzlXKlH-Y2_YosIrJZ0oiwFUrUnqtc-Iko','2022-04-20 13:34:23.424461'),('9cjxk7wdac04y68d86vupgv3fmn40li9','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nYULh:5DJ7p4HkPOqRNkOpMq8bYlq8JoI4Az7FgbIWCaiGUgI','2022-04-10 14:58:33.335047'),('9fs85uzxzl9z1cg7y7rupxv5tagxh56j','eyJ1c2VybmFtZSI6IkRlbWFyaW9fSHVhbmcxMjMiLCJ1aWQiOjYzfQ:1nc7VC:2esqsRB3493AHDOEU8Yor4OUpSlzwBMKfAFrLt5GD4U','2022-04-20 15:23:22.431698'),('9qbdl69v7i452c8r8x1wbfo7ioeldqgj','eyJ1c2VybmFtZSI6ImRkIiwidWlkIjo0NH0:1nc6Aw:riHN1EiJbhdl0n-2GImKDD7Vs_USMIAzn8nnF8uT1Dc','2022-04-20 13:58:22.653789'),('9yvl19n1lkrmq8yqe164sx6ezeb2g1vb','eyJ1c2VybmFtZSI6ImRkZGRkIiwidWlkIjo0NX0:1nc6Is:Vzx22QBoGRK8ngnMfaCFoZt28C1a1t_k18aVIlmXyWc','2022-04-20 14:06:34.668176'),('a2yeziiwh1lkgq21rm5uyy3jj6kvsu8s','eyJ1c2VybmFtZSI6Imh1YW5ncGVuZ3hpYW5nIiwidWlkIjoyM30:1nat2z:rm1Bjq1Z45IP2bFGaKZx-w-t-5QU9tGLOxi92cUCdH0','2022-04-17 05:45:09.140848'),('ag6377fpxnoawihzxqzqzcyknswy44ei','eyJ1c2VybmFtZSI6ImRhY3NhYyIsInVpZCI6NTN9:1nc6ns:SGkumWN14pGT5hwfTiJpRZ54O4GE-T37p0YvFve9DeA','2022-04-20 14:38:36.096053'),('ahgrnfu48k5g6gsgpiolhmkl4yn3xmst','eyJ1c2VybmFtZSI6Inh6Y3pjeHpjIiwidWlkIjo2OX0:1ncH77:hJboOS9HOvvjeFEFvTP3-1SjNBb6JAhUUi4L4T9t38k','2022-04-21 01:39:09.888013'),('aq7kx7xtej3elwq1t5hak1du3vg53g7n','eyJ1c2VybmFtZSI6Imh1YW5nMTIzIiwidWlkIjoyMX0:1naspE:U_TIGTdUaMizADN7vNdqID_NF82HPnxxxb-s9a7fB_I','2022-04-17 05:30:56.091085'),('azlol9fjq0ik7pbq7mjgsvjc77hqzohm','eyJ1c2VybmFtZSI6Ikh1YW5nUGVuZ3hpYW5nMTIzNCIsInVpZCI6NzZ9:1ncM3N:K2XR7ij4lipXLVs6KT5NYgoW_sN1GFYcvi-Yj9I8oQo','2022-04-21 06:55:37.089635'),('b2q3wof7v7bafj122p8hgyx7fkln1oku','eyJ1c2VybmFtZSI6ImQgZCBkIiwidWlkIjozN30:1nc5fH:Gei9dd9a1IEYP_ptAM12G6d5NzuCA6xnDchYZnzbTdg','2022-04-20 13:25:39.865295'),('bpxzlrp72893321043fxrvxxt7mx5ho5','eyJ1c2VybmFtZSI6ImRoc2FjYWEiLCJ1aWQiOjU5fQ:1nc7Dd:rX3BXDE1FmzpeQCUGAbPCbI9DricftJuYbjxkqlyhiU','2022-04-20 15:05:13.005711'),('c8qumv32il05boop4tef39m9sb3zgkc0','eyJ1c2VybmFtZSI6IkhQWCIsInVpZCI6MTh9:1narDH:BS2_e4tzJkkkznFcIKxJRiHIVsfIel4ijaFoFwISSdU','2022-04-17 03:47:39.837145'),('ciz9865bf80inx00fmj64feuhch4ozyr','eyJ1c2VybmFtZSI6Imh1YW5nMTIzNCIsInVpZCI6MjR9:1natGs:hpZXhvGdSGwCAFr4-W_ZZAWhE6mBLUedVmy8NE1DcUY','2022-04-17 05:59:30.239735'),('cpwbms9bjwkc2tin7m6b50ydl5k896p9','.eJxVzM0OwiAQBOB34WwIYPnz6N1nIMsuSNVAUtqT8d0tSQ96nW9m3izAtpaw9bSEmdiFSXb6zSLgM9UB9IB6bxxbXZc58lHhh3Z-a5Re16P7d1Cgl7FWjpwT2RCiidZkrc5qUl5mbyFr4SfvtLG70iR3wwiADpNLwsecMvt8AeIQOH4:1ndW1P:yEZtXMV_Wmdhl6F0TgG2ukvQ6ZjDU3shbU4eaXE9sUg','2022-04-24 11:46:23.588000'),('ebibtj0n27cqvwv552zyw8gxuicj9enb','eyJ1c2VybmFtZSI6Imx6aDEyIiwidWlkIjoxNH0:1nYU1R:dLh7gv7c10Uorj_9l_sO2VEUasYX2v_YHFmPGA7ZeaQ','2022-04-10 14:37:37.525501'),('ec3q91d5kzjwoq8l6jfsw699xpsx9qh2','eyJ1c2VybmFtZSI6IndkYWRkIiwidWlkIjo0MX0:1nc5yo:-uztNgiQmFYtN9XbDibXu_4dD5A8yO1GwpO4Zg3Z8L4','2022-04-20 13:45:50.763096'),('ekvl7jhf1eyp6wx7xqzetj4ndp0yvqjb','eyJ1c2VybmFtZSI6InF3ZXF3IiwidWlkIjozMn0:1nc4So:e01Fuh9TRMiU2zFPoOl6WT1OhamF9EJNZ8NTk9UIm_g','2022-04-20 12:08:42.685289'),('f6yua0xacpngcf1eujstc32thsk8qpyf','eyJ1c2VybmFtZSI6ImNjYyIsInVpZCI6NTF9:1nc6hX:y8L24Iy4c7Fm0tXfaOWd3-U5n8tWP_LOEsr735J8VW0','2022-04-20 14:32:03.899792'),('fgs9w4wfegzhngtldq5r2v1pkxc1j1ou','eyJ1c2VybmFtZSI6Ikh1YW5nUGVuZ3hpYW5nIiwidWlkIjo3MX0:1ncLT3:0ITC8wir35uBjb3Ts-6xrjIqO6hgf3i1XcFXlpIw2TY','2022-04-21 06:18:05.556234'),('hakwc0myg1wgift7k60qc85agnkc5jbf','eyJ1c2VybmFtZSI6Imx6aDEyMyIsInVpZCI6OX0:1nYTRy:4k8vfsQ5PEvwiZvmYRX8U6dG0FCwKFMo45cTDbhsChE','2022-04-10 14:00:58.776717'),('hhdxh0ts0ktu8svgpmooeg434ryvsdyo','eyJ1c2VybmFtZSI6ImRhc2giLCJ1aWQiOjUwfQ:1nc6gd:FN_cClb5kkjBXpIWxAEXiK2uHE2x00ALZiZut-4-8OQ','2022-04-20 14:31:07.798420'),('ht8mku9k9p6i1twgz44x73k15uba0959','eyJ1c2VybmFtZSI6InB3ZCIsInVpZCI6MzN9:1nc4aJ:AmGgL2GKq5VGBKEW3pnE4sTnOa1cFUdesJ5wwgTNxQE','2022-04-20 12:16:27.148655'),('iuxeue2f122ngfpp7iwifz3xc2s84x0i','eyJ1c2VybmFtZSI6Imx6aDEyMyIsInVpZCI6OX0:1nYUJ8:V9Fm073pxaJWa7WrVM_hY0ODDMmnsTtIdI9SKJX7xPk','2022-04-10 14:55:54.035237'),('j1x38uuxsczwgh4d62uv7fbg9zawi1pi','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nX3ca:oa8Gotq4iVox10JSUbfehWfseCBGE7R4zWHL8CAcTWU','2022-04-06 16:14:04.376268'),('jdvn23xfz1hk4zgn6b84lfgm20f4gznb','eyJ1c2VybmFtZSI6ImRlbW8iLCJ1aWQiOjQ2fQ:1nc6V9:2lXlRYyCfj2bbopw_CSlTUgj0IEdHXuoIFJOUVeTkz4','2022-04-20 14:19:15.315925'),('jupbxznsccxjuzdivnps6hjg3the1lth','eyJ1c2VybmFtZSI6ImRhc2RhZGEiLCJ1aWQiOjU1fQ:1nc6ou:Vj4j1JchUufk89_Ku99iqCu3bC6E8GxlAj0-Vg6Ef9U','2022-04-20 14:39:40.957560'),('jxw5wij7lbjrl82xh47xxfqtgus58iw6','eyJ1c2VybmFtZSI6Imx6aDExMTEiLCJ1aWQiOjE0fQ:1nYTmW:W7CZI8KrdeOZn7WuFiTBGnnINLaMaMDgRbWDFmTllfI','2022-04-10 14:22:12.609202'),('k79bxb6c6p2mj7crwjueegk6s99x25ae','eyJ1c2VybmFtZSI6Ind3IiwidWlkIjoyNn0:1nb18f:2NiY6uuoUuTzw7kVK_v4WMQNAtLRqB8sRP_HJToxNGc','2022-04-17 14:23:33.033355'),('kxgkc3t4uce58k7rmqb2if1qahn21hp2','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1ndXHj:uKXrhEoN-1_zSQKXiZzC86PLNw1KQbR5StkklLPqrNg','2022-04-24 13:07:19.314479'),('lay6uszu5mkqoss3gbcc37dp2fwd8azf','.eJyrViotTi3KS8xNVbJSiik1N7MwAZIGSZYw0iw1zQRCKukolWamKFmZmNcCAN-7EM4:1nc6X9:5a2zvIv6yPkpRJUrAcjxU1c53J71QMq0fa3UwxlE2RA','2022-04-20 14:21:19.082311'),('lbj6u2103qfe84i9my1h5prs4rodvmiy','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nYUa0:nOHOGGjXr8xEgwMmIegqASUhtjY8ObKkVuNhZtlFBXA','2022-04-10 15:13:20.011461'),('leg2vs5unsc65cjl4772bio3n5tpugcn','eyJ1c2VybmFtZSI6InB3ZDEiLCJ1aWQiOjI4fQ:1nc452:9lLgW_WShp9xRi_LsDLKBXP7xx1O1EKOWyVj_0Wqtkw','2022-04-20 11:44:08.255995'),('liy47vk9qp2mo0yj9tn3sn1xmpjhzmpg','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nYSs2:Fc49h2XLF3BhlnASzmp4l2TY3pnwYEfxnCF5Kox3mZk','2022-04-10 13:23:50.457281'),('ls62ixzpvy7k762pyswtkp3y60oug59o','eyJ1c2VybmFtZSI6Ikh1YW5nUGVuZ3hpYW5nMTIzNCIsInVpZCI6NzZ9:1nd0FY:72OmdeaaVV4AbNXmyYn8Y1euQnf_Y5qBGzvY2ABUzHE','2022-04-23 01:50:52.392906'),('m5pnsczbxhht5k4h74mhwex114qzqi64','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nYU7F:dt84hZZSizQlUnJ1IQ4wg9XdHU7spzSKJ5eleWKrs3E','2022-04-10 14:43:37.695654'),('mspjj4sdstfvif9jbm4aco1qxd27mdjb','eyJ1c2VybmFtZSI6Ikh1YW5nIiwidWlkIjo2Mn0:1nc7Ro:ggqzcN6ga7luLQn0lLNW1s3IV67WXbb-bod6OGCb5fY','2022-04-20 15:19:52.433304'),('nku9ifzsugxog1ov2rkg0ev35nct5qgj','eyJ1c2VybmFtZSI6ImFhYWFhIiwidWlkIjo1Mn0:1nc6jM:Ovd8sKHU6U_6D8-GAGdFO6A4QY-YSu84hb6g_nM42cg','2022-04-20 14:33:56.961216'),('o606onfupnnv5d1xnqez64xl4a1kzsn7','eyJ1c2VybmFtZSI6InFwciIsInVpZCI6MX0:1ncJzW:-zRXPochBx7DRJkK6W_cfVQ5TvvhKIBqsKHBRNISgtc','2022-04-21 04:43:30.238278'),('oop2m6qm9zuw2nn47q3grbh43cd3xkxc','eyJ1c2VybmFtZSI6IndkYSIsInVpZCI6Mzl9:1nc5jH:R40c_3ZHWFIoLEYQOMbGuqq8ZmbPMlTtFbJixsUMR8Q','2022-04-20 13:29:47.969247'),('ov2vvicweis4q0ifpbjsejwkqpblg5na','eyJ1c2VybmFtZSI6Ikh1YW5nUGVuZ3hpYW5nMTIzNCIsInVpZCI6NzZ9:1nd1Jb:xpBEKozN28tytk9A803e0Dab_6eQucheDNnDLE5LfH8','2022-04-23 02:59:07.398585'),('ph69hzxtr3tzmzmy3ruouchkf1b2x3wz','.eJxVjEsOgzAMBe_iNYowEIJZdt8zICd2C_0klM-q6t2rSGzYzsx7X9hXXSK_FXr4zAsUsE8CPRYw8L6NQ9ZDJoBwYp7DU2MW8uB4TyakuC2TNzkxh13NNYm-Lkd7Ohh5HfNaWbuaWISpcux81dmAtqWqbMR6EiFCDrXthEvFpkbSoC27W2iQSOD3B5yiQC8:1ndX5J:_UF0w7sV05NruXILIrpLO8iPdWqRIN_qUkjiKQCFz60','2022-04-24 12:54:29.125971'),('q02ms5vj2mcex8c59l8izc90yyyq4d2x','eyJ1c2VybmFtZSI6Ikh1YW5nUGVuZ3hpYW5nMTIzIiwidWlkIjo3Mn0:1ncIQD:p6AtHXvr8K8cvffgSOw3NhTw3FZYdMosZhGq_5w6FfI','2022-04-21 03:02:57.369186'),('q354s10ghvjwk0tgar5yarrhnnqj3dvo','eyJ1c2VybmFtZSI6Ikh1YW5nMTIzNCIsInVpZCI6NzV9:1ncLvk:2MLokAb7uhrRG2LGnB6g9Zc8VgivG2p8BpXnacB5qOE','2022-04-21 06:47:44.618486'),('qjbrb5c58x7ar22l1mghtjqm00o9iqv3','eyJ1c2VybmFtZSI6IjIxMyIsInVpZCI6Mjd9:1nc40X:iTVK27ihWlygM4CNBMh-PmuXEaJE5pXvi11R7Pg_2Ec','2022-04-20 11:39:29.321359'),('qtx9re43lyt8o7w4hg2p35ycgoyvg4ry','eyJ1c2VybmFtZSI6ImwyIiwidWlkIjo3M30:1ncJGM:0m46i7k6-5aBo_mUPDzeMm9-frc_MdL78YeZ_lzkD8Q','2022-04-21 03:56:50.357734'),('r470f7qo2x6vofbkhcjfwexq9wmokrnn','eyJ1c2VybmFtZSI6InFwciIsInVpZCI6MX0:1ncK1l:184DQgq_TMfI5PslSj9gwPgcslZ3MEw3d-63XJ11fOI','2022-04-21 04:45:49.008789'),('s7iq9u2e7cnwgplxevih3vbwkqbvoiwg','eyJ1c2VybmFtZSI6ImNhc2FjYSIsInVpZCI6NTR9:1nc6oX:i-iMwZblfPjdBl_xT2jNBsWcLz6D7HKv-pMiHaPm9Ec','2022-04-20 14:39:17.807882'),('smwlkegk12wqjjkfpej2x914s3c6d5bm','eyJ1c2VybmFtZSI6InB3ZDEyMyIsInVpZCI6Mjl9:1nc4Do:-uB7r9XhqBrC9KBqhV_OxYo8Pwszjir4TK70pZZoaTE','2022-04-20 11:53:12.989297'),('st7ueojfauauhms4xx4e45r8n8ojim2m','eyJ1c2VybmFtZSI6ImRhZGEiLCJ1aWQiOjU2fQ:1nc6tT:MMPhildCL1x4IYhERwE4UAWw3KNdjz1XZ7s-3t6sx8U','2022-04-20 14:44:23.813295'),('sxzgzlwgkatznu63a7d4h8p6tozlxf0u','eyJ1c2VybmFtZSI6InBkd2EiLCJ1aWQiOjY2fQ:1ncH2A:UvMEXnTqbrnaf3g-kvRk9k5PaGoz1GxNMCg0j6WsG7g','2022-04-21 01:34:02.831029'),('sy9xrhfuspsgea11jfal5t0386msezma','eyJ1c2VybmFtZSI6ImRlbWFyaW9faHVhbmciLCJ1aWQiOjE2fQ:1naexP:W01_0vGJvBLWF8Nzd99Es2mGuVv55fofPN6g1qJJIbs','2022-04-16 14:42:27.559304'),('t0r06iwvmu31u0b3pmi3gc7jck53ct7x','eyJ1c2VybmFtZSI6Ikh1YW5nUGVuZ3hpYW5nMTIzNCIsInVpZCI6NzZ9:1nd3pV:4-nK5TUZcTQvqHsT8DqfyyD1jki6b2Ufp-m_ub7B2Eg','2022-04-23 05:40:13.410596'),('tgabjbyajqlaz7olwhjwxneqya6t4uq7','eyJ1c2VybmFtZSI6ImRhc2Rhc2RhcyIsInVpZCI6NTd9:1nc78w:W1XVfHM8p44A4f35rb2aEWX6rvKK5WnVerCRuWQga7o','2022-04-20 15:00:22.711759'),('tgsvxinlitpta5j4ala88lsy5u53zxj1','eyJ1c2VybmFtZSI6ImFkZHMiLCJ1aWQiOjQ4fQ:1nc6cz:UapkQQCYpjWW_xn0-jxpdPTmz_Cj832Fn2ZaqCwYmVc','2022-04-20 14:27:21.379221'),('tnhgutg51mvud0q4y1f3sukqu2k0801f','eyJ1c2VybmFtZSI6IndxZSIsInVpZCI6MzB9:1nc4Kj:9_80wdkc0lCqsLJJjeFyQ6xuLrhrwhgu0xMj8gG1R-8','2022-04-20 12:00:21.207923'),('u6fz36iwkkcgmmhaswtfu9dkjualopie','eyJ1c2VybmFtZSI6InFxcXd3IiwidWlkIjozMX0:1nc4Nn:R0_xyPkfyZFzlwB1_hiYrfhtLORU5_PD5Bu4M_-eNE0','2022-04-20 12:03:31.062827'),('umjyh5y5nxoq1g9ewa377m7bgemtr1w6','eyJ1c2VybmFtZSI6ImRhcyIsInVpZCI6NDN9:1nc69t:jqBiKddRBUk_TRmMJRXAi4PmS_tE2JD7cLCjSta6qyM','2022-04-20 13:57:17.857440'),('vb4krxah88igli40i8nkeypn6n65o523','eyJ1c2VybmFtZSI6Imx6aDEyMyIsInVpZCI6OX0:1nYUCV:fbh_f_O3ENyeOEyjcmpSeHTQbnXiVR1aZMEH6btRmz8','2022-04-10 14:49:03.093728'),('vknio3yzow6n8893g5aek7bw98z8un8w','eyJ1c2VybmFtZSI6Ind3d2FzYWQiLCJ1aWQiOjM4fQ:1nc5hY:MwbET6DxsQRHchbVoCy-aktlCLQmqg52m7tG8_wg5m0','2022-04-20 13:28:00.744279'),('vkwlqdh836zc88d83m9t5ttlizi9oxc7','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nYUfA:Gg05sa_ukKki9iVk1-rbwBw85OaPF8SernKg5BHyyfY','2022-04-10 15:18:40.589086'),('vnhtb1ta5poofxgvhw2beqayrxounqe4','eyJ1c2VybmFtZSI6IjEyMzQiLCJ1aWQiOjJ9:1nSZRp:ZPU_Kmp8qjXcRAqOxMoLsuljaDqP7Bka6kVWpX0Cyjs','2022-03-25 07:12:25.431922'),('w78q19dpv7xo2i7nuai8v3zb0eog40sv','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nYUFB:KeOkm49l_jvH8QlyWCaQQROaruLQJi8VXTGHzO0KWBA','2022-04-10 14:51:49.660878'),('w8vfe5kc5storcuectonh740185c24iz','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nYSp1:qCmm2hsSuLoMfsWQX9DDEojc8ocbWfkFn5i_Q68e1hc','2022-04-10 13:20:43.258059'),('xalxlmv3rtylgpygtx26u099sejvv84c','eyJ1c2VybmFtZSI6InJlZ2lzdHJhdGlvbiBkZW1vIiwidWlkIjozNX0:1nc5KW:nojLv4Fx26rvIO1PJjqP0bo9qGpa5FFsNVtBThpVTtc','2022-04-20 13:04:12.746670'),('xdsixs7cmf0zilc111kkjrewrq40lesy','eyJ1c2VybmFtZSI6ImRlbWFyaW9faHVhbmciLCJ1aWQiOjE2fQ:1nabvQ:Od7OcyVW3-jxfpGfeZpiXVX0yBrOLqEaTAieusc1TII','2022-04-16 11:28:12.279540'),('ya6v64jrxo5hnokrfu17zev5hi8xrjtg','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nYSlh:FDyoAloHNph2ucZtG1SkRfK8jFqCBC_BLCPE41aDgFo','2022-04-10 13:17:17.865106'),('you9je0wy60vo172tpz3de1p4d695isz','eyJ1c2VybmFtZSI6Imx6aDExMTEiLCJ1aWQiOjE0fQ:1nYTno:UTx8mf1B-3Y20iN7HVkAA6vxXoWQ0gHJQGV3GL8VdKg','2022-04-10 14:23:32.369422'),('z4p58yn48u3jblwtxeu1nnysl96oghm1','eyJ1c2VybmFtZSI6IjEyM3MiLCJ1aWQiOjIyfQ:1nasqD:JKfjrJeDRoAe-42wnVgNnsEgeyZPfJ1Kbra5Yq3b1a8','2022-04-17 05:31:57.478608'),('zfk71xed4e1v7bn19k716wi3axtaepbu','eyJ1c2VybmFtZSI6Imx6aCIsInVpZCI6OX0:1nX3eG:1PNnQgYiVMe5oJRklXTFHL6vAZrYXqRSQ9yAX_LUGcg','2022-04-06 16:15:48.207316'),('zktqnu0h74t9ey8blqae4rtk4el26gcq','eyJ1c2VybmFtZSI6InFxcSIsInVpZCI6M30:1nSZSZ:tNg8UMYRlG_pgZsalVXm3v3HheKXFHgsUJe8n0vmJqg','2022-03-25 07:13:11.065469'),('zkwb4il6cgdjxsk7awbqhkr7mqfts87q','eyJ1c2VybmFtZSI6ImRhc2RhY3h6IiwidWlkIjo2MX0:1nc7Ol:MWUliBr3BT1YIWAKE611QKG8u2QNwZ4BEQeXwWPtnOk','2022-04-20 15:16:43.893395'),('zxv16s1zj11m8284jwfgvpjayn33zcdh','eyJ1c2VybmFtZSI6Imh1YW5nd2F3YSIsInVpZCI6NDJ9:1nc68N:0soge6FpgrPagH50e6VfQuZ3xetH0-6hGWrYQ2WxUhI','2022-04-20 13:55:43.807245');
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

-- Dump completed on 2022-04-11 12:55:19

DROP EVENT IF EXISTS refresh_hot; 

CREATE EVENT refresh_hot 
ON SCHEDULE EVERY 1 day STARTS DATE_ADD(DATE(CURDATE() + 1),  INTERVAL 0 HOUR)
ON COMPLETION PRESERVE

DO
  UPDATE `CSC4001`.`Our_project_blog_questions` SET `hot` = `hot`/2;
