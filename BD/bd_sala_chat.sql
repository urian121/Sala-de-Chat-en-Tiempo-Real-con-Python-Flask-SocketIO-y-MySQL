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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sala_chat.tbl_chat: ~34 rows (aproximadamente)
INSERT INTO `tbl_chat` (`id_chat`, `desde_id_user`, `para_id_user`, `mensaje`, `archivo_img`, `file_audio`, `fecha_mensaje`) VALUES
	(1, NULL, NULL, NULL, NULL, '472193d29a884f658117d4512f8c5705.webm', '2023-07-03 22:30:28'),
	(2, NULL, NULL, NULL, NULL, '14723af5fc914e35bf57cafd7e64b1aa.webm', '2023-07-03 22:46:23'),
	(3, NULL, NULL, NULL, NULL, '8ee14f2912134d2f938e164140bda7cd.webm', '2023-07-03 22:46:42'),
	(4, NULL, NULL, NULL, NULL, '2226124b3d554780be9a284e44e8194f.webm', '2023-07-03 22:46:45'),
	(5, NULL, NULL, NULL, NULL, '8edb170703ea432785c3f64ecd7e996b.webm', '2023-07-03 22:46:47'),
	(6, NULL, NULL, NULL, NULL, '2f23ea01d8fc4ff99bf2d9bdbfb7b3da.webm', '2023-07-03 22:48:06'),
	(7, NULL, NULL, NULL, NULL, '6deef8916e66433d91705a7206145b1d.webm', '2023-07-03 22:48:54'),
	(8, NULL, NULL, NULL, NULL, 'eda675ce5fe947dbbf8d4229bdb15e75.webm', '2023-07-03 22:51:59'),
	(9, NULL, NULL, NULL, NULL, '50c9b9a4510e4edeb2a9459d6fc7bd2f.webm', '2023-07-03 22:52:05'),
	(10, NULL, NULL, NULL, NULL, '7ff20e660cf54ade80b4d9abd7913432.webm', '2023-07-03 22:52:11'),
	(11, NULL, NULL, NULL, NULL, '0c410cb489574ef1bd1e8932eb20c91d.webm', '2023-07-03 22:52:17'),
	(12, NULL, NULL, NULL, NULL, 'a0566c20c93243b5ae0592206194280c.webm', '2023-07-03 22:52:17'),
	(13, NULL, NULL, NULL, NULL, '650ee0712844492faa1c670984e4ba9a.webm', '2023-07-03 22:52:20'),
	(14, NULL, NULL, NULL, NULL, '303fb9f87f8b43fb8f013b7314fbdeea.webm', '2023-07-03 22:54:38'),
	(15, NULL, NULL, NULL, NULL, '29bcc7f3fb3b47dab81764164510fd35.webm', '2023-07-03 22:54:55'),
	(16, NULL, NULL, NULL, NULL, '91ec21b0c2c5410ab0b3e6645d203c2f.webm', '2023-07-03 22:55:01'),
	(17, NULL, NULL, NULL, NULL, 'c4d9bfa1d56144b581f639722609f0a0.webm', '2023-07-03 22:55:05'),
	(18, NULL, NULL, NULL, NULL, 'ac1adcfe81594ed1800356a27bafdd9d.webm', '2023-07-03 22:55:05'),
	(19, NULL, NULL, NULL, NULL, '593f9baeb740468e920cbc4f22571295.webm', '2023-07-03 23:13:55'),
	(20, NULL, NULL, NULL, NULL, '1fe3d4b1d6a54777941bddf23013c62f.webm', '2023-07-03 23:14:09'),
	(21, NULL, NULL, NULL, NULL, '8784c124d3bb45058bdfce9dc051fa59.webm', '2023-07-03 23:14:43'),
	(22, NULL, NULL, NULL, NULL, '743747096c51480996de905d1144453d.webm', '2023-07-03 23:15:23'),
	(23, NULL, NULL, NULL, NULL, '3f75ef06b7094e3e85dbf0b4af54d0db.webm', '2023-07-03 23:21:10'),
	(24, NULL, NULL, NULL, NULL, '51bf068d653f4fc2b9f9215a6f8fbb6a.webm', '2023-07-03 23:21:32'),
	(25, NULL, NULL, NULL, NULL, '15048714d2544818892140019b9404c0.webm', '2023-07-03 23:22:17'),
	(26, NULL, NULL, NULL, NULL, 'add95ef6af6c4a0db35a6af05a37dd93.webm', '2023-07-03 23:28:32'),
	(27, 3, 11, 'hola mundo', NULL, NULL, '2023-07-05 01:02:01'),
	(28, 11, 11, 'sera', NULL, NULL, '2023-07-05 01:02:16'),
	(29, 11, 11, 'Dios', NULL, NULL, '2023-07-05 01:08:12'),
	(30, 3, 1, 'GraciAS', NULL, NULL, '2023-07-05 01:08:22'),
	(31, 11, 11, '<script>       alert(\'hola\')     </script>', NULL, NULL, '2023-07-05 01:09:59'),
	(32, 3, 1, 'q', NULL, NULL, '2023-07-05 01:10:08'),
	(33, 3, 1, 'aaaaa', NULL, NULL, '2023-07-05 01:10:12'),
	(34, 11, 11, 'qwqw', NULL, NULL, '2023-07-05 01:10:17');

