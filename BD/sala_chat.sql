-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-06-2023 a las 04:02:30
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

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
  `desde_id_user` int(11) DEFAULT NULL,
  `para_id_user` int(11) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `archivo` varchar(100) DEFAULT NULL,
  `file_audio` varchar(100) DEFAULT NULL,
  `fecha_mensaje` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_chat`
--

INSERT INTO `tbl_chat` (`id_chat`, `desde_id_user`, `para_id_user`, `mensaje`, `archivo`, `file_audio`, `fecha_mensaje`) VALUES
(1, NULL, NULL, 'sera', NULL, NULL, '2023-06-14 19:05:12'),
(2, NULL, NULL, 'probando', NULL, NULL, '2023-06-14 19:06:08'),
(3, NULL, NULL, 'quien', NULL, NULL, '2023-06-14 19:06:15'),
(4, NULL, NULL, 'ok', NULL, NULL, '2023-06-14 19:08:41'),
(5, NULL, NULL, 'hola', NULL, NULL, '2023-06-14 19:08:49'),
(6, NULL, NULL, 'ok', NULL, NULL, '2023-06-14 19:27:06'),
(7, NULL, NULL, 'bien', NULL, NULL, '2023-06-14 19:27:14'),
(8, NULL, NULL, 'eso parece', NULL, NULL, '2023-06-14 19:27:17'),
(9, NULL, NULL, 'hola mundo', NULL, NULL, '2023-06-14 19:27:26'),
(10, NULL, NULL, 'gool', NULL, NULL, '2023-06-14 19:31:12'),
(11, NULL, NULL, '', '089a7386ca484eebae171f6e7ef78bd7.PNG', NULL, '2023-06-14 19:31:20'),
(12, NULL, NULL, '', '955c8e0598da40a9ae7f72d4973ee9f5.PNG', NULL, '2023-06-14 19:32:37'),
(13, NULL, NULL, '', '5a3f677350f340fb81e4ae30a8c56dcd.jpg', NULL, '2023-06-14 19:33:44'),
(14, NULL, NULL, 'hola', NULL, NULL, '2023-06-17 21:12:54'),
(15, NULL, NULL, 'que paso', NULL, NULL, '2023-06-17 21:13:08'),
(16, NULL, NULL, 'hola gente', NULL, NULL, '2023-06-17 23:56:16'),
(17, NULL, NULL, 'quien eres', NULL, NULL, '2023-06-17 23:56:26'),
(18, NULL, NULL, 'sera', NULL, NULL, '2023-06-17 23:56:35'),
(19, NULL, NULL, 'hello', NULL, NULL, '2023-06-18 01:57:59'),
(20, NULL, NULL, 'Estod esta quedando cada vez Genial..!', NULL, NULL, '2023-06-18 01:58:22'),
(21, NULL, NULL, NULL, NULL, 'ec4370080edb48b49ad09df2c537a41c.webm', '2023-06-27 23:41:28'),
(22, NULL, NULL, 'hola viejo', NULL, NULL, '2023-06-28 02:20:15'),
(23, NULL, NULL, 'hola', NULL, NULL, '2023-06-28 02:20:28'),
(24, NULL, NULL, 'hi', NULL, NULL, '2023-06-28 02:20:47'),
(25, NULL, NULL, 'probando', NULL, NULL, '2023-06-28 02:26:59'),
(26, NULL, NULL, 'Brendaaa', NULL, NULL, '2023-06-28 02:30:48'),
(27, NULL, NULL, 'fo', NULL, NULL, '2023-06-28 02:31:41'),
(28, NULL, NULL, 'sera', NULL, NULL, '2023-06-28 02:32:03'),
(29, NULL, NULL, 'ak', NULL, NULL, '2023-06-28 02:33:41'),
(30, NULL, NULL, 's', NULL, NULL, '2023-06-28 02:34:11'),
(31, NULL, NULL, 'quien', NULL, NULL, '2023-06-28 02:36:18'),
(32, 3, NULL, 'rapido la vi le', NULL, NULL, '2023-06-28 02:38:30'),
(33, 3, NULL, 'aaa', NULL, NULL, '2023-06-28 02:38:52'),
(34, 3, NULL, 'k', NULL, NULL, '2023-06-28 02:53:20'),
(35, 3, NULL, 'o', NULL, NULL, '2023-06-28 02:53:31'),
(36, 3, NULL, 'p', NULL, NULL, '2023-06-28 02:53:42'),
(37, 3, NULL, 'll', NULL, NULL, '2023-06-28 02:53:54'),
(38, 3, NULL, 'l', NULL, NULL, '2023-06-28 02:54:41'),
(39, 3, NULL, 'wewqeqweqwe', NULL, NULL, '2023-06-28 02:54:49'),
(40, 3, NULL, 'r', NULL, NULL, '2023-06-28 02:54:53'),
(41, 3, NULL, 'rewrwrwerewrewr', NULL, NULL, '2023-06-28 02:54:57'),
(42, 3, NULL, 'ewqewqewqe', NULL, NULL, '2023-06-28 02:55:12'),
(43, 3, NULL, 'sdasdasdsadasd', NULL, NULL, '2023-06-28 02:57:20'),
(44, 3, NULL, 'hola', NULL, NULL, '2023-06-29 00:36:43'),
(45, 3, NULL, 'dfsdfsdff', NULL, NULL, '2023-06-29 00:36:52'),
(46, 3, NULL, 'hola', NULL, NULL, '2023-06-29 00:42:01'),
(47, 3, NULL, 'eqwewwewe', NULL, NULL, '2023-06-29 00:42:10'),
(48, 3, NULL, 'hola', NULL, NULL, '2023-06-29 00:43:32'),
(49, 3, NULL, 'trtrtertert', NULL, NULL, '2023-06-29 00:43:55'),
(50, 3, NULL, 'gdfgg', NULL, NULL, '2023-06-29 01:12:50'),
(51, 3, NULL, 'u', NULL, NULL, '2023-06-29 01:17:08'),
(52, 3, NULL, 'hola', NULL, NULL, '2023-06-29 01:19:35'),
(53, 3, NULL, '', NULL, NULL, '2023-06-29 01:21:40'),
(54, 3, NULL, '', NULL, NULL, '2023-06-29 01:24:05'),
(55, 3, NULL, 'hfghfgh', NULL, NULL, '2023-06-29 01:31:52'),
(56, 3, NULL, 'hgfhfghfg', NULL, NULL, '2023-06-29 01:32:22'),
(57, 3, NULL, 'dfdtdftdf', NULL, NULL, '2023-06-29 01:33:44'),
(58, 3, NULL, 'erwerwer', NULL, NULL, '2023-06-29 01:35:51'),
(59, 3, NULL, 'erwerwer', NULL, NULL, '2023-06-29 01:35:57'),
(60, 3, NULL, 'hdfhd', NULL, NULL, '2023-06-29 01:39:38'),
(61, 3, NULL, '', NULL, NULL, '2023-06-29 01:44:05');

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
  `decription_user` mediumtext DEFAULT NULL,
  `online` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_users`
