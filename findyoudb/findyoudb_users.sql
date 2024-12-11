-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: findyoudb
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `photo` text,
  `gender` text,
  `bio` text,
  `hobby` text,
  `description` text,
  `batch_id` bigint DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `phone` text,
  `fbLink` text,
  `tgLink` text,
  `ttLink` text,
  `igLink` text,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `batch_id` (`batch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5669 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (5657,'Nine Wai Yan','test@gmail.com','1000:3be6e9572e40983ad45d2e418a7e0c14:d8fc4e67f2c9b180ef44070bb38af3c808b7e2b928f33eec96a0fea2bae46e4393fe3202a71710c31ff372a7f9d50cef76d69fa75bd2b16c912bf4875374df1b','download (2)_749d5107-7985-4b4b-b180-0c83d6d4aceb.jpg','Female','I Love My Family','flip,play heart','So Lovely',2,'2000-01-11','09876655345666','5667898767','ioiuyuioi','uiu67890','http://localhost/learniverse/views/index.php',NULL,'2024-11-24 15:06:20','2024-11-25 10:35:21'),(5658,'nine Wai','nine@gmail.com','1000:f9540864bf9dc3fcef2eb747034945ce:62834fcf6ae1a5c28cb7bce7cfa83fd5c0222edb3602a0f6558a28b4ad9c948c92a1252094ccfbf65f6721e35e5ad28677a5daea0a963c2b88acee84db9e8036','download (1)_9dccc42e-f0f8-4e69-adfc-5c7a486966bf.jpg','Male','','','',3,'2024-11-25','','','','','',NULL,'2024-11-24 21:59:48','2024-11-25 10:24:28'),(5659,'Min Thu Htun','minthuhtun@gmail.com','1000:37f2cc6a9ba7cf9979fba6c02b9723db:9a04e6d9ea8f40d49287d86bd73080b1da08f5d555861e9017d15824cf5a1839c363d1c40a572a247897330ddf0f29101b36c924023aac6535b987470e0877c1','images (1)_725118df-8d46-46a7-a7fe-4be9af3eb56c.jpg','Male','this is my bio','watching movie','Hello! I\'m finding partner',2,'2003-01-28','092367892','@facebook','minthu','minthu','minthu',NULL,'2024-11-25 11:23:30','2024-11-26 00:19:46'),(5660,'Cherry','cherry@gmail.com','1000:7bf00a1ea2cc028c9864d9e40b0a4671:c298b250dfe8fcf1a87d401e223e506687188e3295539bda36cf8af21020ad8526742086b8f56da19eece4e717adf1281e194e43fb6dfc38d2c5e63223bcff38','download (6)_f5e5a89a-3d25-4bb9-b3a9-ce8077e073b3.jpg','Female',NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-11-25 20:07:01','2024-11-25 20:07:01'),(5661,'Thet Mon','thetmon@gmail.com','1000:cdecb5c6cbf5637425268698723f6d70:9c1ffb281dce79219a3b745576dc5d30e2a6966fef7b7f1d16f641e03748c906e579b092a906b8735ecd3d4d3e2a4bfc64d86577b57556977b1cbf6e260a1ede','download (8)_0a52bdae-2ff8-41f8-bd97-33ac429a44ed.jpg','Female',NULL,NULL,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-11-25 20:07:29','2024-11-25 20:07:29'),(5662,'Nwe Zar Win','nwezarwin@gmail.com','1000:52cf398978e80b6491557a1347c35eaa:7e5c10daaeecb80fae711a4c75791422adf62042f3b8c9843ea2e7914f86a7e6dfaa12937f487e047fe4efc2e22e7b47c1b447cf3eaeaf5f8d94b75b337db531','download (9)_e1b10ac7-b3cd-46cd-bdb3-178bd95b6b74.jpg','Female',NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-11-25 20:08:05','2024-11-25 20:08:05'),(5663,'Aung Thu Hein','aungthuhein@gmail.com','1000:a3a7e85753ca7881472bf562d683a81d:a2033a0bfc946f3abeeb921b7251f4419d168d953cc5b35c20ca6b81a22da848917bae32519bcdf879a8d137cee4f43a4c3632aa1df424c9bb87c5f5a9f8deaf','download (7)_afefb4e0-d1e0-4da8-b824-86b649a10760.jpg','Male',NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-11-25 20:08:47','2024-11-25 20:08:47'),(5664,'Arkar','arkar@gmail.com','1000:31b4e8386ebffb57612e5bc86c54fad0:78d211ae74c3720d605b424c663f8ef9f4e98a2830e8cf5084a72aa4c8a6f37104042412948005ae6e5b197ac99ad32d178a2014b94fe544ffef0cfc4f9757bf','images (1)_57180e7b-407a-41d9-8bdf-8ea88946ad42.jpg','Male',NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-11-25 20:09:26','2024-11-25 20:09:26'),(5665,'Wutt Hmone','wutt@gmail.com','1000:31029ea8ecfe705021a52cf2fe4126e0:b558ddc82352d32afb51bb2fb35bdfeace22b1150e553bf79d9c6e0ccf6df5f0070f7aff39c2035fd263c265172095c60e14a2f3b5f7eaee17239b4883f23ff9','download (9)_64063a21-2eec-437c-93f0-3236cd5cd0d8.jpg','Female',NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-11-25 23:56:02','2024-11-25 23:56:02'),(5666,'Nwe Zar Win','nwe@gmail.com','1000:833889392bd1358c06a291c699e37f31:1bd7115802a840ebbed5a992bd068c1a17b79797979ca079dbacb1fc63405326557180603cde4fa5851857c1a0db41b5485cc0dd49645274776f4fdc4a14def1','images (2)_dda6d858-a11a-44ba-9875-6245753ed74e.jpg','Female','this is my bio','watching movie','this is ',3,'2024-10-31','09875424','nwe','','','nwe',NULL,'2024-11-25 23:57:34','2024-11-26 00:29:55'),(5667,'apple','apple@gmail.com','1000:b1323c1bd0a22c5f4797e45dfadc04c5:603cd66e7fd77b49ad5d1143d81b499b1868054fa8cf091a7aa61b68607f87e387f0a28e51725908bc470ded9cc075fd4da54e346c83e169c731d64921b90356','download (9)_b119ea9b-dc13-43c0-8685-fe1dbb615ed0.jpg','Male',NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-11-26 00:00:09','2024-11-26 00:00:09'),(5668,'hla wutt','hla@gmail.com','1000:b667169f8754fffed1e2f3ba9c401a50:7636854f3ac561307974ff51fdb9f408d1055a5f9f73dddb14c6cfec44b661b2d6e3db1b9e692ad8d51705e3ec02e53cc792208746ff89d3625bf0269277f1ea','download (10)_b974fe04-cf4e-4c66-be38-33b8dfab7d54.jpg','Female',NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-11-26 00:31:47','2024-11-26 00:31:47');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-11  9:38:50
