-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-05-2026 a las 17:41:20
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cms_landings_esan`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `academic_units`
--

CREATE TABLE `academic_units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL COMMENT 'Código institucional interno',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `academic_units`
--

INSERT INTO `academic_units` (`id`, `name`, `slug`, `domain`, `code`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Pregrado', 'pregrado', 'pregrado.esan.edu.pe', 'PRE-01', 1, '2026-02-17 20:47:48', '2026-03-23 21:26:06', NULL),
(2, 'Posgrado', 'posgrado', NULL, 'POS-01', 1, '2026-02-18 02:56:17', '2026-02-25 22:31:27', NULL),
(3, 'MBA', 'mba', NULL, 'MBA-01', 1, '2026-02-24 01:29:56', '2026-02-24 01:30:44', NULL),
(4, 'LandingDpa', 'landingdpa', 'landingdpa.ue.edu.pe', 'LDPA', 1, '2026-03-23 21:26:55', '2026-03-23 21:26:55', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('cms_cache_spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:77:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:9:\"dashboard\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:4:{i:0;i:2;i:1;i:3;i:2;i:4;i:3;i:5;}}i:1;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:13:\"register_user\";s:1:\"c\";s:3:\"api\";}i:2;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:9:\"list_user\";s:1:\"c\";s:3:\"api\";}i:3;a:3:{s:1:\"a\";i:4;s:1:\"b\";s:9:\"edit_user\";s:1:\"c\";s:3:\"api\";}i:4;a:3:{s:1:\"a\";i:5;s:1:\"b\";s:11:\"delete_user\";s:1:\"c\";s:3:\"api\";}i:5;a:3:{s:1:\"a\";i:6;s:1:\"b\";s:13:\"register_role\";s:1:\"c\";s:3:\"api\";}i:6;a:3:{s:1:\"a\";i:7;s:1:\"b\";s:9:\"list_role\";s:1:\"c\";s:3:\"api\";}i:7;a:3:{s:1:\"a\";i:8;s:1:\"b\";s:9:\"edit_role\";s:1:\"c\";s:3:\"api\";}i:8;a:3:{s:1:\"a\";i:9;s:1:\"b\";s:11:\"delete_role\";s:1:\"c\";s:3:\"api\";}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:17:\"register_category\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:13:\"list_category\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:4:{i:0;i:2;i:1;i:3;i:2;i:4;i:3;i:5;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:13:\"edit_category\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:15:\"delete_category\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:15:\"register_course\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:11:\"list_course\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:3:{i:0;i:2;i:1;i:4;i:2;i:5;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:11:\"edit_course\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:13:\"delete_course\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:13:\"register_post\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:9:\"list_post\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:4:{i:0;i:2;i:1;i:3;i:2;i:4;i:3;i:5;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:9:\"edit_post\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:11:\"delete_post\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:18:\"register_menu_item\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:14:\"list_menu_item\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:4:{i:0;i:2;i:1;i:3;i:2;i:4;i:3;i:5;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:14:\"edit_menu_item\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:16:\"delete_menu_item\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:14:\"register_media\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:10:\"list_media\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:4:{i:0;i:2;i:1;i:3;i:2;i:4;i:3;i:5;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:10:\"edit_media\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:12:\"delete_media\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:13:\"register_lead\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:9:\"list_lead\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:3:{i:0;i:2;i:1;i:4;i:2;i:5;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:9:\"edit_lead\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:11:\"delete_lead\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:33;a:4:{s:1:\"a\";i:34;s:1:\"b\";s:13:\"register_news\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:34;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:9:\"list_news\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:4;i:1;i:5;}}i:35;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:9:\"edit_news\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:36;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:11:\"delete_news\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:37;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:15:\"register_manual\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:38;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:11:\"list_manual\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:4;i:1;i:5;}}i:39;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:11:\"edit_manual\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:40;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:13:\"delete_manual\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:41;a:4:{s:1:\"a\";i:42;s:1:\"b\";s:22:\"register_academic_unit\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:42;a:4:{s:1:\"a\";i:43;s:1:\"b\";s:18:\"list_academic_unit\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:4;i:1;i:5;}}i:43;a:4:{s:1:\"a\";i:44;s:1:\"b\";s:18:\"edit_academic_unit\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:44;a:4:{s:1:\"a\";i:45;s:1:\"b\";s:20:\"delete_academic_unit\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:45;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:22:\"register_study_program\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:46;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:18:\"list_study_program\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:4;i:1;i:5;}}i:47;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:18:\"edit_study_program\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:48;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:20:\"delete_study_program\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:49;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:17:\"register_campaign\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:50;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:13:\"list_campaign\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:4;i:1;i:5;}}i:51;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:13:\"edit_campaign\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:52;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:15:\"delete_campaign\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:53;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:16:\"register_setting\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:54;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:12:\"list_setting\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:4;i:1;i:5;}}i:55;a:4:{s:1:\"a\";i:56;s:1:\"b\";s:12:\"edit_setting\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:56;a:4:{s:1:\"a\";i:57;s:1:\"b\";s:14:\"delete_setting\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:57;a:3:{s:1:\"a\";i:58;s:1:\"b\";s:13:\"register_page\";s:1:\"c\";s:3:\"api\";}i:58;a:4:{s:1:\"a\";i:59;s:1:\"b\";s:9:\"list_page\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:5;}}i:59;a:3:{s:1:\"a\";i:60;s:1:\"b\";s:9:\"edit_page\";s:1:\"c\";s:3:\"api\";}i:60;a:3:{s:1:\"a\";i:61;s:1:\"b\";s:11:\"delete_page\";s:1:\"c\";s:3:\"api\";}i:61;a:3:{s:1:\"a\";i:62;s:1:\"b\";s:13:\"register_menu\";s:1:\"c\";s:3:\"api\";}i:62;a:3:{s:1:\"a\";i:63;s:1:\"b\";s:9:\"list_menu\";s:1:\"c\";s:3:\"api\";}i:63;a:3:{s:1:\"a\";i:64;s:1:\"b\";s:9:\"edit_menu\";s:1:\"c\";s:3:\"api\";}i:64;a:3:{s:1:\"a\";i:65;s:1:\"b\";s:11:\"delete_menu\";s:1:\"c\";s:3:\"api\";}i:65;a:3:{s:1:\"a\";i:66;s:1:\"b\";s:21:\"register_media_folder\";s:1:\"c\";s:3:\"api\";}i:66;a:3:{s:1:\"a\";i:67;s:1:\"b\";s:17:\"list_media_folder\";s:1:\"c\";s:3:\"api\";}i:67;a:3:{s:1:\"a\";i:68;s:1:\"b\";s:17:\"edit_media_folder\";s:1:\"c\";s:3:\"api\";}i:68;a:3:{s:1:\"a\";i:69;s:1:\"b\";s:19:\"delete_media_folder\";s:1:\"c\";s:3:\"api\";}i:69;a:3:{s:1:\"a\";i:70;s:1:\"b\";s:17:\"register_branding\";s:1:\"c\";s:3:\"api\";}i:70;a:3:{s:1:\"a\";i:71;s:1:\"b\";s:13:\"list_branding\";s:1:\"c\";s:3:\"api\";}i:71;a:3:{s:1:\"a\";i:72;s:1:\"b\";s:13:\"edit_branding\";s:1:\"c\";s:3:\"api\";}i:72;a:3:{s:1:\"a\";i:73;s:1:\"b\";s:15:\"delete_branding\";s:1:\"c\";s:3:\"api\";}i:73;a:3:{s:1:\"a\";i:74;s:1:\"b\";s:16:\"register_company\";s:1:\"c\";s:3:\"api\";}i:74;a:3:{s:1:\"a\";i:75;s:1:\"b\";s:12:\"list_company\";s:1:\"c\";s:3:\"api\";}i:75;a:3:{s:1:\"a\";i:76;s:1:\"b\";s:12:\"edit_company\";s:1:\"c\";s:3:\"api\";}i:76;a:3:{s:1:\"a\";i:77;s:1:\"b\";s:14:\"delete_company\";s:1:\"c\";s:3:\"api\";}}s:5:\"roles\";a:4:{i:0;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:10:\"Diseñador\";s:1:\"c\";s:3:\"api\";}i:1;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:5:\"Vista\";s:1:\"c\";s:3:\"api\";}i:2;a:3:{s:1:\"a\";i:4;s:1:\"b\";s:6:\"Prueba\";s:1:\"c\";s:3:\"api\";}i:3;a:3:{s:1:\"a\";i:5;s:1:\"b\";s:8:\"Listador\";s:1:\"c\";s:3:\"api\";}}}', 1778082087);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(50) DEFAULT 'academic',
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `academic_unit_id`, `parent_id`, `name`, `type`, `slug`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'Facultad de Ingeniería', 'academic', 'facultad-de-ingenieria', NULL, '2026-02-18 03:07:34', '2026-02-18 03:07:34'),
(3, 3, NULL, 'Facultad de Ingenieria', 'academic', 'facultad-de-ingenieria', NULL, '2026-02-25 20:58:57', '2026-02-25 20:58:57'),
(4, 2, NULL, 'Facultad de Ingenieria', 'academic', 'facultad-de-ingenieria', NULL, '2026-03-09 21:10:57', '2026-03-09 21:10:57'),
(5, 4, NULL, 'Carreras para DPA', 'academic', 'carreras-para-dpa', NULL, '2026-03-25 22:24:29', '2026-03-25 22:24:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `razon_social` varchar(250) NOT NULL,
  `razon_social_comercial` varchar(250) NOT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `n_document` varchar(50) NOT NULL,
  `birth_date` timestamp NULL DEFAULT NULL COMMENT 'fecha de cumple',
  `address` varchar(250) DEFAULT NULL,
  `urbanizacion` varchar(250) NOT NULL,
  `cod_local` varchar(150) NOT NULL,
  `ubigeo_distrito` varchar(25) DEFAULT NULL,
  `ubigeo_provincia` varchar(25) DEFAULT NULL,
  `ubigeo_region` varchar(25) DEFAULT NULL,
  `distrito` varchar(80) DEFAULT NULL,
  `provincia` varchar(80) DEFAULT NULL,
  `region` varchar(80) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `companies`
--

INSERT INTO `companies` (`id`, `razon_social`, `razon_social_comercial`, `phone`, `email`, `n_document`, `birth_date`, `address`, `urbanizacion`, `cod_local`, `ubigeo_distrito`, `ubigeo_provincia`, `ubigeo_region`, `distrito`, `provincia`, `region`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Laravest Sac.', 'Laravest', '958962565', 'echodeveloper960@gmail.com', '20161515648', '2025-04-29 05:00:00', 'Peru', 'Av. Primavera 2711, Santiago de Surco 25884', '0000', '150101', '1501', '15', 'Lima', 'Lima', 'Lima', '2025-04-30 00:37:01', '2025-05-22 21:45:53', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contents`
--

CREATE TABLE `contents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `type` enum('page','post','landing') DEFAULT 'page',
  `content_blocks` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`content_blocks`)),
  `excerpt` text DEFAULT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `status` enum('draft','published','archived') DEFAULT 'draft',
  `seo_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '{ "title": "", "description": "" }' CHECK (json_valid(`seo_config`)),
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `primary_color` varchar(50) DEFAULT '#ff8121',
  `font_family` varchar(255) DEFAULT 'Arial, sans-serif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contents`
--

INSERT INTO `contents` (`id`, `academic_unit_id`, `user_id`, `title`, `slug`, `type`, `content_blocks`, `excerpt`, `featured_image`, `status`, `seo_config`, `published_at`, `created_at`, `updated_at`, `deleted_at`, `primary_color`, `font_family`) VALUES
(1, 1, 1, 'Inicio', 'inicio', 'page', '[{\"type\":\"ImpactHeroBlock\",\"id\":\"39ed5394-edf5-469f-b34a-cf3102840f40\",\"content\":{\"title\":\"PREGRADO\",\"description\":\"La Unidad de Laboratorio de ESANDATA logra renovar la certificaci\\u00f3n ISO 9001-2015\",\"image\":\"\\/images\\/logos-juntos.png\",\"btnText\":\"M\\u00c1S INFORMACI\\u00d3N\",\"btnLink\":\"\\/noticias\\/iso-9001\",\"config\":{\"bgImage\":\"https:\\/\\/images.unsplash.com\\/photo-1497366216548-37526070297c?auto=format&fit=crop&q=80\",\"align\":\"left\",\"paddingTop\":\"80\",\"paddingBottom\":\"80\"}}},{\"type\":\"CallToActionBlock\",\"id\":\"c4ee56d8-cdc8-46ca-b414-ba4ed10fdefc\",\"content\":{\"preTitle\":\"NUESTROS\",\"title\":\"SERVICIOS\",\"btnText\":\"M\\u00c1S INFORMACI\\u00d3N\",\"btnLink\":\"\\/atencin-a-alumnos-docentes-y-personal-administrativo\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/\\/storage\\/media\\/1770062588_nuestros-proyectos.webp\",\"config\":{\"bgColor\":\"transparent\",\"invertLayout\":true}}},{\"type\":\"CallToActionBlock\",\"id\":\"fafbc6cd-d8bc-4a13-a7f9-e1de858485c6\",\"content\":{\"preTitle\":\"NUESTROS\",\"title\":\"PROYECTOS\",\"btnText\":\"M\\u00c1S INFORMACI\\u00d3N\",\"btnLink\":\"\\/noticias\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/\\/storage\\/media\\/1770062562_nuestros-servicios.webp\",\"config\":{\"bgColor\":\"transparent\",\"invertLayout\":false}}},{\"type\":\"FeatureBanner\",\"id\":\"adf6db3d-1229-43c8-9fa1-2b35a0ff4f46\",\"content\":{\"title\":\"M\\u00e1s de 250 instituciones p\\u00fablicas y privadas atendidas.\",\"buttonText\":\"CONT\\u00c1CTANOS\",\"buttonLink\":\"#contact_section\",\"backgroundImage\":null}}]', NULL, NULL, 'published', '{\"title\":\"Pregrado Esan\",\"description\":\"Domina el futuro con nuestro nuevo diplomado en Inteligencia Artificial.\"}', NULL, '2026-02-18 01:48:53', '2026-03-18 21:00:45', NULL, '#ff8121', 'Arial, sans-serif'),
(2, 1, 1, 'Nosotros', 'nosotros', 'page', '[{\"type\":\"ImpactHeroBlock\",\"id\":\"e86ad241-a582-47e3-a255-0e11a2460265\",\"content\":{\"title\":\"RENOVACI\\u00d3N DE LA CERTIFICACI\\u00d3N ISO-9001-2015\",\"description\":\"La Unidad de Laboratorio de ESANDATA logra renovar la certificaci\\u00f3n ISO 9001-2015\",\"image\":\"\\/images\\/logos-juntos.png\",\"btnText\":\"M\\u00c1S INFORMACI\\u00d3N\",\"btnLink\":\"\\/noticias\\/iso-9001\",\"config\":{\"bgImage\":\"http:\\/\\/127.0.0.1:8000\\/\\/storage\\/media\\/1770666090_banner-principal-1.webp\",\"align\":\"left\",\"paddingTop\":\"80\",\"paddingBottom\":\"80\",\"overlayOpacity\":0.9},\"tagline\":\"La Unidad de Laboratorio de ESANDATA logra renovar la certificaci\\u00f3n ISO 9001-2015\",\"logoImage\":\"http:\\/\\/127.0.0.1:8000\\/\\/storage\\/media\\/1770744435_logos-juntos.webp\"}},{\"type\":\"AchievementData\",\"id\":\"1c5cd48b-9397-4de5-aaae-9a733e96169c\",\"content\":{\"subtitle\":\"LOGROS ALCANZADOS\",\"title\":\"Algunos datos sobre nuestra instituci\\u00f3n\",\"buttonText\":\"CONT\\u00c1CTANOS\",\"buttonLink\":\"#contact_section\",\"backgroundImage\":null,\"counters\":[{\"id\":1,\"value\":20,\"suffix\":\"+\",\"description\":\"a\\u00f1os de trayectoria en capacitaci\\u00f3n y consultor\\u00eda.\"},{\"id\":2,\"value\":1000,\"suffix\":\"+\",\"description\":\"empresas atendidas con \\u00e9xito.\"},{\"id\":3,\"value\":50000,\"suffix\":\"+\",\"description\":\"profesionales capacitados globalmente.\"}]}},{\"type\":\"AboutCompany\",\"id\":\"b070d86a-4abe-4462-819a-f1f0826617aa\",\"content\":{\"title\":\"NUESTRA HISTORIA\",\"image\":null,\"content\":\"<p>El instituto de Regulaci\\u00f3n y Finanzas - FRI ESAN - de la Universidad ESAN fue fundado en el a\\u00f1o 2001. Como instituto buscamos colaborar en el desarrollo y fortalecimiento de las instituciones p\\u00fablicas y privadas de nuestro pa\\u00eds.<\\/p>\"}}]', NULL, NULL, 'published', '{\"title\":\"Aprende IA | Diplomado 2026\",\"description\":\"Domina el futuro con nuestro nuevo diplomado en Inteligencia Artificial.\"}', NULL, '2026-02-18 06:48:53', '2026-02-20 20:31:43', NULL, '#ff8121', 'Arial, sans-serif'),
(3, 2, 12, 'Pagina de Prueba', 'pagina-de-prueba', 'landing', '[{\"type\":\"HeaderInnovaBlock\",\"id\":\"2935f16d-7a56-42a7-ade7-3c0b9ba1f8ad\",\"content\":{\"logoUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772052600_logoinnova.webp\",\"heroImage\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772051034_slider01.webp\",\"heroTitle\":\"Innova\",\"heroSubtitle\":\"the business challenge\",\"navLinks\":[{\"id\":\"562bc59b-f173-4217-8734-4f11b61e705a\",\"label\":\"PREMIOS\",\"url\":\"#sec-562bc59b-f173-4217-8734-4f11b61e705a\"},{\"id\":\"d3821c5e-5ebf-4b5d-b7e9-5bc21b0f0ce4\",\"label\":\"TIME LINE\",\"url\":\"#sec-d3821c5e-5ebf-4b5d-b7e9-5bc21b0f0ce4\"},{\"id\":\"0d99b35d-5ce9-4a2a-9578-73cd6a3b5688\",\"label\":\"Curso intensivo de especialidad\",\"url\":\"#sec-0d99b35d-5ce9-4a2a-9578-73cd6a3b5688\"},{\"id\":\"b08f50de-8e13-4e71-a509-0ab1cf3aa619\",\"label\":\"TIME LINE\",\"url\":\"#sec-b08f50de-8e13-4e71-a509-0ab1cf3aa619\"},{\"id\":\"7c4a063e-853c-4778-995a-d6053b4227d5\",\"label\":\"POSTULACI\\u00d3N\",\"url\":\"#sec-7c4a063e-853c-4778-995a-d6053b4227d5\"},{\"id\":\"9f6d8297-caa8-4c30-9430-ec89630ec077\",\"label\":\"objetivo del programa\",\"url\":\"#sec-9f6d8297-caa8-4c30-9430-ec89630ec077\"},{\"id\":\"d455b006-53ac-4f0c-bd1c-b10925d2d52e\",\"label\":\"\\ud83c\\udf93 Nuestros Programas\",\"url\":\"#sec-d455b006-53ac-4f0c-bd1c-b10925d2d52e\"},{\"id\":\"b9ca3fec-8635-48a5-9fe6-45df24d978c1\",\"label\":\"campus esan\",\"url\":\"#sec-b9ca3fec-8635-48a5-9fe6-45df24d978c1\"}],\"topLinks\":[{\"label\":\"ESAN UNIVERSITY\",\"url\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/\"},{\"label\":\"esan school of business\",\"url\":\"https:\\/\\/www.esan.edu.pe\\/\"}],\"primaryColor\":\"#ffffff\"}},{\"type\":\"TimelineInnovaBlock\",\"id\":\"562bc59b-f173-4217-8734-4f11b61e705a\",\"content\":{\"title\":\"PREMIOS\",\"contentType\":\"html\",\"imageType\":\"single\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772144195_agrupacion.webp\",\"images\":[null,null,null],\"imageSide\":\"right\",\"bgColor\":\"#ffffff\",\"accentColor\":\"#2176ff\",\"overlayColor1\":\"#2176ff\",\"overlayColor2\":\"#ff8121\",\"items\":[{\"label\":\"Convocatoria\",\"content\":\"<ul><li>Webinar informativo<\\/li><\\/ul>\",\"active\":true},{\"label\":\"Selecci\\u00f3n\",\"content\":\"<ul><li>Publicaci\\u00f3n de resultados<\\/li><\\/ul>\",\"active\":false}],\"content\":\"<p>El premio se otorgar\\u00e1 a los mejores 15 equipos en el ranking final seg\\u00fan el puntaje acumulativo de todas las etapas.<\\/p><p><strong>DESCUENTO INTEGRAL para Innova ESAN Venture Lab:<\\/strong><\\/p><p>A los equipos que se encuentren en el Top 3 del ranking final:<\\/p><ul><li>Descuento del 100% para el Programa de incubaci\\u00f3n en Innova ESAN.<\\/li><\\/ul><p><strong>DESCUENTO PARCIAL para Innova ESAN Venture Lab:<\\/strong><\\/p><p>A los siguientes 12 equipos de mayor puntaje en el ranking final:<\\/p><ul><li>Descuento del 83% para el Programa de incubaci\\u00f3n en Innova ESAN, valorizado en dieciocho mil (18,000) soles por equipo en servicios de incubaci\\u00f3n.<\\/li><\\/ul><p><br><\\/p>\",\"features\":[]}},{\"type\":\"TimelineInnovaBlock\",\"id\":\"d3821c5e-5ebf-4b5d-b7e9-5bc21b0f0ce4\",\"content\":{\"title\":\"TIME LINE\",\"contentType\":\"accordion\",\"imageType\":\"triple\",\"image\":\"imagenes\\/landing\\/presentacion.png\",\"images\":[\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772056660_presentacion.webp\",\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772142697_equipo.webp\",\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772144195_agrupacion.webp\"],\"imageSide\":\"left\",\"bgColor\":\"#ffffff\",\"accentColor\":\"#2176ff\",\"overlayColor1\":\"#2176ff\",\"overlayColor2\":\"#ff8121\",\"items\":[{\"label\":\"Convocatoria\",\"content\":\"<ul><li>Webinar informativo<\\/li><\\/ul>\",\"active\":true},{\"label\":\"Selecci\\u00f3n\",\"content\":\"<ul><li>Publicaci\\u00f3n de resultados<\\/li><\\/ul>\",\"active\":false}],\"content\":null,\"features\":[]}},{\"type\":\"TimelineInnovaBlock\",\"id\":\"0d99b35d-5ce9-4a2a-9578-73cd6a3b5688\",\"content\":{\"title\":\"Curso intensivo de especialidad\",\"contentType\":\"accordion\",\"imageType\":\"triple\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772051034_slider01.webp\",\"images\":[null,null,null],\"imageSide\":\"right\",\"bgColor\":\"#ffffff\",\"accentColor\":\"#2176ff\",\"overlayColor1\":\"#2176ff\",\"overlayColor2\":\"#ff8121\",\"items\":[{\"label\":\"Convocatoria\",\"content\":\"<ul><li>Publicaci\\u00f3n de resultados<\\/li><li>Publicaci\\u00f3n de resultados<\\/li><li>Publicaci\\u00f3n de resultados<\\/li><li>Publicaci\\u00f3n de resultados<\\/li><\\/ul><p><br><\\/p><p><br><\\/p>\",\"active\":true},{\"label\":\"Selecci\\u00f3n\",\"content\":\"<ul><li>Publicaci\\u00f3n de resultados<\\/li><\\/ul>\",\"active\":false},{\"label\":\"ASDDASADS\",\"content\":\"<ul><li>sadasdadssdad<\\/li><\\/ul>\"}],\"content\":null,\"features\":[]}},{\"type\":\"TimelineInnovaBlock\",\"id\":\"b08f50de-8e13-4e71-a509-0ab1cf3aa619\",\"content\":{\"title\":\"TIME LINE\",\"contentType\":\"timeline\",\"imageType\":\"single\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772056660_presentacion.webp\",\"images\":[null,null,null],\"imageSide\":\"right\",\"bgColor\":\"#ffffff\",\"accentColor\":\"#0060fa\",\"overlayColor1\":\"#2176ff\",\"overlayColor2\":\"#ff8121\",\"items\":[{\"label\":\"Convocatoria\",\"content\":\"<p><br><\\/p><ul><li><strong style=\\\"color: inherit;\\\">Webinar informativo 1:<\\/strong>&nbsp;Jueves 16 de enero de 2025.<\\/li><li><strong style=\\\"color: inherit;\\\">Webinar informativo 2:<\\/strong>&nbsp;Jueves 6 de febrero de 2025.<\\/li><li><strong style=\\\"color: inherit;\\\">Cierre de postulaci\\u00f3n:<\\/strong>&nbsp;Viernes 21 de febrero de 2025.<\\/li><\\/ul>\",\"active\":true},{\"label\":\"Selecci\\u00f3n\",\"content\":\"<p><br><\\/p><ul><li><strong style=\\\"color: inherit;\\\">Publicaci\\u00f3n de equipos seleccionados para el Bootcamp:<\\/strong><\\/li><li>Lunes 24 de febrero de 2025.<\\/li><\\/ul>\",\"active\":false}],\"content\":null,\"features\":[]}},{\"id\":\"7c4a063e-853c-4778-995a-d6053b4227d5\",\"type\":\"CtaPostulacionBlock\",\"content\":{\"title\":\"POSTULACI\\u00d3N\",\"description\":\"La postulaci\\u00f3n a la convocatoria del concurso es totalmente gratuita y abierta a todas las personas que deseen postular y que cumplan los requisitos y criterios de la convocatoria (Bases de la Convocatoria).\",\"buttonText\":\"M\\u00e1s informaci\\u00f3n\",\"buttonLink\":\"https:\\/\\/forms.gle\\/92arYWEZFHZziC56A\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772144195_agrupacion.webp\",\"overlayColor1\":\"rgba(33, 118, 255, 0.80)\",\"overlayColor2\":\"rgba(33, 118, 255, 0.80)\"}},{\"id\":\"9f6d8297-caa8-4c30-9430-ec89630ec077\",\"type\":\"CtaPostulacionBlock\",\"content\":{\"title\":\"objetivo del programa\",\"description\":\"Acelerar la validaci\\u00f3n y tracci\\u00f3n de emprendimientos innovadores con potencial de impacto global, vincul\\u00e1ndolos con oportunidades del ecosistema emprendedor y de ESAN. Adem\\u00e1s de brindar acompa\\u00f1amiento personalizado a los equipos seleccionados.\",\"buttonText\":\"M\\u00e1s informaci\\u00f3n\",\"buttonLink\":\"#\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772051034_slider01.webp\",\"overlayColor1\":\"rgba(6, 97, 234, 0.35)\",\"overlayColor2\":\"rgba(23, 70, 146, 0.35)\"}},{\"id\":\"d455b006-53ac-4f0c-bd1c-b10925d2d52e\",\"type\":\"ProgramasBlock\",\"content\":{\"sectionRotulo\":\"Nuestros\",\"sectionTitle\":\"programas\",\"backgroundColor\":\"#000000\",\"titleColor\":\"#ffffff\",\"items\":[{\"id\":\"1\",\"title\":\"Start\",\"subtitle\":\"Descubre oportunidades\",\"description\":\"<p>Inicia tu camino en la comunidad, desarrolla habilidades innovadoras y descubre las oportunidades para iniciar tu emprendimiento. A trav\\u00e9s de charlas inspiradoras, ideathones con retos empresariales, ferias y workshops especializados.<\\/p><p><br><\\/p><p><br><\\/p><p><strong>Innova Ignite, Emprende ESAN, Innovation&amp;Research Week, etc<\\/strong><\\/p>\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772144195_agrupacion.webp\",\"color1\":\"rgba(33, 118, 255, 0.7)\",\"color2\":\"rgba(0, 33, 77, 0.7)\"},{\"id\":\"2\",\"title\":\"Explorer\",\"subtitle\":\"Valida el cliente y demanda\",\"description\":\"<p>Aprende nuevas metodolog\\u00edas y herramientas \\u00e1giles para implementarlas en tu proyecto de emprendimiento. Validar el cliente y el mercado ser\\u00e1 clave para el buen desarrollo de producto y la etapa comercial. Adem\\u00e1s, descubre en la comunidad a tu futuro socio.<\\/p><p><br><\\/p><p><br><\\/p><p><strong>Modalidad:<\\/strong><\\/p><p> Online <\\/p><p><br><\\/p><p><strong>Santander X Explorer con el apoyo Innova ESAN.<\\/strong><\\/p>\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772144195_agrupacion.webp\",\"color1\":\"rgba(33, 118, 255, 0.60)\",\"color2\":\"rgba(0, 33, 77, 0.60)\"},{\"id\":\"3\",\"title\":\"Venture Lab\",\"subtitle\":\"Mejora tu producto e inicia ventas\",\"description\":\"<p>El programa de incubaci\\u00f3n de empresas con el que validas tu PMV y las condiciones para iniciar tu empresa, primeras ventas y estar listo para buscar financiamiento. Recibir\\u00e1s gu\\u00eda de nuestra red de mentores y seguimiento de nuestro staff. S\\u00e9 parte de nuestra red de la emprendedores de ESAN.<\\/p><p><br><\\/p><p><br><\\/p><p><strong>The Business Challenge:<\\/strong><\\/p><p> Concurso de becas hasta el 13 de febrero.<\\/p><p><br><\\/p><p><strong>Venture Lab:<\\/strong><\\/p><p> marzo-julio <\\/p><p><br><\\/p><p><strong>Modalidad:<\\/strong><\\/p><p> H\\u00edbrida<\\/p>\",\"image\":\"imagenes\\/incubacion.png\",\"color1\":\"rgba(33, 118, 255, 0.60)\",\"color2\":\"rgba(0, 33, 77, 0.60)\"},{\"id\":\"4\",\"title\":\"Venture Capital 101\",\"subtitle\":\"Inicia tu camino como inversionista\",\"description\":\"<p>Conoce los primeros pasos para convertirte en un inversionista en startups. Aprende de los protagonistas del ecosistema de venture capital en Per\\u00fa y Latam y descubre los beneficios de ser parte de la red. <\\/p><p><br><\\/p><p><br><\\/p><p><strong>Inicio:<\\/strong><\\/p><p> abril 2025 <\\/p><p><br><\\/p><p><strong>Modalidad:<\\/strong><\\/p><p> virtual <\\/p><p><br><\\/p><p><strong>Duraci\\u00f3n:<\\/strong><\\/p><p> 6 semanas <\\/p><p><br><\\/p><p>Fundamentos de Venture Capital con PECAP<\\/p>\",\"image\":\"imagenes\\/aceleracion.png\",\"color1\":\"rgba(33, 118, 255, 0.60)\",\"color2\":\"rgba(0, 33, 77, 0.60)\"}]}},{\"id\":\"b9ca3fec-8635-48a5-9fe6-45df24d978c1\",\"type\":\"VisitanosBlock\",\"content\":{\"title\":\"campus esan\",\"address\":\"Jr. Alonso de Molina 1652, Santiago de Surco 15023\",\"mapUrl\":\"https:\\/\\/www.google.com\\/maps\\/embed?pb=!1m18!1m12!1m3!1d3900.7417483669145!2d-76.9655655241477!3d-12.105436188136357!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c71363650f95%3A0xd64d7dfae5435b80!2sUniversidad%20ESAN!5e0!3m2!1ses-419!2spe!4v1700000000000!5m2!1ses-419!2spe\",\"backgroundColor\":\"#ffffff\",\"textColor\":\"#333333\",\"invertLayout\":false}},{\"id\":\"d2fb3a39-d0b7-46c4-8d7a-0b0de4235e9a\",\"type\":\"FooterBlock\",\"content\":{\"logoUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772052600_logoinnova.webp\",\"respaldoLogoUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772231396_logoesan.webp\",\"reclamacionesLogoUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/mba\\/2026\\/02\\/1772230149_libroreclamaciones.webp\",\"linkedinUrl\":\"https:\\/\\/www.linkedin.com\\/\",\"instagramUrl\":\"https:\\/\\/www.instagram.com\\/\",\"siteMapLinks\":[{\"text\":\"Home\",\"url\":\"#\"},{\"text\":\"\\u00bfQuienes somos?\",\"url\":\"#\"}],\"masEsanLinks\":[{\"text\":\"Posgrado\",\"url\":\"#\"},{\"text\":\"Pregrado\",\"url\":\"#\"}],\"address\":\"Alonso de Molina 1652...\",\"phone\":\"317-7200\",\"email\":\"innovaesan@esan.edu.pe\",\"reclamacionesUrl\":\"https:\\/\\/intranet.esan.edu.pe\\/...\",\"copyrightText\":\"\\u00a9 Copyright 2025...\",\"backgroundColor\":\"#1a1a1a\",\"textColor\":\"#ffffff\"}}]', NULL, NULL, 'published', '{\"title\":\"Pagina de Prueba\",\"description\":null}', NULL, '2026-02-25 02:21:11', '2026-03-23 18:28:04', NULL, '#000000', '\'Montserrat\', sans-serif'),
(4, 2, 12, 'Ingeniera de Sistemas DPA', 'ingenieria-de-sistemas-dpa', 'landing', '[{\"id\":\"e7d77d5e-c649-4e2f-8945-337718e8ba35\",\"type\":\"NavbarBlock\",\"content\":{\"bgColor\":\"#ffffff\",\"buttonColor\":\"#8c357f\",\"buttonTextColor\":\"#ffffff\",\"logoImage\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/posgrado\\/2026\\/03\\/1773176523_dpa-esan-carrerasparagentequetrabaja-color.webp\",\"showButton\":true,\"buttonText\":\"COMUN\\u00cdCATE\",\"buttonLink\":\"#comunicate\",\"isSticky\":true}},{\"id\":\"e927f689-4e66-4a3b-88c7-dd4157d467b0\",\"type\":\"CareerHeroBlock\",\"content\":{\"name\":\"DPA Ingenier\\u00eda de Sistemas\",\"description\":\"DESARROLLA TECNOLOG\\u00cdAS DE INFORMACI\\u00d3N EN BENEFICIO DE TU EMPRESA U ORGANIZACI\\u00d3N\",\"branding_color\":\"#4e1a3d\",\"bg_overlay\":\"rgba(24, 8, 38, 0.8)\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/posgrado\\/2026\\/03\\/1773073721_bg.webp\",\"form_config\":{\"campaign_id\":8,\"title\":\"Comun\\u00edcate\",\"subtitle\":\"D\\u00e9janos tus datos y un asesor absolver\\u00e1 tus dudas.\",\"button_text\":\"Enviar mensaje\",\"success_title\":\"\\u00a1Solicitud enviada!\",\"success_message\":\"\\u00a1Gracias! Nos contactaremos pronto.\",\"show_phone\":true,\"show_consult\":true},\"curriculum_json\":[{\"modality\":\"Presencial\",\"url\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/posgrado\\/2026\\/03\\/1773075987_ingsistemas-presencial.pdf\"},{\"modality\":\"Semipresencial\",\"url\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/images\\/dpa\\/files\\/Ing.Sistemas-Semipresencial.pdf\"},{\"modality\":\"A Distancia\",\"url\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/images\\/dpa\\/files\\/Ing_Sist-A-Distancia.pdf\"}]}},{\"id\":\"9f185698-905c-4102-b508-1fc4015e067e\",\"type\":\"CountersBlock\",\"content\":{\"title\":\"Por qu\\u00e9 elegir ESAN\",\"counters\":[{\"prefix\":\"TOP\",\"number\":1,\"label\":\"Escuela de Posgrado\",\"note\":\"*\"},{\"prefix\":\"TOP\",\"number\":5,\"label\":\"Carreras Universitarias\",\"note\":\"*\"},{\"prefix\":\"+\",\"number\":17200,\"label\":\"Graduados de Pregrado y Maestr\\u00edas\",\"note\":null},{\"prefix\":\"TOP\",\"number\":3,\"label\":\"Ranking Merco Empresas 2024\",\"note\":null}]}},{\"id\":\"c14f087d-960b-4ec9-ad15-982bddffd911\",\"type\":\"AboutCareerBlock\",\"content\":{\"tag\":\"ACERCA DE LA CARRERA\",\"title\":\"\\u00a1Bienvenido a la carrera de Ingenier\\u00eda de Sistemas para gente que trabaja!\",\"subtitle\":\"La carrera de Ingenier\\u00eda de Sistemas forma profesionales con una visi\\u00f3n estrat\\u00e9gica de la gesti\\u00f3n de las organizaciones, basado en el tratamiento sofisticado de la informaci\\u00f3n.\",\"description\":\"Desarrollar\\u00e1s habilidades para modelar sistemas de negocio, crear modelos de toma de decisiones y detectar oportunidades para implementar tecnolog\\u00edas de informaci\\u00f3n alineadas con los objetivos organizacionales. Adem\\u00e1s, adquirir\\u00e1s nuevas competencias t\\u00e9cnicas en gesti\\u00f3n, lo que te permitir\\u00e1 aprovechar la tecnolog\\u00eda en beneficio de tu empresa.\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/posgrado\\/2026\\/03\\/1773073721_bg.webp\",\"bgColor\":\"#ffffff\",\"textColor\":\"#1e1e1e\",\"tagColor\":\"#8c357f\"}},{\"id\":\"4c9e2570-c453-41aa-b33e-eba583c2e005\",\"type\":\"VideoBlock\",\"content\":{\"title\":\"CAF\\u00c9 DPA con Joseph Ball\\u00f3n\",\"description\":\"C\\u00f3mo la carrera de Ingenier\\u00eda de Sistemas integra conocimientos y habilidades para abordar las diversas \\u00e1reas del mercado laboral actual.\",\"videoUrl\":\"https:\\/\\/www.youtube.com\\/watch?v=dQw4w9WgXcQ\",\"bgImage\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/posgrado\\/2026\\/03\\/1773073721_bg.webp\",\"textColor\":\"#ffffff\",\"overlayColor\":\"#020a12\",\"overlayOpacity\":0.7}},{\"id\":\"1ad54029-4771-43e5-bf9d-f52fb7656d1d\",\"type\":\"CareerDevelopmentBlock\",\"content\":{\"bgColor\":\"#fcf5fb\",\"textColor\":\"#1e293b\",\"accentColor\":\"#8c357f\",\"devTitle\":\"Desarrollo Profesional\",\"devSubtitle\":\"Como graduado, podr\\u00e1s trabajar en:\",\"devImage\":\"https:\\/\\/images.unsplash.com\\/photo-1573164713988-8665fc963095?q=80&w=800&auto=format&fit=crop\",\"devItems\":[\"Posiciones de gerencia en \\u00e1reas de tecnolog\\u00eda de la informaci\\u00f3n.\",\"Gerencia en inteligencia de negocios.\",\"Gerencia en tecnolog\\u00edas de informaci\\u00f3n.\",\"Consultor\\u00eda independiente.\",\"Administrador de proyectos de tecnolog\\u00eda.\"],\"specTitle\":\"\\u00c1reas de Especializaci\\u00f3n\",\"specSubtitle\":\"Nuestra carrera cuenta con una estructura curricular flexible, que te brinda una amplia gama de cr\\u00e9ditos electivos para que personalices tu formaci\\u00f3n y potencies tus oportunidades laborales al finalizar tus estudios.\",\"specItems\":[{\"title\":\"Sistemas de Informaci\\u00f3n\",\"icon\":\"bi-cpu\"},{\"title\":\"Ciencias de Datos\",\"icon\":\"bi-database\"},{\"title\":\"Nueva Especializaci\\u00f3n\",\"icon\":\"bi bi-star\"}]}},{\"id\":\"414f5c33-3231-4b37-8869-70ab16b981b7\",\"type\":\"CareerDetailsBlock\",\"content\":{\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/posgrado\\/2026\\/03\\/1773073721_bg.webp\",\"boxBgColor\":\"#fcf5fb\",\"iconColor\":\"#8c357f\",\"textColor\":\"#1e1e1e\",\"items\":[{\"icon\":\"bi bi-calendar3\",\"text\":\"10 Semestres\"},{\"icon\":\"bi bi-mortarboard\",\"text\":\"200 Cr\\u00e9ditos\"},{\"icon\":\"bi bi-book\",\"text\":\"Grado de Bachiller en Ingenier\\u00eda de Sistemas\"},{\"icon\":\"bi bi-bank\",\"text\":\"T\\u00edtulo de Ingeniero de Sistemas\"}]}},{\"id\":\"71fca49f-7a18-4df4-9e5a-557408ff11f1\",\"type\":\"FooterBlockLanding\",\"content\":{\"bgColor\":\"#151e2d\",\"textColor\":\"#e2e8f0\",\"iconHoverColor\":\"#8c357f\",\"logoImage\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/posgrado\\/2026\\/03\\/1773176223_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"slogan\":\"Trabajar y estudiar es crecer X 2.\",\"copyrightText\":\"Universidad ESAN.\",\"socialLinks\":{\"linkedin\":\"https:\\/\\/www.linkedin.com\\/school\\/universidad-esan\\/\",\"facebook\":\"https:\\/\\/www.facebook.com\\/uesan\\/\",\"instagram\":\"https:\\/\\/www.instagram.com\\/uesan_oficial\\/\",\"twitter\":\"https:\\/\\/twitter.com\\/universidadesan\"}}}]', NULL, NULL, 'published', '{\"title\":\"Ingeniera de Sistemas DPA\",\"description\":null}', NULL, '2026-03-09 21:21:20', '2026-03-21 02:35:24', NULL, NULL, 'Arial, sans-serif'),
(5, 2, 12, 'Inicio', 'inicio', 'page', '[{\"type\":\"ImpactHeroBlock\",\"id\":\"39ed5394-edf5-469f-b34a-cf3102840f40\",\"content\":{\"title\":\"POSGRADO\",\"description\":\"La Unidad de Laboratorio de ESANDATA logra renovar la certificaci\\u00f3n ISO 9001-2015\",\"image\":\"\\/images\\/logos-juntos.png\",\"btnText\":\"M\\u00c1S INFORMACI\\u00d3N\",\"btnLink\":\"\\/noticias\\/iso-9001\",\"config\":{\"bgImage\":\"https:\\/\\/images.unsplash.com\\/photo-1497366216548-37526070297c?auto=format&fit=crop&q=80\",\"align\":\"left\",\"paddingTop\":\"80\",\"paddingBottom\":\"80\"}}},{\"type\":\"CallToActionBlock\",\"id\":\"c4ee56d8-cdc8-46ca-b414-ba4ed10fdefc\",\"content\":{\"preTitle\":\"NUESTROS\",\"title\":\"SERVICIOS\",\"btnText\":\"M\\u00c1S INFORMACI\\u00d3N\",\"btnLink\":\"\\/atencin-a-alumnos-docentes-y-personal-administrativo\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/\\/storage\\/media\\/1770062588_nuestros-proyectos.webp\",\"config\":{\"bgColor\":\"transparent\",\"invertLayout\":true}}},{\"type\":\"CallToActionBlock\",\"id\":\"fafbc6cd-d8bc-4a13-a7f9-e1de858485c6\",\"content\":{\"preTitle\":\"NUESTROS\",\"title\":\"PROYECTOS\",\"btnText\":\"M\\u00c1S INFORMACI\\u00d3N\",\"btnLink\":\"\\/noticias\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/\\/storage\\/media\\/1770062562_nuestros-servicios.webp\",\"config\":{\"bgColor\":\"transparent\",\"invertLayout\":false}}},{\"type\":\"FeatureBanner\",\"id\":\"adf6db3d-1229-43c8-9fa1-2b35a0ff4f46\",\"content\":{\"title\":\"M\\u00e1s de 250 instituciones p\\u00fablicas y privadas atendidas.\",\"buttonText\":\"CONT\\u00c1CTANOS\",\"buttonLink\":\"#contact_section\",\"backgroundImage\":null}}]', NULL, NULL, 'published', '{\"title\":\"Posgrado Esan\",\"description\":\"Domina el futuro con nuestro nuevo diplomado en Inteligencia Artificial.\"}', NULL, '2026-03-17 03:15:14', '2026-03-19 02:20:45', NULL, '#ff8121', '\'Playfair Display\', serif'),
(6, 2, 12, 'Nosotros', 'nosotros', 'page', '[{\"id\":\"eaa7c17e-552e-428d-85b4-1b1ca40d7b45\",\"type\":\"BannerHero\",\"content\":{\"autoPlayInterval\":5000,\"slides\":[{\"id\":1,\"layout\":\"standard-mode\",\"title\":\"NOSOTROS\",\"preTitle\":null,\"btnText\":\"CONT\\u00c1CTANOS\",\"btnLink\":\"#contact\",\"imageUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/posgrado\\/2026\\/03\\/1773073721_bg.webp\"}]}}]', NULL, NULL, 'published', '{\"title\":\"Nosotros\",\"description\":null}', NULL, '2026-03-21 02:33:43', '2026-03-21 02:34:20', NULL, '#ff8121', 'Arial, sans-serif'),
(7, 4, 12, 'Inicio', 'inicio', 'page', '[{\"id\":\"30902013-55c2-4a27-99a6-76a1af4050ac\",\"type\":\"HeaderDynamic\",\"content\":{\"logoDesktop\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"logoMobile\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"logoUrl\":\"#\",\"textColor\":\"#ffffff\",\"bgColor\":\"transparent\",\"menuItems\":[]}},{\"id\":\"820eb7d5-5594-4f1a-8ec8-5e2cbe18dbd4\",\"type\":\"HeroWelcome\",\"content\":{\"title\":\"BIENVENIDOS AL DPA\",\"subtitle\":\"Formaci\\u00f3n profesional universitaria de adultos con experiencia laboral\",\"bgImage\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774382381_fondo-principal.webp\",\"mainImage\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774382058_imagen-crece.webp\",\"overlayOpacity\":0.8,\"textColor\":\"#ffffff\",\"btnColor\":\"#ff3131\",\"primaryBtnText\":\"INSCR\\u00cdBETE A LAS CHARLAS\",\"primaryBtnUrl\":\"\\/landingdpa\\/landing\\/charla\",\"secondaryBtnText\":\"SOLICITA INFORMACI\\u00d3N\",\"secondaryBtnUrl\":\"\\/landingdpa\\/landing\\/comunicate\",\"items\":[]}},{\"id\":\"4aaf9783-5ed2-43f4-b8c6-5c273ad981b4\",\"type\":\"FooterSimple\",\"content\":{\"bgColor\":\"#151515\",\"textColor\":\"#c1bebe\",\"leftText\":\"\\u00a9 Copyright 2024 - Universidad ESAN | Todos los derechos reservados.\",\"rightText\":\"Raz\\u00f3n Social: Universidad ESAN | RUC: 20136507720\"}}]', NULL, NULL, 'published', '{\"title\":\"Inicio\",\"description\":null}', NULL, '2026-03-23 21:46:53', '2026-05-06 01:47:45', NULL, '#ff8121', 'Arial, sans-serif'),
(8, 4, 12, 'Charla', 'charla', 'landing', '[{\"id\":\"e0bda285-bac7-4fb1-b71f-f21ae1ae12fd\",\"type\":\"HeaderDynamic\",\"content\":{\"logoDesktop\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"logoMobile\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"textColor\":\"#ffffff\",\"bgColor\":\"#ffffff\",\"bgOpacity\":\"0\",\"logoDesktopScrolled\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"logoMobileScrolled\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"textColorScrolled\":\"#000000\",\"bgColorScrolled\":\"#ff0a0a\",\"bgOpacityScrolled\":\"1\",\"logoUrl\":\"#\",\"menuItems\":[]}},{\"id\":\"3e5b6bfc-41e4-40db-9035-5b6a2c7a65fd\",\"type\":\"FutureProfessional\",\"content\":{\"introText\":\"\\u00a1Tu futuro profesional comienza aqu\\u00ed! Reg\\u00edstrate ya y s\\u00e9 parte de nuestra charla virtual DPA.\",\"mainQuote\":\"\\u00a1MANTENTE ATENTO!\\nMuy pronto, nuevos eventos para ti.\",\"featuredImage\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774454214_miniatura-2.webp\",\"bgPattern\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774451337_fondo-dpa.webp\",\"bgGradient1\":\"#311b92\",\"bgGradient2\":\"#1a237e\",\"bgGradient3\":\"#0d1246\",\"bgPatternOpacity\":\"0.4\",\"textColor\":\"#ffffff\"}},{\"id\":\"fab29116-4e3c-46b9-b43c-07aed7e2f11c\",\"type\":\"StudyWorkBanner\",\"content\":{\"title\":\"ESTUDIAR Y TRABAJAR ES POSIBLE\",\"subtitle\":\"ENCUENTRA EL BALANCE PARA CRECER PROFESIONALMENTE SIN DESCUIDAR TU TRABAJO.\",\"bgColor\":\"#ffffff\",\"bgPattern\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774453574_fondo-amarillo.webp\",\"bgPatternOpacity\":\"1\",\"titleColor\":\"#000000\",\"subtitleColor\":\"#000000\",\"fontFamily\":\"inherit\"}},{\"id\":\"62c439f0-5ddb-4407-829b-19b932a6ef68\",\"type\":\"FeatureSplit\",\"content\":{\"title\":\"MODALIDAD PRESENCIAL Y SEMIPRESENCIAL\",\"description\":\"Estudia en el campus, en tu casa o\\n en el lugar que desees.\",\"imageSrc\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774455332_modalidad-semipresencial2.webp\",\"btnText\":\"M\\u00c1S INFORMACI\\u00d3N\",\"btnUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774455258_esan-dpa-semipresencial-adjunto-para-folleto.pdf\",\"bgColor\":\"#ffffff\",\"btnColor\":\"#ff2b2b\",\"textColor\":\"#333333\",\"titleColor\":\"#000000\",\"inverted\":false}},{\"id\":\"a7aeea35-e1f4-491b-bad2-6f4fe857c846\",\"type\":\"BenefitsSplit\",\"content\":{\"title\":\"\\u00bfPOR QU\\u00c9 ESTUDIAR EN EL DPA?\",\"imageSrc\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774455865_img-02.webp\",\"bgColor\":\"#f8f9fa\",\"titleColor\":\"#000000\",\"textColor\":\"#555555\",\"features\":[{\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774455802_ico-a.webp\",\"title\":\"RESPALDO DE ESAN\",\"text\":\"Toda la experiencia y liderazgo de ESAN est\\u00e1 presente en el DPA, lo que asegura un alto nivel de calidad.\"},{\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774455807_ico-b.webp\",\"title\":\"GRADO Y T\\u00cdTULO A NOMBRE DE LA NACI\\u00d3N\",\"text\":\"El DPA otorga grados y t\\u00edtulos a nombre de la Naci\\u00f3n en cumplimiento de la Ley.\"},{\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774455832_ico-c.webp\",\"title\":\"EDUCACI\\u00d3N GERENCIAL\",\"text\":\"Nuestras carreras universitarias para gente que trabaja est\\u00e1n orientadas a la gesti\\u00f3n empresarial. Formamos profesionales que se posicionen como l\\u00edderes.\"},{\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774455837_ico-d.webp\",\"title\":\"GRADO Y T\\u00cdTULO A NOMBRE DE LA NACI\\u00d3N\",\"text\":\"El DPA de la Universidad ESAN otorga grados y t\\u00edtulos a nombre de la Naci\\u00f3n en cumplimiento de la Ley Universitaria vigente.\"},{\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774455841_ico-e.webp\",\"title\":\"CLASES EN HORARIOS FLEXIBLES\",\"text\":\"Para todos los cursos de nuestra modalidad presencial, ofrecemos clases 2 veces por semana los s\\u00e1bados y domingos; mientras que para los cursos virtuales de nuestra modalidad semipresencial, ofrecemos la posibilidad de escoger clases de lunes a viernes por la noche \\u00f3 s\\u00e1bados y domingos.\"},{\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774455846_ico-f.webp\",\"title\":\"METODOLOG\\u00cdA DE ENSE\\u00d1ANZA\",\"text\":\"Utilizamos la Andragog\\u00eda, que es un conjunto de t\\u00e9cnicas de ense\\u00f1anza orientadas a educar a personas adultas.\"}]}},{\"id\":\"df38982d-9982-4898-9f59-17acbf096aa6\",\"type\":\"StudyWorkBanner\",\"content\":{\"title\":\"ESTUDIA SIN DEJAR DE TRABAJAR EN EL DPA DE LA UNIVERSIDAD ESAN\",\"subtitle\":\"ENCUENTRA EL BALANCE PARA CRECER PROFESIONALMENTE SIN DESCUIDAR TU TRABAJO.\",\"titleSize\":\"24\",\"subtitleSize\":\"10\",\"contentWidth\":\"530\",\"bgColor\":\"#000000\",\"bgPattern\":null,\"bgPatternOpacity\":0.15,\"titleColor\":\"#ffffff\",\"subtitleColor\":\"#000000\",\"fontFamily\":\"inherit\"}},{\"id\":\"2cc94d64-a9a8-46a2-a324-da233b053c0e\",\"type\":\"FooterSimple\",\"content\":{\"bgColor\":\"#151515\",\"textColor\":\"#a3a3a3\",\"leftText\":\"\\u00a9 Copyright 2024 - Universidad ESAN | Todos los derechos reservados.\",\"rightText\":\"Raz\\u00f3n Social: Universidad ESAN | RUC: 20136507720\"}}]', NULL, NULL, 'published', '{\"title\":\"Comun\\u00edcate\",\"description\":null}', NULL, '2026-03-25 19:31:27', '2026-03-25 22:11:03', NULL, '#ff8121', 'Arial, sans-serif'),
(9, 4, 12, 'Comunícate', 'comunicate', 'landing', '[{\"id\":\"db2c6067-3282-459e-a35f-ae838a8b24fd\",\"type\":\"HeaderDynamic\",\"content\":{\"logoDesktop\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"logoMobile\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"textColor\":\"#ffffff\",\"bgColor\":\"transparent\",\"bgOpacity\":0,\"logoDesktopScrolled\":null,\"logoMobileScrolled\":null,\"textColorScrolled\":\"#ffffff\",\"bgColorScrolled\":\"#74071a\",\"bgOpacityScrolled\":1,\"logoUrl\":\"\\/landingdpa\",\"menuItems\":[{\"label\":\"CARRERAS\",\"url\":\"#sec-c8f42dc9-81e1-490a-a8b1-b8f73ea4cc0d\"},{\"label\":\"BENEFICIOS\",\"url\":\"#sec-f177e594-0dae-47c7-afd3-2b8619811f76\"},{\"label\":\"TESTIMONIOS\",\"url\":\"#sec-62c90f73-f3b3-4e38-b55b-2580bea68861\"}]}},{\"id\":\"842a361b-a677-410a-92fc-4f78114d1642\",\"type\":\"LeadFormHero\",\"content\":{\"bgImage\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774472025_comunicatefondo.webp\",\"formPosition\":\"izquierda\",\"themeColor\":\"#e73636\",\"linkColor\":\"#ffffff\",\"mainTitle\":\"\\u00a1TRANSFORMA TU FUTURO! DA EL PRIMER PASO HACIA TU EXCELENCIA PROFESIONAL\",\"subTitle\":\"D\\u00e9janos tus datos y un asesor absolver\\u00e1 tus dudas.\",\"marketingTitle\":\"\\u00a1TRANSFORMA TU FUTURO! DA EL PRIMER PASO HACIA TU EXCELENCIA PROFESIONAL\",\"marketingDescription\":null,\"marketingImage\":null,\"formConfig\":{\"bgImage\":\"https:\\/\\/www.ue.edu.pe\\/img\\/home\\/fondo-carreras-dpa.jpg\",\"themeColor\":\"#ff2b2b\",\"mainTitle\":\"\\u00a1TRANSFORMA TU FUTURO! DA EL PRIMER PASO HACIA TU EXCELENCIA PROFESIONAL\",\"subTitle\":\"D\\u00e9janos tus datos y un asesor absolver\\u00e1 tus dudas.\",\"marketingTitle\":\"INVIERTE EN TU EXCELENCIA\",\"campaign_id\":9,\"cod_form_old\":\"2\",\"condition\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/politica-de-privacidad\",\"button_text\":\"Enviar\",\"success_title\":\"\\u00a1Solicitud enviada!\",\"success_message\":\"Un asesor se pondr\\u00e1 en contacto contigo muy pronto.\",\"show_phone\":true,\"show_consult\":true,\"show_courses\":true,\"courses_list\":[{\"id\":8,\"name\":\"Administraci\\u00f3n con Menci\\u00f3n en Direcci\\u00f3n de Empresas\"},{\"id\":9,\"name\":\"Contabilidad y Finanzas\"},{\"id\":10,\"name\":\"Derecho\"},{\"id\":11,\"name\":\"Ingenier\\u00eda de Sistemas\"},{\"id\":12,\"name\":\"Ingenier\\u00eda Industrial\"},{\"id\":13,\"name\":\"Marketing y Direcci\\u00f3n Comercial\"},{\"id\":14,\"name\":\"Negocios Internacionales\"},{\"id\":15,\"name\":\"Psicolog\\u00eda\"}]}}},{\"id\":\"07e11bd6-19a9-4862-81cc-2de4fb40ff30\",\"type\":\"SingleImage\",\"content\":{\"imageUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774540452_excelencia.webp\",\"alignment\":\"center\",\"maxWidth\":\"100%\",\"padding\":\"py-0\"}},{\"id\":\"c8f42dc9-81e1-490a-a8b1-b8f73ea4cc0d\",\"type\":\"DpaProgramsGrid\",\"content\":{\"title\":\"CARRERAS PARA GENTE CON EXPERIENCIA LABORAL\",\"subtitle\":null,\"programs\":[{\"id\":8,\"name\":\"Administraci\\u00f3n con Menci\\u00f3n en Direcci\\u00f3n de Empresas\",\"link\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/dpa\\/carreras\\/administracion-con-mencion-en-direccion-de-empresas\",\"color\":\"#12c2c0\",\"image\":\"https:\\/\\/ue.edu.pe\\/pregrado\\/images\\/dpa\\/carreras\\/administracion.png\",\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776283536_administraciondpa-icono.webp\"},{\"id\":9,\"name\":\"Contabilidad y Finanzas\",\"link\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/dpa\\/carreras\\/contabilidad-y-finanzas\",\"color\":\"#759773\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776272713_contabilidad.webp\",\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776283589_icono-contabilidad.webp\"},{\"id\":10,\"name\":\"Derecho\",\"link\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/dpa\\/carreras\\/derecho\",\"color\":\"#5570f7\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776272772_derecho.webp\",\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776283609_derechodpa-icono.webp\"},{\"id\":11,\"name\":\"Ingenier\\u00eda de Sistemas\",\"link\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/dpa\\/carreras\\/ingenieria-de-sistemas\",\"color\":\"#a23eb6\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776272853_ingsistema.webp\",\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776283732_sistemasdpa-icono.webp\"},{\"id\":12,\"name\":\"Ingenier\\u00eda Industrial\",\"link\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/dpa\\/carreras\\/ingenieria-industrial\",\"color\":\"#d85aaa\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776272888_ingindustrial.webp\",\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776283750_industrialdpa-icono.webp\"},{\"id\":13,\"name\":\"Marketing y Direcci\\u00f3n Comercial\",\"link\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/dpa\\/carreras\\/marketing-y-direccion-comercial\",\"color\":\"#1d92ed\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776272919_marketing.webp\",\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776283770_marketingdpa-icono.webp\"},{\"id\":14,\"name\":\"Negocios Internacionales\",\"link\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/dpa\\/carreras\\/negocios-internacionales\",\"color\":\"#2e5094\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776272969_negocio.webp\",\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776283783_negociosdpa-icono.webp\"},{\"id\":15,\"name\":\"Psicolog\\u00eda\",\"link\":\"https:\\/\\/www.ue.edu.pe\\/pregrado\\/dpa\\/carreras\\/psicologia\",\"color\":\"#e49090\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776272990_psicologia.webp\",\"icon\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776283795_icono-psicologia.webp\"}],\"bgType\":\"image\",\"bgColor\":\"#f8f9fa\",\"bgImage\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776271861_fondo-imagen2.webp\",\"bgGradient\":\"linear-gradient(90deg, #00A89E 0%, #18b5dc 100%)\",\"titleColor\":\"#ffffff\",\"titleSize\":\"2rem\",\"subtitleColor\":\"#6c757d\",\"subtitleSize\":\"1.25rem\"}},{\"id\":\"f177e594-0dae-47c7-afd3-2b8619811f76\",\"type\":\"SingleImage\",\"content\":{\"imageUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/03\\/1774541521_porque-estudiasdpa.webp\",\"alignment\":\"center\",\"maxWidth\":\"100%\",\"padding\":\"py-0\"}},{\"id\":\"5d16b2d6-2f6e-4731-a7e6-3c9f09dd05c3\",\"type\":\"MultiModalidadSection\",\"content\":{\"bgType\":\"image\",\"bgColor\":\"#ffffff\",\"bgImage\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/05\\/1777995840_fondo-color-rojo.webp\",\"bgGradient\":\"linear-gradient(135deg, #f0f0f0 0%, #ffffff 100%)\",\"padding\":{\"top\":80,\"bottom\":80},\"imageLeft\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/05\\/1777995812_3-modalidades1.webp\",\"spaceHeight\":30,\"buttonText\":\"M\\u00c1S INFORMACI\\u00d3N\",\"buttonUrl\":\"#\",\"buttonTarget\":\"_blank\",\"imageRight\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/05\\/1777995870_nueva-modalidad.webp\"}},{\"id\":\"62c90f73-f3b3-4e38-b55b-2580bea68861\",\"type\":\"TestimonialSlider\",\"content\":{\"bgType\":\"color\",\"bgColor\":\"#2a1515\",\"bgImage\":null,\"bgGradient\":\"linear-gradient(135deg, #2a1515 0%, #1a0d0d 100%)\",\"titleColor\":\"#ffffff\",\"titleSize\":\"1.8rem\",\"quoteColor\":\"#f8f9fa\",\"quoteSize\":\"1.1rem\",\"authorColor\":\"#cccccc\",\"authorSize\":\"0.9rem\",\"title\":\"ESTUDIA CON LOS PROFESIONALES DE LOS NEGOCIOS\",\"testimonials\":[{\"id\":1776285361358,\"quote\":\"\\\"La carrera de Ingenier\\u00eda de Sistemas integra la tecnolog\\u00eda con los negocios, lo que es clave para hacer frente a la transformaci\\u00f3n digital que hoy experimentamos\\\".\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776285469_03-daniella-tapia-1.webp\",\"name\":\"Daniella Tapia Villanes\",\"role\":\"Alumna Ingenier\\u00eda de Sistemas (Analista de Transformaci\\u00f3n Digital)\"},{\"id\":1776285478321,\"quote\":\"\\\"Nuevo testimonio sobre la experiencia educativa\\\".\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776285456_01-manuel-1.webp\",\"name\":\"Nombre del Alumno\",\"role\":\"Carrera y Cargo actual\"},{\"id\":1776285504320,\"quote\":\"\\\"Nuevo testimonio sobre la experiencia educativa\\\".\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776285464_02-daniella-paredes-1.webp\",\"name\":\"Nombre del Alumno\",\"role\":\"Carrera y Cargo actual\"}]}},{\"id\":\"f3b7c513-838f-4144-a5ed-1e79529306a1\",\"type\":\"DarkFooter\",\"content\":{\"bgColor\":\"#0a0a0a\",\"textColor\":\"#ffffff\",\"fontFamily\":\"Montserrat, sans-serif\",\"socials\":[{\"icon\":\"fa-brands fa-facebook-f\",\"url\":\"#\"},{\"icon\":\"fa-brands fa-instagram\",\"url\":\"#\"},{\"icon\":\"fa-brands fa-youtube\",\"url\":\"#\"},{\"icon\":\"fa-brands fa-linkedin-in\",\"url\":\"#\"},{\"icon\":\"fa-brands fa-tiktok\",\"url\":\"#\"}],\"complaintsBookImg\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/landingdpa\\/2026\\/04\\/1776286268_libro-reclamaciones.webp\",\"complaintsBookUrl\":\"#\",\"locationTitle\":\"UB\\u00cdCANOS\",\"locationText\":\"Alonso de Molina 1652, Monterrico, Surco, Lima - Per\\u00fa\",\"locationEmail\":\"exitoesan@ue.edu.pe\",\"scheduleTitle\":\"HORARIOS DE ATENCI\\u00d3N\",\"scheduleText\":\"Oficina de Admisi\\u00f3n de Pregrado\\nHorario de atenci\\u00f3n presencial: Lunes a viernes de 10:00 - 6:45 p.m.\",\"copyright\":\"\\u00a9 Copyright 2024 - Universidad ESAN | Todos los derechos reservados.\",\"companyInfo\":\"Raz\\u00f3n Social: Universidad ESAN | RUC: 20136507720\"}}]', NULL, NULL, 'published', '{\"title\":\"Comun\\u00edcate\",\"description\":null}', NULL, '2026-03-25 21:59:31', '2026-05-06 01:47:04', NULL, '#ff8121', 'Inter');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `leads`
--

CREATE TABLE `leads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `campaign_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Respuestas dinámicas' CHECK (json_valid(`payload`)),
  `marketing_metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'UTMs, IP, Device, Referrer' CHECK (json_valid(`marketing_metadata`)),
  `status` enum('new','contacted','converted','spam') DEFAULT 'new',
  `external_sync_status` varchar(50) DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `leads`
--

INSERT INTO `leads` (`id`, `campaign_id`, `first_name`, `last_name`, `email`, `phone`, `payload`, `marketing_metadata`, `status`, `external_sync_status`, `created_at`) VALUES
(1, 1, 'Juan', 'Pérez', 'juan@email.com', '999888777', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"12332112\",\"estudios_superiores\":\"Universitarios Completos\",\"consulta\":\"asdasdasda\",\"programa_origen\":\"DPA Ingenier\\u00eda de Sistemas1\",\"acepta_publicidad\":true}', '{\"ip_address\":\"127.0.0.1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/145.0.0.0 Safari\\/537.36\",\"referrer\":\"http:\\/\\/localhost:3000\\/\"}', 'new', 'pending', '2026-02-18 02:39:58'),
(2, 8, 'Juan', 'Pérez', 'juan@email.com', '999888777', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"12332112\",\"estudios_superiores\":\"Universitarios Completos\",\"consulta\":\"asdasdasda\",\"programa_origen\":\"DPA Ingenier\\u00eda de Sistemas1\",\"acepta_publicidad\":true}', '{\"ip_address\":\"127.0.0.1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/145.0.0.0 Safari\\/537.36\",\"referrer\":\"http:\\/\\/localhost:3000\\/\"}', 'new', 'pending', '2026-02-18 21:20:47'),
(3, 8, 'adsadsad', 'asdasda asdadsa', 'juan@gmail.com', '321321321', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"12332112\",\"estudios_superiores\":\"Universitarios Completos\",\"consulta\":\"asdasdasda\",\"programa_origen\":\"DPA Ingenier\\u00eda de Sistemas1\",\"acepta_publicidad\":true}', '{\"ip_address\":\"127.0.0.1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/145.0.0.0 Safari\\/537.36\",\"referrer\":\"http:\\/\\/localhost:3000\\/\"}', 'new', 'pending', '2026-03-10 01:01:27'),
(4, 8, 'Juan Sideral', 'Lujan Carrion', 'juan@gmail.com', '987987789', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"87667831\",\"estudios_superiores\":\"Universitarios Incompletos\",\"consulta\":\"Quisiera Saber sobre consulta 123\",\"programa_origen\":\"DPA Ingenier\\u00eda de Sistemas\",\"acepta_publicidad\":true}', '{\"ip_address\":\"127.0.0.1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/146.0.0.0 Safari\\/537.36\",\"referrer\":\"http:\\/\\/localhost:3000\\/\"}', 'new', 'pending', '2026-03-20 03:56:07'),
(5, 9, 'Sideral', 'Lujan Carrion', 'juan@gmail.com', '987654312', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"12345678\",\"estudios_superiores\":\"Universitarios Completos\",\"consulta\":\"Juan\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"acepta_publicidad\":true}', '{\"ip_address\":\"127.0.0.1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/146.0.0.0 Safari\\/537.36\",\"referrer\":\"http:\\/\\/localhost:3000\\/\"}', 'new', 'pending', '2026-03-26 02:08:20'),
(6, 9, 'Juan Sideral', 'Lujan Carrion', 'juan@gmail.com', '912211221', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"98765432\",\"estudios_superiores\":\"Universitarios Incompletos\",\"consulta\":\"adsdasddsa\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Contabilidad y Finanzas\",\"url_slug\":\"comunicate\",\"acepta_publicidad\":true}', '{\"ip_address\":\"127.0.0.1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/146.0.0.0 Safari\\/537.36\",\"referrer\":\"http:\\/\\/localhost:3000\\/\"}', 'new', 'pending', '2026-03-26 02:16:00'),
(7, 9, 'Juan', 'Lujan Carrion', 'juan@gmail.com', '987654321', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"12332132\",\"estudios_superiores\":\"T\\u00e9cnicos incompletos\",\"consulta\":\"Consulta 123\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Psicolog\\u00eda\",\"url_slug\":\"comunicate\",\"acepta_publicidad\":true}', '{\"ip_address\":\"127.0.0.1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/146.0.0.0 Safari\\/537.36\",\"referrer\":\"http:\\/\\/localhost:3000\\/\"}', 'new', 'pending', '2026-03-27 20:54:30'),
(8, 9, 'Prueba', 'Pruebaa Pruebaaa', 'prueba@gmail.com', '912321123', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"87655678\",\"estudios_superiores\":\"T\\u00e9cnicos incompletos\",\"consulta\":\"adsasdads\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Contabilidad y Finanzas\",\"url_slug\":\"comunicate\",\"acepta_publicidad\":true}', '{\"ip_address\":\"127.0.0.1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/146.0.0.0 Safari\\/537.36\",\"referrer\":\"http:\\/\\/localhost:3000\\/\"}', 'new', 'pending', '2026-03-27 21:06:14'),
(9, 9, 'asdadsasda', 'asdasdasd asdads', 'juan123@gmail.com', '987123333', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"12332112\",\"estudios_superiores\":\"T\\u00e9cnicos completos\",\"consulta\":\"adasdassa\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Contabilidad y Finanzas\",\"url_slug\":\"comunicate\",\"acepta_publicidad\":true}', '{\"ip_address\":\"127.0.0.1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/146.0.0.0 Safari\\/537.36\",\"referrer\":\"http:\\/\\/localhost:3000\\/\"}', 'new', 'pending', '2026-03-27 21:27:23'),
(10, 9, 'Prueba Nombre', 'Apellido ApellidoMaterno', 'juan312@gmail.com', '987987789', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"87654444\",\"estudios_superiores\":\"T\\u00e9cnicos incompletos\",\"consulta\":\"Consulta123\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Derecho\",\"url_slug\":\"comunicate\",\"acepta_publicidad\":true}', '{\"ip_address\":\"127.0.0.1\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/146.0.0.0 Safari\\/537.36\",\"referrer\":\"http:\\/\\/localhost:3000\\/\"}', 'new', 'pending', '2026-03-27 22:10:40'),
(11, 9, 'Juan', 'Paterno Materno', 'juanitotorres.842@gmail.com', '987654321', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"98765432\",\"estudios_superiores\":\"T\\u00e9cnicos completos\",\"consulta\":\"Consulta de Prueba\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Ingenier\\u00eda de Sistemas\",\"url_slug\":\"comunicate\",\"acepta_publicidad\":true,\"slug_carrera\":\"comunicate\"}', '[]', 'new', 'pending', '2026-03-27 22:40:22'),
(12, 9, 'Pureba', 'Pruebasa Pruebaaa', 'juan123@gmail.com', '999777666', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"87654321\",\"estudios_superiores\":\"T\\u00e9cnicos completos\",\"consulta\":\"adsdasdasdads\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Administraci\\u00f3n con Menci\\u00f3n en Direcci\\u00f3n de Empresas\",\"url_slug\":\"comunicate\",\"acepta_publicidad\":true,\"slug_carrera\":\"comunicate\"}', '[]', 'new', 'pending', '2026-03-27 22:43:56'),
(13, 9, 'Juan Prueba', 'Prueba Apellido', 'juna123312@gmail.com', '981212312', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"98765412\",\"estudios_superiores\":\"T\\u00e9cnicos completos\",\"consulta\":\"Consulta\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Contabilidad y Finanzas\",\"url_slug\":\"comunicate\",\"acepta_publicidad\":true,\"slug_carrera\":\"comunicate\"}', '[]', 'new', 'pending', '2026-03-28 00:36:04'),
(14, 9, 'Probando', 'Formulario Prueba', 'prueba@gmail.com', '998877665', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"99887766\",\"estudios_superiores\":\"T\\u00e9cnicos incompletos\",\"consulta\":\"Consulta de prueba\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Ingenier\\u00eda de Sistemas\",\"url_slug\":\"comunicate\",\"acepta_publicidad\":true,\"slug_carrera\":\"comunicate\"}', '[]', 'new', 'pending', '2026-03-28 00:42:49'),
(15, 9, 'Formulario de PRUEBA', 'PRUEBA PRUEBA', 'prueba@gmail.com', '987654321', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"98765432\",\"estudios_superiores\":\"T\\u00e9cnicos incompletos\",\"consulta\":\"asdadasd\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Contabilidad y Finanzas\",\"url_slug\":\"comunicate\",\"acepta_publicidad\":true,\"slug_carrera\":\"comunicate\"}', '[]', 'new', 'pending', '2026-03-28 00:46:55'),
(16, 9, 'Juan', 'Prueba Pruebaaa', 'juan@gmail.com', '987654321', '{\"tipo_documento\":\"DNI\",\"numero_documento\":\"98765123\",\"apellido_materno\":\"Pruebaaa\",\"estudios_superiores\":\"Universitarios completos\",\"consulta\":\"czxcxxczcxzzcxzcx\",\"programa_origen\":\"Carrera de Inter\\u00e9s\",\"curso_interes\":\"Contabilidad y Finanzas\",\"url_slug\":\"comunicate\",\"acepta_condiciones\":true,\"acepta_publicidad\":true,\"cod_form_old\":\"2\",\"slug_carrera\":\"comunicate\"}', '[]', 'new', 'pending', '2026-03-28 01:12:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marketing_campaigns`
--

CREATE TABLE `marketing_campaigns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `study_program_id` bigint(20) UNSIGNED DEFAULT NULL,
  `content_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'La landing page asociada',
  `academic_period` varchar(50) NOT NULL COMMENT 'Ej: 2026-I',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `form_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Configuración dinámica del formulario de captación' CHECK (json_valid(`form_config`)),
  `utm_source_default` varchar(100) DEFAULT 'web',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `marketing_campaigns`
--

INSERT INTO `marketing_campaigns` (`id`, `academic_unit_id`, `name`, `slug`, `study_program_id`, `content_id`, `academic_period`, `start_date`, `end_date`, `form_config`, `utm_source_default`, `is_active`, `created_at`) VALUES
(1, 1, 'Campaña de Captación Verano 2026', 'captacion-verano-2026', NULL, NULL, '2026-I', '2026-02-01', '2026-03-18', '{\"fields\": [{\"name\": \"empresa_actual\", \"type\": \"text\"}, {\"name\": \"anios_experiencia\", \"type\": \"select\"}]}', 'facebook', 1, '2026-02-17 21:32:06'),
(2, 1, 'Admision Verano 2026', 'admision-verano-2026', NULL, NULL, '2026-I', '2026-01-10', '2026-03-10', '{\"fields\":[{\"name\":\"name\",\"type\":\"text\"}]}', 'web', 1, '2026-02-24 22:07:43'),
(5, 3, 'Campaña 4', 'campana-4', NULL, NULL, '2026-I', '2026-02-24', '2026-02-24', '{\"fields\":[{\"name\":\"nombre\",\"type\":\"text\"}]}', 'web', 1, '2026-02-25 02:20:43'),
(6, 3, 'Dpa Verano', 'dpa-verano', NULL, NULL, '2026-I', '2026-02-25', '2026-02-25', '{\"fields\":[{\"name\":\"nombre\",\"type\":\"text\"}]}', 'web', 1, '2026-02-25 20:53:41'),
(7, 3, 'asdasdasdasdasd', 'asdasdasdasdasd', NULL, NULL, 'asdadssadasd', '2026-02-27', '2026-02-27', '{\"fields\":[]}', 'web', 1, '2026-02-28 04:07:57'),
(8, 2, 'Admision Verano 2026 DPA', 'admision-verano-2026-dpa', NULL, NULL, '2026-I', '2026-03-09', '2026-03-31', '{\"fields\":[]}', 'web', 1, '2026-03-10 00:32:24'),
(9, 4, 'Campaña de Prueba', 'campana-de-prueba', NULL, NULL, '20206-I', '2026-03-25', '2026-05-14', '{\"fields\":[]}', 'web', 1, '2026-03-26 01:55:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `media`
--

CREATE TABLE `media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `folder_id` bigint(20) UNSIGNED DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `url` varchar(500) NOT NULL,
  `path` varchar(500) NOT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `size` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `media`
--

INSERT INTO `media` (`id`, `academic_unit_id`, `folder_id`, `filename`, `url`, `path`, `mime_type`, `size`, `created_at`) VALUES
(2, 1, 10, '1771947395_1.webp', 'http://127.0.0.1:8000/storage/media/pregrado/2026/02/1771947395_1.webp', 'public/media/pregrado/2026/02/1771947395_1.webp', 'image/webp', 100898, '2026-02-24 20:36:36'),
(3, 1, 11, '1771948381_image.webp', 'http://127.0.0.1:8000//storage/media/pregrado/2026/02/1771948381_image.webp', 'public/media/pregrado/2026/02/1771948381_image.webp', 'image/webp', 16500, '2026-02-24 20:53:01'),
(4, 1, NULL, '1771948581_161.webp', 'http://127.0.0.1:8000//storage/media/pregrado/2026/02/1771948581_161.webp', 'public/media/pregrado/2026/02/1771948581_161.webp', 'image/webp', 39468, '2026-02-24 20:56:22'),
(5, 1, 11, '1771967222_18.webp', 'http://127.0.0.1:8000//storage/media/pregrado/2026/02/1771967222_18.webp', 'public/media/pregrado/2026/02/1771967222_18.webp', 'image/webp', 13914, '2026-02-25 02:07:02'),
(6, 3, 12, '1771968115_18.webp', 'http://127.0.0.1:8000//storage/media/mba/2026/02/1771968115_18.webp', 'public/media/mba/2026/02/1771968115_18.webp', 'image/webp', 13914, '2026-02-25 02:21:56'),
(7, 3, 14, '1772040596_bizagi-modeler.webp', 'http://127.0.0.1:8000//storage/media/mba/2026/02/1772040596_bizagi-modeler.webp', 'public/media/mba/2026/02/1772040596_bizagi-modeler.webp', 'image/webp', 1656, '2026-02-25 22:29:56'),
(8, 3, 14, '1772051034_slider01.webp', 'http://127.0.0.1:8000//storage/media/mba/2026/02/1772051034_slider01.webp', 'public/media/mba/2026/02/1772051034_slider01.webp', 'image/webp', 262386, '2026-02-26 01:23:55'),
(9, 3, 14, '1772052600_logoinnova.webp', 'http://127.0.0.1:8000//storage/media/mba/2026/02/1772052600_logoinnova.webp', 'public/media/mba/2026/02/1772052600_logoinnova.webp', 'image/webp', 2668, '2026-02-26 01:50:00'),
(10, 3, 14, '1772056653_habitos-atomicos-james-clear.pdf', 'http://127.0.0.1:8000//storage/media/mba/2026/02/1772056653_habitos-atomicos-james-clear.pdf', 'public/media/mba/2026/02/1772056653_habitos-atomicos-james-clear.pdf', 'application/pdf', 2253442, '2026-02-26 02:57:33'),
(11, 3, 14, '1772056660_presentacion.webp', 'http://127.0.0.1:8000//storage/media/mba/2026/02/1772056660_presentacion.webp', 'public/media/mba/2026/02/1772056660_presentacion.webp', 'image/webp', 101032, '2026-02-26 02:57:40'),
(12, 3, 14, '1772142697_equipo.webp', 'http://127.0.0.1:8000//storage/media/mba/2026/02/1772142697_equipo.webp', 'public/media/mba/2026/02/1772142697_equipo.webp', 'image/webp', 33142, '2026-02-27 02:51:38'),
(13, 3, 14, '1772144195_agrupacion.webp', 'http://127.0.0.1:8000//storage/media/mba/2026/02/1772144195_agrupacion.webp', 'public/media/mba/2026/02/1772144195_agrupacion.webp', 'image/webp', 70590, '2026-02-27 03:16:36'),
(14, 3, 14, '1772230149_libroreclamaciones.webp', 'http://127.0.0.1:8000//storage/media/mba/2026/02/1772230149_libroreclamaciones.webp', 'public/media/mba/2026/02/1772230149_libroreclamaciones.webp', 'image/webp', 2736, '2026-02-28 03:09:10'),
(15, 3, 14, '1772231396_logoesan.webp', 'http://127.0.0.1:8000//storage/media/mba/2026/02/1772231396_logoesan.webp', 'public/media/mba/2026/02/1772231396_logoesan.webp', 'image/webp', 920, '2026-02-28 03:29:56'),
(16, 2, 16, '1773073721_bg.webp', 'http://127.0.0.1:8000//storage/media/posgrado/2026/03/1773073721_bg.webp', 'public/media/posgrado/2026/03/1773073721_bg.webp', 'image/webp', 91450, '2026-03-09 21:28:44'),
(17, 2, 16, '1773075987_ingsistemas-presencial.pdf', 'http://127.0.0.1:8000//storage/media/posgrado/2026/03/1773075987_ingsistemas-presencial.pdf', 'public/media/posgrado/2026/03/1773075987_ingsistemas-presencial.pdf', 'application/pdf', 4733425, '2026-03-09 22:06:27'),
(18, 2, 17, '1773176223_dpa-esan-carrerasparagentequetrabaja-blanco.webp', 'http://127.0.0.1:8000//storage/media/posgrado/2026/03/1773176223_dpa-esan-carrerasparagentequetrabaja-blanco.webp', 'public/media/posgrado/2026/03/1773176223_dpa-esan-carrerasparagentequetrabaja-blanco.webp', 'image/webp', 5272, '2026-03-11 01:57:03'),
(19, 2, 17, '1773176523_dpa-esan-carrerasparagentequetrabaja-color.webp', 'http://127.0.0.1:8000//storage/media/posgrado/2026/03/1773176523_dpa-esan-carrerasparagentequetrabaja-color.webp', 'public/media/posgrado/2026/03/1773176523_dpa-esan-carrerasparagentequetrabaja-color.webp', 'image/webp', 7520, '2026-03-11 02:02:03'),
(20, 1, 18, '1773848225_logo-esan.webp', 'http://127.0.0.1:8000//storage/media/pregrado/2026/03/1773848225_logo-esan.webp', 'public/media/pregrado/2026/03/1773848225_logo-esan.webp', 'image/webp', 41824, '2026-03-18 20:37:06'),
(21, 4, 19, '1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp', 'public/media/landingdpa/2026/03/1774285184_dpa-esan-carrerasparagentequetrabaja-blanco.webp', 'image/webp', 5272, '2026-03-23 21:59:44'),
(22, 4, 20, '1774382058_imagen-crece.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774382058_imagen-crece.webp', 'public/media/landingdpa/2026/03/1774382058_imagen-crece.webp', 'image/webp', 34858, '2026-03-25 00:54:19'),
(23, 4, 20, '1774382381_fondo-principal.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774382381_fondo-principal.webp', 'public/media/landingdpa/2026/03/1774382381_fondo-principal.webp', 'image/webp', 17330, '2026-03-25 00:59:41'),
(24, 4, 20, '1774451337_fondo-dpa.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774451337_fondo-dpa.webp', 'public/media/landingdpa/2026/03/1774451337_fondo-dpa.webp', 'image/webp', 23504, '2026-03-25 20:08:58'),
(25, 4, 20, '1774453574_fondo-amarillo.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774453574_fondo-amarillo.webp', 'public/media/landingdpa/2026/03/1774453574_fondo-amarillo.webp', 'image/webp', 6050, '2026-03-25 20:46:14'),
(26, 4, 20, '1774454214_miniatura-2.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774454214_miniatura-2.webp', 'public/media/landingdpa/2026/03/1774454214_miniatura-2.webp', 'image/webp', 64426, '2026-03-25 20:56:54'),
(27, 4, 21, '1774455258_esan-dpa-semipresencial-adjunto-para-folleto.pdf', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774455258_esan-dpa-semipresencial-adjunto-para-folleto.pdf', 'public/media/landingdpa/2026/03/1774455258_esan-dpa-semipresencial-adjunto-para-folleto.pdf', 'application/pdf', 299060, '2026-03-25 21:14:18'),
(28, 4, 20, '1774455332_modalidad-semipresencial2.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774455332_modalidad-semipresencial2.webp', 'public/media/landingdpa/2026/03/1774455332_modalidad-semipresencial2.webp', 'image/webp', 48456, '2026-03-25 21:15:32'),
(29, 4, 22, '1774455802_ico-a.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774455802_ico-a.webp', 'public/media/landingdpa/2026/03/1774455802_ico-a.webp', 'image/webp', 1092, '2026-03-25 21:23:22'),
(30, 4, 22, '1774455807_ico-b.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774455807_ico-b.webp', 'public/media/landingdpa/2026/03/1774455807_ico-b.webp', 'image/webp', 1392, '2026-03-25 21:23:27'),
(31, 4, 22, '1774455832_ico-c.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774455832_ico-c.webp', 'public/media/landingdpa/2026/03/1774455832_ico-c.webp', 'image/webp', 826, '2026-03-25 21:23:52'),
(32, 4, 22, '1774455837_ico-d.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774455837_ico-d.webp', 'public/media/landingdpa/2026/03/1774455837_ico-d.webp', 'image/webp', 1320, '2026-03-25 21:23:57'),
(33, 4, 22, '1774455841_ico-e.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774455841_ico-e.webp', 'public/media/landingdpa/2026/03/1774455841_ico-e.webp', 'image/webp', 1798, '2026-03-25 21:24:01'),
(34, 4, 22, '1774455846_ico-f.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774455846_ico-f.webp', 'public/media/landingdpa/2026/03/1774455846_ico-f.webp', 'image/webp', 2128, '2026-03-25 21:24:06'),
(35, 4, 20, '1774455865_img-02.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774455865_img-02.webp', 'public/media/landingdpa/2026/03/1774455865_img-02.webp', 'image/webp', 53396, '2026-03-25 21:24:25'),
(36, 4, 20, '1774472025_comunicatefondo.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774472025_comunicatefondo.webp', 'public/media/landingdpa/2026/03/1774472025_comunicatefondo.webp', 'image/webp', 17178, '2026-03-26 01:53:46'),
(37, 4, 20, '1774540452_excelencia.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774540452_excelencia.webp', 'public/media/landingdpa/2026/03/1774540452_excelencia.webp', 'image/webp', 92404, '2026-03-26 20:54:12'),
(38, 4, 20, '1774541521_porque-estudiasdpa.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/03/1774541521_porque-estudiasdpa.webp', 'public/media/landingdpa/2026/03/1774541521_porque-estudiasdpa.webp', 'image/webp', 126422, '2026-03-26 21:12:02'),
(39, 4, 20, '1776271861_fondo-imagen2.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776271861_fondo-imagen2.webp', 'public/media/landingdpa/2026/04/1776271861_fondo-imagen2.webp', 'image/webp', 61676, '2026-04-15 21:51:03'),
(40, 4, 23, '1776272564_administracion.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776272564_administracion.webp', 'public/media/landingdpa/2026/04/1776272564_administracion.webp', 'image/webp', 6946, '2026-04-15 22:02:44'),
(41, 4, 23, '1776272713_contabilidad.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776272713_contabilidad.webp', 'public/media/landingdpa/2026/04/1776272713_contabilidad.webp', 'image/webp', 6890, '2026-04-15 22:05:13'),
(42, 4, 23, '1776272772_derecho.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776272772_derecho.webp', 'public/media/landingdpa/2026/04/1776272772_derecho.webp', 'image/webp', 7056, '2026-04-15 22:06:12'),
(43, 4, 23, '1776272853_ingsistema.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776272853_ingsistema.webp', 'public/media/landingdpa/2026/04/1776272853_ingsistema.webp', 'image/webp', 7408, '2026-04-15 22:07:33'),
(44, 4, 23, '1776272888_ingindustrial.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776272888_ingindustrial.webp', 'public/media/landingdpa/2026/04/1776272888_ingindustrial.webp', 'image/webp', 6952, '2026-04-15 22:08:08'),
(45, 4, 23, '1776272919_marketing.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776272919_marketing.webp', 'public/media/landingdpa/2026/04/1776272919_marketing.webp', 'image/webp', 7686, '2026-04-15 22:08:39'),
(46, 4, 23, '1776272969_negocio.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776272969_negocio.webp', 'public/media/landingdpa/2026/04/1776272969_negocio.webp', 'image/webp', 8098, '2026-04-15 22:09:29'),
(47, 4, 23, '1776272990_psicologia.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776272990_psicologia.webp', 'public/media/landingdpa/2026/04/1776272990_psicologia.webp', 'image/webp', 6828, '2026-04-15 22:09:50'),
(48, 4, 24, '1776283536_administraciondpa-icono.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776283536_administraciondpa-icono.webp', 'public/media/landingdpa/2026/04/1776283536_administraciondpa-icono.webp', 'image/webp', 200, '2026-04-16 01:05:36'),
(49, 4, 24, '1776283589_icono-contabilidad.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776283589_icono-contabilidad.webp', 'public/media/landingdpa/2026/04/1776283589_icono-contabilidad.webp', 'image/webp', 364, '2026-04-16 01:06:29'),
(50, 4, 24, '1776283609_derechodpa-icono.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776283609_derechodpa-icono.webp', 'public/media/landingdpa/2026/04/1776283609_derechodpa-icono.webp', 'image/webp', 316, '2026-04-16 01:06:49'),
(51, 4, 24, '1776283732_sistemasdpa-icono.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776283732_sistemasdpa-icono.webp', 'public/media/landingdpa/2026/04/1776283732_sistemasdpa-icono.webp', 'image/webp', 238, '2026-04-16 01:08:52'),
(52, 4, 24, '1776283750_industrialdpa-icono.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776283750_industrialdpa-icono.webp', 'public/media/landingdpa/2026/04/1776283750_industrialdpa-icono.webp', 'image/webp', 332, '2026-04-16 01:09:10'),
(53, 4, 24, '1776283770_marketingdpa-icono.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776283770_marketingdpa-icono.webp', 'public/media/landingdpa/2026/04/1776283770_marketingdpa-icono.webp', 'image/webp', 462, '2026-04-16 01:09:30'),
(54, 4, 24, '1776283783_negociosdpa-icono.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776283783_negociosdpa-icono.webp', 'public/media/landingdpa/2026/04/1776283783_negociosdpa-icono.webp', 'image/webp', 378, '2026-04-16 01:09:43'),
(55, 4, 24, '1776283795_icono-psicologia.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776283795_icono-psicologia.webp', 'public/media/landingdpa/2026/04/1776283795_icono-psicologia.webp', 'image/webp', 958, '2026-04-16 01:09:55'),
(56, 4, 25, '1776285456_01-manuel-1.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776285456_01-manuel-1.webp', 'public/media/landingdpa/2026/04/1776285456_01-manuel-1.webp', 'image/webp', 21324, '2026-04-16 01:37:36'),
(57, 4, 25, '1776285464_02-daniella-paredes-1.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776285464_02-daniella-paredes-1.webp', 'public/media/landingdpa/2026/04/1776285464_02-daniella-paredes-1.webp', 'image/webp', 19042, '2026-04-16 01:37:44'),
(58, 4, 25, '1776285469_03-daniella-tapia-1.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776285469_03-daniella-tapia-1.webp', 'public/media/landingdpa/2026/04/1776285469_03-daniella-tapia-1.webp', 'image/webp', 14404, '2026-04-16 01:37:49'),
(59, 4, 26, '1776286268_libro-reclamaciones.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/04/1776286268_libro-reclamaciones.webp', 'public/media/landingdpa/2026/04/1776286268_libro-reclamaciones.webp', 'image/webp', 2854, '2026-04-16 01:51:08'),
(60, 4, 20, '1777995812_3-modalidades1.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/05/1777995812_3-modalidades1.webp', 'public/media/landingdpa/2026/05/1777995812_3-modalidades1.webp', 'image/webp', 27734, '2026-05-05 20:43:38'),
(61, 4, 20, '1777995840_fondo-color-rojo.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/05/1777995840_fondo-color-rojo.webp', 'public/media/landingdpa/2026/05/1777995840_fondo-color-rojo.webp', 'image/webp', 25574, '2026-05-05 20:44:08'),
(62, 4, 20, '1777995870_nueva-modalidad.webp', 'http://127.0.0.1:8000//storage/media/landingdpa/2026/05/1777995870_nueva-modalidad.webp', 'public/media/landingdpa/2026/05/1777995870_nueva-modalidad.webp', 'image/webp', 50766, '2026-05-05 20:44:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `media_folders`
--

CREATE TABLE `media_folders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `media_folders`
--

INSERT INTO `media_folders` (`id`, `parent_id`, `academic_unit_id`, `name`, `created_at`) VALUES
(9, NULL, 1, 'DPA', '2026-02-24 19:42:52'),
(10, 9, 1, '1', '2026-02-24 19:43:07'),
(11, 9, 1, '2', '2026-02-24 20:52:06'),
(12, NULL, 3, 'Imagenes', '2026-02-25 02:21:46'),
(13, NULL, 3, 'Paginas', '2026-02-25 22:29:39'),
(14, 13, 3, 'Inicio', '2026-02-25 22:29:48'),
(15, NULL, 2, 'PROGRAMAS', '2026-03-09 21:21:51'),
(16, 15, 2, 'ING DE SISTEMAS', '2026-03-09 21:21:59'),
(17, NULL, 2, 'LOGO', '2026-03-11 01:56:57'),
(18, NULL, 1, 'Logo', '2026-03-18 20:36:57'),
(19, NULL, 4, 'Logo', '2026-03-23 21:59:29'),
(20, NULL, 4, 'Imagen', '2026-03-25 00:54:11'),
(21, NULL, 4, 'PDF', '2026-03-25 21:14:13'),
(22, NULL, 4, 'Icono', '2026-03-25 21:23:15'),
(23, NULL, 4, 'Carreras', '2026-04-15 22:02:11'),
(24, 23, 4, 'Iconos', '2026-04-16 01:05:28'),
(25, NULL, 4, 'Testimonios', '2026-04-16 01:36:24'),
(26, NULL, 4, 'Footer', '2026-04-16 01:50:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `menus`
--

INSERT INTO `menus` (`id`, `academic_unit_id`, `name`, `location`) VALUES
(1, 2, 'Menú Principal Header', 'header'),
(2, 1, 'Menu Principal', 'header');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_items`
--

CREATE TABLE `menu_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Para menús anidados (hijos)',
  `content_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'ID del contenido/página interna',
  `title` varchar(100) NOT NULL COMMENT 'Texto que se verá en el menú',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL externa o manual (si no usa content_id)',
  `order` int(11) DEFAULT 0 COMMENT 'Posición en el menú',
  `target` enum('_self','_blank') DEFAULT '_self' COMMENT '¿Abrir en misma pestaña o nueva?',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `parent_id`, `content_id`, `title`, `url`, `order`, `target`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 5, 'Inicio', NULL, 1, '_self', '2026-02-19 19:52:39', '2026-03-17 03:15:41'),
(2, 1, NULL, 6, 'Nosotros', NULL, 2, '_self', '2026-03-13 21:07:31', '2026-03-21 02:34:35'),
(3, 2, NULL, 1, 'Inicio', NULL, 1, '_self', '2026-03-18 20:37:35', '2026-03-18 20:37:35'),
(4, 2, NULL, 2, 'Nosotros', NULL, 2, '_self', '2026-03-18 20:37:40', '2026-03-18 20:37:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_04_03_214921_create_personal_access_tokens_table', 1),
(5, '2025_04_07_022344_create_permission_tables', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 9),
(1, 'App\\Models\\User', 12),
(2, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 6),
(2, 'App\\Models\\User', 11),
(3, 'App\\Models\\User', 7),
(3, 'App\\Models\\User', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'dashboard', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(2, 'register_user', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(3, 'list_user', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(4, 'edit_user', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(5, 'delete_user', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(6, 'register_role', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(7, 'list_role', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(8, 'edit_role', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(9, 'delete_role', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(10, 'register_category', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(11, 'list_category', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(12, 'edit_category', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(13, 'delete_category', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(14, 'register_course', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(15, 'list_course', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(16, 'edit_course', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(17, 'delete_course', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(18, 'register_post', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(19, 'list_post', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(20, 'edit_post', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(21, 'delete_post', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(22, 'register_menu_item', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(23, 'list_menu_item', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(24, 'edit_menu_item', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(25, 'delete_menu_item', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(26, 'register_media', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(27, 'list_media', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(28, 'edit_media', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(29, 'delete_media', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(30, 'register_lead', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(31, 'list_lead', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(32, 'edit_lead', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(33, 'delete_lead', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(34, 'register_news', 'api', '2026-01-16 14:38:17', '2026-01-16 14:38:17'),
(35, 'list_news', 'api', '2026-01-16 14:38:17', '2026-01-16 14:38:17'),
(36, 'edit_news', 'api', '2026-01-16 14:38:17', '2026-01-16 14:38:17'),
(37, 'delete_news', 'api', '2026-01-16 14:38:17', '2026-01-16 14:38:17'),
(38, 'register_manual', 'api', '2026-02-11 16:11:07', '2026-02-11 16:11:07'),
(39, 'list_manual', 'api', '2026-02-11 16:11:07', '2026-02-11 16:11:07'),
(40, 'edit_manual', 'api', '2026-02-11 16:11:07', '2026-02-11 16:11:07'),
(41, 'delete_manual', 'api', '2026-02-11 16:11:07', '2026-02-11 16:11:07'),
(42, 'register_academic_unit', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(43, 'list_academic_unit', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(44, 'edit_academic_unit', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(45, 'delete_academic_unit', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(46, 'register_study_program', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(47, 'list_study_program', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(48, 'edit_study_program', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(49, 'delete_study_program', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(50, 'register_campaign', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(51, 'list_campaign', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(52, 'edit_campaign', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(53, 'delete_campaign', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(54, 'register_setting', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(55, 'list_setting', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(56, 'edit_setting', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(57, 'delete_setting', 'api', '2026-02-25 14:29:41', '2026-02-25 14:29:41'),
(58, 'register_page', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(59, 'list_page', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(60, 'edit_page', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(61, 'delete_page', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(62, 'register_menu', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(63, 'list_menu', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(64, 'edit_menu', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(65, 'delete_menu', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(66, 'register_media_folder', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(67, 'list_media_folder', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(68, 'edit_media_folder', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(69, 'delete_media_folder', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(70, 'register_branding', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(71, 'list_branding', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(72, 'edit_branding', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(73, 'delete_branding', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(74, 'register_company', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(75, 'list_company', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(76, 'edit_company', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22'),
(77, 'delete_company', 'api', '2026-04-30 16:23:22', '2026-04-30 16:23:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `type` enum('news','event') NOT NULL DEFAULT 'news',
  `excerpt` text DEFAULT NULL,
  `body` longtext DEFAULT NULL,
  `featured_image_path` varchar(255) DEFAULT NULL,
  `status` enum('draft','published','archived') NOT NULL DEFAULT 'draft',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `posts`
--

INSERT INTO `posts` (`id`, `academic_unit_id`, `category_id`, `title`, `slug`, `type`, `excerpt`, `body`, `featured_image_path`, `status`, `start_date`, `end_date`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 4, 'Prueba', 'prueba', 'news', 'dadadsad', '{\"html\":\"<p>asdasdadsasdasdasdsadasaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</p>\",\"layout\":\"hero\",\"author\":{\"name\":\"asdasdasd\",\"role\":\"asdasasd\",\"avatar\":\"http://127.0.0.1:8000/storage/media/posgrado/2026/03/1773073721_bg.webp\"},\"extra\":{\"read_time\":\"5 min\",\"tags\":[\"adsads\",\"asd\",\"aaa\",\"a\",\"aa\",\"adsad\",\"asdadsdsa\",\"ads\",\"adadss\"]}}', 'http://127.0.0.1:8000/storage/media/posgrado/2026/03/1773073721_bg.webp', 'published', '2026-03-19 00:00:00', '2026-04-17 00:00:00', '2026-03-20 01:23:44', '2026-03-21 00:41:05', NULL),
(2, 2, 4, 'aaa', 'aaa', 'news', 'aa', '{\"html\":\"<p>asdasdadsasdasd</p>\",\"author\":{\"name\":...', NULL, 'draft', '2026-03-19 00:00:00', '2026-03-19 00:00:00', '2026-03-20 02:12:06', '2026-03-20 02:12:11', '2026-03-20 02:12:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Super-Admin', 'api', '2026-01-05 19:28:21', '2026-01-05 19:28:21'),
(2, 'Diseñador', 'api', '2026-01-05 19:41:14', '2026-01-05 19:41:40'),
(3, 'Vista', 'api', '2026-01-05 19:52:48', '2026-01-05 19:52:48'),
(4, 'Prueba', 'api', '2026-02-25 20:32:42', '2026-02-25 20:32:42'),
(5, 'Listador', 'api', '2026-05-04 22:45:18', '2026-05-04 22:45:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(10, 2),
(10, 4),
(11, 2),
(11, 3),
(11, 4),
(11, 5),
(12, 2),
(12, 4),
(13, 2),
(13, 4),
(14, 2),
(14, 4),
(15, 2),
(15, 4),
(15, 5),
(16, 2),
(16, 4),
(17, 2),
(17, 4),
(18, 2),
(18, 4),
(19, 2),
(19, 3),
(19, 4),
(19, 5),
(20, 2),
(20, 4),
(21, 2),
(21, 4),
(22, 2),
(22, 4),
(23, 2),
(23, 3),
(23, 4),
(23, 5),
(24, 2),
(24, 4),
(25, 2),
(25, 4),
(26, 2),
(26, 4),
(27, 2),
(27, 3),
(27, 4),
(27, 5),
(28, 2),
(28, 4),
(29, 2),
(29, 4),
(30, 4),
(31, 2),
(31, 4),
(31, 5),
(32, 4),
(33, 4),
(34, 4),
(35, 4),
(35, 5),
(36, 4),
(37, 4),
(38, 4),
(39, 4),
(39, 5),
(40, 4),
(41, 4),
(42, 4),
(43, 4),
(43, 5),
(44, 4),
(45, 4),
(46, 4),
(47, 4),
(47, 5),
(48, 4),
(49, 4),
(50, 4),
(51, 4),
(51, 5),
(52, 4),
(53, 4),
(54, 4),
(55, 4),
(55, 5),
(56, 4),
(57, 4),
(59, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0Ka9gi01sQ0qqghl4arPfIXMO7OluZlzasWUK59R', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUWdEUlBRbnNpTXh6M1ZCQVdoOGVPcTBSNThldlFJMkhEYThmQ2F5RSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMjM1Nzk2XzEyLTEud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770236656),
('0SHOgltt4otDZn5AzERNnOZkWCjXrqnyVamvTo8F', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS2UzR0dIVnVzVzhYUUlFalk0Q0pGY0w4WER1U2ZxZjdoeWd2UGd0USI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766070237),
('0TY8lnEkpsMasPd7oQ9lsyo53NMERGP5RlXbMXlK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU2l1VVIwUmc2UUdCaFhZTFNPRVZvZkRvOUhWdTlXNkpVZEpFUWZRMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723228),
('0uLXe6XxeRjhC7DNC06aG2ztw1NpF0Mav3XIanMn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ2tzWUcwRVJOU0NtQXp4cUlFSlVqY2syQlFpWU1oMWV5RDJRZkFvMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723760),
('0V1ikqcRGummH1utBc6x4jMR5gYq0ZjWP6WifKlV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYVJJZzFYY1RmNTZtcUNRM1Zpb1d4THZpUGkwQndzWGdjQThybk43SSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODIwNzM5X2FjcmU0LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1766089801),
('1nKITG9CteaFH6zzA9pM8hE8TiwfRUL8MJrPKBpv', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid1Z6SUtnY0wzcTRYU0VVRkxYRTMwdzdaNXJDaDRUWldDbzZjd2lZVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768508306),
('1s4xqgNd6aN3UF2pJSli2NrXrh8ObuCHtLWpmk0d', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiakQ5VUZ2WlZUamN2V3VMdzZSY2pEb0taT2lkclVuVFJtQ0JOVlpsWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMjM1Nzk2XzEyLTEud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770235801),
('2i0lxwQygxHdEeF5Gf1Mdt3psw4gcAg1J4KIsLUu', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicm11T3Y0WVZINFZpbHM0azkxZWpmbTZ3MlVOWEJiWlVFUzVTQ2FEZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768318846),
('2WLHoXwTm36MJBnsp2gAMKigIG70Pd6B33179Fgf', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicVgxV3hMem5hV0ZJQnNuNXp2Mm50b3FKZ1hUb2VJNnFwa09NajZMWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY3NzM4ODA1XzE3NDk3NTg1Njg2ODRiMzI2ODA3ZWY1LXJlZ3VsYWNpb24ud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768321468),
('2YcjVbV6hDwFCIlNiuf37nIbbVoFw8J1qzZr2ild', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS0VuSVI3SzZyejN6UzF6MkNZTWFhQXZVdUMzQzhFcFliOGhEYWdtWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766073432),
('33pN60cDSidxlYgiyB3OvCJIwTB6BOYz18wukq3k', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidHhGQm0xcGc1S1VlckFYakg1QjhVNzhnVG1zZXhYbFRQMjFGbmRmaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NjEwX2p1bGlhcXVpc3BlYXJyaW9sYS53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766156169),
('3i0Bu19tMRrO2zfmGvYbDdymyX0iQs6pGgawOmqe', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR1M1d2xVdXhZOGxROE54c1RpU3EzT0NtMGlhUXk5T2IxY3ByQlJjUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723651),
('3ZOD5hQjkGsM0dK69XFCApefGX9pMNGKDoJxC7yG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiekVRNGpSQ1JKTzc3VTltWjFsUmJNaXFTMEVxckRPbThmRlJWNHhuZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723815),
('4jyV3rmFycj6EmN1dr8HbWSFNtYAAKVKh2bN7Ces', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYlVJMUsyR1VmVUhESXZlV0dVaFVCM2VKUWZJTThGQlh5ekQza1NDZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766069162),
('4s25v4eurPIW1lDy6GaJDMFmZZ62Znv6bbDhdv9E', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkttb2Y5anBBT3BiNkZ4dTJRSk13eFFKc09jSUZzd0hEd0sxdUpYViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NjEwX2p1bGlhcXVpc3BlYXJyaW9sYS53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766156174),
('4v50fn2tcnlqII3Exow37s1HRP4xVmWRBicoAj2t', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNGRqaDlQSERobmdtM0lySkNoS3FleEZoWFZGWWdPVVdUVTBIQzU5WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY3NzM4ODA1XzE3NDk3NTg1Njg2ODRiMzI2ODA3ZWY1LXJlZ3VsYWNpb24ud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768513396),
('4zQCfJhPA8Vu3xB4od2zrRwtGUxxC8kQTdg4AbGY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWTJWT1Y4ZURzR1p3ZG1DOHhzVzVNOGJ4VzhCZXg4YVBpcWt0cEM2eSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767720566),
('58qT0ysbAckeF8tpFQN6N55mqIQA0nTXmMBHqMKt', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQTJ0Y0s5N1Q3ckdreXRjdnd5RkZuOWFEYkx0Zk1Gd2VOWURxMFJ3UiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwNzQzNDY2X3NlbnNlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770844671),
('5aDC5FapeIyfeNVUXSWB3dFI7rImIaEGO27O7FiX', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYmhtZXZHMkpFNHRndkZ1RHdKVmNUYkw3TGRTamR2YmRjVnRjMzFVUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723412),
('5byVLZTysQ4cielpeZ3Fv08JwDfCoAwIYV2Q3KWK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaDBJSlRyT0E2ZW90VDRXVFlmZ2tKN0tpaTVoYjFhM2x0UDNnd2JOQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723339),
('5jj5h7zBpwxzmu0mM3mSvlLuUauNV9F4s3L7zyHI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaHdZQm1IR0ttdnZNRTFFc2tuU0hYb0Y1ZVhRZlB1WEJNajU3ZVFYSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723293),
('5OPUP9c36zwTvLeczgJoG3VA8V0Xo3opwXzVXCBI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaVRVYTVldUx3YmtNOW5vM1U2STdXSk5xNDRuakZSUklDZjM2eXhCWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY3NzM4ODA1XzE3NDk3NTg1Njg2ODRiMzI2ODA3ZWY1LXJlZ3VsYWNpb24ud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768321493),
('5qJuhVeVmy8kNAjmQ8FqmUZ0BEyjmMpHUPGrsDbF', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1R1WDlxT2U3UzRneDR2cEdxUE41SHJOc3VGUkdWUFR1TVV0R3NuYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723742),
('5S2gBu3vF276nnBrk6deBASdYosyxJw6pnJE8eTf', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZXQ0Ykk5MHhoTGpJS0R3b1ZoZ2Q5ZlhYOHlXTXY4U3Rwbm1FU3V5VCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODI1ODMxX2FjcmU1LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1766089787),
('5TVUoXZFYQjzWNQkt6Q1xuooM42qxwSIbbZDOJKh', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicG5nbWFoQ1JMMHdDZFFPcElUN09ONVdCZGozQ0pFdmMzeXNKTkRzZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723650),
('6KsQht6EIM8qx9lQoxvjvhMUDBUSGaVVlJgxvRBr', NULL, '127.0.0.1', 'insomnia/12.3.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT3h5M0s2RVRid1hmR0tTZlJmekNrWld0QUpYYmJlZWNXbDlMbmJOYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771512438),
('6td0fCHUHq2zEAcKhn7nHDRKJ2Irlpe3pdt13iGA', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQmJNUWg5OFdYdkV5bGZDNHFBVHVmQW9rdWprWnlLYUdNZzM1ckk4MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723255),
('750WBqMlSnO2R0l888I7YIsGnKHuKN5c2H4I3Cwg', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOENGZXkxWkt5cDNTOGY0QVNkN1VTbmFiQWxHTWFoUDNkUGNSOE11WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768572535),
('75YpZhhCJt5lgGyJKA5NyDdU6x08BK2CQ33t5S6v', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZDdRcEN3TmxtRGVVbmdUc2t1S0llSG1zN2pQNm0zbzZMcFVtY3V5dyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723633),
('79AhaePnR5EIPb73HBIhWdPYr1qboQ2wjIhSlDs9', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMG9adlZObjJwd2duVnU3Uk9VYkR3ZHp5S25NTU0xZXBZeTVGbXlOYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766091078),
('7Do5dZuGDjMr3fBaHzQP109pCor4N3H6u4RiuNGL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicTdjS2NVNWRLS2c5SnRFUWN2aVgwc1VuektPWFZuYVI0ZzBwVXhsWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723221),
('7GzPzCVA5h7p4deD8Ai5faQEItFNboel6f7wcCiq', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSExpQUNXU0VYYzhDejFTakl5ZVRXaU9od2hHZnBUbmNIVTZiN3RhZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768411237),
('8Ji3M5Kzy4zHPJbCky6uL7zdVIADcZrSnfZTfGIB', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYlhTM2xMZkp0em9hTDVFVzR6bDNIaEI5alNqTU45NEJOazNFUUR2QyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODI1ODMxX2FjcmU1LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1766089801),
('8R4uq1ZiCm3XDzK82r7aDXvjKOp0y1D3t1iEmki3', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOXpCbk5kMWtFeVZ5SVNTUHpnV3d5RnFBOGhVV3ZPeVpVTDhZOHI1TCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766069842),
('9DQ40ZAZW6YF1kifT7nU3uT7zkN3Nk3tLotCKDcD', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid0VlUUU0MlVPZmllOHdDN1BOS3NyM2ZNa05zTlNqVkZrV0p1UnBuZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723639),
('a2iCYnJ9DhP3p9JIXNd3KlH1ZFcLf5mpqWGfJn0y', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibmJHczdYSjZINnR3UDNFTzRscUZLaXBycWpsa0FoenJ2a3BjZTVtOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY5MzQxX211bmRvcHVudG9zLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766090766),
('A6Lnegh2a1S6DHPX1pNYAyFjwsPliXCJY02rw94n', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSHVPUGNUVjZ5Vm5LcFFJaEFvU2RyYWlYYXluWTJoRkxpRTBJRDlNciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768255279),
('aem8TFQmwl6eoRfqFwZwGuBcCCPNhljefb0d7Nt4', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZGg4WWczWk5FRjdvcm9IVktHZWJ2cEFqb2pOU1UzT0Y5a05sTUpnVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766072720),
('aSomtk4xARHhkZtcaMbBTdmKdvrlnKdHFO8MMwJJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicUI4a2U3ZlNhc3c5S2ZEb2d3cldnWXVEaUpSVWxzNThEWURiNFRDOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NjEwX2p1bGlhcXVpc3BlYXJyaW9sYS53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766073433),
('AtEbIW2fcXLEFrADgdzx98c7eW4F1ozWsLIta75g', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmEyVTF3dnRNaDhRY2psSEVzaHhwVExqUUVwMXJ5SFhaa3NLRzFSeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769808646),
('Aw3EZ7UfzSBbJKEw2x1YTc6toherjc63A5U29GsY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibmloS0ZxRlZ4ZlZKU3pBbTZaS2IwTHhLRW5kb1BiaXBkVDFVWnNnViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768496896),
('b1qplabABMHayNODQzhPKHaYfqNLwK7qMfgfF9i2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSEdjV0pJbzlkMlNyT2REcXRrMktoTW1OZjdOQ3BrSE1HZTBkb3B3USI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766069831),
('bBk9S7QblxnY6XTkPFHcHrPzX5VvE60Xhnlf0eyw', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieU9nYmxQcURDeVZaTmJLdzY4NFlxWkRmMk1TUHh2Qmk2MFhpMzk2WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766088143),
('BH5rfdxfairOcoHI4cb7haSnozXDK80KJod1xjgT', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkdnQ3ZYZURrcE5ieTQ3djJHaTgzbmhIbXJGWDdFUlRLaTFBbHRwRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723266),
('BKQObZa2lu7f2RLVmJs6rOgnjTFVYt5Payibe85l', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiamxpalEwck9WQURBbDhPbEVPRjBSdkpZZEE0cGFQQ2xaZDNOTnpsbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723734),
('bw6emB90w7QLXSerDEbdGJ0AvJflGh1xQSIvUXhI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWRjQ1E3Nk9BTjNnUEhyeEtYSnZxY0Y1WkxTTGt3Z2ZTRGcyNlpnYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768513386),
('c38OBSBgR21FqHjIAGipF8wltLtC5jthTqiHv2HP', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZnNyc1lidEYwdGF5dlVLM25TVUNzQjdxS01jMmFBQUk0WmVKWHlTaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723512),
('Cb6A1JvMfl3LsUViazRRD0UiqqWFZu050m7Iw7XY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZzNzZHRKVjZRZDZnQWgwaTZVbGo5UnVGcm00ZVNPdHN4RGlidXlONyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768255231),
('ci6Brg4tU1aeW9siejZGDHFvDJWmqFWpfNjkyMxQ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVXIxb1JjTTI3aWVkYXY2c25KMGhwSlIzdndGNHZqUWFwcHB1b3M5cCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723264),
('CMsvnz8sqQuAkHgOUdDJAQLupto69NJN1MO03dcI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic29zd3k4SmJyRUpFdjc3ZXQwVGhKSVlKemFteTFYdENTQkdvSnFjaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768507921),
('cOisdvN8QzMCwBVjsXK2aGcknJwIh2O5Xhh9J9dN', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTGx5U2c1QUJPWDg3MXN2dHNPd0FoWWpkMENyd2UzblZaZzVNdzNOdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723254),
('CpUeMf3jp30DfKywLWPwmYRsL2C7sikH7U8OZ0D8', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiblVXc0ZBbHZucVRZcE1QVTZCRWxLbEp5RjhHcFBqaEFmbWRMS0FHZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768505109),
('cy0TtwEfQQ5dseGowbA25QZLDSBiiEaHM7k898kt', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibWw4N2VmeG1kS0NDeUNwNXZnZXhqUEtxdTZ4YkxrUHYySG5hZGl2dyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768318816),
('D1Dn4Sdc1a6ghGFqg5U2H13LfSMgHEspJjmpv1NV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaUVVREcyYklYeUxwbGlvTDNIMHQ3bnNyWDlZdWwxYTY0dWR1czA5ZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723761),
('Da3vEl9MHZzSojSDgVP6AVsbD6d8Yh0xfxtZmfiW', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQUdRQzNTWFhJSExGNm9KOFN2N2VUb0VzOFRKb2U4dm5qNXJKWkJjNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768505107),
('dF7phmJxsfle5tz8SAq0VGFMbFZpkVvKkCNA5tJ7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibnhJemdMbU1jNjV2clBLb3J2V2IzNENhZXV3RDJlSEFtaks4aGFPNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMjM1Nzk2XzEyLTEud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770236470),
('Dl9BpSUP3rNlWVqABWXmblFGgLe4CzZc0tR14GxE', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYmdCalhpR0J3MXZxNEE1ZmZ4djFIWmJVd21USG9KcFZuRFRZR1RkbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767721209),
('DpkxfFLFYUFGgWxwo49cqj69J7Y4BQFJ3Md35pNK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib0lVZU1EZWk2OTRaNWZEQlVDTVVSZ0lMTWhibXN1eTBTVmJUNTFZMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMjM1Nzk2XzEyLTEud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770236670),
('DR9ohRE7aDfTulZvTxI5CXLo3EHZpobFWbXjOdw7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTDl5WWpDZE5UaWpFbndJUzhFUTRKdnlQZlkzSElVYThFYWdIZnpRVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NjEwX2p1bGlhcXVpc3BlYXJyaW9sYS53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766072707),
('Dra2x2M5WCNIaOpIMcbLseZMvrrI9UpKADq4mP6K', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemg2S3lRc3BSVnNUckk5UkVEV2FsZnRpU2o4Zks5Y09MeERocGo2ZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766156169),
('dSxCvQV5zzXw9Ua7OV9kmXN4lNyamHdrtZkgXvky', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieFJaemE0bjl0ZlA0VjNUdHdiOG4yNWQwQzhRaGhxZ1NSaWZTNHdnRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768496870),
('DxJ1vf57ErvqPs79NoxWdH6mAnTzsZf7Saq9vhG2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicGxZZWVoRkZCaDhPaktGVHVtZThGTDdTVVl6YlFrZnl0M2V1VEpSRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY5MzQxX211bmRvcHVudG9zLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766069341),
('DyOPJho5yAYxrBY05qCHnONrnw4WZlTru33Hjbp6', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic3dFS3FNRDdMNHVWQmJsaDJkMURUZFpzMmNsUHJQVUppRGFOcDlSbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766072693),
('ewQWzsWnujOnRMVkBmiWBCohKtcOpihobFaCHrRx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoialhwQ05tZG1rbDhJQnV0cjNXV1NBU0JXT01Nd0RrV1RKc2NxcGJuTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768411312),
('Fa16ac8H1VRXJYJhdzfkbdhnBN7EetabZE7AAmSr', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTlc2NU9ITnFDdzVoQmp1MmJZS0tNcDlTTElsSGxmN200Ynlna2dLRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMzEwNzAxX2luY29taW5nLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770647665),
('fEvEciiVKFL5d9CRwLvO3AwktvJu133DsEasSMob', NULL, '127.0.0.1', 'insomnia/12.3.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV21iaVdkQTFYMFBNWmREQ0J6OGdIUTkzbDAwcHk3d3VTVmE4ZVNwVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771431660),
('Fgxam7N7J4oYyA1oGsSRuV06jkAUahsNgSo65v78', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUDhTY3hvOEVnOHMzcTUxUkVBQXBNemVZekRxaHVEQXdaT3pBTUtKeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY5MzQxX211bmRvcHVudG9zLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766089494),
('fIMhApQM7Sb9i99ToJrQY1HaAOXOAa3PuC2L80lC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia3l0Wk05Uml1UWZ6MWc4R0t4QnZxbXVBY1dLZFFyWWJQZDZJUGhvNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767720551),
('firhLJ9rX8ulAcpxK1NhYc7NQmUOkBkHQl3PRqha', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRTA4UExnQmlLcGhkYWlwZWZCYmVFck9lS1hYSGdleHRjU2VPRWEyMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY5MzQxX211bmRvcHVudG9zLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766069626),
('FXSqdEBGgt6JoKv6MExeT6Z5wIfFewvyjDhmR85b', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiazVuU2wyS2hyRzlxR0FpeGhmeU5yUUVXM2R3SWFNUFlGSDJyVlBsaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723235),
('g3sUeOy6vMBMU49U9IH7ohtDNpNtl2QfDPESNc4W', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY2w4UWt5R2xaYmMxMHdxTHpTUkhKd3FtZTU1NVFtWmJjR21KQnlORCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODI1ODMxX2FjcmU1LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1766089818),
('g64wBMCCFzzt3aTLScBXwc5JGWtqgWa2NAKY5vYw', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaGY1ZzVBME96ZUpTSGdXRUUxaEdDTTdlcEZOdVZlbmpRR0JiOUFHRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY3NzM4ODA1XzE3NDk3NTg1Njg2ODRiMzI2ODA3ZWY1LXJlZ3VsYWNpb24ud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723351),
('gQBqpaDTB5EN1Wi9DKO5bOD6TQzStgF6P2vVSqEH', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMDhFczdheFVoM09TaGRGRUN1RU1rMm5NV2lrcmdrVG5RZ0NZUHR1aiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723749),
('GU41ifgqlalZxsPPPaLszUnewYLQq6vYFVFlemnT', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid2MyblhWczVyVU1LOUk0TTVPUDY3bFZlUk9DbkptUTMzUFpNYVhmaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723747),
('h037FAkLW7AU9MPIgRbIApSoVhkZ1sbFavmdgRDn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVBSUEZybHduM2dsYXAxNDBQZ1NJcm5WU1JyaFB2UmFDNzQ1b0Q5UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723591),
('h0ks2oVrn6WSVVRCMhUAxNZs68Zja5Mp51wTYoiX', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVnFzdGFKRDg2YlJENFFUUG5NSDJaYmZqbGpXTnl4dGdhQ3hSYnJYZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1767721272),
('HAUs2pwgjZrejf9QkOZqn7s7ntMo86qAqM2FTXja', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidHRXbXVQNWlUeEw0RmROS0RtbjZZWlYzcHE0VldZNnRNUmlKdklYNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766068272),
('HJIpAABF2P1vVsAw8FGjUmMu5LzqEDlOr4PsuaxA', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNE1nSm04Z29jWVA1ZmR3ZmxzYmJ1VnJDN3lZZmFvZERJZ2FLYnVsMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMzEwNzAxX2luY29taW5nLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770647640),
('HOQiNn50WeRcMdZARjWc4arknNx4UhnY8p2uJ6K2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaVVMV3FQdmZkTXFIblEzNm9DZWZ1eHdzOGlwODJuV3F1YWRoNDN3QSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768507927),
('HRvWxzaQbUc4rOY71JNI0jWtrHKgwb16S0Xbd2Vk', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTEMxbjNjQ1FXR2JWd0RFcEI0U0htMFFaU0JUcXIzNmhYVEdrdGdSeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723658),
('I0ULz2BUXNhqce2hBwaAQiD58Ir6YV4LgDYPXNx7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicm56enVXa3VmSHFER0RJWVdJRmNETThYMHR2M2laQkhuQ2RQRVg0diI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY5MzQxX211bmRvcHVudG9zLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766069712),
('I6myXYgcahqQVY83efZoxkhZxcr1ZytAJdc1iMGV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQWltY3NJaVVqNnRRN2ZsVXE2cDh1cDdFVWdldDJRNWVoc2xKS0hVWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766072656),
('iKUcElci62FRElh88lNHZU3fek9thMr2ZzNQIKt4', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNGE3QlFFTklyTXY2aXJReURMYXo5YjZ2TkZHVXM0ano5a1lneDczVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766068926),
('iNAcd2817WnVrqdF3F8XUacZjowg2t3EQkRfnG8e', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWUx1cG5yMmFINkJZWUJsNXJsd2p4ODlna200WUxXM3VWVGo0MmpzQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwNzQzNDY2X3NlbnNlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770844668),
('IQsZoiAv5eHmdEoQ3a1UIk5nm45T8o7dgMCPMJmO', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib0FGRjdKT3ZvSmI5QmdTdGttYXFCY2FKUmtlT3BRclY3dVdNUjBKVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766070211),
('iroSes6q3KkujlNo54N73f3ywCXcgBL9R5kuukrb', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaWFyUjZROXF3WTdGdDdmcTVVcTZ0M1daSEpPVnViVDFKQWpVSm9vSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723752),
('IrwhiO6Qxts37lOPXLK25qLn7nAlp9WRzrdiYJl9', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTU5iQWsyQmgxQTlDYURpYVYzcEJkd293VTJ3REpwMTRUdlU3V3ZaWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMjM1Nzk2XzEyLTEud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770236394),
('IsLsI1Gxi01PETtAHv4dC9WVW979wPZzQgR0faCx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVWdtNHpzSmxkcDR0azZ3UkFRQnNpdjNqYldwVDFaNm1FQWlBMWdQViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY3NzM4ODA1XzE3NDk3NTg1Njg2ODRiMzI2ODA3ZWY1LXJlZ3VsYWNpb24ud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723335),
('izwJv8YLov8LYOslyTunmUqvm31ojFJn6kHL803Q', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU2NwWjk2ZHRkdlBsU0xzU2xBcjNSelp0VjVwUGFjRlRyVjVzcVJqeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723869),
('J8EWmGEl7KcrdLkH5l9rnWuIbYXXwAsdJfIxkqbC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZEJDN2VJa0czNVhock1nMm04OHl2T3JIcHl3Vk5RWmdWZlg3WE9zMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768411197),
('Jrvt7Bi8RHhdtP24n8p8WfSfgP50r7OU2vWtD1QC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1hXbEM1Nmc5VnJ4b281bmg0dWMzaXVNTFdEamtNdmtzZ0dtSTNGRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768507957),
('KBvp25gwrdUicUizxiCVnIuCdE6QpLg6QyeWMyh0', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ0ZNUDNPQWh4OTF3cGQ1T1NSN2hkeVpGdEp4MmtvbjhPTnF3OVdYZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766073432),
('kF63VYX3BC3vW2BcPWMARCkwPZSf13Ac30x1jHHU', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidklRS0IzMjM0Nmk1VDhmVzA5MUNEeXJGZ0NKbmc4bUJ3MDdFdDdxbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768513382),
('kL9cKrFc2tecR4i0NnvkfOBgSHDkV3UCLXXOxuoO', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM1JwYzVucnYyUXZqSTRmUzR0eTJmNEFCNTRtV3E2M3VpZnVrMVV6MiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODIwNzM5X2FjcmU0LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1766089788),
('klvNjn9Laorp9eJZgjGaYFxStDcmDvQcPRF6fek9', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib0dDWnhiT2d5Y25RVUR1dzl1b1A4d09KTlVhY3JkMGxUVzg0NUZaWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723351),
('kOzI6zVl7r30vXpOggLZJYmdkryOxn3c7cqmppu7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZUFJcE9BbEthZmZYNmY2VWJzYlZDbXFtNTl5MzdLYVR6ckFydjZMdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768513366),
('LbDBE5thdjLanOzIbYdEfD06n3BT0INy6UQ4z0pp', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieTlZUE5CZWVWc1RQOGlReWU5RjRzYUd6eDVPejYyYU9zcHpSdHY3USI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723220),
('lbKeNpIOOdIsLzz3IsZkVRjxPEtyS0YI7XNdatur', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTVFEWjYwWVNab0ZEdW5iOXJSME9WWlFOSlE5ZTR0cjZST2o5MlJsUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768496920),
('LmIvpftBehVJhPlF6ZWZNzVpfOzHPn8Yl6tVIGRD', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT2ZMakdFaHdVVWlHc1MzdGpHMk91WW9MMHBhbGJYbHczUWhIcU5wRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723655),
('LMJCbI6xBYcPdVTJxyaFD7FzQu7ANCyD4Bk0xmvC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiODZ0bTBISXlHemlreGZjTjZEQkl6RFczcFRNWHhXekhESlNtdzBkaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769718914),
('LXrtzue6EW1icmE2bQ3HNAOT1PsylDqqGsRy3zKK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY1FCc3Q5Rm80bGRiNnlkYXFSTFlQSTZPYjcxenplbTNSUjFHTHk3aiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768255250);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('MEV9at9ABbYc7iNLB1ki8zCdu9KW5vtZa1PmD2dN', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMFc5M3hWcTZHSEZadHJJYWNRVWg4a3N3OWV6WUpnVUZiUTZ4empwayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1767721287),
('mg91cMkt0DYnN1wmGzQq6FtZU6mJnVXXgOqSBNWZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib29oTGgyUE9XYjdra2hqNlNaTnJVZFBHWVhqNXQzRTNkV2FlVVNQUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY5MzQxX211bmRvcHVudG9zLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766090967),
('MGNJy21JT77W10yzzbUweC5u0nsyHNz3t3uXS9Cs', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTWI0d2ZjZjNRa3FoVHl1cE9EVTB0dGxNRFdYdEE3Wld3bU9Ic0JpQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766156173),
('MGSOUpaGXVWQFgiajvUHI2jE8P36slQncE6jMlgL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVlRYQjlPajMxU0ZrZEVJMngzWkNDV1JEOE5aRjdsUnV6N3pEMzdwViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMzEwNzAxX2luY29taW5nLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770647662),
('mI5OOnPmErs3ZxmDPCI8Cg5eCLPxnQGPzJlOhylo', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSk9Mak81R1RDZU55aWlybDIyMlNYcExMaUNZWk5GSmFIMmNGYmc5aSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723193),
('mMI13dMUPGU3nLfHulWzJg3ZRV5gYjkTCMqsXFWS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0ZkeWVTaXhyVlpQWjM5VnpQMEFtQVA3WE1KUUZvcUxQT1c2emw2cSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODIwNzE0X2FjcmUzLnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1767721149),
('mMmevcwq3GwUbPCI1lBYDzbhy3dTvRoNKJ7XXTdy', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNTQ5ZjVmSHBGWEFVT2IxMWlqbzBlZ1NMdktCTVlUeVlUYjNKUUk3RSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY3NzM4ODA1XzE3NDk3NTg1Njg2ODRiMzI2ODA3ZWY1LXJlZ3VsYWNpb24ud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768321480),
('mouK19FqaLYJreAjdT0iPZnzde2n0FULtGvEcUXR', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieDc4eXJ6OWJiSXhyTlRoaDFXZVhsd1dBUmVWM1dKVzEybURPSHlJZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723663),
('MU2xj3jIOL1MW0yyoGlafWnRlr2RaIyLJVJJR40Y', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWWpxTndDc1huTFBTRU5PU0ozUVpCYm5mOUYxNmxJZmt6cDRjZ3VubSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY3NzM4ODA1XzE3NDk3NTg1Njg2ODRiMzI2ODA3ZWY1LXJlZ3VsYWNpb24ud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723336),
('mvbbgcPEomzRWB6y8Uas3ZQeNfiP7sK4S0vkYKcS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ2VaMkRWTGFvaEE5Q3NzY2dHMEM3SVA5bEQ3NXNlYndjbFBRZzdoTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwNzQzNDY2X3NlbnNlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770844695),
('NbYEVamQH3wVYBYZgez1EyULRaeJ5TrKjnJB2US2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib2JUSUhpSG1Vb08xRVYwSGJVcURyTnlBbnltM200VVdQZnkxakRYNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY5MzQxX211bmRvcHVudG9zLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766069772),
('nk2fqm8MJb4XfmMj0LBI2iDANxcTvCWxZNgjCLJc', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTzJtOVB5Z1BwS00xRmVtZE40M0wyVTlkSHVUdnhkUmxWRXB2bE9wbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMjM1Nzk2XzEyLTEud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770236479),
('NKnrDqoNu8DO5kU3WK9e0x8V07dCW2AeIczas2EB', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibzFrWW5TU0R1MTZYa2lsRU5YUk15MWgwTDc5dnlRUnJjN2lNbnZsOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723260),
('NNTfJ4HjRgI6oVV6oYGQ6U4X0NJQ0S3Kau3ON1j8', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieGFaVHdtNU5ycFVlTXA0Y1l6QXNRQUpoMFJYa3BjQkdlelFZUGFtMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768507953),
('NoEfZtw4rR4zsUdH6Wl1RjKRwQEVpBQojxBnxfMT', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaEVuNFZGRU5Ma1I1bVAwa2JLSDZFWHpHNGZ6UlVqcTE1ODBvNXBuWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMjM1Nzk2XzEyLTEud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770236619),
('nQ0qvzZU4ICbvwVTf8uBwzlFYL1SteXzevHkAkWm', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidU9XTUZzR0MxWkkxT0ZLc3FrUzljTnJFazdDYXZYMHQ5ZlpYYWZTbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwNzQzNDY2X3NlbnNlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770844587),
('nsqmpTwGhNu6HhXgcRdoDnSMlEbrolpCojU4NUC5', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieVNSVGkyaTFWVnJyZlhVemVQbWRYcU1pWnUxaUFkMUxUSVJkODU4dSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwNzQzNDY2X3NlbnNlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770844594),
('ObZ9iKsiHazZRqzEXZR40oFs4NSgePBZCIQQJXey', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic1lSZWU5cnJSNHo2SlExb0R2a05QSjhYVU13YUJSM01ZUjZSUFVRNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766072249),
('oKB3mMFQjRWVEqqdytODXmr6DuuUEpuLWgFtlmJV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRVBTb0duNklTdnlDRE5mYnR0OVlCbkR1R1lVdXRIbkk3S1BscnlLcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwNzQzNDY2X3NlbnNlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770844673),
('onbk87x1k2pUL3pKe9I5rsTMvZpkgpj3LYEu2S3f', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUnByaWpaU0NSbk5FTHN4bEdCcFE2VTYycms2TXVOY3VQVkY5aUMyVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767803789),
('p9BWIhw3ANx51ki6bIvHYAYHkdDm4KdloC6NfAYJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidWZSRVJQTlhCOXVoOGVvQ3BUTkZxSkhadmRYVkpTaDJ1UERaRGZXeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768507917),
('phEp5Is4LiWUjlotyY0vZvNqRqZWRXOlBHovMjbR', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmRUT012azljU29TNUJ0UmpNaVpSbkpCeVFRTFJ0SGtqVWE5VTY0UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768255290),
('pONcU1AQG5hIKqxLkOtqmMmmi4s8oFZonsGit3Eo', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVXN6bno3ZTZFMWlkMFhuSHY0cERQSnNPWkNtMU1TZnVlUzYwYkVDbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1767736153),
('q7zHTfvByOxOsMMmkoFdLMOnMo2o1NuscvM0NHp8', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUzZTTUFuWEpXWkppR3FoNjNJaUczQVJocnNTZklxNHRSWW9xVmY5YSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723202),
('q9U2pMermTYJsyszsc89ssqm0AbRVq3v06r3SM80', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMWkzRlhpY0FXQXVhc0hvbjNtM2luYjBaRlpNdWthRUFqUmp5MnNFMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723634),
('qcftAWlW8Uak2KZNcqHB5OZ6kwDqJAiXgOtq2pGu', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaFQ1QmV1MnlGbUt0T1M0SFpZM1hUdVJMRVRvUzBEa3ZBNVFhdU5aYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766090759),
('qch21ZtLBWkjPQBFLCNTP17Ue0SFxAUwc5l2J7fx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNG1GWFVLSmc0QUtpOGZKWUlRVnRNZ1ZMQkNyYmpsUW1ZeTdVbm5HaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768499023),
('QHahDOO7P0MdC4C7FLwU8PHbb0Mo1872wq7I43HO', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQncxdmEwTzBDMkFsdGkxcXFZTEdzT29xcTZrZXVvOUtJVEpwc3FEUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768411202),
('qhOSFtQHoySaI6FL1PYTcbeKB35azbsIkkvzU4yN', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWTgxbVloSEs5MjhRbzh6NndBa1gzM0JBOXU5MmgzTWpsN04xdGFyQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY5MzQxX211bmRvcHVudG9zLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766089568),
('QJ6aceyrTzit2gL810fJmXYJekl0fNkCJgxJlaH2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQzNWUzdCVVdyc3pTM3I1a3pNSk1OVGcySFJyVmJhSlV2bGlyOUxIeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768503324),
('qjHONuWfcqmblod39ldx90CoElfNRJs1iI1RHM9O', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiazVxT3VQQkgzWDRLZklwSzJaTUJTYnBjNW9ITWhjcENtcTNtTHA1bSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NjEwX2p1bGlhcXVpc3BlYXJyaW9sYS53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768255368),
('QO6LYygNYpCslh0rq5ayfmwFLtvvtdPuiwhqzUSJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibDROZTlnczRCcGpJMVpSR1hZaGRPYUhkQ3BUR0h5b3p0Q1lzd1dHMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODIwNzM5X2FjcmU0LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1766089810),
('qpZrm7FVKDPnpySqM0WFKErcP2oSFI0Kn0Pnp49U', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM3U2QnFBSnRmTjYwMFFGdHJhMDE4ckZGcGxiU0Z1SzNpTVFvWTBjNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768507854),
('Qrqppn6m3tfLMSfi5nYCk78yyRucmK8w1lAgiAO6', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidENIQTRKMTcwNTBtOWczaVhDMDBCeloyaXJZSDVFamxyV21RelB4QSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODIxMDA5X2FjcmUxLnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1767721148),
('qWCTpiF3RN1C9anDUKYDngx2pofT84ZLtUqhrjfz', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRVVhMGRST0lBZW1XbjFXdTg4dnk2T0F4b0tvV0FKbUZYMkloOXdFdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766072241),
('qX7BZDEM0PfrzCQY5CAU5yaioXzbN7gN6KXDEdur', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT2FVSkRpZGpHc25pWXk1OVFLOFN2NjBsWDJOTmg5WkhxcnlRMmtzayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767720555),
('R0pUQL45LskWlerucYlgVOErs4YgrUA2MKZzVYdD', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT1Y0Q1djZ0hSRWRmd1VtcWFadGJvR1RTMlFkaXJLSmNpaUxReHZIRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723414),
('R4VuEPC1d46Z70DNoRpuzujE9V8jaWIp5IOoZPZS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZE1HY1ZxWTdlT3pKbWVWNnFRM3hkaFI2c2hyVjI0OFNWZDJLWlh4QSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766072673),
('r5ipRQoKcOxe42d7KhClDQtOWeLWxZLQW56MWTdO', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRnM5UWZxZGoxM043Z3RHOWVEMjlUYjlZZGhOS0VkNFZ5Rm94anVQbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Nzk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS9kb2N1bWVudHMvMTc3MDQxNTYyNl9tYW51YWwtaXNlLWxhcHRvcC5wZGYiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770418526),
('r7rse5q381sdWenLv7sGow4kCpsdZh8hzYCK5hGt', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTFBDRUFiTWJLWnVBdDJnN0NrSTRQczZtc1RHNDJONDl5QU5FQ2syMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766069336),
('ReRl4rxKqBaPDfL6IRJyhRYAanfoydNw7G2dOYHw', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaDYwRXN1d2RtMEFIVHcwZXFvbHp6UEJpd1ZwU2czTVpDZUZxdmlPbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY3NzM4ODY4X2FwcC53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768513393),
('rfZxMBYEoGfZ2Tc5g4BDRgceqydiqZtLRjiEtQoL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiekxScGs3MUZyeXFSck5LMnpRM2hzUXRPazFsTG1MaVA5QzI5NVVodyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723207),
('RmDSoLzBpg2LliUpD3vA1QvuY3ge0N3z3FnIbDjN', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibktVTEk4U21LMURlb3g2Y1RsNWxxSm92OEZVV2h4c28yTTVndDhZcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768255371),
('rr3gusoAsxBEBim5SG2YesAbglfk13Z30lOaBLUL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVB4Z2U2ZmZacjhoY2E1UVc1UEVLaUE5VDlSOXhrekpJQjNaSThMaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767737934),
('RS47sgPRh8REugGK42fTuyQuCJZc2qFj9tzOZvLx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVVVVMnFNaWI4S1Rib2tSWnF0ZTY0OUJxSzRpVzF6aE1mcENGRGEzNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723756),
('rznCzVMuyWORqfBMbcLi9uB2PBKm6UwaSnyr91Ik', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR0lUQ1ZqemZoNlhhSmJVRFQzeFc0QTNuU0Y5eHpRT05VNGR1MTQxayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769808665),
('saWtDHqenhZiQNdlk5Y7qu394iCdlOtCH2JdBnhC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUXRQSTFxSGthYlRsWHBEWWVPMk1UckV2V3BGMFRSSTZoUWhSOExNVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768255363),
('SbbMxpKDuTSAxfTSrV4owPXm478mSxUawPFy8ZN5', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMmpzUXYwUlJac2d3SWxEZWMzcXB4MEhpa3RzSGhVbzdiQVdXTEFLUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723528),
('sF7mLFOL7O5RuAK49O3mafdp2J2S0aOkuKwz3VhG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM2xDUndRQmdpcEJWeUg5Y1VuUzZWUHF6b0JlSnBoY0JFdXVWQmVCYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDEwMzkwX2plZmVyc29uLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766156181),
('sJMNEL6l1xTL8wKYsBN60lVEX2uZDP3rxRR47xjI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiam5ZMWx5dmN0MjNKSUtFMEtIQzdZclN2MEdJbFozbWRiMkg5M1pwRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723735),
('sjWEMBiPrnJeQbt3ei5vYPtbv9k3MsfDnQzQCijQ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTG5PbWVHOEpoVjdkZGFwUEtJZzV3d0xJSXJTcTl3Nko3UmEyWXhybSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768422545),
('SPLUoHXQLg2C3nez0oqxG2XAQe7fY4BTx5k6KTCf', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibzBweXVjbzRJRk5UNTJURUI3aXpUMFQwdXR0SGR2eGVXM0d3ZWM5MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723756),
('SU0fOoowAssmd7VnGRrzyHEcw3vtcLqQ0oPvTv8C', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1c3MExyMzdFWHZ0Nm9tdlZmdDFQWm12OXc1N1BES1BZWVBkN016RCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766072170),
('T17KfdaszWC7SoxImMhGJSU886ObtjOrkS71UUF7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR096QVhxNTNMaGRUcTZya09LR1h4OG15S0ZmQXVTbmxSVTd2RzFBTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY5MzQxX211bmRvcHVudG9zLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766089454),
('tDVJ6znEVnHklsfypTuPNxhd6JGWD35UYrAoGW5U', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibkJhb1c2OUZxakpVb0QzYXFoUW5LZGFXV1VxS2cyS1llWThyYXdqcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODIwNzI1X2FjcmUyLnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1767721148),
('TUfcvRcmYCU6HxUuydGkMN3Rhoqfg36IZ73S3o8p', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM3dyaXlDTGlaZ25CeEk2WFl1WXZyanl2aHYyRXNQMjg3YnIwWU9vUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMjM1Nzk2XzEyLTEud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770236653),
('U4zPTVM9hxH3vadxaR4wnWOz3fvOnDdIuaBx5qxj', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVTdtVFc5OWp6elN5TE5XamNjb2RON0kwMGxuYzdYZ3B0S3lqZ1RKQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzI0MjY1X2xvZ28tZXNhbmRhdGEtbmVncm8ud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770129980),
('UAcsAmcA4o0W9jQ310v57VHlKp4gT3VWh85u3ZRz', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkV2MVd5RWpYN0tDMnJ4V2p3ejNqOW85dWRud2N6RGpOWDJ6VWhNNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwNDA5MDU5X3ByaW5jaXBhbC53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1770411313),
('UQNEjZVB5t1cWJZ3Qtu4kkMlXb3dkrv04usoKAyG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMU5telZhWjdjWllacnF5VFprb1gwazF5SjI0bGtjREI2bllsR0xOTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1OTAxNTg5X2VzYW4tZWxlY2Npb25lcy1mYi5qcGciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1766068682),
('uUAyTPjDqnhw2TYtYgmxmKF3zbxeJPSSlCR8B08R', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSFN5VVQ1NjE5em9xSTZ3bXVhbVNzYTNqRERGUlJXZzN5MFZYMjVuRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723331),
('UUcfol23kH7LF3RIbwV9sgbQzlzrL2MtEG7IDMTL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOUFKZGw3SUpvRjJmbkVsMUw1TXpmb010U1k2dGExS1M1NTJRa1BqZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODI1ODMxX2FjcmU1LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1767803782),
('UvCaAv56iqbdMQNaMUf5ALL0HTVFgT3sqN6COpis', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRjF1M3BKa3NKdjZrNFV5YmVqMFVKMFF5M1dKbkQwM3o5bjRjTGp0diI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODIwNzM5X2FjcmU0LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1766089819),
('V8u4VkVL5QOh38W3hZMs16z6vSam617vd8O5YbF0', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnJSZmJwdmRKTmNWMmJBa1hiRktaV1k2eE90R09HMVNDaERPQXlDbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723530),
('vCThjpCioZDFojKGapMHwUvLGfNGXzZUs6IvgFox', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibWFiZFhieFpjeDVMaEZZM0NYNnVpTExLUFpHWWd2b2ZwRWdKaFgwTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzE2NzIyX21pY3JvZmluYW56YXMud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769722908),
('vSHhHtUYg4X45FAVKdZBW9TihuTQMXYgHl1cb34G', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWWg0Wm9SRUdPWjY2ZHFPVzZ5blViY0dVeklKMlJ2YUJmaXZJOVIwTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768496891),
('WAvJyYAgCk19UKIdVfBfn4TYbRPyDvYZooBq929l', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUE9LTGowZmRTSW9YaDZCc3JUMXJtbTZzWUVVYmtwRVUzajFSbENmZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768507978),
('WAzWdUBveYLjSWTPB6o6AIugV2r1kPsF4LU5bU0X', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWGF2UmFtajVaV0p5TUNEc1BFOUEyc1JLaHlpaDlXZ2pacTNRT29xaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768496865),
('wCpPM24OqfVAaEXbSxy2AFDyGlqImGSiQeGOAqdK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia0FvclFpZHNya0hoUnBndjM1N1QzdVNSN2dDOUhVWVRVdGRoVkozTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766090964),
('wDQL3EYz9f60NPmX3BJPWZVZRWeixgm8fBvVLe6e', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVW5qbkY1T2tjektwVEtMSXM3VTA3M2NaVkl3aHhkRzAxalNuOGRvMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY3NzM4ODA1XzE3NDk3NTg1Njg2ODRiMzI2ODA3ZWY1LXJlZ3VsYWNpb24ud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723348),
('whs8b6xrHXkAMjV06nXViRL4kIz47L983o5Px1fI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1FZeGNQeVdaYVBGVU9pRGp5NGFOeUdCanQ2NjVzSGh3UmdCejZkUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMjM1Nzk2XzEyLTEud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770235797),
('wlIcSaREOd6vTajOrxkHcZBmVXXRz1GMnqlcuJbz', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidEZ1eGh3a0FkU1FLMWhOOGdjNHNjWXIwV28yRVRrV3h0d2ZtZ2lUNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NTgwX2ZvdG9kb2NlbnRlLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723328),
('wMqQflnJQi897RDbYZGEXwOUZIxhmnXOeSfnhpN7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0pjck5ZV2NtU1RHNTB2MHdzOHlmR0dHMnR3MEVZWlJVR0szMDAydiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766068751),
('wojyKcG8U0ZWQSriPMXPYz1tHITKtm3Elnj5M3Ff', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSWtGREx3QU4wR2JSaTd4eHhxS0ZxYnFvSTZadXBnaGtVR0FNQmR2eiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY5NzkwNjczXzEyLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1770235788),
('wRMwFBA0DPGXaD5J505npsg6UxW5IDD4s2C20Bx8', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMDRFWE9yekZQbEg0cVNid2dsOExhb3dKRTlmeXczbTRUY0REUnViSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODIwNzM5X2FjcmU0LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1767803783),
('WU9SD0iYfRIwBwUdZc8pBtoUaAg5zkA159RVgKOP', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHNOa2pwWTVLcml5SXdmV2daR0ZzYTE3aFQybGtMZnlYU05BMFd4TiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768255307),
('WUjFCzHMzEvnwmW4843lCeTMr7E4P9LalcrD6KZr', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT2owbFp4a1hDakJ6T3pFdjRWd05WeFNnYU1nUnFoSzVjODNPSUtjNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767737407),
('X6aueymTAJFR9bY4mDWWy8Cf0DJcdeoXaSzeyQDN', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicjlSUlo4RVdtcEMwYXFaYnJMeDhpNnBFRjRDSVBTdWtkZzFGcjdobyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwMjM1Nzk2XzEyLTEud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770236670),
('X8RUD48lZ25Y2h0iF12Aeg9ri3ffBC1cmyZmw5zt', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaVNpbDNheWpURUY2SEJDYXJHQjRoM2ZsYTR3MVFuTVNpR2U2UFg2dCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768507935),
('XBiIPD5CpKZzhzjbC99BB4pazFLuAcxci5KHf7ZC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzRyeGxaUk4zVHpaOXZvbnlkQjRkYnE4NWVGUXI5eUNDdEVrZm9jMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTE3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvL3N0b3JhZ2UvbWVkaWEvZG9jdW1lbnRzLzE3NjkwOTU1ODNfc2NyZWVuY2FwdHVyZS1sb2NhbGhvc3QtNTE3My1pbmljaW8tMjAyNi0wMS0xMy0xMC00NC0yMi5wZGYiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769097659),
('Xfcq3freydtlqaTF2JnAugIooHI0l1oXFFyjD09y', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMmljRUo2Nzl5OWVERlRmNHF5RzVrVDlDS2hobXEzeFZGcVI0YWc1bCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODIxMDA5X2FjcmUxLnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1766069159),
('xQNheAAAFmE4ubC1sx42Yo1Gx1Mcj8xsragmKLp6', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWRGSXl5U2dudnRxUVRXWjd6TFdHT0lsWm9pQzhBUGtzT0VBeEpRQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767737423),
('XyUpdO3XqEkV4hKRc8eJ4Cs2OrSNpD52MjPZPTGL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaXQ1d24zQVNPdllrOUVyVEpjWnZjUFVXRWQwaEI3T0xDUGI1aUZmWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDEyMTEwX2ZhYmxhYi00LTEtMTAyNHgxMDI0LndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769723269),
('YeOs6hfhsqPZ5n9KNxoixdffg0URzGpzbq5fZahs', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZUlQb0lDNURkcVYxTkwzZUprbkE4RlJZNVFwd2dtVVpISEJNamQ3dyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766089575),
('yGeB13LMwZZKC2OsypqbbUhV3kaHhPGqmjldDT5p', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicEZ6VDBtSjB5UUVBaHlxcVh3cGJrUTlMNXE1bFVkU25YSkh5TUt2SyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768513377),
('yjFlhO53tzkzgCVm2eaANXaJBshZjXInz9JkBxTv', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVHBvbHlyQU1kYnNzeUJqSFJtOWt5NFdZOHRKaGlOSVdMWkFsdW5rcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDA4NjEwX2p1bGlhcXVpc3BlYXJyaW9sYS53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766156181),
('YqPAltoXhMYLPz6TPC2I2cWmpXYCtJGyQ32ih06v', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRHRwZlowRGQzVFdYMzYxN2ZCVTJneVNFZHduWGhNYXI2eDMxWHV6ZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY3NzM4ODA1XzE3NDk3NTg1Njg2ODRiMzI2ODA3ZWY1LXJlZ3VsYWNpb24ud2VicCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769723339),
('YRFncEU25GeC53N4fNaGiPnPxLYLQiqNMOmDqPDS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSjRWWUFsbUd3SWlrNE5oSTNjVTBaWDI2dUJscUVLTnI3cUE3VkpXdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY2MDY4NzUwX2VzYW4tZWxlY2Npb25lcy1mYi53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1767721512),
('yv5q2ahH3H5zDys708g9XaumghtBfyMZAXjKBHL3', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieGFHbG5NZXVlYTVpdmE5cXJhVzdqclpSaXJ3VWttZ1l4YWhsR2V3cCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY1ODI1ODMxX2FjcmU1LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1766089810),
('zdbKRjqkaEVmDpVijEUv7pshYgCY2oTBqHaqytek', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOFNtVVFXUUNjam5nektzZFlRaXZRTzYweUszMmVYSGswajh3dGlmUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzcwNDA5MDU5X3ByaW5jaXBhbC53ZWJwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1770411313),
('ZZsFAE0Z0ktvcz4nlKJDyKDw4E0Mwl5ovdU0wgrg', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRndiV2haTlAzUk96bDluQk1sVWdJR2wweWhwZVpySmNWWFh4UUlVNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8vc3RvcmFnZS9tZWRpYS8xNzY4NDA5OTIzX2NvbnN1bHRvcmlhLndlYnAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768411322);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `study_programs`
--

CREATE TABLE `study_programs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `modality` enum('presencial','virtual','semi-presencial') DEFAULT 'presencial',
  `duration` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `branding_color` varchar(7) DEFAULT '#000000',
  `curriculum_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`curriculum_json`)),
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `study_programs`
--

INSERT INTO `study_programs` (`id`, `academic_unit_id`, `category_id`, `name`, `modality`, `duration`, `description`, `slug`, `branding_color`, `curriculum_json`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Ingeniería de Sistemas', 'presencial', '10 ciclos', NULL, 'ingenieria-de-sistemas', '#000000', NULL, 1, '2026-02-18 03:20:55', '2026-02-18 03:20:55'),
(2, 1, 1, 'Ingeniera de Software', 'presencial', '10 Ciclos', 'asdasd', 'ingeniera-de-software', '#e72323', NULL, 1, '2026-02-24 01:51:24', '2026-02-24 02:07:54'),
(4, 1, 1, 'Ingeniera de IA', 'presencial', '10 Ciclos', 'dsad', 'ingeniera-de-ia', '#db0000', NULL, 1, '2026-02-24 02:16:55', '2026-02-24 02:16:55'),
(5, 3, 3, 'Derecho', 'presencial', '10 ciclos', NULL, 'derecho', '#18b5dc', NULL, 1, '2026-02-25 21:00:11', '2026-02-25 21:00:11'),
(6, 3, 3, 'Ing. de Sistemas', 'presencial', '10 Ciclos', NULL, 'ing-de-sistemas', '#000000', NULL, 1, '2026-02-25 21:05:21', '2026-02-25 21:05:21'),
(7, 2, 4, 'Ingenieria de Sistemas DPA', 'presencial', '10 ciclos', NULL, 'ingenieria-de-sistemas-dpa', '#000000', NULL, 1, '2026-03-09 21:11:28', '2026-03-09 21:11:28'),
(8, 4, 5, 'Administración con Mención en Dirección de Empresas', 'presencial', '10 Ciclos', NULL, 'administracion-con-mencion-en-direccion-de-empresas', '#12c2c0', NULL, 1, '2026-03-25 22:25:03', '2026-04-15 23:00:59'),
(9, 4, 5, 'Contabilidad y Finanzas', 'presencial', '10 Ciclos', NULL, 'contabilidad-y-finanzas', '#7ed38c', NULL, 1, '2026-03-25 22:26:31', '2026-03-25 22:26:31'),
(10, 4, 5, 'Derecho', 'presencial', '10 Ciclos', NULL, 'derecho', '#5570f7', NULL, 1, '2026-03-25 22:31:35', '2026-03-25 22:31:35'),
(11, 4, 5, 'Ingeniería de Sistemas', 'presencial', '10 Ciclos', NULL, 'ingenieria-de-sistemas', '#a23eb6', NULL, 1, '2026-03-25 22:32:02', '2026-03-25 22:32:02'),
(12, 4, 5, 'Ingeniería Industrial', 'presencial', '10 Ciclos', NULL, 'ingenieria-industrial', '#d85aaa', NULL, 1, '2026-03-25 22:32:31', '2026-03-25 22:32:31'),
(13, 4, 5, 'Marketing y Dirección Comercial', 'presencial', '10 Ciclos', NULL, 'marketing-y-direccion-comercial', '#1d92ed', NULL, 1, '2026-03-25 22:33:15', '2026-03-25 22:33:15'),
(14, 4, 5, 'Negocios Internacionales', 'presencial', '10 Ciclos', NULL, 'negocios-internacionales', '#2e5094', NULL, 1, '2026-03-25 22:33:36', '2026-03-25 22:33:36'),
(15, 4, 5, 'Psicología', 'presencial', '10 Ciclos', NULL, 'psicologia', '#e49090', NULL, 1, '2026-03-25 22:33:53', '2026-03-25 22:33:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unit_branding`
--

CREATE TABLE `unit_branding` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `primary_color` varchar(7) DEFAULT '#01828f',
  `secondary_color` varchar(7) DEFAULT '#ffffff',
  `accent_color` varchar(7) DEFAULT '#f4a912',
  `logo_primary_id` bigint(20) UNSIGNED DEFAULT NULL,
  `logo_footer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `favicon_id` bigint(20) UNSIGNED DEFAULT NULL,
  `header_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`header_config`)),
  `footer_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`footer_config`)),
  `custom_css` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `unit_branding`
--

INSERT INTO `unit_branding` (`id`, `academic_unit_id`, `primary_color`, `secondary_color`, `accent_color`, `logo_primary_id`, `logo_footer_id`, `favicon_id`, `header_config`, `footer_config`, `custom_css`, `created_at`, `updated_at`) VALUES
(1, 1, '#01828f', '#ffffff', '#f4a912', NULL, NULL, NULL, '{\"logoUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/pregrado\\/2026\\/03\\/1773848225_logo-esan.webp\",\"logoHeight\":70,\"logoHeightScrolled\":45,\"sticky\":true,\"isTransparent\":true,\"showTopBar\":true,\"topBarBgColor\":\"#cc0033\",\"topBarTextColor\":\"#ffffff\",\"navBgColor\":\"#000000\",\"navTextColor\":\"#ffffff\",\"navTransparentTextColor\":\"#ffffff\",\"navHoverColor\":\"#cc0033\",\"socialLinks\":[{\"icon\":\"bi bi-facebook\",\"url\":\"#\"},{\"icon\":\"bi bi-twitter-x\",\"url\":\"#\"},{\"icon\":\"bi bi-instagram\",\"url\":\"#\"},{\"icon\":\"bi bi-linkedin\",\"url\":\"#\"}],\"topLinks\":[{\"text\":\"Acerca de ESAN\",\"url\":\"#\",\"hasChild\":true},{\"text\":\"Biblioteca\",\"url\":\"#\",\"hasChild\":false}],\"ctaText\":\"POSGRADO\",\"ctaUrl\":\"#\",\"ctaIcon\":\"bi bi-arrow-right-circle\",\"containerType\":\"container\",\"heavyShadow\":true,\"menu_id\":2}', NULL, '[{\"id\":1,\"type\":\"HeaderMega\",\"content\":{\"logoUrl\":\"http://127.0.0.1:8000/storage/media/pregrado/2026/03/1773848225_logo-esan.webp\",\"logoHeight\":70,\"logoHeightScrolled\":45,\"sticky\":true,\"isTransparent\":true,\"showTopBar\":true,\"topBarBgColor\":\"#cc0033\",\"topBarTextColor\":\"#ffffff\",\"navBgColor\":\"#000000\",\"navTextColor\":\"#ffffff\",\"navTransparentTextColor\":\"#ffffff\",\"navHoverColor\":\"#cc0033\",\"socialLinks\":[{\"icon\":\"bi bi-facebook\",\"url\":\"#\"},{\"icon\":\"bi bi-twitter-x\",\"url\":\"#\"},{\"icon\":\"bi bi-instagram\",\"url\":\"#\"},{\"icon\":\"bi bi-linkedin\",\"url\":\"#\"}],\"topLinks\":[{\"text\":\"Acerca de ESAN\",\"url\":\"#\",\"hasChild\":true},{\"text\":\"Biblioteca\",\"url\":\"#\",\"hasChild\":false}],\"ctaText\":\"POSGRADO\",\"ctaUrl\":\"#\",\"ctaIcon\":\"bi bi-arrow-right-circle\",\"containerType\":\"container\",\"heavyShadow\":true,\"menu_id\":2}}]', '2026-02-18 22:27:40', '2026-03-18 20:38:27'),
(2, 2, '#003366', '#ffffff', '#ffcc00', NULL, NULL, NULL, '{\"logoUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/posgrado\\/2026\\/03\\/1773176223_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"logoHeight\":\"35\",\"logoHeightScrolled\":\"35\",\"sticky\":true,\"isTransparent\":true,\"showTopBar\":true,\"topBarBgColor\":\"#cc0033\",\"topBarTextColor\":\"#ffffff\",\"navBgColor\":\"#000000\",\"navTextColor\":\"#ffffff\",\"navTransparentTextColor\":\"#ffffff\",\"navHoverColor\":\"#cc0033\",\"socialLinks\":[{\"icon\":\"bi bi-facebook\",\"url\":\"#\"},{\"icon\":\"bi bi-twitter-x\",\"url\":\"#\"},{\"icon\":\"bi bi-instagram\",\"url\":\"#\"},{\"icon\":\"bi bi-linkedin\",\"url\":\"#\"},{\"icon\":\"bi bi-link-45deg\",\"url\":\"#\"}],\"topLinks\":[{\"text\":\"Acerca de ESAN\",\"url\":\"#\",\"hasChild\":true},{\"text\":\"Biblioteca\",\"url\":\"#\",\"hasChild\":false}],\"ctaText\":\"PORTAL ACAD\\u00c9MICO\",\"ctaUrl\":\"#\",\"ctaIcon\":\"bi bi-arrow-right-circle\",\"menu_id\":1}', '{\"logoUrl\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/media\\/posgrado\\/2026\\/03\\/1773176223_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"logoHeight\":60,\"description\":\"Instituci\\u00f3n l\\u00edder enfocada en la excelencia acad\\u00e9mica y la formaci\\u00f3n integral.\",\"bgColor\":\"#1a1a1a\",\"textColor\":\"#ffffff\",\"accentColor\":\"#cc0033\",\"address\":\"Av. Universitaria 123, Lima - Per\\u00faaa\",\"phone\":\"+51 1 123 4567a\",\"email\":\"contacto@universidad.edu.pe\",\"socialLinks\":[{\"icon\":\"bi bi-facebook\",\"url\":\"#\"},{\"icon\":\"bi bi-linkedin\",\"url\":\"#\"},{\"icon\":\"bi bi-instagram\",\"url\":\"#\"},{\"icon\":\"bi bi-link-45deg\",\"url\":\"#\"}],\"footerColumns\":[{\"title\":\"Instituci\\u00f3n\",\"links\":[{\"text\":\"Sobre nosotros\",\"url\":\"#\"},{\"text\":\"Transparencia\",\"url\":\"#\"},{\"text\":\"Noticias\",\"url\":\"#\"}]},{\"title\":\"Admisi\\u00f3n\",\"links\":[{\"text\":\"Pregrado\",\"url\":\"#\"},{\"text\":\"Posgrado\",\"url\":\"#\"},{\"text\":\"Becas\",\"url\":\"#\"}]}],\"copyrightText\":\"\\u00a9 2026 Universidad. Todos los derechos reservados.\"}', '[{\"id\":2,\"type\":\"HeaderMega\",\"content\":{\"logoUrl\":\"http://127.0.0.1:8000/storage/media/posgrado/2026/03/1773176223_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"logoHeight\":\"35\",\"logoHeightScrolled\":\"35\",\"sticky\":true,\"isTransparent\":true,\"showTopBar\":true,\"topBarBgColor\":\"#cc0033\",\"topBarTextColor\":\"#ffffff\",\"navBgColor\":\"#000000\",\"navTextColor\":\"#ffffff\",\"navTransparentTextColor\":\"#ffffff\",\"navHoverColor\":\"#cc0033\",\"socialLinks\":[{\"icon\":\"bi bi-facebook\",\"url\":\"#\"},{\"icon\":\"bi bi-twitter-x\",\"url\":\"#\"},{\"icon\":\"bi bi-instagram\",\"url\":\"#\"},{\"icon\":\"bi bi-linkedin\",\"url\":\"#\"},{\"icon\":\"bi bi-link-45deg\",\"url\":\"#\"}],\"topLinks\":[{\"text\":\"Acerca de ESAN\",\"url\":\"#\",\"hasChild\":true},{\"text\":\"Biblioteca\",\"url\":\"#\",\"hasChild\":false}],\"ctaText\":\"PORTAL ACADÉMICO\",\"ctaUrl\":\"#\",\"ctaIcon\":\"bi bi-arrow-right-circle\",\"menu_id\":1}},{\"id\":\"dde1e814-9310-4bcf-94b6-14e597e1c817\",\"type\":\"FooterPro\",\"content\":{\"logoUrl\":\"http://127.0.0.1:8000/storage/media/posgrado/2026/03/1773176223_dpa-esan-carrerasparagentequetrabaja-blanco.webp\",\"logoHeight\":60,\"description\":\"Institución líder enfocada en la excelencia académica y la formación integral.\",\"bgColor\":\"#1a1a1a\",\"textColor\":\"#ffffff\",\"accentColor\":\"#cc0033\",\"address\":\"Av. Universitaria 123, Lima - Perúaa\",\"phone\":\"+51 1 123 4567a\",\"email\":\"contacto@universidad.edu.pe\",\"socialLinks\":[{\"icon\":\"bi bi-facebook\",\"url\":\"#\"},{\"icon\":\"bi bi-linkedin\",\"url\":\"#\"},{\"icon\":\"bi bi-instagram\",\"url\":\"#\"},{\"icon\":\"bi bi-link-45deg\",\"url\":\"#\"}],\"footerColumns\":[{\"title\":\"Institución\",\"links\":[{\"text\":\"Sobre nosotros\",\"url\":\"#\"},{\"text\":\"Transparencia\",\"url\":\"#\"},{\"text\":\"Noticias\",\"url\":\"#\"}]},{\"title\":\"Admisión\",\"links\":[{\"text\":\"Pregrado\",\"url\":\"#\"},{\"text\":\"Posgrado\",\"url\":\"#\"},{\"text\":\"Becas\",\"url\":\"#\"}]}],\"copyrightText\":\"© 2026 Universidad. Todos los derechos reservados.\"}}]', '2026-03-13 22:10:13', '2026-03-21 03:59:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `surname` varchar(250) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `avatar` varchar(250) DEFAULT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `academic_unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `type_document` varchar(35) DEFAULT NULL,
  `n_document` varchar(35) DEFAULT NULL,
  `gender` varchar(1) NOT NULL DEFAULT 'M',
  `state` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `email`, `avatar`, `role_id`, `academic_unit_id`, `phone`, `type_document`, `n_document`, `gender`, `state`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Jhar Del Alfonso', 'Pumahuillca Llancay', 'jpumahuillca1@esan.edu.pe', NULL, 1, NULL, NULL, NULL, NULL, 'M', 1, '2025-04-07 07:36:52', '$2y$12$0961rXwuun2ngdhUrri7E..vDHPzA2k2tFz9mhveBdF5OfS0RIyq2', 'Bk3vemcQBz', '2025-04-07 07:36:52', '2025-12-04 03:49:48', NULL),
(2, 'Juan', 'Diaz', 'juandiaz@gmail.com', NULL, 2, NULL, '975717177', 'TARJETA MILITAR', '74782828', 'M', 1, NULL, '$2y$12$64vOQxt7L2KlAv6J770cb..a7ArAKlY5QYPY8mqD4d56HbHjN9Feu', NULL, '2025-04-08 05:50:01', '2026-01-20 00:40:24', '2026-01-20 00:40:24'),
(3, 'Fatima', 'Lopez', 'danielopez@gmail.com', NULL, 2, NULL, '94454544', 'DNI', '74828282', 'F', 1, NULL, '$2y$12$dLI8ajL8giFLGKN6MzanDugEHrDnfA.meFhNojJC1M4G4nNMHDH1O', NULL, '2025-04-08 05:52:05', '2026-01-20 00:40:28', '2026-01-20 00:40:28'),
(4, 'Gabrieles', 'Soto', 'gabrielsoto@gmail.com', NULL, 2, NULL, '9845454', 'CARNET DE EXTRANJERIA', '478528282', 'M', 2, NULL, '$2y$12$wnxe6hcoYJBu1Y5FyenjJODlU1WRy2slRteMvZONPbjQpJjQUBkN6', NULL, '2025-04-08 06:09:28', '2026-01-20 00:40:33', '2026-01-20 00:40:33'),
(6, 'Johan Renzo', 'Mamani Simeon', 'jmamanisi@esan.edu.pe', NULL, 2, NULL, NULL, NULL, NULL, 'M', 1, NULL, '$2y$12$cGxKpbGDt6Y6qgTyYGzCs.Nko0Xc.gNYWFHEUxANsRF5mdLOIi5oa', NULL, '2025-12-04 19:29:55', '2025-12-04 19:29:55', NULL),
(8, 'Jose Jaico', NULL, 'laravest@gmail.com', NULL, 1, NULL, NULL, NULL, NULL, 'M', 1, NULL, '$2y$12$XOqiCPhSw0TrqHRr19Hx.O/65xOsvvMz5ad5kHKrS1rxde0MaqVRm', NULL, '2026-01-05 19:24:22', '2026-01-05 20:17:54', '2026-01-05 20:17:54'),
(10, 'Luis ', 'Escobar', 'lescobar@esan.edu.pe', NULL, 3, NULL, '321321321', 'DNI', '12341234', 'M', 1, NULL, '$2y$12$xGVJopHKeHMRn7aRrYqMgu0fbxwbMFAkDRb/LqrunoBO08TEatd3i', NULL, '2026-01-05 22:16:45', '2026-01-05 22:40:14', NULL),
(11, 'Cesar', 'Chavez Perez', 'cchavezp@esan.edu.pe', NULL, 2, NULL, '321321123', 'DNI', '987897789', 'M', 1, NULL, '$2y$12$pJN.JT2lFpqRkOBplg9BUef/H2TiN2PLfih0k33JAQo1xY2btXDgW', NULL, '2026-01-05 22:50:09', '2026-01-05 22:52:56', NULL),
(12, 'Juan', 'Lujan', 'jpumahuillca@esan.edu.pe', NULL, 1, 4, '987654321', 'DNI', '32112322', 'M', 1, NULL, '$2y$12$ayXFUWvj0E8xRZNwU5TQeO5AGGgJgH9JFVpJjL0i4g9h/U9wBztZG', NULL, '2026-02-25 01:44:25', '2026-02-25 01:44:25', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `academic_units`
--
ALTER TABLE `academic_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unit_slug_unique` (`slug`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `domain` (`domain`);

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cat_unit` (`academic_unit_id`),
  ADD KEY `fk_cat_parent` (`parent_id`);

--
-- Indices de la tabla `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `contents`
--
ALTER TABLE `contents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `content_slug_unit_unique` (`slug`,`academic_unit_id`),
  ADD KEY `fk_content_unit` (`academic_unit_id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_lead_email` (`email`),
  ADD KEY `fk_lead_campaign` (`campaign_id`);

--
-- Indices de la tabla `marketing_campaigns`
--
ALTER TABLE `marketing_campaigns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `campaign_slug_unit_unique` (`slug`,`academic_unit_id`),
  ADD KEY `fk_offering_sp` (`study_program_id`),
  ADD KEY `fk_offering_content` (`content_id`),
  ADD KEY `fk_campaign_unit` (`academic_unit_id`);

--
-- Indices de la tabla `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_media_folder` (`folder_id`),
  ADD KEY `fk_media_unit` (`academic_unit_id`);

--
-- Indices de la tabla `media_folders`
--
ALTER TABLE `media_folders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_folder_parent` (`parent_id`),
  ADD KEY `fk_folder_unit` (`academic_unit_id`);

--
-- Indices de la tabla `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_menu_unit` (`academic_unit_id`);

--
-- Indices de la tabla `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_menu_items_menu` (`menu_id`),
  ADD KEY `fk_menu_items_parent` (`parent_id`),
  ADD KEY `fk_menu_items_content` (`content_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `posts_slug_unique` (`slug`),
  ADD KEY `posts_academic_unit_id_foreign` (`academic_unit_id`),
  ADD KEY `posts_category_id_foreign` (`category_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `study_programs`
--
ALTER TABLE `study_programs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sp_unit` (`academic_unit_id`),
  ADD KEY `fk_sp_cat` (`category_id`);

--
-- Indices de la tabla `unit_branding`
--
ALTER TABLE `unit_branding`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `branding_unit_unique` (`academic_unit_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `fk_user_academic_unit` (`academic_unit_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `academic_units`
--
ALTER TABLE `academic_units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `contents`
--
ALTER TABLE `contents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `leads`
--
ALTER TABLE `leads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `marketing_campaigns`
--
ALTER TABLE `marketing_campaigns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT de la tabla `media_folders`
--
ALTER TABLE `media_folders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `study_programs`
--
ALTER TABLE `study_programs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `unit_branding`
--
ALTER TABLE `unit_branding`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_cat_parent` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cat_unit` FOREIGN KEY (`academic_unit_id`) REFERENCES `academic_units` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `contents`
--
ALTER TABLE `contents`
  ADD CONSTRAINT `fk_content_unit` FOREIGN KEY (`academic_unit_id`) REFERENCES `academic_units` (`id`);

--
-- Filtros para la tabla `leads`
--
ALTER TABLE `leads`
  ADD CONSTRAINT `fk_lead_campaign` FOREIGN KEY (`campaign_id`) REFERENCES `marketing_campaigns` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `marketing_campaigns`
--
ALTER TABLE `marketing_campaigns`
  ADD CONSTRAINT `fk_campaign_unit` FOREIGN KEY (`academic_unit_id`) REFERENCES `academic_units` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_offering_content` FOREIGN KEY (`content_id`) REFERENCES `contents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_offering_sp` FOREIGN KEY (`study_program_id`) REFERENCES `study_programs` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `fk_media_folder` FOREIGN KEY (`folder_id`) REFERENCES `media_folders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_media_unit` FOREIGN KEY (`academic_unit_id`) REFERENCES `academic_units` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `media_folders`
--
ALTER TABLE `media_folders`
  ADD CONSTRAINT `fk_folder_parent` FOREIGN KEY (`parent_id`) REFERENCES `media_folders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_folder_unit` FOREIGN KEY (`academic_unit_id`) REFERENCES `academic_units` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `menus`
--
ALTER TABLE `menus`
  ADD CONSTRAINT `fk_menu_unit` FOREIGN KEY (`academic_unit_id`) REFERENCES `academic_units` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `fk_menu_items_content` FOREIGN KEY (`content_id`) REFERENCES `contents` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_menu_items_menu` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_menu_items_parent` FOREIGN KEY (`parent_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_academic_unit_id_foreign` FOREIGN KEY (`academic_unit_id`) REFERENCES `academic_units` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `study_programs`
--
ALTER TABLE `study_programs`
  ADD CONSTRAINT `fk_sp_cat` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_sp_unit` FOREIGN KEY (`academic_unit_id`) REFERENCES `academic_units` (`id`);

--
-- Filtros para la tabla `unit_branding`
--
ALTER TABLE `unit_branding`
  ADD CONSTRAINT `fk_branding_unit` FOREIGN KEY (`academic_unit_id`) REFERENCES `academic_units` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_user_academic_unit` FOREIGN KEY (`academic_unit_id`) REFERENCES `academic_units` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
