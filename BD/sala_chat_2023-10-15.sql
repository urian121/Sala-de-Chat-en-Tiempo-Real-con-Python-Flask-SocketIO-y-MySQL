# ************************************************************
# Sequel Pro SQL dump
# Versión 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.4.28-MariaDB)
# Base de datos: sala_chat
# Tiempo de Generación: 2023-10-16 00:46:00 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Volcado de tabla tbl_chat
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tbl_chat`;

CREATE TABLE `tbl_chat` (
  `id_chat` int(11) NOT NULL AUTO_INCREMENT,
  `desde_id_user` int(11) DEFAULT NULL,
  `para_id_user` int(11) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `archivo_img` varchar(100) DEFAULT NULL,
  `file_audio` varchar(100) DEFAULT NULL,
  `fecha_mensaje` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus_leido` int(11) DEFAULT 0,
  PRIMARY KEY (`id_chat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `tbl_chat` WRITE;
/*!40000 ALTER TABLE `tbl_chat` DISABLE KEYS */;

INSERT INTO `tbl_chat` (`id_chat`, `desde_id_user`, `para_id_user`, `mensaje`, `archivo_img`, `file_audio`, `fecha_mensaje`, `estatus_leido`)
VALUES
	(1,4,1,'hola',NULL,NULL,'2023-10-15 18:12:52',1),
	(2,4,1,'que haces',NULL,NULL,'2023-10-15 18:12:52',1),
	(3,1,4,'nada y tu',NULL,NULL,'2023-10-15 18:02:48',1),
	(4,4,1,'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto finalLorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final',NULL,NULL,'2023-10-15 18:12:52',1),
	(5,1,4,'hola',NULL,NULL,'2023-10-15 18:02:48',1),
	(6,4,1,'HOLA',NULL,NULL,'2023-10-15 18:15:14',1),
	(7,4,1,'que haces?',NULL,NULL,'2023-10-15 18:15:14',1),
	(8,4,10,'hola Felipe',NULL,NULL,'2023-10-15 18:20:05',0),
	(9,4,10,'hola',NULL,NULL,'2023-10-15 18:35:22',0),
	(10,4,1,'holaaaa',NULL,NULL,'2023-10-15 18:35:48',0),
	(11,1,10,'g',NULL,NULL,'2023-10-15 18:53:39',0),
	(12,1,10,'k',NULL,NULL,'2023-10-15 18:57:08',0),
	(13,1,12,'holka',NULL,NULL,'2023-10-15 19:16:37',0),
	(14,1,3,'hola',NULL,NULL,'2023-10-15 19:21:25',0),
	(15,4,13,'hola',NULL,NULL,'2023-10-15 19:21:42',0),
	(16,4,14,'hola',NULL,NULL,'2023-10-15 19:23:39',0),
	(17,4,10,'hola',NULL,NULL,'2023-10-15 19:23:48',0),
	(18,4,13,'ghjh',NULL,NULL,'2023-10-15 19:26:23',0),
	(19,4,13,'jghj',NULL,NULL,'2023-10-15 19:26:25',0),
	(20,4,13,'kjk',NULL,NULL,'2023-10-15 19:27:38',0),
	(21,4,14,'jkh',NULL,NULL,'2023-10-15 19:27:46',0),
	(22,4,14,'khjkh',NULL,NULL,'2023-10-15 19:27:55',0),
	(23,4,14,'hjk',NULL,NULL,'2023-10-15 19:27:56',0),
	(24,4,14,'hjk',NULL,NULL,'2023-10-15 19:27:57',0),
	(25,4,14,'kjhk',NULL,NULL,'2023-10-15 19:27:59',0);

/*!40000 ALTER TABLE `tbl_chat` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla tbl_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tbl_users`;

CREATE TABLE `tbl_users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(150) DEFAULT NULL,
  `email_user` varchar(60) DEFAULT NULL,
  `pass_user` mediumtext NOT NULL,
  `tlf_user` varchar(50) DEFAULT NULL,
  `foto_user` varchar(100) DEFAULT NULL,
  `description_user` mediumtext DEFAULT NULL,
  `online` tinyint(4) DEFAULT 0,
  `ultima_conexion` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `tbl_users` WRITE;
/*!40000 ALTER TABLE `tbl_users` DISABLE KEYS */;

INSERT INTO `tbl_users` (`id_user`, `user`, `email_user`, `pass_user`, `tlf_user`, `foto_user`, `description_user`, `online`, `ultima_conexion`)
VALUES
	(1,'Brenda Cataleya','brenda@gmail.com','scrypt:32768:8:1$baPQqls2DqzH5SNk$b0a9cfb4752f405a244bb0b315d5bbffac0c1019c783bc4958b2ad1c4e4a482a60fcaf9c41bd77193e857c673da290e3f73be5df982115c4778d4a2e301e3567','1236547895','63e3ce26c93245299618ca976fc05f46.jpg',NULL,1,'2023-07-20 18:26:49'),
	(2,'Urian Dev','dev@gmail.com','scrypt:32768:8:1$7ARj3v1eiO9ZoUot$4545b263539d4ecaeff4e72fbbd2a1797b271e5010fc080a186e88cd1d5e8d0d177434587da32d97f260d936d6b955973f8eb4617c3e406b9fe51f603b221343','1239874568','1ead0939249f47e498939e0f750bafe1.jpg',NULL,1,'2023-07-21 00:20:22'),
	(3,'Uriany','uriany@gmail.com','scrypt:32768:8:1$iAa8D0oCYDzugE3r$caf253ab8661cb58da1b3d400ac7603e98569136838c699cb96471e288285218a1fa457b49590bbf93f0236cd749be3ecf6f7d42a082534aaf5313525d79cd62','2147483647','bbb06e47b11045eb9304f44babfa1367.jpg',NULL,1,'2023-07-14 00:40:58'),
	(4,'Alejandro Torres','alejandro@gmail.com','scrypt:32768:8:1$kVCG8lDrBf3Xxl3z$352eebcb9d6c1b5ce49591f861c45bb5f4f1c3d74a256f2c419c3a2e8ee6a3325530ca725809fdb4aeb30e19809cec1bea3d5dad74af4dcab8bc302666c96a2e','2147483647','a3d633ee2e3a4aabbac38c7ffe95d863.jpg',NULL,1,'2023-07-21 00:20:36'),
	(5,'Diego Harry Torres ','diego@gmail.com','scrypt:32768:8:1$chz6ZfpOFWET4z92$b7563e3dec1aed62311b3673a794a642cf43c8f1116ada1b35b282f050d3c940c4887c54b0893286695873c30777f0cecdfaacb5a1eb8a96b953e1949d4da055','2147483647','5973af67e5c0430fa44ec068084e070f.jpg',NULL,1,'2023-07-20 01:21:53'),
	(7,'Zuit J.','zuit@gmail.com','scrypt:32768:8:1$opzc5Q3rRkSOe3JZ$f586c3eac82ac46787bc7edc98beb1d1e891ce596b58fcdaecc1f00ea4fe129f4fb6a8abb8b2b23e4569744f5ac1f03557dbef8afe24d0e4ca015a57d3ac93d2','1236547895','495e28b119924482ba548656c7953eb0.jpg',NULL,0,'2023-07-14 02:28:32'),
	(9,'Taylor Zurich','taylor@gmail.com','scrypt:32768:8:1$YMK0watti5O26JMl$ef3c38d7c6acff45a13a005faf0fbea82f1fc6fe451f19e9f466972b93822d9923fa90e0f8252fa57920ddf3d0430ab2a9a90d2612b632799616e8c333a29586','1236547895','267fc204c8db448d86f92b67a5f5fa2a.jpg',NULL,0,'2023-07-14 02:32:50'),
	(10,'Gustavo Felipe','gustavo_2023@gmail.com','scrypt:32768:8:1$VqbhzSfCmrt3cufD$1c0b0150cc861e12c0e6f70eb222f6fcfb10aaa14deaad0b150eb81e10917cc16373913aefed505395948f1932c44595f75d66422b58254230f8bef939da8e5e','1236547895','53d779c429174d52bb45ed60d4a181b7.jpg',NULL,0,'2023-07-14 02:39:11'),
	(11,'Urian Viera','viera@gmail.com','scrypt:32768:8:1$GexA6CObPGwk32tD$40706cbc4d9ed3e68ce517e7b0bc03ee92c9eca5652a4ad96cc5bf2cf79ebf529926874d1e791374a534ea9f2ca0df057a4715c433f89e91c6e08bf602337c42','2147483647','e5b188602c764b7dbcf07930b5576339.jpg',NULL,0,'2023-07-17 01:18:34'),
	(12,'Hui Yun','hui_05@gmail.com','scrypt:32768:8:1$3qZeufA6uKQ3lohU$1138603d43b1035916645dea81dcd6fa33b20246caa41e4c690c8d2a882041e88af53a4281174bd6cd69c614c0f7e1b6b6b6590e361ef054bdc472e76ba4c6f1','2147483647','a831da7df4634adc98802b2aea511774.jpg',NULL,0,'2023-07-14 02:56:35'),
	(13,'Julian D.','julian@gmail.com','scrypt:32768:8:1$OOu4EK6Qw5XGq62m$35fd4769308d5770bd3005cc593267a18021f82fe78caa053cca08bde399f1ec15aa70d9fb33f5cb24589ff85bd15aafa52de37df99a9c042c3e7aa303c81a6f','2147483647','a4fc85577ff04d97adcad85c502a946e.jpg',NULL,0,'2023-07-14 03:06:41'),
	(14,'Pedro E.','pedro2023@gmail.com','scrypt:32768:8:1$6eFYmCnKNQlARfTO$8ab09bb31eaabe46ccb0ac698745801703f301841600ff774b8ece1404cecfabd709f66b2b60b31c5e8c26269e235af2422994ccfb00925d4a85a89f80ab156c','2147483647','498a58a777454fae8494090d3fe8c67a.jpg',NULL,0,'2023-07-14 03:10:52');

/*!40000 ALTER TABLE `tbl_users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
