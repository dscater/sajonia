-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 09-09-2024 a las 20:36:36
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sajonia_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `estado_cliente` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVO',
  `fecha_estado` date DEFAULT NULL,
  `fechan` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `user_id`, `estado_cliente`, `fecha_estado`, `fechan`, `created_at`, `updated_at`) VALUES
(1, 4, 'DISPENSA', '2024-09-07', '2025-03-07', '2024-09-06 19:40:09', '2024-09-07 20:55:00'),
(2, 5, 'ACTIVO', NULL, NULL, '2024-09-09 23:26:13', '2024-09-09 23:26:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ciudad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `web` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `ciudad`, `dir`, `fono`, `correo`, `web`, `actividad`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'SAJONIA', 'SJ', 'SAJONIA S.A.', 'LA PAZ', 'ZONA LOS OLIVOS', '77777777', 'SAJONIA@GMAIL.COM', 'SAJONIA.COM', 'ACTIVIDAD', '1725897866_1.jpg', NULL, '2024-09-09 20:04:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: SUPERVISOR<br/>foto: 1725380981_JPERES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 16:29:41<br/>', NULL, 'USUARIOS', '2024-09-03', '16:29:41', '2024-09-03 20:29:41', '2024-09-03 20:29:41'),
(2, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 3<br/>usuario: EPAREDES<br/>nombre: EDUARDO<br/>paterno: PAREDES<br/>materno: <br/>ci: 2222<br/>ci_exp: LP<br/>dir: LOS PEDREGALES<br/>email: <br/>fono: 66666666<br/>password: $2y$12$szDkh9OhxlYZlsMEIzhktuML1W0QBdiu4ADBRIX5PIs30L6Z2zhHa<br/>tipo: AGENTE INMOBILIARIO<br/>foto: <br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 17:29:23<br/>updated_at: 2024-09-03 17:29:23<br/>', NULL, 'USUARIOS', '2024-09-03', '17:29:23', '2024-09-03 21:29:23', '2024-09-03 21:29:23'),
(3, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 4<br/>usuario: MPAREDES<br/>nombre: MARIA<br/>paterno: PAREDES<br/>materno: <br/>ci: 3333<br/>ci_exp: LP<br/>dir: ZONA LOS PEDREGALES<br/>email: MARIA@GMAIL.COM<br/>fono: 78787878<br/>password: $2y$12$vsNccOFOJPrFo7ZcgyJtpuRt4/rpj27f3GFu6qYIECyulco2KlFg.<br/>tipo: AGENTE INMOBILIARIO<br/>foto: 1725386133_MPAREDES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 17:55:33<br/>updated_at: 2024-09-03 17:55:33<br/>', NULL, 'USUARIOS', '2024-09-03', '17:55:33', '2024-09-03 21:55:33', '2024-09-03 21:55:33'),
(4, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: SUPERVISOR<br/>foto: 1725380981_JPERES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 16:29:41<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: SUPERVISOR<br/>foto: 1725380981_JPERES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 16:29:41<br/>', 'USUARIOS', '2024-09-03', '18:53:04', '2024-09-03 22:53:04', '2024-09-03 22:53:04'),
(5, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 3<br/>usuario: EPAREDES<br/>nombre: EDUARDO<br/>paterno: PAREDES<br/>materno: <br/>ci: 2222<br/>ci_exp: LP<br/>dir: LOS PEDREGALES<br/>email: <br/>fono: 66666666<br/>password: $2y$12$szDkh9OhxlYZlsMEIzhktuML1W0QBdiu4ADBRIX5PIs30L6Z2zhHa<br/>tipo: AGENTE INMOBILIARIO<br/>foto: <br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 17:29:23<br/>updated_at: 2024-09-03 17:29:23<br/>', 'id: 3<br/>usuario: EPAREDES<br/>nombre: EDUARDO<br/>paterno: PAREDES<br/>materno: <br/>ci: 2222<br/>ci_exp: LP<br/>dir: LOS PEDREGALES<br/>email: <br/>fono: 66666666<br/>password: $2y$12$szDkh9OhxlYZlsMEIzhktuML1W0QBdiu4ADBRIX5PIs30L6Z2zhHa<br/>tipo: AGENTE INMOBILIARIO<br/>foto: <br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 17:29:23<br/>updated_at: 2024-09-03 17:29:23<br/>', 'USUARIOS', '2024-09-03', '18:59:01', '2024-09-03 22:59:01', '2024-09-03 22:59:01'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: SUPERVISOR<br/>foto: 1725380981_JPERES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 16:29:41<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: SUPERVISOR<br/>foto: 1725380981_JPERES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 19:13:10<br/>', 'USUARIOS', '2024-09-03', '19:13:10', '2024-09-03 23:13:10', '2024-09-03 23:13:10'),
(7, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: SUPERVISOR<br/>foto: 1725380981_JPERES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 19:13:10<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: AGENTE INMOBILIARIO<br/>foto: 1725380981_JPERES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 19:13:15<br/>', 'USUARIOS', '2024-09-03', '19:13:15', '2024-09-03 23:13:15', '2024-09-03 23:13:15'),
(8, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: AGENTE INMOBILIARIO<br/>foto: 1725380981_JPERES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 19:13:15<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: AGENTE INMOBILIARIO<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 19:13:51<br/>', 'USUARIOS', '2024-09-03', '19:13:51', '2024-09-03 23:13:51', '2024-09-03 23:13:51'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: AGENTE INMOBILIARIO<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 19:13:51<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: AGENTE INMOBILIARIO<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 21:44:09<br/>', 'USUARIOS', '2024-09-03', '21:44:09', '2024-09-04 01:44:09', '2024-09-04 01:44:09'),
(10, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN USUARIO', 'id: 4<br/>usuario: MPAREDES<br/>nombre: MARIA<br/>paterno: PAREDES<br/>materno: <br/>ci: 3333<br/>ci_exp: LP<br/>dir: ZONA LOS PEDREGALES<br/>email: MARIA@GMAIL.COM<br/>fono: 78787878<br/>password: $2y$12$vsNccOFOJPrFo7ZcgyJtpuRt4/rpj27f3GFu6qYIECyulco2KlFg.<br/>tipo: AGENTE INMOBILIARIO<br/>foto: 1725386133_MPAREDES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 17:55:33<br/>updated_at: 2024-09-03 17:55:33<br/>', NULL, 'USUARIOS', '2024-09-03', '21:47:28', '2024-09-04 01:47:28', '2024-09-04 01:47:28'),
(11, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: AGENTE INMOBILIARIO<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 21:44:09<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: ADMINISTRADOR<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 22:00:25<br/>', 'USUARIOS', '2024-09-03', '22:00:25', '2024-09-04 02:00:25', '2024-09-04 02:00:25'),
(12, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: ADMINISTRADOR<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 22:00:25<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: SUPERVISOR<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 22:00:31<br/>', 'USUARIOS', '2024-09-03', '22:00:31', '2024-09-04 02:00:31', '2024-09-04 02:00:31'),
(13, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN LA CONTRASEÑA DE UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: SUPERVISOR<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 22:00:31<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$qH0EQA9wOUuc4CL2kiaEKOB.XpvzOfOyL6Kd/ivvFckqeC/RNSv9.<br/>tipo: SUPERVISOR<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 23:13:13<br/>', 'USUARIOS', '2024-09-03', '23:13:13', '2024-09-04 03:13:13', '2024-09-04 03:13:13'),
(14, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN LA CONTRASEÑA DE UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$qH0EQA9wOUuc4CL2kiaEKOB.XpvzOfOyL6Kd/ivvFckqeC/RNSv9.<br/>tipo: SUPERVISOR<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 23:13:13<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$1SJUHEJR/bkiKdRy37Z6kuNmIX0lHcj1uv06N47WxysFRUBrCSVnC<br/>tipo: SUPERVISOR<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 23:13:29<br/>', 'USUARIOS', '2024-09-03', '23:13:29', '2024-09-04 03:13:29', '2024-09-04 03:13:29'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 3<br/>nombre: URBANIZACION #1<br/>descripcion: DESC. URB. 1<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 00:01:54<br/>updated_at: 2024-09-04 00:01:54<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '00:01:54', '2024-09-04 04:01:54', '2024-09-04 04:01:54'),
(16, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA URBANIZACIÓN', 'id: 3<br/>nombre: URBANIZACION #1<br/>descripcion: DESC. URB. 1<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 00:01:54<br/>updated_at: 2024-09-04 00:01:54<br/>', 'id: 3<br/>nombre: URBANIZACION #1ASD<br/>descripcion: DESC. URB. 1<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 00:01:54<br/>updated_at: 2024-09-04 00:02:08<br/>', 'URBANIZACIÓN', '2024-09-04', '00:02:08', '2024-09-04 04:02:08', '2024-09-04 04:02:08'),
(17, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA URBANIZACIÓN', 'id: 3<br/>nombre: URBANIZACION #1ASD<br/>descripcion: DESC. URB. 1<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 00:01:54<br/>updated_at: 2024-09-04 00:02:08<br/>', 'id: 3<br/>nombre: URBANIZACION #1ASD<br/>descripcion: DESC. URB. 1E<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 00:01:54<br/>updated_at: 2024-09-04 00:02:13<br/>', 'URBANIZACIÓN', '2024-09-04', '00:02:13', '2024-09-04 04:02:13', '2024-09-04 04:02:13'),
(18, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA URBANIZACIÓN', 'id: 3<br/>nombre: URBANIZACION #1ASD<br/>descripcion: DESC. URB. 1E<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 00:01:54<br/>updated_at: 2024-09-04 00:02:13<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '00:02:40', '2024-09-04 04:02:40', '2024-09-04 04:02:40'),
(19, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 1<br/>nombre: URBANIZACION #1<br/>descripcion: DESC. URB. 1<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 00:02:54<br/>updated_at: 2024-09-04 00:02:54<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '00:02:54', '2024-09-04 04:02:54', '2024-09-04 04:02:54'),
(20, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 2<br/>nombre: U2<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:10<br/>updated_at: 2024-09-04 12:02:10<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:10', '2024-09-04 16:02:10', '2024-09-04 16:02:10'),
(21, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 3<br/>nombre: U3<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:15<br/>updated_at: 2024-09-04 12:02:15<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:15', '2024-09-04 16:02:15', '2024-09-04 16:02:15'),
(22, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 4<br/>nombre: U4<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:19<br/>updated_at: 2024-09-04 12:02:19<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:19', '2024-09-04 16:02:19', '2024-09-04 16:02:19'),
(23, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 5<br/>nombre: 5<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:23<br/>updated_at: 2024-09-04 12:02:23<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:23', '2024-09-04 16:02:23', '2024-09-04 16:02:23'),
(24, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 6<br/>nombre: 6<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:26<br/>updated_at: 2024-09-04 12:02:26<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:26', '2024-09-04 16:02:26', '2024-09-04 16:02:26'),
(25, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 7<br/>nombre: 7<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:30<br/>updated_at: 2024-09-04 12:02:30<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:30', '2024-09-04 16:02:30', '2024-09-04 16:02:30'),
(26, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 8<br/>nombre: 8<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:34<br/>updated_at: 2024-09-04 12:02:34<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:34', '2024-09-04 16:02:34', '2024-09-04 16:02:34'),
(27, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 9<br/>nombre: 9<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:37<br/>updated_at: 2024-09-04 12:02:37<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:37', '2024-09-04 16:02:37', '2024-09-04 16:02:37'),
(28, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 10<br/>nombre: 10<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:42<br/>updated_at: 2024-09-04 12:02:42<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:42', '2024-09-04 16:02:42', '2024-09-04 16:02:42'),
(29, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 11<br/>nombre: 11<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:44<br/>updated_at: 2024-09-04 12:02:44<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:44', '2024-09-04 16:02:44', '2024-09-04 16:02:44'),
(30, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA URBANIZACIÓN', 'id: 12<br/>nombre: 12<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:47<br/>updated_at: 2024-09-04 12:02:47<br/>', NULL, 'URBANIZACIÓN', '2024-09-04', '12:02:47', '2024-09-04 16:02:47', '2024-09-04 16:02:47'),
(31, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MANZANO', 'id: 1<br/>urbanizacion_id: 1<br/>nombre: MANZANO #1<br/>descripcion: DESC. 1<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:19:27<br/>updated_at: 2024-09-04 12:19:27<br/>', NULL, 'MANZANOS', '2024-09-04', '12:19:27', '2024-09-04 16:19:27', '2024-09-04 16:19:27'),
(32, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN MANZANO', 'id: 1<br/>urbanizacion_id: 1<br/>nombre: MANZANO #1<br/>descripcion: DESC. 1<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:19:27<br/>updated_at: 2024-09-04 12:19:27<br/>', 'id: 1<br/>urbanizacion_id: 2<br/>nombre: MANZANO #1ASD<br/>descripcion: DESC. 1ASD<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:19:27<br/>updated_at: 2024-09-04 12:19:42<br/>', 'MANZANOS', '2024-09-04', '12:19:42', '2024-09-04 16:19:42', '2024-09-04 16:19:42'),
(33, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN MANZANO', 'id: 1<br/>urbanizacion_id: 2<br/>nombre: MANZANO #1ASD<br/>descripcion: DESC. 1ASD<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:19:27<br/>updated_at: 2024-09-04 12:19:42<br/>', NULL, 'MANZANOS', '2024-09-04', '12:19:59', '2024-09-04 16:19:59', '2024-09-04 16:19:59'),
(34, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA URBANIZACIÓN', 'id: 2<br/>nombre: U2<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:10<br/>updated_at: 2024-09-04 12:02:10<br/>', 'id: 2<br/>nombre: URBANIZACION #2<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:02:10<br/>updated_at: 2024-09-04 12:20:40<br/>', 'URBANIZACIÓN', '2024-09-04', '12:20:40', '2024-09-04 16:20:40', '2024-09-04 16:20:40'),
(35, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MANZANO', 'id: 1<br/>urbanizacion_id: 1<br/>nombre: MANZANO #1<br/>descripcion: DESC. 1<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:20:53<br/>updated_at: 2024-09-04 12:20:53<br/>', NULL, 'MANZANOS', '2024-09-04', '12:20:53', '2024-09-04 16:20:53', '2024-09-04 16:20:53'),
(36, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MANZANO', 'id: 2<br/>urbanizacion_id: 1<br/>nombre: MANZANO #2<br/>descripcion: <br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:37:02<br/>updated_at: 2024-09-04 12:37:02<br/>', NULL, 'MANZANOS', '2024-09-04', '12:37:02', '2024-09-04 16:37:02', '2024-09-04 16:37:02'),
(37, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN LOTE', 'id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>nombre: LOTE #1<br/>ubicacion: PARTE ESPECIAL<br/>esquina: PARTE ESPECIAL<br/>esquina_area: FRENTE ÁREA VERDE<br/>esquina_equipamiento: NINGUNO<br/>avenida_estr: NINGUNO<br/>avenida_union: NINGUNO<br/>superficie: 300M2<br/>costo_contado: 10000<br/>costo_credito: 12000<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:49:05<br/>updated_at: 2024-09-04 12:49:05<br/>', NULL, 'LOTES', '2024-09-04', '12:49:05', '2024-09-04 16:49:05', '2024-09-04 16:49:05'),
(38, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN LOTE', 'id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>nombre: LOTE #1<br/>ubicacion: PARTE ESPECIAL<br/>esquina: PARTE ESPECIAL<br/>esquina_area: FRENTE ÁREA VERDE<br/>esquina_equipamiento: NINGUNO<br/>avenida_estr: NINGUNO<br/>avenida_union: NINGUNO<br/>superficie: 300M2<br/>costo_contado: 10000.00<br/>costo_credito: 12000.00<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:49:05<br/>updated_at: 2024-09-04 12:49:05<br/>', 'id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>nombre: LOTE #1<br/>ubicacion: PARTE ESPECIAL<br/>esquina: PARTE ESPECIAL<br/>esquina_area: FRENTE ÁREA VERDE<br/>esquina_equipamiento: NINGUNO<br/>avenida_estr: NINGUNO<br/>avenida_union: NINGUNO<br/>superficie: 300 M2<br/>costo_contado: 10000.00<br/>costo_credito: 12000.00<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:49:05<br/>updated_at: 2024-09-04 12:49:35<br/>', 'LOTES', '2024-09-04', '12:49:35', '2024-09-04 16:49:35', '2024-09-04 16:49:35'),
(39, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN LOTE', 'id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>nombre: LOTE #1<br/>ubicacion: PARTE ESPECIAL<br/>esquina: PARTE ESPECIAL<br/>esquina_area: FRENTE ÁREA VERDE<br/>esquina_equipamiento: NINGUNO<br/>avenida_estr: NINGUNO<br/>avenida_union: NINGUNO<br/>superficie: 300 M2<br/>costo_contado: 10000.00<br/>costo_credito: 12000.00<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:49:05<br/>updated_at: 2024-09-04 12:49:35<br/>', NULL, 'LOTES', '2024-09-04', '12:49:46', '2024-09-04 16:49:46', '2024-09-04 16:49:46'),
(40, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN LOTE', 'id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>nombre: LOTE #1<br/>ubicacion: PARTE ESPECIAL<br/>esquina: PARTE BAJA<br/>esquina_area: FRENTE ÁREA VERDE<br/>esquina_equipamiento: NINGUNO<br/>avenida_estr: NINGUNO<br/>avenida_union: NINGUNO<br/>superficie: 300 M2<br/>costo_contado: 10000<br/>costo_credito: 12000<br/>fecha_registro: 2024-09-04<br/>created_at: 2024-09-04 12:50:21<br/>updated_at: 2024-09-04 12:50:21<br/>', NULL, 'LOTES', '2024-09-04', '12:50:21', '2024-09-04 16:50:21', '2024-09-04 16:50:21'),
(41, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN LOTE', 'id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>nombre: LOTE #2<br/>ubicacion: PARTE MEDIA<br/>esquina: PARTE MEDIA<br/>esquina_area: NINGUNO<br/>esquina_equipamiento: NINGUNO<br/>avenida_estr: NINGUNO<br/>avenida_union: NINGUNO<br/>superficie: 6000 M2<br/>costo_contado: 8000<br/>costo_credito: 4000<br/>fecha_registro: 2024-09-05<br/>created_at: 2024-09-05 22:59:00<br/>updated_at: 2024-09-05 22:59:00<br/>', NULL, 'LOTES', '2024-09-05', '22:59:01', '2024-09-06 02:59:01', '2024-09-06 02:59:01'),
(42, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA PLANILLA DE CUOTA', 'id: 1<br/>lote_id: 1<br/>plazo: 6<br/>descripcion: DESC PLANILLA 1<br/>fecha_registro: 2024-09-05<br/>created_at: 2024-09-05 23:09:45<br/>updated_at: 2024-09-05 23:09:45<br/>', NULL, 'PLANILLA DE CUOTAS', '2024-09-05', '23:09:45', '2024-09-06 03:09:45', '2024-09-06 03:09:45'),
(43, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA PLANILLA DE CUOTA', 'id: 1<br/>lote_id: 1<br/>plazo: 6<br/>descripcion: DESC PLANILLA 1<br/>fecha_registro: 2024-09-05<br/>created_at: 2024-09-05 23:09:45<br/>updated_at: 2024-09-05 23:09:45<br/>', 'id: 1<br/>lote_id: 1<br/>plazo: 8<br/>descripcion: DESC PLANILLA 1<br/>fecha_registro: 2024-09-05<br/>created_at: 2024-09-05 23:09:45<br/>updated_at: 2024-09-05 23:11:44<br/>', 'PLANILLA DE CUOTAS', '2024-09-05', '23:11:44', '2024-09-06 03:11:44', '2024-09-06 03:11:44'),
(44, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA PLANILLA DE CUOTA', 'id: 1<br/>lote_id: 1<br/>plazo: 8<br/>descripcion: DESC PLANILLA 1<br/>fecha_registro: 2024-09-05<br/>created_at: 2024-09-05 23:09:45<br/>updated_at: 2024-09-05 23:11:44<br/>', NULL, 'PLANILLA DE CUOTAS', '2024-09-05', '23:12:16', '2024-09-06 03:12:16', '2024-09-06 03:12:16'),
(45, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA PLANILLA DE CUOTA', 'id: 2<br/>lote_id: 1<br/>plazo: 8<br/>descripcion: DESC. PLANILLA 1<br/>fecha_registro: 2024-09-05<br/>created_at: 2024-09-05 23:13:24<br/>updated_at: 2024-09-05 23:13:24<br/>', NULL, 'PLANILLA DE CUOTAS', '2024-09-05', '23:13:24', '2024-09-06 03:13:24', '2024-09-06 03:13:24'),
(46, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA PLANILLA DE CUOTA', 'id: 2<br/>lote_id: 1<br/>plazo: 8<br/>descripcion: DESC. PLANILLA 1<br/>fecha_registro: 2024-09-05<br/>created_at: 2024-09-05 23:13:24<br/>updated_at: 2024-09-05 23:13:24<br/>', NULL, 'PLANILLA DE CUOTAS', '2024-09-05', '23:13:32', '2024-09-06 03:13:32', '2024-09-06 03:13:32'),
(47, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA PLANILLA DE CUOTA', 'id: 1<br/>lote_id: 1<br/>plazo: 8<br/>descripcion: DESC. PLANILLA #1<br/>fecha_registro: 2024-09-05<br/>created_at: 2024-09-05 23:13:48<br/>updated_at: 2024-09-05 23:13:48<br/>', NULL, 'PLANILLA DE CUOTAS', '2024-09-05', '23:13:48', '2024-09-06 03:13:48', '2024-09-06 03:13:48'),
(48, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA PLANILLA DE CUOTA', 'id: 2<br/>lote_id: 2<br/>plazo: 7<br/>descripcion: <br/>fecha_registro: 2024-09-05<br/>created_at: 2024-09-05 23:13:58<br/>updated_at: 2024-09-05 23:13:58<br/>', NULL, 'PLANILLA DE CUOTAS', '2024-09-05', '23:13:58', '2024-09-06 03:13:58', '2024-09-06 03:13:58'),
(49, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'id: 4<br/>usuario: MPAREDES<br/>nombre: MARCOS<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 54444<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 78787878<br/>password: $2y$12$ioQYtHbdxm8I6WFRfwczyOHUY2Rw6oz30oVVdweXTVvrwI5uSkDrO<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:25:59<br/>updated_at: 2024-09-06 15:25:59<br/>', NULL, 'CLIENTES', '2024-09-06', '15:25:59', '2024-09-06 19:25:59', '2024-09-06 19:25:59'),
(50, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 4<br/>usuario: MPAREDES<br/>nombre: MARCOS<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 54444<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 78787878<br/>password: $2y$12$ioQYtHbdxm8I6WFRfwczyOHUY2Rw6oz30oVVdweXTVvrwI5uSkDrO<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:25:59<br/>updated_at: 2024-09-06 15:25:59<br/>', 'id: 4<br/>usuario: MPAREDES<br/>nombre: MARCOS<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 54444<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 78787878<br/>password: $2y$12$ioQYtHbdxm8I6WFRfwczyOHUY2Rw6oz30oVVdweXTVvrwI5uSkDrO<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:25:59<br/>updated_at: 2024-09-06 15:25:59<br/>', 'CLIENTES', '2024-09-06', '15:38:13', '2024-09-06 19:38:13', '2024-09-06 19:38:13'),
(51, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 4<br/>usuario: MPAREDES<br/>nombre: MARCOS<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 54444<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 78787878<br/>password: $2y$12$ioQYtHbdxm8I6WFRfwczyOHUY2Rw6oz30oVVdweXTVvrwI5uSkDrO<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:25:59<br/>updated_at: 2024-09-06 15:25:59<br/>', 'id: 4<br/>usuario: MPAREDES<br/>nombre: MARCOS<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 54444<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 78787878<br/>password: $2y$12$ioQYtHbdxm8I6WFRfwczyOHUY2Rw6oz30oVVdweXTVvrwI5uSkDrO<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 0<br/>created_at: 2024-09-06 15:25:59<br/>updated_at: 2024-09-06 15:38:17<br/>', 'CLIENTES', '2024-09-06', '15:38:17', '2024-09-06 19:38:17', '2024-09-06 19:38:17'),
(52, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 4<br/>usuario: MPAREDES<br/>nombre: MARCOS<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 54444<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 78787878<br/>password: $2y$12$ioQYtHbdxm8I6WFRfwczyOHUY2Rw6oz30oVVdweXTVvrwI5uSkDrO<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 0<br/>created_at: 2024-09-06 15:25:59<br/>updated_at: 2024-09-06 15:38:17<br/>', 'id: 4<br/>usuario: MPAREDES<br/>nombre: MARCOS<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 54444<br/>ci_exp: CB<br/>dir: <br/>email: <br/>fono: 78787878<br/>password: $2y$12$ioQYtHbdxm8I6WFRfwczyOHUY2Rw6oz30oVVdweXTVvrwI5uSkDrO<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:25:59<br/>updated_at: 2024-09-06 15:38:23<br/>', 'CLIENTES', '2024-09-06', '15:38:23', '2024-09-06 19:38:23', '2024-09-06 19:38:23'),
(53, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN CLIENTE', 'id: 4<br/>usuario: MPAREDES<br/>nombre: MARCOS<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 54444<br/>ci_exp: CB<br/>dir: <br/>email: <br/>fono: 78787878<br/>password: $2y$12$ioQYtHbdxm8I6WFRfwczyOHUY2Rw6oz30oVVdweXTVvrwI5uSkDrO<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:25:59<br/>updated_at: 2024-09-06 15:38:23<br/>', NULL, 'CLIENTES', '2024-09-06', '15:39:37', '2024-09-06 19:39:37', '2024-09-06 19:39:37'),
(54, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'id: 4<br/>usuario: EGONZALES<br/>nombre: EDUARDO<br/>paterno: GONZALES<br/>materno: PAREDES<br/>ci: 4432<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 76767676<br/>password: $2y$12$42OTS8KZvTnU8oo.V8rsveZBr8GTAPVKvdRdAFRaoG8sjoOXn9t12<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:40:09<br/>updated_at: 2024-09-06 15:40:09<br/>', NULL, 'CLIENTES', '2024-09-06', '15:40:09', '2024-09-06 19:40:09', '2024-09-06 19:40:09'),
(55, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN LA CONTRASEÑA DE UN USUARIO', 'id: 4<br/>usuario: EGONZALES<br/>nombre: EDUARDO<br/>paterno: GONZALES<br/>materno: PAREDES<br/>ci: 4432<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 76767676<br/>password: $2y$12$42OTS8KZvTnU8oo.V8rsveZBr8GTAPVKvdRdAFRaoG8sjoOXn9t12<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:40:09<br/>updated_at: 2024-09-06 15:40:09<br/>', 'id: 4<br/>usuario: EGONZALES<br/>nombre: EDUARDO<br/>paterno: GONZALES<br/>materno: PAREDES<br/>ci: 4432<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 76767676<br/>password: $2y$12$vrWsViHHfQ52OQ1xVNV..utUwM0XJj5day4xLw4Pra64RyjAbCPDa<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:40:09<br/>updated_at: 2024-09-06 15:43:23<br/>', 'USUARIOS', '2024-09-06', '15:43:23', '2024-09-06 19:43:23', '2024-09-06 19:43:23'),
(56, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 1<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 1<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 12000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-06<br/>created_at: 2024-09-06 17:17:07<br/>updated_at: 2024-09-06 17:17:08<br/>', NULL, 'VENTA DE LOTES', '2024-09-06', '17:17:08', '2024-09-06 21:17:08', '2024-09-06 21:17:08'),
(57, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 1<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 1<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 12000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-06<br/>created_at: 2024-09-06 17:17:07<br/>updated_at: 2024-09-06 17:17:08<br/>', 'id: 1<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 1<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 10000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CONTADO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-06<br/>created_at: 2024-09-06 17:17:07<br/>updated_at: 2024-09-06 17:40:17<br/>', 'VENTA DE LOTES', '2024-09-06', '17:40:17', '2024-09-06 21:40:17', '2024-09-06 21:40:17'),
(58, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 1<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 1<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 10000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CONTADO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-06<br/>created_at: 2024-09-06 17:17:07<br/>updated_at: 2024-09-06 17:40:17<br/>', 'id: 1<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 1<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 12000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-06<br/>created_at: 2024-09-06 17:17:07<br/>updated_at: 2024-09-06 17:40:30<br/>', 'VENTA DE LOTES', '2024-09-06', '17:40:30', '2024-09-06 21:40:30', '2024-09-06 21:40:30'),
(59, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 4<br/>usuario: EGONZALES<br/>nombre: EDUARDO<br/>paterno: GONZALES<br/>materno: PAREDES<br/>ci: 4432<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 76767676<br/>password: $2y$12$FTckeBbcsLg3dJWv34dOIOSjEp.mMt.Ek5kUFZF/ReU1iXMXrKc0W<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:40:09<br/>updated_at: 2024-09-06 15:44:55<br/>', 'id: 4<br/>usuario: EGONZALES<br/>nombre: EDUARDO<br/>paterno: GONZALES<br/>materno: PAREDES<br/>ci: 4432<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 76767676<br/>password: $2y$12$FTckeBbcsLg3dJWv34dOIOSjEp.mMt.Ek5kUFZF/ReU1iXMXrKc0W<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:40:09<br/>updated_at: 2024-09-06 15:44:55<br/>', 'CLIENTES', '2024-09-07', '16:55:00', '2024-09-07 20:55:00', '2024-09-07 20:55:00'),
(60, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'id: 4<br/>usuario: EGONZALES<br/>nombre: EDUARDO<br/>paterno: GONZALES<br/>materno: PAREDES<br/>ci: 4432<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 76767676<br/>password: $2y$12$FTckeBbcsLg3dJWv34dOIOSjEp.mMt.Ek5kUFZF/ReU1iXMXrKc0W<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:40:09<br/>updated_at: 2024-09-06 15:44:55<br/>', 'id: 4<br/>usuario: EGONZALES<br/>nombre: EDUARDO<br/>paterno: GONZALES<br/>materno: PAREDES<br/>ci: 4432<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 76767676<br/>password: $2y$12$FTckeBbcsLg3dJWv34dOIOSjEp.mMt.Ek5kUFZF/ReU1iXMXrKc0W<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-06<br/>acceso: 1<br/>created_at: 2024-09-06 15:40:09<br/>updated_at: 2024-09-06 15:44:55<br/>', 'CLIENTES', '2024-09-07', '16:55:41', '2024-09-07 20:55:41', '2024-09-07 20:55:41'),
(61, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PAGO', 'id: 1<br/>user_id: 1<br/>cliente_id: 1<br/>venta_lote_id: 1<br/>nro_cuotas: 3<br/>cuota: 1500.00<br/>total_cuota: 4500.00<br/>descripcion: DESC. PAGO<br/>fecha_pago: 2024-09-09<br/>fecha_registro: 2024-09-09<br/>created_at: 2024-09-09 15:21:03<br/>updated_at: 2024-09-09 15:21:03<br/>', NULL, 'PAGOS', '2024-09-09', '15:21:03', '2024-09-09 19:21:03', '2024-09-09 19:21:03'),
(62, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN PAGO', 'id: 1<br/>user_id: 1<br/>cliente_id: 1<br/>venta_lote_id: 1<br/>nro_cuotas: 3<br/>cuota: 1500.00<br/>total_cuota: 4500.00<br/>descripcion: DESC. PAGO<br/>fecha_pago: 2024-09-09<br/>fecha_registro: 2024-09-09<br/>created_at: 2024-09-09 15:21:03<br/>updated_at: 2024-09-09 15:21:03<br/>', NULL, 'PAGOS', '2024-09-09', '15:33:06', '2024-09-09 19:33:06', '2024-09-09 19:33:06'),
(63, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PAGO', 'id: 1<br/>user_id: 1<br/>cliente_id: 1<br/>venta_lote_id: 1<br/>nro_cuotas: 2<br/>cuota: 1500.00<br/>total_cuota: 3000.00<br/>descripcion: DESC. PAGO<br/>fecha_pago: 2024-09-09<br/>fecha_registro: 2024-09-09<br/>created_at: 2024-09-09 15:33:29<br/>updated_at: 2024-09-09 15:33:29<br/>', NULL, 'PAGOS', '2024-09-09', '15:33:29', '2024-09-09 19:33:29', '2024-09-09 19:33:29'),
(64, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'id: 5<br/>usuario: JGOMEZ<br/>nombre: JUAN<br/>paterno: GOMEZ<br/>materno: GOMEZ<br/>ci: 3333<br/>ci_exp: CB<br/>dir: <br/>email: <br/>fono: 76766767<br/>password: $2y$12$vMBL.p0c04i0GXgi/KoKRu8QnCzusvtAFNgIQbvCdf/ctr/P5QvXu<br/>tipo: CLIENTE<br/>foto: <br/>fecha_registro: 2024-09-09<br/>acceso: 1<br/>created_at: 2024-09-09 19:26:13<br/>updated_at: 2024-09-09 19:26:13<br/>', NULL, 'CLIENTES', '2024-09-09', '19:26:14', '2024-09-09 23:26:14', '2024-09-09 23:26:14'),
(65, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: FINALIZADO<br/>estudios_com: FINALIZADO<br/>minuta: FINALIZADO<br/>titulacion: FINALIZADO<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:29:16<br/>updated_at: 2024-09-09 19:29:16<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:29:16', '2024-09-09 23:29:16', '2024-09-09 23:29:16'),
(66, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: FINALIZADO<br/>estudios_com: FINALIZADO<br/>minuta: FINALIZADO<br/>titulacion: FINALIZADO<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:29:16<br/>updated_at: 2024-09-09 19:29:16<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:30:56', '2024-09-09 23:30:56', '2024-09-09 23:30:56'),
(67, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 3<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: FINALIZADO<br/>estudios_com: FINALIZADO<br/>minuta: FINALIZADO<br/>titulacion: FINALIZADO<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:31:15<br/>updated_at: 2024-09-09 19:31:15<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:31:15', '2024-09-09 23:31:15', '2024-09-09 23:31:15'),
(68, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 3<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: FINALIZADO<br/>estudios_com: FINALIZADO<br/>minuta: FINALIZADO<br/>titulacion: FINALIZADO<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:31:15<br/>updated_at: 2024-09-09 19:31:15<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:32:07', '2024-09-09 23:32:07', '2024-09-09 23:32:07'),
(69, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 4<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:32:22<br/>updated_at: 2024-09-09 19:32:22<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:32:22', '2024-09-09 23:32:22', '2024-09-09 23:32:22'),
(70, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 4<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:32:22<br/>updated_at: 2024-09-09 19:32:22<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:33:16', '2024-09-09 23:33:16', '2024-09-09 23:33:16'),
(71, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 5<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: EN PROCESO<br/>minuta: EN PROCESO<br/>titulacion: EN PROCESO<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:33:37<br/>updated_at: 2024-09-09 19:33:37<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:33:37', '2024-09-09 23:33:37', '2024-09-09 23:33:37'),
(72, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 5<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: EN PROCESO<br/>minuta: EN PROCESO<br/>titulacion: EN PROCESO<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:33:37<br/>updated_at: 2024-09-09 19:33:37<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:34:13', '2024-09-09 23:34:13', '2024-09-09 23:34:13'),
(73, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 6<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:34:33<br/>updated_at: 2024-09-09 19:34:33<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:34:33', '2024-09-09 23:34:33', '2024-09-09 23:34:33'),
(74, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 6<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:34:33<br/>updated_at: 2024-09-09 19:34:33<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:35:26', '2024-09-09 23:35:26', '2024-09-09 23:35:26'),
(75, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:35:51<br/>updated_at: 2024-09-09 19:35:51<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:35:51', '2024-09-09 23:35:51', '2024-09-09 23:35:51'),
(76, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:35:51<br/>updated_at: 2024-09-09 19:35:51<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:35:51<br/>updated_at: 2024-09-09 19:38:24<br/>', 'VENTA DE LOTES', '2024-09-09', '19:38:24', '2024-09-09 23:38:24', '2024-09-09 23:38:24'),
(77, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: CANCELADO<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:35:51<br/>updated_at: 2024-09-09 19:41:08<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:41:45', '2024-09-09 23:41:45', '2024-09-09 23:41:45'),
(78, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 3<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-10<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:42:06<br/>updated_at: 2024-09-09 19:42:06<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:42:06', '2024-09-09 23:42:06', '2024-09-09 23:42:06'),
(79, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 3<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-10<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:42:06<br/>updated_at: 2024-09-09 19:42:06<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:48:08', '2024-09-09 23:48:08', '2024-09-09 23:48:08'),
(80, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 4<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-10<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:48:23<br/>updated_at: 2024-09-09 19:48:23<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:48:23', '2024-09-09 23:48:23', '2024-09-09 23:48:23'),
(81, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 4<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-10<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:48:23<br/>updated_at: 2024-09-09 19:48:23<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:50:25', '2024-09-09 23:50:25', '2024-09-09 23:50:25');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(82, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 5<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:50:42<br/>updated_at: 2024-09-09 19:50:42<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:50:42', '2024-09-09 23:50:42', '2024-09-09 23:50:42'),
(83, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 5<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:50:42<br/>updated_at: 2024-09-09 19:50:42<br/>', 'id: 5<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:50:42<br/>updated_at: 2024-09-09 19:50:55<br/>', 'VENTA DE LOTES', '2024-09-09', '19:50:55', '2024-09-09 23:50:55', '2024-09-09 23:50:55'),
(84, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 5<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: CANCELADO<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:50:42<br/>updated_at: 2024-09-09 19:50:55<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:51:36', '2024-09-09 23:51:36', '2024-09-09 23:51:36'),
(85, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 6<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:51:51<br/>updated_at: 2024-09-09 19:51:51<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:51:51', '2024-09-09 23:51:51', '2024-09-09 23:51:51'),
(86, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 6<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:51:51<br/>updated_at: 2024-09-09 19:51:51<br/>', 'id: 6<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:51:51<br/>updated_at: 2024-09-09 19:52:03<br/>', 'VENTA DE LOTES', '2024-09-09', '19:52:03', '2024-09-09 23:52:03', '2024-09-09 23:52:03'),
(87, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 6<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: CANCELADO<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:51:51<br/>updated_at: 2024-09-09 19:52:03<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:52:39', '2024-09-09 23:52:39', '2024-09-09 23:52:39'),
(88, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 7<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: EN PROCESO<br/>estudios_com: EN PROCESO<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:52:56<br/>updated_at: 2024-09-09 19:52:56<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:52:56', '2024-09-09 23:52:56', '2024-09-09 23:52:56'),
(89, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 7<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: EN PROCESO<br/>estudios_com: EN PROCESO<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:52:56<br/>updated_at: 2024-09-09 19:52:56<br/>', 'id: 7<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: EN PROCESO<br/>estudios_com: EN PROCESO<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:52:56<br/>updated_at: 2024-09-09 19:53:04<br/>', 'VENTA DE LOTES', '2024-09-09', '19:53:04', '2024-09-09 23:53:04', '2024-09-09 23:53:04'),
(90, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 7<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: CANCELADO<br/>tipo_pago: CRÉDITO<br/>sistema: EN PROCESO<br/>estudios_com: EN PROCESO<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:52:56<br/>updated_at: 2024-09-09 19:53:05<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:54:55', '2024-09-09 23:54:55', '2024-09-09 23:54:55'),
(91, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 8<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:55:15<br/>updated_at: 2024-09-09 19:55:15<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:55:15', '2024-09-09 23:55:15', '2024-09-09 23:55:15'),
(92, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 8<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:55:15<br/>updated_at: 2024-09-09 19:55:15<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:57:42', '2024-09-09 23:57:42', '2024-09-09 23:57:42'),
(93, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 9<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:58:58<br/>updated_at: 2024-09-09 19:58:58<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:58:58', '2024-09-09 23:58:58', '2024-09-09 23:58:58'),
(94, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 9<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 19:58:58<br/>updated_at: 2024-09-09 19:58:58<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '19:59:30', '2024-09-09 23:59:30', '2024-09-09 23:59:30'),
(95, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:00:00<br/>updated_at: 2024-09-09 20:00:00<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '20:00:00', '2024-09-10 00:00:00', '2024-09-10 00:00:00'),
(96, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:00:00<br/>updated_at: 2024-09-09 20:00:00<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '20:01:03', '2024-09-10 00:01:03', '2024-09-10 00:01:03'),
(97, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 3<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-10<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:01:16<br/>updated_at: 2024-09-09 20:01:17<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '20:01:17', '2024-09-10 00:01:17', '2024-09-10 00:01:17'),
(98, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 3<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-10<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:01:16<br/>updated_at: 2024-09-09 20:01:17<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '20:01:41', '2024-09-10 00:01:41', '2024-09-10 00:01:41'),
(99, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:02:12<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '20:02:12', '2024-09-10 00:02:12', '2024-09-10 00:02:12'),
(100, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:02:12<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:15:33<br/>', 'VENTA DE LOTES', '2024-09-09', '20:15:33', '2024-09-10 00:15:33', '2024-09-10 00:15:33'),
(101, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: CANCELADO<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:15:33<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:15:44<br/>', 'VENTA DE LOTES', '2024-09-09', '20:15:44', '2024-09-10 00:15:44', '2024-09-10 00:15:44'),
(102, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: CANCELADO<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:15:44<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CONTADO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:19:01<br/>', 'VENTA DE LOTES', '2024-09-09', '20:19:01', '2024-09-10 00:19:01', '2024-09-10 00:19:01'),
(103, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CONTADO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:19:01<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:19:08<br/>', 'VENTA DE LOTES', '2024-09-09', '20:19:08', '2024-09-10 00:19:08', '2024-09-10 00:19:08'),
(104, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:19:08<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:19:18<br/>', 'VENTA DE LOTES', '2024-09-09', '20:19:18', '2024-09-10 00:19:18', '2024-09-10 00:19:18'),
(105, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:19:18<br/>', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CONTADO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:19:30<br/>', 'VENTA DE LOTES', '2024-09-09', '20:19:30', '2024-09-10 00:19:30', '2024-09-10 00:19:30'),
(106, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-09<br/>total_venta: 8000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CONTADO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:02:12<br/>updated_at: 2024-09-09 20:19:30<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '20:19:36', '2024-09-10 00:19:36', '2024-09-10 00:19:36'),
(107, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA DE LOTE', 'id: 2<br/>user_id: 1<br/>cliente_id: 2<br/>urbanizacion_id: 1<br/>manzano_id: 1<br/>lote_id: 2<br/>fecha_formalizacion: 2024-09-16<br/>total_venta: 4000.00<br/>estado_pago: PENDIENTE<br/>tipo_pago: CRÉDITO<br/>sistema: PENDIENTE<br/>estudios_com: PENDIENTE<br/>minuta: PENDIENTE<br/>titulacion: PENDIENTE<br/>estado_cliente: ACTIVO<br/>fecha_registro: 2024-09-09<br/>fecha_estado: <br/>fechan: <br/>created_at: 2024-09-09 20:20:13<br/>updated_at: 2024-09-09 20:20:13<br/>', NULL, 'VENTA DE LOTES', '2024-09-09', '20:20:13', '2024-09-10 00:20:13', '2024-09-10 00:20:13'),
(108, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 3<br/>usuario: EPAREDES<br/>nombre: EDUARDO<br/>paterno: PAREDES<br/>materno: <br/>ci: 2222<br/>ci_exp: LP<br/>dir: LOS PEDREGALES<br/>email: <br/>fono: 66666666<br/>password: $2y$12$szDkh9OhxlYZlsMEIzhktuML1W0QBdiu4ADBRIX5PIs30L6Z2zhHa<br/>tipo: AGENTE INMOBILIARIO<br/>foto: <br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 17:29:23<br/>updated_at: 2024-09-03 17:29:23<br/>', 'id: 3<br/>usuario: EPAREDES<br/>nombre: EDUARDO<br/>paterno: PAREDES<br/>materno: <br/>ci: 2222<br/>ci_exp: LP<br/>dir: LOS PEDREGALES<br/>email: <br/>fono: 66666666<br/>password: $2y$12$szDkh9OhxlYZlsMEIzhktuML1W0QBdiu4ADBRIX5PIs30L6Z2zhHa<br/>tipo: AGENTE INMOBILIARIO<br/>foto: <br/>fecha_registro: 2024-09-03<br/>acceso: 1<br/>created_at: 2024-09-03 17:29:23<br/>updated_at: 2024-09-09 20:27:29<br/>', 'USUARIOS', '2024-09-09', '20:27:29', '2024-09-10 00:27:29', '2024-09-10 00:27:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lotes`
--

CREATE TABLE `lotes` (
  `id` bigint UNSIGNED NOT NULL,
  `urbanizacion_id` bigint UNSIGNED NOT NULL,
  `manzano_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubicacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `esquina` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `esquina_area` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `esquina_equipamiento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avenida_estr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avenida_union` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `superficie` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `costo_contado` decimal(24,2) NOT NULL,
  `costo_credito` decimal(24,2) NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `vendido` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `lotes`
--

INSERT INTO `lotes` (`id`, `urbanizacion_id`, `manzano_id`, `nombre`, `ubicacion`, `esquina`, `esquina_area`, `esquina_equipamiento`, `avenida_estr`, `avenida_union`, `superficie`, `costo_contado`, `costo_credito`, `fecha_registro`, `vendido`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'LOTE #1', 'PARTE ESPECIAL', 'PARTE BAJA', 'FRENTE ÁREA VERDE', 'NINGUNO', 'NINGUNO', 'NINGUNO', '300 M2', 10000.00, 12000.00, '2024-09-04', 1, '2024-09-04 16:50:21', '2024-09-04 16:50:21'),
(2, 1, 1, 'LOTE #2', 'PARTE MEDIA', 'PARTE MEDIA', 'NINGUNO', 'NINGUNO', 'NINGUNO', 'NINGUNO', '6000 M2', 8000.00, 4000.00, '2024-09-05', 1, '2024-09-06 02:59:00', '2024-09-10 00:20:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `manzanos`
--

CREATE TABLE `manzanos` (
  `id` bigint UNSIGNED NOT NULL,
  `urbanizacion_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(600) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `manzanos`
--

INSERT INTO `manzanos` (`id`, `urbanizacion_id`, `nombre`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 'MANZANO #1', 'DESC. 1', '2024-09-04', '2024-09-04 16:20:53', '2024-09-04 16:20:53'),
(2, 1, 'MANZANO #2', '', '2024-09-04', '2024-09-04 16:37:02', '2024-09-04 16:37:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '2024_01_31_165641_create_configuracions_table', 1),
(3, '2024_02_02_205431_create_historial_accions_table', 2),
(4, '2024_08_28_150138_create_urbanizacions_table', 3),
(5, '2024_08_28_150143_create_manzanos_table', 3),
(6, '2024_08_28_150147_create_lotes_table', 3),
(7, '2024_08_28_150155_create_planilla_cuotas_table', 3),
(8, '2024_08_28_150202_create_clientes_table', 3),
(9, '2024_08_28_150217_create_venta_lotes_table', 3),
(10, '2024_08_28_150228_create_venta_planillas_table', 3),
(11, '2024_08_28_150240_create_notificacions_table', 3),
(12, '2024_08_28_150242_create_notificacion_users_table', 3),
(13, '2024_08_28_150251_create_pagos_table', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacions`
--

CREATE TABLE `notificacions` (
  `id` bigint UNSIGNED NOT NULL,
  `tipo_notificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(900) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `registro_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificacions`
--

INSERT INTO `notificacions` (`id`, `tipo_notificacion`, `descripcion`, `fecha`, `hora`, `registro_id`, `created_at`, `updated_at`) VALUES
(1, 'ESTADO CLIENTE', 'SE CAMBIO EL ESTADO DEL CLIENTE EDUARDO GONZALES PAREDES A DISPENSA', '2024-09-07', '16:55:00', 1, '2024-09-07 20:55:00', '2024-09-07 20:55:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion_users`
--

CREATE TABLE `notificacion_users` (
  `id` bigint UNSIGNED NOT NULL,
  `notificacion_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `visto` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificacion_users`
--

INSERT INTO `notificacion_users` (`id`, `notificacion_id`, `user_id`, `visto`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2024-09-07 20:55:00', '2024-09-07 21:17:25'),
(2, 1, 2, 0, '2024-09-07 20:55:00', '2024-09-07 20:55:00'),
(3, 1, 3, 0, '2024-09-07 20:55:00', '2024-09-07 20:55:00'),
(4, 1, 4, 0, '2024-09-07 20:55:00', '2024-09-07 20:55:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `venta_lote_id` bigint UNSIGNED NOT NULL,
  `nro_cuotas` int NOT NULL,
  `cuota` decimal(24,2) NOT NULL,
  `total_cuota` decimal(24,2) NOT NULL,
  `descripcion` varchar(900) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_pago` date NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `user_id`, `cliente_id`, `venta_lote_id`, `nro_cuotas`, `cuota`, `total_cuota`, `descripcion`, `fecha_pago`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 2, 1500.00, 3000.00, 'DESC. PAGO', '2024-09-09', '2024-09-09', '2024-09-09 19:33:29', '2024-09-09 19:33:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planilla_cuotas`
--

CREATE TABLE `planilla_cuotas` (
  `id` bigint UNSIGNED NOT NULL,
  `lote_id` bigint UNSIGNED NOT NULL,
  `plazo` int NOT NULL,
  `descripcion` varchar(600) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `planilla_cuotas`
--

INSERT INTO `planilla_cuotas` (`id`, `lote_id`, `plazo`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 8, 'DESC. PLANILLA #1', '2024-09-05', '2024-09-06 03:13:48', '2024-09-06 03:13:48'),
(2, 2, 7, '', '2024-09-05', '2024-09-06 03:13:58', '2024-09-06 03:13:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `urbanizacions`
--

CREATE TABLE `urbanizacions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(600) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `urbanizacions`
--

INSERT INTO `urbanizacions` (`id`, `nombre`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'URBANIZACION #1', 'DESC. URB. 1', '2024-09-04', '2024-09-04 04:02:54', '2024-09-04 04:02:54'),
(2, 'URBANIZACION #2', '', '2024-09-04', '2024-09-04 16:02:10', '2024-09-04 16:20:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `acceso` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `email`, `fono`, `password`, `tipo`, `foto`, `fecha_registro`, `acceso`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', NULL, '0', '', '', 'admin@admin.com', '', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 'ADMINISTRADOR', NULL, '2024-08-26', 1, NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1111', 'LP', 'ZONA LOS OLIVOS', 'JUAN@GMAIL.COM', '77777777', '$2y$12$L7LBOAaTNeNTBH95eWVlbu60uJGvoSTzo5.LQ8cp.e1Truu5fLus6', 'SUPERVISOR', '1725406290_JPERES.jpg', '2024-09-03', 1, '2024-09-03 20:29:41', '2024-09-04 03:36:34'),
(3, 'EPAREDES', 'EDUARDO', 'PAREDES', '', '2222', 'LP', 'LOS PEDREGALES', '', '66666666', '$2y$12$szDkh9OhxlYZlsMEIzhktuML1W0QBdiu4ADBRIX5PIs30L6Z2zhHa', 'AGENTE INMOBILIARIO', NULL, '2024-09-03', 1, '2024-09-03 21:29:23', '2024-09-10 00:27:29'),
(4, 'EGONZALES', 'EDUARDO', 'GONZALES', 'PAREDES', '4432', 'LP', NULL, NULL, '76767676', '$2y$12$FTckeBbcsLg3dJWv34dOIOSjEp.mMt.Ek5kUFZF/ReU1iXMXrKc0W', 'CLIENTE', NULL, '2024-09-06', 1, '2024-09-06 19:40:09', '2024-09-06 19:44:55'),
(5, 'JGOMEZ', 'JUAN', 'GOMEZ', 'GOMEZ', '3333', 'CB', NULL, NULL, '76766767', '$2y$12$vMBL.p0c04i0GXgi/KoKRu8QnCzusvtAFNgIQbvCdf/ctr/P5QvXu', 'CLIENTE', NULL, '2024-09-09', 1, '2024-09-09 23:26:13', '2024-09-09 23:26:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_lotes`
--

CREATE TABLE `venta_lotes` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `urbanizacion_id` bigint UNSIGNED NOT NULL,
  `manzano_id` bigint UNSIGNED NOT NULL,
  `lote_id` bigint UNSIGNED NOT NULL,
  `fecha_formalizacion` date NOT NULL,
  `total_venta` decimal(8,2) NOT NULL,
  `estado_pago` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_pago` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estudios_com` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `minuta` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titulacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado_cliente` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `fecha_estado` date DEFAULT NULL,
  `fechan` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `venta_lotes`
--

INSERT INTO `venta_lotes` (`id`, `user_id`, `cliente_id`, `urbanizacion_id`, `manzano_id`, `lote_id`, `fecha_formalizacion`, `total_venta`, `estado_pago`, `tipo_pago`, `sistema`, `estudios_com`, `minuta`, `titulacion`, `estado_cliente`, `fecha_registro`, `fecha_estado`, `fechan`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 1, '2024-09-09', 12000.00, 'PENDIENTE', 'CRÉDITO', 'PENDIENTE', 'PENDIENTE', 'PENDIENTE', 'PENDIENTE', 'DISPENSA', '2024-09-06', NULL, NULL, '2024-09-06 21:17:07', '2024-09-07 20:55:00'),
(2, 1, 2, 1, 1, 2, '2024-09-16', 4000.00, 'PENDIENTE', 'CRÉDITO', 'PENDIENTE', 'PENDIENTE', 'PENDIENTE', 'PENDIENTE', 'ACTIVO', '2024-09-09', NULL, NULL, '2024-09-10 00:20:13', '2024-09-10 00:20:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_planillas`
--

CREATE TABLE `venta_planillas` (
  `id` bigint UNSIGNED NOT NULL,
  `venta_lote_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `nro_cuota` int NOT NULL,
  `cuota` decimal(8,2) NOT NULL,
  `total_sumado` decimal(8,2) NOT NULL,
  `estado` int NOT NULL,
  `fecha_pago` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `venta_planillas`
--

INSERT INTO `venta_planillas` (`id`, `venta_lote_id`, `cliente_id`, `nro_cuota`, `cuota`, `total_sumado`, `estado`, `fecha_pago`, `created_at`, `updated_at`) VALUES
(9, 1, 1, 1, 1500.00, 1500.00, 1, '2024-10-09', '2024-09-06 21:40:30', '2024-09-09 19:33:29'),
(10, 1, 1, 2, 1500.00, 3000.00, 1, '2024-11-09', '2024-09-06 21:40:30', '2024-09-09 19:33:29'),
(11, 1, 1, 3, 1500.00, 4500.00, 0, '2024-12-09', '2024-09-06 21:40:30', '2024-09-09 19:33:06'),
(12, 1, 1, 4, 1500.00, 6000.00, 0, '2025-01-09', '2024-09-06 21:40:30', '2024-09-06 21:40:30'),
(13, 1, 1, 5, 1500.00, 7500.00, 0, '2025-02-09', '2024-09-06 21:40:30', '2024-09-06 21:40:30'),
(14, 1, 1, 6, 1500.00, 9000.00, 0, '2025-03-09', '2024-09-06 21:40:30', '2024-09-06 21:40:30'),
(15, 1, 1, 7, 1500.00, 10500.00, 0, '2025-04-09', '2024-09-06 21:40:30', '2024-09-06 21:40:30'),
(16, 1, 1, 8, 1500.00, 12000.00, 0, '2025-05-09', '2024-09-06 21:40:30', '2024-09-06 21:40:30'),
(17, 2, 2, 1, 571.43, 571.43, 0, '2024-10-16', '2024-09-10 00:20:13', '2024-09-10 00:20:13'),
(18, 2, 2, 2, 571.43, 1142.86, 0, '2024-11-16', '2024-09-10 00:20:13', '2024-09-10 00:20:13'),
(19, 2, 2, 3, 571.43, 1714.29, 0, '2024-12-16', '2024-09-10 00:20:13', '2024-09-10 00:20:13'),
(20, 2, 2, 4, 571.43, 2285.72, 0, '2025-01-16', '2024-09-10 00:20:13', '2024-09-10 00:20:13'),
(21, 2, 2, 5, 571.43, 2857.15, 0, '2025-02-16', '2024-09-10 00:20:13', '2024-09-10 00:20:13'),
(22, 2, 2, 6, 571.43, 3428.58, 0, '2025-03-16', '2024-09-10 00:20:13', '2024-09-10 00:20:13'),
(23, 2, 2, 7, 571.43, 4000.01, 0, '2025-04-16', '2024-09-10 00:20:13', '2024-09-10 00:20:13');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientes_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `lotes`
--
ALTER TABLE `lotes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lotes_manzano_id_foreign` (`manzano_id`),
  ADD KEY `lotes_urbanizacion_id_foreign` (`urbanizacion_id`);

--
-- Indices de la tabla `manzanos`
--
ALTER TABLE `manzanos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `manzanos_urbanizacion_id_foreign` (`urbanizacion_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notificacion_users_notificacion_id_foreign` (`notificacion_id`),
  ADD KEY `notificacion_users_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pagos_user_id_foreign` (`user_id`),
  ADD KEY `pagos_cliente_id_foreign` (`cliente_id`),
  ADD KEY `pagos_venta_lote_id_foreign` (`venta_lote_id`);

--
-- Indices de la tabla `planilla_cuotas`
--
ALTER TABLE `planilla_cuotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `planilla_cuotas_lote_id_foreign` (`lote_id`);

--
-- Indices de la tabla `urbanizacions`
--
ALTER TABLE `urbanizacions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- Indices de la tabla `venta_lotes`
--
ALTER TABLE `venta_lotes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `venta_lotes_user_id_foreign` (`user_id`),
  ADD KEY `venta_lotes_cliente_id_foreign` (`cliente_id`),
  ADD KEY `venta_lotes_urbanizacion_id_foreign` (`urbanizacion_id`),
  ADD KEY `venta_lotes_manzano_id_foreign` (`manzano_id`),
  ADD KEY `venta_lotes_lote_id_foreign` (`lote_id`);

--
-- Indices de la tabla `venta_planillas`
--
ALTER TABLE `venta_planillas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `venta_planillas_venta_lote_id_foreign` (`venta_lote_id`),
  ADD KEY `venta_planillas_cliente_id_foreign` (`cliente_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT de la tabla `lotes`
--
ALTER TABLE `lotes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `manzanos`
--
ALTER TABLE `manzanos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `planilla_cuotas`
--
ALTER TABLE `planilla_cuotas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `urbanizacions`
--
ALTER TABLE `urbanizacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `venta_lotes`
--
ALTER TABLE `venta_lotes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `venta_planillas`
--
ALTER TABLE `venta_planillas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `lotes`
--
ALTER TABLE `lotes`
  ADD CONSTRAINT `lotes_manzano_id_foreign` FOREIGN KEY (`manzano_id`) REFERENCES `manzanos` (`id`),
  ADD CONSTRAINT `lotes_urbanizacion_id_foreign` FOREIGN KEY (`urbanizacion_id`) REFERENCES `urbanizacions` (`id`);

--
-- Filtros para la tabla `manzanos`
--
ALTER TABLE `manzanos`
  ADD CONSTRAINT `manzanos_urbanizacion_id_foreign` FOREIGN KEY (`urbanizacion_id`) REFERENCES `urbanizacions` (`id`);

--
-- Filtros para la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  ADD CONSTRAINT `notificacion_users_notificacion_id_foreign` FOREIGN KEY (`notificacion_id`) REFERENCES `notificacions` (`id`),
  ADD CONSTRAINT `notificacion_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `pagos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `pagos_venta_lote_id_foreign` FOREIGN KEY (`venta_lote_id`) REFERENCES `venta_lotes` (`id`);

--
-- Filtros para la tabla `planilla_cuotas`
--
ALTER TABLE `planilla_cuotas`
  ADD CONSTRAINT `planilla_cuotas_lote_id_foreign` FOREIGN KEY (`lote_id`) REFERENCES `lotes` (`id`);

--
-- Filtros para la tabla `venta_lotes`
--
ALTER TABLE `venta_lotes`
  ADD CONSTRAINT `venta_lotes_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `venta_lotes_lote_id_foreign` FOREIGN KEY (`lote_id`) REFERENCES `lotes` (`id`),
  ADD CONSTRAINT `venta_lotes_manzano_id_foreign` FOREIGN KEY (`manzano_id`) REFERENCES `manzanos` (`id`),
  ADD CONSTRAINT `venta_lotes_urbanizacion_id_foreign` FOREIGN KEY (`urbanizacion_id`) REFERENCES `urbanizacions` (`id`),
  ADD CONSTRAINT `venta_lotes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `venta_planillas`
--
ALTER TABLE `venta_planillas`
  ADD CONSTRAINT `venta_planillas_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `venta_planillas_venta_lote_id_foreign` FOREIGN KEY (`venta_lote_id`) REFERENCES `venta_lotes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
