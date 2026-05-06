

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel_cache_spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:30:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:9:\"dashboard\";s:1:\"c\";s:3:\"api\";}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:13:\"register_role\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:3;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:9:\"list_role\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:3;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:9:\"edit_role\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:3;}}i:4;a:3:{s:1:\"a\";i:5;s:1:\"b\";s:11:\"delete_role\";s:1:\"c\";s:3:\"api\";}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:13:\"register_user\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:3;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:9:\"list_user\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:3;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:9:\"edit_user\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:3;}}i:8;a:3:{s:1:\"a\";i:9;s:1:\"b\";s:11:\"delete_user\";s:1:\"c\";s:3:\"api\";}i:9;a:3:{s:1:\"a\";i:10;s:1:\"b\";s:8:\"settings\";s:1:\"c\";s:3:\"api\";}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:16:\"register_product\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:12:\"list_product\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:12:\"edit_product\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:13;a:3:{s:1:\"a\";i:14;s:1:\"b\";s:14:\"delete_product\";s:1:\"c\";s:3:\"api\";}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:15:\"register_client\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:11:\"list_client\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:11:\"edit_client\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:13:\"delete_client\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:13:\"register_sale\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:9:\"list_sale\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:9:\"edit_sale\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:4;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:11:\"delete_sale\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:4;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:18:\"register_categorie\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:3;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:14:\"edit_categorie\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:3;}}i:24;a:3:{s:1:\"a\";i:25;s:1:\"b\";s:16:\"delete_categorie\";s:1:\"c\";s:3:\"api\";}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:14:\"list_categorie\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:3;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:22:\"register_guia_remision\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:27;a:3:{s:1:\"a\";i:28;s:1:\"b\";s:18:\"list_guia_remision\";s:1:\"c\";s:3:\"api\";}i:28;a:3:{s:1:\"a\";i:29;s:1:\"b\";s:16:\"nota_electronica\";s:1:\"c\";s:3:\"api\";}i:29;a:3:{s:1:\"a\";i:30;s:1:\"b\";s:21:\"list_nota_electronica\";s:1:\"c\";s:3:\"api\";}}s:5:\"roles\";a:3:{i:0;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:10:\"Diseñador\";s:1:\"c\";s:3:\"api\";}i:1;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:6:\"Editor\";s:1:\"c\";s:3:\"api\";}i:2;a:3:{s:1:\"a\";i:4;s:1:\"b\";s:6:\"Lector\";s:1:\"c\";s:3:\"api\";}}}', 1765037393);

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
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `category_post`
--

CREATE TABLE `category_post` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


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
  `origin_url` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` enum('new','contacted','spam') NOT NULL DEFAULT 'new',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_items`
--

