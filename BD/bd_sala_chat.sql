-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.28-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla sala_chat.tbl_chat
CREATE TABLE IF NOT EXISTS `tbl_chat` (
  `id_chat` int(11) NOT NULL AUTO_INCREMENT,
  `desde_id_user` int(11) DEFAULT NULL,
  `para_id_user` int(11) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `archivo_img` varchar(100) DEFAULT NULL,
  `file_audio` varchar(100) DEFAULT NULL,
  `fecha_mensaje` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_chat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sala_chat.tbl_chat: ~0 rows (aproximadamente)

-- Volcando estructura para tabla sala_chat.tbl_users
CREATE TABLE IF NOT EXISTS `tbl_users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(150) DEFAULT NULL,
  `email_user` varchar(60) DEFAULT NULL,
  `pass_user` mediumtext NOT NULL,
  `tlf_user` int(10) DEFAULT NULL,
  `foto_user` varchar(100) DEFAULT NULL,
  `description_user` mediumtext DEFAULT NULL,
  `online` tinyint(4) DEFAULT 0,
  `ultima_conexion` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sala_chat.tbl_users: ~5 rows (aproximadamente)
INSERT INTO `tbl_users` (`id_user`, `user`, `email_user`, `pass_user`, `tlf_user`, `foto_user`, `description_user`, `online`, `ultima_conexion`) VALUES
	(1, 'Brenda', 'brenda@gmail.com', 'scrypt:32768:8:1$baPQqls2DqzH5SNk$b0a9cfb4752f405a244bb0b315d5bbffac0c1019c783bc4958b2ad1c4e4a482a60fcaf9c41bd77193e857c673da290e3f73be5df982115c4778d4a2e301e3567', 1236547895, '63e3ce26c93245299618ca976fc05f46.jpg', NULL, 1, '2023-07-09 22:50:14'),
	(2, 'Urian Dev', 'dev@gmail.com', 'scrypt:32768:8:1$7ARj3v1eiO9ZoUot$4545b263539d4ecaeff4e72fbbd2a1797b271e5010fc080a186e88cd1d5e8d0d177434587da32d97f260d936d6b955973f8eb4617c3e406b9fe51f603b221343', 1239874568, '1ead0939249f47e498939e0f750bafe1.jpg', NULL, 0, '2023-07-09 22:52:20'),
	(3, 'Uriany', 'uriany@gmail.com', 'scrypt:32768:8:1$iAa8D0oCYDzugE3r$caf253ab8661cb58da1b3d400ac7603e98569136838c699cb96471e288285218a1fa457b49590bbf93f0236cd749be3ecf6f7d42a082534aaf5313525d79cd62', 2147483647, 'bbb06e47b11045eb9304f44babfa1367.jpg', NULL, NULL, '2023-07-09 22:48:57'),
	(4, 'Alejandro', 'alejandro@gmail.com', 'scrypt:32768:8:1$kVCG8lDrBf3Xxl3z$352eebcb9d6c1b5ce49591f861c45bb5f4f1c3d74a256f2c419c3a2e8ee6a3325530ca725809fdb4aeb30e19809cec1bea3d5dad74af4dcab8bc302666c96a2e', 2147483647, 'a3d633ee2e3a4aabbac38c7ffe95d863.jpg', NULL, NULL, '2023-07-09 22:49:45'),
	(5, 'Diego', 'diego@gmail.com', 'scrypt:32768:8:1$chz6ZfpOFWET4z92$b7563e3dec1aed62311b3673a794a642cf43c8f1116ada1b35b282f050d3c940c4887c54b0893286695873c30777f0cecdfaacb5a1eb8a96b953e1949d4da055', 2147483647, '5973af67e5c0430fa44ec068084e070f.jpg', NULL, 1, '2023-07-09 23:24:14');

-- Volcando estructura para disparador sala_chat.trg_update_last_connection
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER trg_update_last_connection
BEFORE UPDATE ON tbl_users
FOR EACH ROW
BEGIN
    SET NEW.ultima_conexion = CURRENT_TIMESTAMP;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