-- Volcando estructura para tabla sala_chat.tbl_users
CREATE TABLE IF NOT EXISTS `tbl_users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(150) DEFAULT NULL,
  `email_user` varchar(60) DEFAULT NULL,
  `pass_user` mediumtext NOT NULL,
  `tlf_user` int(10) DEFAULT NULL,
  `foto_user` varchar(100) DEFAULT NULL,
  `description_user` mediumtext DEFAULT NULL,
  `online` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sala_chat.tbl_users: ~8 rows (aproximadamente)
INSERT INTO `tbl_users` (`id_user`, `user`, `email_user`, `pass_user`, `tlf_user`, `foto_user`, `description_user`, `online`) VALUES
	(1, 'URIAN', 'urian@gmail.com', 'sha256$Vy4xdu6RdJwQwtIB$78c6a6f1630f5ba6eee7c281d6a24550baca88e47789452616fd4c1941ef51e8', 1234567896, '1.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 1),
	(2, 'Jose', 'jose@gmail.com', 'sha256$hwaah2qkCWyIJJh3$604be91a2fb0effc0f9e7247c16bdc5fb2e123f6f2c985b124e53b1631ba3cf5', 1236547896, '2.jpg', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 0),
	(3, 'Brenda', 'brenda@gmail.com', 'sha256$9iyFWrwuguqHnfvx$4d1f361039f3861948c844a9e5e139045ccd1aba61eb7caac2b6e06d5b601e87', 1234568795, '91489dc03746478ea57a680ee8ce72f1.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 1),
	(6, 'Angel', 'angel@gmail.com', 'sha256$9iyFWrwuguqHnfvx$4d1f361039f3861948c844a9e5e139045ccd1aba61eb7caac2b6e06d5b601e87', 1234569875, '3.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 0),
	(7, 'asas', 'ssss@gmail.com', 'sha256$IZe1u3dLGEMgc6UJ$e55d379b916a217e946879f5c80d37a9a280c2a177d99511a05f0efd2b1770ff', 1236547895, '4.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 1),
	(9, 'Hooks', 'hooks@gmail.com', 'sha256$XXo0OCgS2JK4MfAM$217e560c485354b9e9e4e020c6bfcc9677215fb3d95ad6a9ac2c28531f704bb1', 1234567895, 'd12a2fe6f88b44f7abbed8ebc5ab4d79.PNG', NULL, NULL),
	(10, 'Alejandro', 'alejandro@gmail.com', 'sha256$EIPK7muIHydDBUKP$e02ec0a81bb0c286eaa72f3fa7c130f62dd7cd73ed0486727c116943ff5dabe5', 1234569875, '91fd8d77c64e4399bd7930cdd47139d0.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', NULL),
	(11, 'Dev', 'dev@gmail.com', 'sha256$JoqfU4XO8GIjiCZT$49f310acf2e67a6041e91111d25f73ef1316e8b353b2f066317cbba29acbb8b0', 2147483647, '17ef76aadf8745dd8611d8ca0b1e6e2b.jpg', NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
