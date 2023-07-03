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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sala_chat.tbl_chat: ~14 rows (aproximadamente)
INSERT INTO `tbl_chat` (`id_chat`, `desde_id_user`, `para_id_user`, `mensaje`, `archivo_img`, `file_audio`, `fecha_mensaje`) VALUES
	(1, 3, NULL, '', '156194a9206b40abb2467a51fc7515b8.png', NULL, '2023-07-03 17:06:03'),
	(2, 3, NULL, '', 'f29a328aee814cd188bdc769096db19f.png', NULL, '2023-07-03 17:07:18'),
	(3, 3, NULL, '', '244cbcbc9e904c25b30e09394c36e076.png', NULL, '2023-07-03 17:08:42'),
	(4, 3, NULL, '', 'e9d1091566a64cc38ab917365f06be48.png', NULL, '2023-07-03 17:09:10'),
	(5, 3, NULL, '', '0f2d24b9545e4a17a472fabe3b7cc846.png', NULL, '2023-07-03 17:09:10'),
	(6, 3, NULL, '', '9d6ea003d2ca47eca9668aa0206db96e.png', NULL, '2023-07-03 17:09:24'),
	(7, 3, NULL, '', '1a82d6b557224df999f253ac675cdcbe.png', NULL, '2023-07-03 17:09:24'),
	(8, 3, NULL, '', 'a3798e0a9a8f4fff89d8c39fdb07430e.png', NULL, '2023-07-03 17:09:24'),
	(9, 3, NULL, '', '1d806df5a4a34f569b98fa44b5139ce4.PNG', NULL, '2023-07-03 17:48:08'),
	(10, 3, NULL, '', 'baffb3ffd12648eeac0e8dabfa7db438.png', NULL, '2023-07-03 17:48:14'),
	(11, 3, NULL, 'hola', '678892bb968c40c4a2530e06986c74a2', NULL, '2023-07-03 17:51:21'),
	(12, 3, NULL, 'que tal', '2460b12b3dff402496b111e9aa3a620a', NULL, '2023-07-03 17:51:27'),
	(13, 3, NULL, 'sera', '9c42580cef6942dabad5e5e2bfdd16ff', NULL, '2023-07-03 17:51:33'),
	(14, 3, NULL, 'probando', '2fb99aae4c3b4492a7b5c7ee33e4d278', NULL, '2023-07-03 17:55:45'),
	(15, 3, 10, 'calpinteria', 'c614d29c8dc142908208d12c67e26356', NULL, '2023-07-03 17:58:38'),
	(16, 3, 6, 'how', '9e054d448207455fbff270d726a9d1de', NULL, '2023-07-03 17:59:03'),
	(17, 3, 3, 'dime', 'e08cac1a6b534eb4b78497e5391ce93b', NULL, '2023-07-03 18:00:17'),
	(18, 3, 3, 'brenda', '27ab8b9ec9604131a6c4e48921eac995', NULL, '2023-07-03 18:01:25'),
	(19, 3, 6, 'comoo', 'facd32d4638f419fb99530866c4140b0', NULL, '2023-07-03 18:03:09'),
	(20, 3, 10, 'a', 'f15a9c29127a4b90be1dc87ec1942d34', NULL, '2023-07-03 18:04:08'),
	(21, 3, 3, 'despacio', '1dea06bbd7fa4286af79e4aa220d18f6', NULL, '2023-07-03 18:06:13'),
	(22, 3, 6, 'hola', NULL, NULL, '2023-07-03 18:10:48'),
	(23, 3, 9, 's', NULL, NULL, '2023-07-03 18:11:46'),
	(24, 3, 10, 'hola', NULL, NULL, '2023-07-03 18:17:16'),
	(25, 3, 3, 'hola', NULL, NULL, '2023-07-03 18:18:26'),
	(26, 3, 3, 'como', NULL, NULL, '2023-07-03 18:22:15'),
	(27, 3, 3, 'qe', NULL, NULL, '2023-07-03 18:22:18'),
	(28, 3, 1, 'que bien', NULL, NULL, '2023-07-03 18:22:24');

-- Volcando estructura para tabla sala_chat.tbl_users
CREATE TABLE IF NOT EXISTS `tbl_users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(150) DEFAULT NULL,
  `email_user` varchar(60) DEFAULT NULL,
  `pass_user` mediumtext NOT NULL,
  `tlf_user` int(10) DEFAULT NULL,
  `foto_user` varchar(100) DEFAULT NULL,
  `decription_user` mediumtext DEFAULT NULL,
  `online` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla sala_chat.tbl_users: ~6 rows (aproximadamente)
INSERT INTO `tbl_users` (`id_user`, `user`, `email_user`, `pass_user`, `tlf_user`, `foto_user`, `decription_user`, `online`) VALUES
	(1, 'URIAN', 'urian@gmail.com', 'sha256$Vy4xdu6RdJwQwtIB$78c6a6f1630f5ba6eee7c281d6a24550baca88e47789452616fd4c1941ef51e8', 1234567896, '1.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 1),
	(2, 'Jose', 'jose@gmail.com', 'sha256$hwaah2qkCWyIJJh3$604be91a2fb0effc0f9e7247c16bdc5fb2e123f6f2c985b124e53b1631ba3cf5', 1236547896, '2.jpg', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 0),
	(3, 'Brenda', 'brenda@gmail.com', 'sha256$9iyFWrwuguqHnfvx$4d1f361039f3861948c844a9e5e139045ccd1aba61eb7caac2b6e06d5b601e87', 1234568795, '91489dc03746478ea57a680ee8ce72f1.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 1),
	(6, 'Angel', 'angel@gmail.com', 'sha256$9iyFWrwuguqHnfvx$4d1f361039f3861948c844a9e5e139045ccd1aba61eb7caac2b6e06d5b601e87', 1234569875, '3.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 0),
	(7, 'asas', 'ssss@gmail.com', 'sha256$IZe1u3dLGEMgc6UJ$e55d379b916a217e946879f5c80d37a9a280c2a177d99511a05f0efd2b1770ff', 1236547895, '4.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 1),
	(9, 'Hooks', 'hooks@gmail.com', 'sha256$XXo0OCgS2JK4MfAM$217e560c485354b9e9e4e020c6bfcc9677215fb3d95ad6a9ac2c28531f704bb1', 1234567895, 'd12a2fe6f88b44f7abbed8ebc5ab4d79.PNG', NULL, NULL),
	(10, 'Alejandro', 'alejandro@gmail.com', 'sha256$EIPK7muIHydDBUKP$e02ec0a81bb0c286eaa72f3fa7c130f62dd7cd73ed0486727c116943ff5dabe5', 1234569875, '91fd8d77c64e4399bd7930cdd47139d0.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
