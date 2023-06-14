-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-06-2023 a las 21:45:25
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sala_chat`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_chat`
--

CREATE TABLE `tbl_chat` (
  `id_chat` int(11) NOT NULL,
  `mensaje` text DEFAULT NULL,
  `archivo` varchar(100) DEFAULT NULL,
  `file_audio` varchar(100) DEFAULT NULL,
  `fecha_mensaje` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_chat`
--

INSERT INTO `tbl_chat` (`id_chat`, `mensaje`, `archivo`, `file_audio`, `fecha_mensaje`) VALUES
(1, 'sera', NULL, NULL, '2023-06-14 19:05:12'),
(2, 'probando', NULL, NULL, '2023-06-14 19:06:08'),
(3, 'quien', NULL, NULL, '2023-06-14 19:06:15'),
(4, 'ok', NULL, NULL, '2023-06-14 19:08:41'),
(5, 'hola', NULL, NULL, '2023-06-14 19:08:49'),
(6, 'ok', NULL, NULL, '2023-06-14 19:27:06'),
(7, 'bien', NULL, NULL, '2023-06-14 19:27:14'),
(8, 'eso parece', NULL, NULL, '2023-06-14 19:27:17'),
(9, 'hola mundo', NULL, NULL, '2023-06-14 19:27:26'),
(10, 'gool', NULL, NULL, '2023-06-14 19:31:12'),
(11, '', '089a7386ca484eebae171f6e7ef78bd7.PNG', NULL, '2023-06-14 19:31:20'),
(12, '', '955c8e0598da40a9ae7f72d4973ee9f5.PNG', NULL, '2023-06-14 19:32:37'),
(13, '', '5a3f677350f340fb81e4ae30a8c56dcd.jpg', NULL, '2023-06-14 19:33:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id_user` int(11) NOT NULL,
  `user` varchar(150) DEFAULT NULL,
  `email_user` varchar(60) DEFAULT NULL,
  `pass_user` mediumtext NOT NULL,
  `tlf_user` int(10) DEFAULT NULL,
  `foto_user` varchar(100) DEFAULT NULL,
  `decription_user` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_users`
--

INSERT INTO `tbl_users` (`id_user`, `user`, `email_user`, `pass_user`, `tlf_user`, `foto_user`, `decription_user`) VALUES
(1, 'URIAN', 'urian@gmail.com', 'sha256$Vy4xdu6RdJwQwtIB$78c6a6f1630f5ba6eee7c281d6a24550baca88e47789452616fd4c1941ef51e8', 1234567896, NULL, NULL),
(2, 'Jose', 'jose@gmail.com', 'sha256$hwaah2qkCWyIJJh3$604be91a2fb0effc0f9e7247c16bdc5fb2e123f6f2c985b124e53b1631ba3cf5', 1236547896, NULL, NULL),
(3, 'Brenda', 'brenda@gmail.com', 'sha256$9iyFWrwuguqHnfvx$4d1f361039f3861948c844a9e5e139045ccd1aba61eb7caac2b6e06d5b601e87', 1234568795, '91489dc03746478ea57a680ee8ce72f1.png', NULL),
(6, 'Angel', 'angel@gmail.com', 'sha256$9iyFWrwuguqHnfvx$4d1f361039f3861948c844a9e5e139045ccd1aba61eb7caac2b6e06d5b601e87', 1234569875, '91489dc03746478ea57a680ee8ce72f1.png', NULL),
(7, 'asas', 'ssss@gmail.com', 'sha256$IZe1u3dLGEMgc6UJ$e55d379b916a217e946879f5c80d37a9a280c2a177d99511a05f0efd2b1770ff', 1236547895, 'f9228a14a2c94383ad0a9011e9ed2a01.PNG', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_chat`
--
ALTER TABLE `tbl_chat`
  ADD PRIMARY KEY (`id_chat`);

--
-- Indices de la tabla `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_chat`
--
ALTER TABLE `tbl_chat`
  MODIFY `id_chat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