CREATE TABLE `menu_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `target` varchar(20) DEFAULT '_self',
  `type` varchar(50) NOT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `menu_items`
--

INSERT INTO `menu_items` (`id`, `title`, `slug`, `url`, `target`, `type`, `post_id`, `parent_id`, `order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Equipo', 'equipo-esan', NULL, '_self', 'page', 3, NULL, 2, 1, '2025-12-05 20:58:25', '2025-12-05 21:16:47'),
(2, 'Inicio', 'inicio', NULL, '_self', 'page', 9, NULL, 1, 1, '2025-12-05 16:09:40', '2025-12-05 21:16:04'),
(3, 'Curso', 'curso', NULL, '_self', 'page', 4, NULL, 3, 1, '2025-12-05 22:54:54', '2025-12-05 22:55:22'),
(4, 'Noticias', 'noticias', NULL, '_self', 'page', 10, NULL, 4, 1, '2025-12-05 18:02:33', '2025-12-06 00:47:12'),
(5, 'XD', 'GAAAA', NULL, '_self', 'page', 11, 1, 0, 1, '2025-12-05 19:41:15', '2025-12-05 19:41:15');

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
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 7),
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3),
(4, 'App\\Models\\User', 4);

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
(1, 'dashboard', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(2, 'register_role', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(3, 'list_role', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(4, 'edit_role', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(5, 'delete_role', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(6, 'register_user', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(7, 'list_user', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(8, 'edit_user', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(9, 'delete_user', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(10, 'settings', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(11, 'register_product', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(12, 'list_product', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(13, 'edit_product', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(14, 'delete_product', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(15, 'register_client', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(16, 'list_client', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(17, 'edit_client', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(18, 'delete_client', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(19, 'register_sale', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(20, 'list_sale', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(21, 'edit_sale', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(22, 'delete_sale', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(23, 'register_categorie', 'api', NULL, NULL),
(24, 'edit_categorie', 'api', NULL, NULL),
(25, 'delete_categorie', 'api', NULL, NULL),
(26, 'list_categorie', 'api', NULL, NULL),
(27, 'register_guia_remision', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(28, 'list_guia_remision', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(29, 'nota_electronica', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51'),
(30, 'list_nota_electronica', 'api', '2025-04-07 07:36:51', '2025-04-07 07:36:51');

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
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'page',
  `status` enum('published','draft','archived') NOT NULL DEFAULT 'draft',
  `status_course` varchar(100) DEFAULT NULL,
  `content_blocks` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`content_blocks`)),
  `excerpt` text DEFAULT NULL,
  `featured_image_path` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT 0.00,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_description` varchar(160) DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `slug`, `type`, `status`, `status_course`, `content_blocks`, `excerpt`, `featured_image_path`, `price`, `start_date`, `end_date`, `seo_title`, `seo_description`, `published_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Curso de Especialización en Diseño de Redes de Agua Potable y Sistemas de Alcantarillado', 'curso-especializacion-en-diseno-de-redes', 'course', 'published', NULL, '[{\"type\":\"HeroSection\",\"id\":\"7c136871-475f-4516-800b-29cef59d5441\",\"content\":{\"title\":\"Nuevo Hero\",\"subtitle\":\"Subt\\u00edtulo aqu\\u00ed\",\"ctaText\":\"Ver M\\u00e1s\",\"image\":null},\"isOpen\":true},{\"type\":\"CourseDetailBlock\",\"id\":\"543e3fb9-0825-4c27-bac9-a6e04abcbc29\",\"content\":{\"category\":\"Categor\\u00eda del Curso\",\"title\":\"Dise\\u00f1o de Redes de Agua Potable y Sistemas de Alcantarillado\",\"subtitle\":\"Curso de Especializaci\\u00f3n en\",\"startDate\":\"03-12-2025\",\"duration\":\"20 horas lectivas\",\"schedule\":\"Mi\\u00e9 7:00 - 10:00 PM\",\"whatsappNumber\":\"(+51) 918 378 298\",\"whatsappDisplay\":\"+51 999 999 999\",\"presentation\":\"En un entorno global donde el acceso al agua potable y el saneamiento adecuado son esenciales para la salud p\\u00fablica y el desarrollo sostenible, la formaci\\u00f3n especializada en dise\\u00f1o y gesti\\u00f3n de redes de agua y alcantarillado se convierte en una prioridad. Las empresas prestadoras de servicios y los profesionales del sector enfrentan desaf\\u00edos crecientes debido al crecimiento poblacional, el cambio clim\\u00e1tico y la necesidad de cumplir con normativas ambientales estrictas. Este curso ofrece una plataforma integral para adquirir conocimientos avanzados y habilidades pr\\u00e1cticas, promoviendo soluciones  sostenibles para mejorar la eficiencia y la resiliencia de las infraestructuras hidr\\u00e1ulicas.\",\"objectives\":[\"Comprender los fundamentos de hidr\\u00e1ulica aplicada a redes de agua y alcantarillado\",\"Calcular la demanda de agua y desag\\u00fce para distintos tipos de proyectos\",\"Dise\\u00f1ar y dimensionar tuber\\u00edas para sistemas de abastecimiento y alcantarillado\"],\"profile\":[\"Ingenieros civiles, sanitarios y ambientales interesados en especializarse en el dise\\u00f1o y gesti\\u00f3n de redes de agua y alcantarillado.\",\"Profesionales de empresas prestadoras de servicios de agua y saneamiento que busquen actualizar y ampliar sus conocimientos t\\u00e9cnicos y normativos.\",\"Funcionarios de instituciones p\\u00fablicas y organismos reguladores responsables de la planificaci\\u00f3n y supervisi\\u00f3n de proyectos de infraestructura hidr\\u00e1ulica.\",\"Consultores y contratistas que participen en proyectos de dise\\u00f1o, construcci\\u00f3n y mantenimiento de redes de agua potable y alcantarillado.\"],\"certification\":\"Informaci\\u00f3n de certificaci\\u00f3n...\",\"curriculum\":[\"Fundamentos de hidr\\u00e1ulica de tuber\\u00edas y canales\",\"C\\u00e1lculo de demanda de agua y desag\\u00fce.\",\"Dimensionamiento de tuber\\u00edas.\",\"Dise\\u00f1o de estructuras de captaci\\u00f3n y tratamiento\",\"Ubicaci\\u00f3n de v\\u00e1lvulas y accesorios.\"],\"importantNotes\":[\"Nota importante\"],\"teachers\":[{\"name\":\"Omar Olivos Lara\",\"role\":\"Especialista de Planeamiento F\\u00edsico en SEDAPAL\",\"bio\":\"Mag\\u00edster en Ingenier\\u00eda Civil por la PUCP. Ingeniero civil e ingeniero sanitario. Estudios de Diplomatura de especializaci\\u00f3n en Dise\\u00f1o Estructural por la PUCP. Especialista de proyectos en infraestructura civil e hidr\\u00e1ulica con experiencia en el dise\\u00f1o estructural de edificaciones, sistemas de protecci\\u00f3n s\\u00edsmica, dise\\u00f1o de estructuras hidr\\u00e1ulicas, formulaci\\u00f3n y evaluaci\\u00f3n de proyectos p\\u00fablicos y privados de ingenier\\u00eda. Actualmente especialista de planeamiento f\\u00edsico en el Equipo Planeamiento F\\u00edsico y Programaci\\u00f3n de Inversiones en Sedapal.\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/blocks\\/C11ur0C3URvn1CjtCd30ZVDDRAQ0fDall227Ye0b.jpg\"}],\"benefits\":[\"Beneficio 1\"]},\"isOpen\":false}]', NULL, NULL, 14.00, '2020-12-12', NULL, NULL, NULL, NULL, '2025-12-02 16:34:24', '2025-12-04 17:40:47', NULL),
(2, 1, 'Nosotros', 'nosotros-esan', 'landing', 'published', NULL, '[{\"type\":\"TeachersGrid\",\"id\":\"d91d6204-07fb-455d-8132-e2ce9d2896bf\",\"content\":{\"title\":\"Nuestros Docentes\",\"items\":[{\"name\":\"Sideral Lujan Carrion\",\"role\":\"Sideral Lujan Carrion\",\"image\":null},{\"name\":\"Sideral Lujan Carrion\",\"role\":\"Sideral Lujan Carrion\",\"image\":null},{\"name\":\"Sideral Lujan Carrion\",\"role\":\"Sideral Lujan Carrion\",\"image\":null}]}}]', NULL, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, '2025-12-02 17:24:34', '2025-12-05 17:43:54', NULL),
(3, 1, 'Equipo', 'equipo-esan', 'page', 'published', NULL, '[{\"type\":\"HeroSection\",\"id\":\"f730ea3d-a17c-48d7-a984-19832745e3cc\",\"content\":{\"title\":\"Equipo ESAN\",\"subtitle\":\"EQUIPO\",\"ctaText\":\"Ver M\\u00e1s\",\"image\":null}}]', 'equipo-esan', NULL, 0.00, NULL, NULL, NULL, NULL, NULL, '2025-12-02 21:41:45', '2025-12-05 17:57:35', NULL),
(4, 1, 'Curso', 'curso', 'page', 'published', NULL, '[{\"type\":\"DynamicCourseGrid\",\"id\":\"153acfb4-5038-4e61-b523-f0010ab231b0\",\"content\":{\"title\":\"Pr\\u00f3ximos Inicios\",\"limit\":4}}]', NULL, NULL, 5.00, NULL, NULL, NULL, NULL, NULL, '2025-12-03 14:44:06', '2025-12-05 17:56:03', NULL),
(5, 1, 'Cruso ventasd 1', 'curso-ventas-1', 'course', 'published', NULL, '[{\"type\":\"CourseDetailBlock\",\"id\":\"22d344a6-86b2-45f1-90a1-211e0956eff7\",\"content\":{\"category\":\"Categor\\u00eda\",\"title\":\"Nuevo Curso\",\"startDate\":\"1\",\"duration\":\"20 horas lectivas\",\"schedule\":\"1\",\"whatsappNumber\":\"99999999\",\"presentation\":\"En un entorno global donde el acceso al agua potable y el saneamiento adecuado son esenciales para la salud p\\u00fablica y el desarrollo sostenible, la formaci\\u00f3n especializada en dise\\u00f1o y gesti\\u00f3n de redes de agua y alcantarillado se convierte en una prioridad. Las empresas prestadoras de servicios y los profesionales del sector enfrentan desaf\\u00edos crecientes debido al crecimiento poblacional, el cambio clim\\u00e1tico y la necesidad de cumplir con normativas ambientales estrictas. Este curso ofrece una plataforma integral para adquirir conocimientos avanzados y habilidades pr\\u00e1cticas, promoviendo soluciones sostenibles para mejorar la eficiencia y la resiliencia de las infraestructuras hidr\\u00e1ulicas.\",\"objectives\":[\"Objetivo 1\",\"Nuevo\",\"Nuevo\",\"Nuevo\"],\"profile\":[\"Perfil 1\",\"Nuevo\",\"Nuevo\",\"Nuevo\"],\"certification\":null,\"curriculum\":[\"Tema 1\",\"Nuevo\",\"Nuevo\",\"Nuevo\"],\"teachers\":[{\"name\":\"eqweqeqe\",\"role\":\"qeqweqe\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/blocks\\/gaHjhtJAgngsdNrOFgDTfwyWIdGjD5ndUnAGFVYR.jpg\"}]}}]', '111111', NULL, 3.00, '2030-12-12', NULL, NULL, NULL, NULL, '2025-12-03 17:44:39', '2025-12-03 19:50:21', NULL),
(6, 1, 'Curso venta 5', 'curso-venta-41', 'course', 'published', NULL, '[{\"type\":\"CourseDetailBlock\",\"id\":\"50dd80f1-645a-4a9d-99e6-2af31636586a\",\"content\":{\"category\":\"Categor\\u00eda\",\"title\":\"Nuevo Curso\",\"startDate\":\"112313123\",\"duration\":\"123123\",\"schedule\":\"12321321\",\"whatsappNumber\":\"123123123\",\"presentation\":\"12312313131231231313123123131312312313131231231313123123131312312313131231231313\",\"objectives\":[\"Objetivo 1\",\"johan\",\"Nuevo\"],\"profile\":[\"Perfil 1\"],\"certification\":null,\"curriculum\":[\"Tema 1\"],\"teachers\":[{\"name\":\"docente\",\"role\":\"docentedocentedocente\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/blocks\\/pG4lbjfanLhrHry49wldaHIvTu9l1lMiCMJwFi6y.jpg\"}]}}]', NULL, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, '2025-12-03 20:31:03', '2025-12-03 20:31:51', NULL),
(7, 1, 'Curso De Introduccion a la Ing. de Software', 'curso-introduccio-ing', 'course', 'published', NULL, '[{\"type\":\"CourseDetailBlock\",\"id\":\"866aee54-56ff-4536-80b7-7cf5b0b6f7e0\",\"content\":{\"category\":\"ENERG\\u00cdA Y ELECTRICIDAD\",\"title\":\"Nuevo Curso\",\"startDate\":\"4-12-2005\",\"duration\":\"4hORAS\",\"schedule\":\"Lunes a Viernes 8PM\",\"whatsappNumber\":\"999321123\",\"presentation\":\"Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion Curso para la introduccion\",\"objectives\":[\"Objetivo 1\",\"Nuevo\",\"Nuevo\",\"Nuevo\"],\"profile\":[\"Perfil 1\",\"Nuevo\",\"Nuevo\",\"Nuevo\"],\"certification\":\"adsadasd\",\"curriculum\":[\"Tema 1\",\"Nuevo\",\"Nuevo\",\"Nuevo\"],\"teachers\":[{\"name\":\"Sideral Lujan Carrion\",\"role\":\"docente\",\"image\":null}],\"beneficios\":\"asdadsadsadsad\",\"certificacion\":\"gaaa\"}}]', NULL, 'http://127.0.0.1:8000/storage/blocks/SfXyrFbVAqLpmfv4XdQTCl9uwLjiz1vJGSzNv6BJ.png', 1000.00, '2025-12-12', NULL, NULL, NULL, NULL, '2025-12-04 16:06:18', '2025-12-04 17:44:41', NULL),
(8, 1, 'CursoPrueba', 'curso-prueba', 'course', 'published', 'DISPONIBLE', '[{\"type\":\"CourseDetailBlock\",\"id\":\"7d2f73ed-d02d-49d3-9281-cc045db077e9\",\"content\":{\"category\":\"Categor\\u00eda\",\"title\":\"Nuevo Curso\",\"startDate\":\"asdad\",\"duration\":\"asdasd\",\"schedule\":\"asdadsasd\",\"whatsappNumber\":\"asdasdasdas\",\"presentation\":\"dasdsadasdasd\",\"objectives\":[\"Objetivo 1\",\"Nuevo\"],\"profile\":[\"Perfil 1\"],\"certification\":\"adsadasdasdasdasdasd\",\"curriculum\":[\"Tema 1\"],\"teachers\":[{\"name\":\"asdasdasd\",\"role\":\"adsasdasd\",\"image\":null}],\"course_status\":\"DISPONIBLE\"}}]', 'asdasdadasdasdas', NULL, 123.00, '2121-12-12', NULL, NULL, NULL, NULL, '2025-12-04 17:46:37', '2025-12-04 22:55:09', NULL),
(9, 1, 'Inicio', 'inicio', 'page', 'published', NULL, '[{\"type\":\"HeroSection\",\"id\":\"69990f4d-e443-4298-89cd-a0efe386c50d\",\"content\":{\"title\":\"Bienvienido a la Esan\",\"subtitle\":\"Subitutlo\",\"ctaText\":\"Ver M\\u00e1s\",\"image\":\"http:\\/\\/127.0.0.1:8000\\/storage\\/blocks\\/1AbALwTv6xls7lzWnt6g5N8gSijF0k5955jfX3HZ.png\"}},{\"type\":\"ProgramGrid\",\"id\":\"70fa4f31-825d-46da-898e-6c7a3f715f11\",\"content\":{\"title\":\"Nuestras Carreras\",\"items\":[{\"title\":\"PREGADO\",\"link\":\"PREGADO\"},{\"title\":\"PREGADO\",\"link\":\"PREGADO\"},{\"title\":\"PREGADO\",\"link\":\"PREGADO\"},{\"title\":\"PREGADO\",\"link\":\"PREGADO\"}]}}]', NULL, NULL, 5.00, NULL, NULL, NULL, NULL, NULL, '2025-12-05 16:09:40', '2025-12-05 17:37:33', NULL),
(10, 7, 'Noticias', 'noticias', 'page', 'draft', NULL, '[]', NULL, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, '2025-12-05 18:02:33', '2025-12-05 18:02:33', NULL),
(11, 7, 'XD', 'GAAAA', 'page', 'published', NULL, '[{\"type\":\"ProgramGrid\",\"id\":\"3d6dc07b-1552-42cd-ba9a-7bf3fe70de56\",\"content\":{\"title\":\"ASDAAAAAAAAAAAAA\",\"items\":[{\"title\":\"ASDAD\",\"link\":\"ASDASD\"},{\"title\":\"ASDASD\",\"link\":\"ASDASD\"}]}}]', 'ASDSADAS', NULL, 5.00, NULL, NULL, NULL, NULL, NULL, '2025-12-05 19:41:15', '2025-12-05 19:42:31', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `post_meta`
--

CREATE TABLE `post_meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(191) NOT NULL,
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-
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