--

INSERT INTO `tbl_users` (`id_user`, `user`, `email_user`, `pass_user`, `tlf_user`, `foto_user`, `decription_user`, `online`) VALUES
(1, 'URIAN', 'urian@gmail.com', 'sha256$Vy4xdu6RdJwQwtIB$78c6a6f1630f5ba6eee7c281d6a24550baca88e47789452616fd4c1941ef51e8', 1234567896, '1.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 1),
(2, 'Jose', 'jose@gmail.com', 'sha256$hwaah2qkCWyIJJh3$604be91a2fb0effc0f9e7247c16bdc5fb2e123f6f2c985b124e53b1631ba3cf5', 1236547896, '2.jpg', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 0),
(3, 'Brenda', 'brenda@gmail.com', 'sha256$9iyFWrwuguqHnfvx$4d1f361039f3861948c844a9e5e139045ccd1aba61eb7caac2b6e06d5b601e87', 1234568795, '91489dc03746478ea57a680ee8ce72f1.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 1),
(6, 'Angel', 'angel@gmail.com', 'sha256$9iyFWrwuguqHnfvx$4d1f361039f3861948c844a9e5e139045ccd1aba61eb7caac2b6e06d5b601e87', 1234569875, '3.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 0),
(7, 'asas', 'ssss@gmail.com', 'sha256$IZe1u3dLGEMgc6UJ$e55d379b916a217e946879f5c80d37a9a280c2a177d99511a05f0efd2b1770ff', 1236547895, '4.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', 1),
(9, 'Hooks', 'hooks@gmail.com', 'sha256$XXo0OCgS2JK4MfAM$217e560c485354b9e9e4e020c6bfcc9677215fb3d95ad6a9ac2c28531f704bb1', 1234567895, 'd12a2fe6f88b44f7abbed8ebc5ab4d79.PNG', NULL, NULL),
(10, 'Alejandro', 'alejandro@gmail.com', 'sha256$EIPK7muIHydDBUKP$e02ec0a81bb0c286eaa72f3fa7c130f62dd7cd73ed0486727c116943ff5dabe5', 1234569875, '91fd8d77c64e4399bd7930cdd47139d0.png', 'Lorem ipsum es el texto que se usa habitualmente en diseño gráfico en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final', NULL);

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
  MODIFY `id_chat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
