-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para sala_chat
CREATE DATABASE IF NOT EXISTS `sala_chat` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sala_chat`;

-- Volcando estructura para tabla sala_chat.tbl_chat
CREATE TABLE IF NOT EXISTS `tbl_chat` (
  `id_chat` int NOT NULL AUTO_INCREMENT,
  `desde_id_user` int DEFAULT NULL,
  `para_id_user` int DEFAULT NULL,
  `mensaje` text COLLATE utf8mb4_general_ci,
  `archivo_img` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `file_audio` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fecha_mensaje` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus_leido` int DEFAULT '0',
  PRIMARY KEY (`id_chat`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sala_chat.tbl_chat: ~11 rows (aproximadamente)
INSERT IGNORE INTO `tbl_chat` (`id_chat`, `desde_id_user`, `para_id_user`, `mensaje`, `archivo_img`, `file_audio`, `fecha_mensaje`, `estatus_leido`) VALUES
	(1, 2, 1, 'hola Brenda es Dev', NULL, NULL, '2023-07-21 00:20:06', 0),
	(2, 2, 1, 'que haces', NULL, NULL, '2023-07-21 00:20:09', 0),
	(3, 4, 1, 'Hola Brenda es Alejandro', NULL, NULL, '2023-07-21 00:20:50', 0),
	(4, 4, 1, 'que haces', NULL, NULL, '2023-07-21 00:20:53', 0),
	(5, 4, 1, 'Vas para la Univ?', NULL, NULL, '2023-07-21 00:21:01', 0),
	(6, 4, 5, 'Hola Diego es Alejandro', NULL, NULL, '2023-07-21 00:24:02', 0),
	(7, 1, 4, 'Hola Alejandro, si voy para la Univ', NULL, NULL, '2023-07-21 00:24:31', 0),
	(8, 1, 4, 'nos vemos alla', NULL, NULL, '2023-07-21 00:24:36', 0),
	(9, 4, 1, 'hola', NULL, NULL, '2023-07-21 01:01:51', 0),
	(10, 4, 1, 'h', NULL, NULL, '2023-07-21 01:01:52', 0),
	(11, 4, 1, 'h', NULL, NULL, '2023-07-21 01:01:53', 0),
	(12, 4, 1, 'h', NULL, NULL, '2023-07-21 01:01:53', 0);

-- Volcando estructura para tabla sala_chat.tbl_users
CREATE TABLE IF NOT EXISTS `tbl_users` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `user` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_user` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pass_user` mediumtext COLLATE utf8mb4_general_ci NOT NULL,
  `tlf_user` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `foto_user` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description_user` mediumtext COLLATE utf8mb4_general_ci,
  `online` tinyint DEFAULT '0',
  `ultima_conexion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sala_chat.tbl_users: ~14 rows (aproximadamente)
INSERT IGNORE INTO `tbl_users` (`id_user`, `user`, `email_user`, `pass_user`, `tlf_user`, `foto_user`, `description_user`, `online`, `ultima_conexion`) VALUES
	(1, 'Brenda Cataleya', 'brenda@gmail.com', 'scrypt:32768:8:1$baPQqls2DqzH5SNk$b0a9cfb4752f405a244bb0b315d5bbffac0c1019c783bc4958b2ad1c4e4a482a60fcaf9c41bd77193e857c673da290e3f73be5df982115c4778d4a2e301e3567', '1236547895', '63e3ce26c93245299618ca976fc05f46.jpg', NULL, 1, '2023-07-20 18:26:49'),
	(2, 'Urian Dev', 'dev@gmail.com', 'scrypt:32768:8:1$7ARj3v1eiO9ZoUot$4545b263539d4ecaeff4e72fbbd2a1797b271e5010fc080a186e88cd1d5e8d0d177434587da32d97f260d936d6b955973f8eb4617c3e406b9fe51f603b221343', '1239874568', '1ead0939249f47e498939e0f750bafe1.jpg', NULL, 0, '2023-07-21 00:20:22'),
	(3, 'Uriany', 'uriany@gmail.com', 'scrypt:32768:8:1$iAa8D0oCYDzugE3r$caf253ab8661cb58da1b3d400ac7603e98569136838c699cb96471e288285218a1fa457b49590bbf93f0236cd749be3ecf6f7d42a082534aaf5313525d79cd62', '2147483647', 'bbb06e47b11045eb9304f44babfa1367.jpg', NULL, 1, '2023-07-14 00:40:58'),
	(4, 'Alejandro Torres', 'alejandro@gmail.com', 'scrypt:32768:8:1$kVCG8lDrBf3Xxl3z$352eebcb9d6c1b5ce49591f861c45bb5f4f1c3d74a256f2c419c3a2e8ee6a3325530ca725809fdb4aeb30e19809cec1bea3d5dad74af4dcab8bc302666c96a2e', '2147483647', 'a3d633ee2e3a4aabbac38c7ffe95d863.jpg', NULL, 1, '2023-07-21 00:20:36'),
	(5, 'Diego Harry Torres ', 'diego@gmail.com', 'scrypt:32768:8:1$chz6ZfpOFWET4z92$b7563e3dec1aed62311b3673a794a642cf43c8f1116ada1b35b282f050d3c940c4887c54b0893286695873c30777f0cecdfaacb5a1eb8a96b953e1949d4da055', '2147483647', '5973af67e5c0430fa44ec068084e070f.jpg', NULL, 1, '2023-07-20 01:21:53'),
	(7, 'aa', 'aa@gmail.com', 'scrypt:32768:8:1$opzc5Q3rRkSOe3JZ$f586c3eac82ac46787bc7edc98beb1d1e891ce596b58fcdaecc1f00ea4fe129f4fb6a8abb8b2b23e4569744f5ac1f03557dbef8afe24d0e4ca015a57d3ac93d2', '1236547895', '495e28b119924482ba548656c7953eb0.jpg', NULL, 0, '2023-07-14 02:28:32'),
	(9, 'qqq', 'qqqa@gmail.com', 'scrypt:32768:8:1$YMK0watti5O26JMl$ef3c38d7c6acff45a13a005faf0fbea82f1fc6fe451f19e9f466972b93822d9923fa90e0f8252fa57920ddf3d0430ab2a9a90d2612b632799616e8c333a29586', '1236547895', '267fc204c8db448d86f92b67a5f5fa2a.jpg', NULL, 0, '2023-07-14 02:32:50'),
	(10, 'qwqwqw', 'awqwqw@gmail.com', 'scrypt:32768:8:1$VqbhzSfCmrt3cufD$1c0b0150cc861e12c0e6f70eb222f6fcfb10aaa14deaad0b150eb81e10917cc16373913aefed505395948f1932c44595f75d66422b58254230f8bef939da8e5e', '1236547895', '53d779c429174d52bb45ed60d4a181b7.jpg', NULL, 0, '2023-07-14 02:39:11'),
	(11, 'Urian Viera', 'u@gmail.com', 'scrypt:32768:8:1$GexA6CObPGwk32tD$40706cbc4d9ed3e68ce517e7b0bc03ee92c9eca5652a4ad96cc5bf2cf79ebf529926874d1e791374a534ea9f2ca0df057a4715c433f89e91c6e08bf602337c42', '2147483647', 'e5b188602c764b7dbcf07930b5576339.jpg', NULL, 0, '2023-07-17 01:18:34'),
	(12, '535', '45@gmail.com', 'scrypt:32768:8:1$3qZeufA6uKQ3lohU$1138603d43b1035916645dea81dcd6fa33b20246caa41e4c690c8d2a882041e88af53a4281174bd6cd69c614c0f7e1b6b6b6590e361ef054bdc472e76ba4c6f1', '2147483647', 'a831da7df4634adc98802b2aea511774.jpg', NULL, 0, '2023-07-14 02:56:35'),
	(13, 'ASAS', 'SA@GMAIL.COM', 'scrypt:32768:8:1$OOu4EK6Qw5XGq62m$35fd4769308d5770bd3005cc593267a18021f82fe78caa053cca08bde399f1ec15aa70d9fb33f5cb24589ff85bd15aafa52de37df99a9c042c3e7aa303c81a6f', '2147483647', 'a4fc85577ff04d97adcad85c502a946e.jpg', NULL, 0, '2023-07-14 03:06:41'),
	(14, 'ppp', 'p@gmail.com', 'scrypt:32768:8:1$6eFYmCnKNQlARfTO$8ab09bb31eaabe46ccb0ac698745801703f301841600ff774b8ece1404cecfabd709f66b2b60b31c5e8c26269e235af2422994ccfb00925d4a85a89f80ab156c', '2147483647', '498a58a777454fae8494090d3fe8c67a.jpg', NULL, 0, '2023-07-14 03:10:52');

-- Volcando estructura para disparador sala_chat.trg_update_last_connection
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `trg_update_last_connection` BEFORE UPDATE ON `tbl_users` FOR EACH ROW BEGIN
    SET NEW.ultima_conexion = CURRENT_TIMESTAMP;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
