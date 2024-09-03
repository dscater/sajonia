-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 03-09-2024 a las 19:14:30
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
  `estado_cliente` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'SAJONIA', 'SJ', 'SAJONIA S.A.', 'LA PAZ', 'ZONA LOS OLIVOS', '77777777', 'sajonia@gmail.com', 'sajonia.com', 'ACTIVIDAD', 'logo.svg', NULL, NULL);

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
(8, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: AGENTE INMOBILIARIO<br/>foto: 1725380981_JPERES.jpg<br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 19:13:15<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 77777777<br/>password: $2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u<br/>tipo: AGENTE INMOBILIARIO<br/>foto: 1725390831_JPERES.png<br/>fecha_registro: 2024-09-03<br/>acceso: 0<br/>created_at: 2024-09-03 16:29:41<br/>updated_at: 2024-09-03 19:13:51<br/>', 'USUARIOS', '2024-09-03', '19:13:51', '2024-09-03 23:13:51', '2024-09-03 23:13:51');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion_users`
--

CREATE TABLE `notificacion_users` (
  `id` bigint UNSIGNED NOT NULL,
  `notificacion_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1111', 'LP', 'ZONA LOS OLIVOS', 'JUAN@GMAIL.COM', '77777777', '$2y$12$PXuj3k43zq1kLH4/pIA2AeeYxsbUZd1J.kBBdhzjklBczxX8kwt8u', 'AGENTE INMOBILIARIO', '1725390831_JPERES.png', '2024-09-03', 0, '2024-09-03 20:29:41', '2024-09-03 23:13:51'),
(3, 'EPAREDES', 'EDUARDO', 'PAREDES', '', '2222', 'LP', 'LOS PEDREGALES', '', '66666666', '$2y$12$szDkh9OhxlYZlsMEIzhktuML1W0QBdiu4ADBRIX5PIs30L6Z2zhHa', 'AGENTE INMOBILIARIO', NULL, '2024-09-03', 0, '2024-09-03 21:29:23', '2024-09-03 21:29:23'),
(4, 'MPAREDES', 'MARIA', 'PAREDES', '', '3333', 'LP', 'ZONA LOS PEDREGALES', 'MARIA@GMAIL.COM', '78787878', '$2y$12$vsNccOFOJPrFo7ZcgyJtpuRt4/rpj27f3GFu6qYIECyulco2KlFg.', 'AGENTE INMOBILIARIO', '1725386133_MPAREDES.jpg', '2024-09-03', 1, '2024-09-03 21:55:33', '2024-09-03 21:55:33');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `lotes`
--
ALTER TABLE `lotes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `manzanos`
--
ALTER TABLE `manzanos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `planilla_cuotas`
--
ALTER TABLE `planilla_cuotas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `urbanizacions`
--
ALTER TABLE `urbanizacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `venta_lotes`
--
ALTER TABLE `venta_lotes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta_planillas`
--
ALTER TABLE `venta_planillas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
