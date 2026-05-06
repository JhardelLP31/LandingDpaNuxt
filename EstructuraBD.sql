

CREATE TABLE `academic_units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `code` varchar(50) DEFAULT NULL COMMENT 'Código institucional interno',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
('cms_cache_categories_admin_all', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:27:{i:0;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:31;s:4:\"name\";s:19:\"Creación de Videos\";s:4:\"slug\";s:18:\"creacion-de-videos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 16:43:21\";s:10:\"updated_at\";s:19:\"2026-02-10 16:43:21\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:31;s:4:\"name\";s:19:\"Creación de Videos\";s:4:\"slug\";s:18:\"creacion-de-videos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 16:43:21\";s:10:\"updated_at\";s:19:\"2026-02-10 16:43:21\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:1;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:30;s:4:\"name\";s:24:\"Inteligencia de Negocios\";s:4:\"slug\";s:24:\"inteligencia-de-negocios\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 16:43:10\";s:10:\"updated_at\";s:19:\"2026-02-10 16:43:10\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:30;s:4:\"name\";s:24:\"Inteligencia de Negocios\";s:4:\"slug\";s:24:\"inteligencia-de-negocios\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 16:43:10\";s:10:\"updated_at\";s:19:\"2026-02-10 16:43:10\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:2;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:29;s:4:\"name\";s:24:\"Modelamiento de Software\";s:4:\"slug\";s:24:\"modelamiento-de-software\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:17:44\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:44\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:29;s:4:\"name\";s:24:\"Modelamiento de Software\";s:4:\"slug\";s:24:\"modelamiento-de-software\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:17:44\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:44\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:3;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:28;s:4:\"name\";s:17:\"Minería de Datos\";s:4:\"slug\";s:16:\"mineria-de-datos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:17:32\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:32\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:28;s:4:\"name\";s:17:\"Minería de Datos\";s:4:\"slug\";s:16:\"mineria-de-datos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:17:32\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:32\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:4;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:27;s:4:\"name\";s:19:\"Software Financiero\";s:4:\"slug\";s:19:\"software-financiero\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:42\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:42\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:27;s:4:\"name\";s:19:\"Software Financiero\";s:4:\"slug\";s:19:\"software-financiero\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:42\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:42\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:5;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:26;s:4:\"name\";s:28:\"Administración de Proyectos\";s:4:\"slug\";s:27:\"administracion-de-proyectos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:37\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:37\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:26;s:4:\"name\";s:28:\"Administración de Proyectos\";s:4:\"slug\";s:27:\"administracion-de-proyectos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:37\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:37\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:6;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:25;s:4:\"name\";s:10:\"Ofimática\";s:4:\"slug\";s:9:\"ofimatica\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:12\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:05\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:25;s:4:\"name\";s:10:\"Ofimática\";s:4:\"slug\";s:9:\"ofimatica\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:12\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:05\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:7;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:24;s:4:\"name\";s:21:\"Software de Marketing\";s:4:\"slug\";s:21:\"software-de-marketing\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:02\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:02\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:24;s:4:\"name\";s:21:\"Software de Marketing\";s:4:\"slug\";s:21:\"software-de-marketing\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:02\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:02\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:8;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:23;s:4:\"name\";s:15:\"Virtualización\";s:4:\"slug\";s:13:\"virtualizacin\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:15:32\";s:10:\"updated_at\";s:19:\"2026-02-10 15:15:32\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:23;s:4:\"name\";s:15:\"Virtualización\";s:4:\"slug\";s:13:\"virtualizacin\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:15:32\";s:10:\"updated_at\";s:19:\"2026-02-10 15:15:32\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:9;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:22;s:4:\"name\";s:21:\"Software Estadístico\";s:4:\"slug\";s:20:\"software-estadistico\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:29:11\";s:10:\"updated_at\";s:19:\"2026-02-10 14:29:11\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:22;s:4:\"name\";s:21:\"Software Estadístico\";s:4:\"slug\";s:20:\"software-estadistico\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:29:11\";s:10:\"updated_at\";s:19:\"2026-02-10 14:29:11\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:10;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:21;s:4:\"name\";s:22:\"Software de Networking\";s:4:\"slug\";s:22:\"software-de-networking\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#10205c\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:28:49\";s:10:\"updated_at\";s:19:\"2026-02-10 14:28:49\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:21;s:4:\"name\";s:22:\"Software de Networking\";s:4:\"slug\";s:22:\"software-de-networking\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#10205c\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:28:49\";s:10:\"updated_at\";s:19:\"2026-02-10 14:28:49\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:11;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:20;s:4:\"name\";s:7:\"Diseño\";s:4:\"slug\";s:6:\"diseno\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#511877\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:28:27\";s:10:\"updated_at\";s:19:\"2026-02-10 14:28:27\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:20;s:4:\"name\";s:7:\"Diseño\";s:4:\"slug\";s:6:\"diseno\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#511877\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:28:27\";s:10:\"updated_at\";s:19:\"2026-02-10 14:28:27\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:12;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:19;s:4:\"name\";s:14:\"Bases de datos\";s:4:\"slug\";s:14:\"bases-de-datos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:67:\"http://127.0.0.1:8000//storage/media/1770677247_bizagi-modeler.webp\";s:5:\"color\";s:7:\"#56c5e1\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 22:57:55\";s:10:\"updated_at\";s:19:\"2026-02-09 22:57:55\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:19;s:4:\"name\";s:14:\"Bases de datos\";s:4:\"slug\";s:14:\"bases-de-datos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:67:\"http://127.0.0.1:8000//storage/media/1770677247_bizagi-modeler.webp\";s:5:\"color\";s:7:\"#56c5e1\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 22:57:55\";s:10:\"updated_at\";s:19:\"2026-02-09 22:57:55\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:13;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:18;s:4:\"name\";s:20:\"Modelado de Procesos\";s:4:\"slug\";s:20:\"modelado-de-procesos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:20:\"modelado-de-procesos\";s:10:\"image_path\";s:64:\"http://127.0.0.1:8000//storage/media/1768409923_consultoria.webp\";s:5:\"color\";s:7:\"#36ce70\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 22:41:36\";s:10:\"updated_at\";s:19:\"2026-02-09 22:41:36\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:18;s:4:\"name\";s:20:\"Modelado de Procesos\";s:4:\"slug\";s:20:\"modelado-de-procesos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:20:\"modelado-de-procesos\";s:10:\"image_path\";s:64:\"http://127.0.0.1:8000//storage/media/1768409923_consultoria.webp\";s:5:\"color\";s:7:\"#36ce70\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 22:41:36\";s:10:\"updated_at\";s:19:\"2026-02-09 22:41:36\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:14;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:17;s:4:\"name\";s:21:\"Software de Análisis\";s:4:\"slug\";s:20:\"software-de-analisis\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:66:\"http://127.0.0.1:8000//storage/media/1769716722_microfinanzas.webp\";s:5:\"color\";s:7:\"#f54336\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 21:45:54\";s:10:\"updated_at\";s:19:\"2026-02-09 21:45:54\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:17;s:4:\"name\";s:21:\"Software de Análisis\";s:4:\"slug\";s:20:\"software-de-analisis\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:66:\"http://127.0.0.1:8000//storage/media/1769716722_microfinanzas.webp\";s:5:\"color\";s:7:\"#f54336\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 21:45:54\";s:10:\"updated_at\";s:19:\"2026-02-09 21:45:54\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:15;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:15;s:4:\"name\";s:7:\"English\";s:4:\"slug\";s:7:\"english\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:59:13\";s:10:\"updated_at\";s:19:\"2026-02-06 21:59:13\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:15;s:4:\"name\";s:7:\"English\";s:4:\"slug\";s:7:\"english\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:59:13\";s:10:\"updated_at\";s:19:\"2026-02-06 21:59:13\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:16;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:14;s:4:\"name\";s:8:\"Español\";s:4:\"slug\";s:7:\"espanol\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:40:31\";s:10:\"updated_at\";s:19:\"2026-02-06 21:53:14\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:14;s:4:\"name\";s:8:\"Español\";s:4:\"slug\";s:7:\"espanol\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:40:31\";s:10:\"updated_at\";s:19:\"2026-02-06 21:53:14\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:17;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:12;s:4:\"name\";s:12:\"Aplicaciones\";s:4:\"slug\";s:12:\"aplicaciones\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:39:31\";s:10:\"updated_at\";s:19:\"2026-02-06 21:39:31\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:12;s:4:\"name\";s:12:\"Aplicaciones\";s:4:\"slug\";s:12:\"aplicaciones\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:39:31\";s:10:\"updated_at\";s:19:\"2026-02-06 21:39:31\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:18;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:11;s:4:\"name\";s:9:\"Telefonos\";s:4:\"slug\";s:9:\"telefonos\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:39:05\";s:10:\"updated_at\";s:19:\"2026-02-06 21:39:05\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:11;s:4:\"name\";s:9:\"Telefonos\";s:4:\"slug\";s:9:\"telefonos\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:39:05\";s:10:\"updated_at\";s:19:\"2026-02-06 21:39:05\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:19;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Laboratorio\";s:4:\"slug\";s:11:\"laboratorio\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:38:44\";s:10:\"updated_at\";s:19:\"2026-02-06 21:38:44\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Laboratorio\";s:4:\"slug\";s:11:\"laboratorio\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:38:44\";s:10:\"updated_at\";s:19:\"2026-02-06 21:38:44\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:20;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:9;s:4:\"name\";s:10:\"Profesores\";s:4:\"slug\";s:10:\"profesores\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008037_banca.webp\";s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 20:58:22\";s:10:\"updated_at\";s:19:\"2026-02-06 20:58:22\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:9;s:4:\"name\";s:10:\"Profesores\";s:4:\"slug\";s:10:\"profesores\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008037_banca.webp\";s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 20:58:22\";s:10:\"updated_at\";s:19:\"2026-02-06 20:58:22\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:21;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:7;s:4:\"name\";s:14:\"Micro Finanzas\";s:4:\"slug\";s:14:\"micro-finanzas\";s:4:\"type\";s:4:\"news\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:57:\"http://127.0.0.1:8000//storage/media/1766008084_agua.webp\";s:5:\"color\";s:7:\"#018290\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-01-13 16:29:53\";s:10:\"updated_at\";s:19:\"2026-02-09 21:28:53\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:7;s:4:\"name\";s:14:\"Micro Finanzas\";s:4:\"slug\";s:14:\"micro-finanzas\";s:4:\"type\";s:4:\"news\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:57:\"http://127.0.0.1:8000//storage/media/1766008084_agua.webp\";s:5:\"color\";s:7:\"#018290\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-01-13 16:29:53\";s:10:\"updated_at\";s:19:\"2026-02-09 21:28:53\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:22;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:5;s:4:\"name\";s:26:\"Desarrollo de Aplicaciones\";s:4:\"slug\";s:26:\"desarrollo-de-aplicaciones\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:20:\"energia-electricidad\";s:10:\"image_path\";s:60:\"http://127.0.0.1:8000//storage/media/1766007677_energia.webp\";s:5:\"color\";s:7:\"#00b151\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 21:41:43\";s:10:\"updated_at\";s:19:\"2026-02-09 22:09:27\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:5;s:4:\"name\";s:26:\"Desarrollo de Aplicaciones\";s:4:\"slug\";s:26:\"desarrollo-de-aplicaciones\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:20:\"energia-electricidad\";s:10:\"image_path\";s:60:\"http://127.0.0.1:8000//storage/media/1766007677_energia.webp\";s:5:\"color\";s:7:\"#00b151\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 21:41:43\";s:10:\"updated_at\";s:19:\"2026-02-09 22:09:27\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:23;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Banca y Seguros\";s:4:\"slug\";s:13:\"banca-seguros\";s:4:\"type\";s:4:\"page\";s:9:\"parent_id\";N;s:11:\"description\";s:13:\"banca-seguros\";s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008037_banca.webp\";s:5:\"color\";s:7:\"#0f6eb6\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 20:57:36\";s:10:\"updated_at\";s:19:\"2026-02-06 16:40:58\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Banca y Seguros\";s:4:\"slug\";s:13:\"banca-seguros\";s:4:\"type\";s:4:\"page\";s:9:\"parent_id\";N;s:11:\"description\";s:13:\"banca-seguros\";s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008037_banca.webp\";s:5:\"color\";s:7:\"#0f6eb6\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 20:57:36\";s:10:\"updated_at\";s:19:\"2026-02-06 16:40:58\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:24;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:3;s:4:\"name\";s:23:\"Creación de driagramas\";s:4:\"slug\";s:21:\"creacion-de-diagramas\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:11:\"transportes\";s:10:\"image_path\";s:63:\"http://127.0.0.1:8000//storage/media/1766008054_transporte.webp\";s:5:\"color\";s:7:\"#5f4d87\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 20:55:57\";s:10:\"updated_at\";s:19:\"2026-02-09 22:29:25\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:3;s:4:\"name\";s:23:\"Creación de driagramas\";s:4:\"slug\";s:21:\"creacion-de-diagramas\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:11:\"transportes\";s:10:\"image_path\";s:63:\"http://127.0.0.1:8000//storage/media/1766008054_transporte.webp\";s:5:\"color\";s:7:\"#5f4d87\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 20:55:57\";s:10:\"updated_at\";s:19:\"2026-02-09 22:29:25\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:25;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:2;s:4:\"name\";s:5:\"Salud\";s:4:\"slug\";s:5:\"salud\";s:4:\"type\";s:4:\"page\";s:9:\"parent_id\";N;s:11:\"description\";s:5:\"Salud\";s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008067_salud.webp\";s:5:\"color\";s:7:\"#43b0c2\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-16 22:32:42\";s:10:\"updated_at\";s:19:\"2026-02-06 16:41:11\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:2;s:4:\"name\";s:5:\"Salud\";s:4:\"slug\";s:5:\"salud\";s:4:\"type\";s:4:\"page\";s:9:\"parent_id\";N;s:11:\"description\";s:5:\"Salud\";s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008067_salud.webp\";s:5:\"color\";s:7:\"#43b0c2\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-16 22:32:42\";s:10:\"updated_at\";s:19:\"2026-02-06 16:41:11\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:26;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:1;s:4:\"name\";s:7:\"Alumnos\";s:4:\"slug\";s:7:\"alumnos\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";s:18:\"Agua y Saneamiento\";s:10:\"image_path\";s:57:\"http://127.0.0.1:8000//storage/media/1766008084_agua.webp\";s:5:\"color\";s:7:\"#01828f\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-16 16:43:07\";s:10:\"updated_at\";s:19:\"2026-02-06 20:51:06\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:1;s:4:\"name\";s:7:\"Alumnos\";s:4:\"slug\";s:7:\"alumnos\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";s:18:\"Agua y Saneamiento\";s:10:\"image_path\";s:57:\"http://127.0.0.1:8000//storage/media/1766008084_agua.webp\";s:5:\"color\";s:7:\"#01828f\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-16 16:43:07\";s:10:\"updated_at\";s:19:\"2026-02-06 20:51:06\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1770931028);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('cms_cache_categories_admin_course', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:18:{i:0;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:31;s:4:\"name\";s:19:\"Creación de Videos\";s:4:\"slug\";s:18:\"creacion-de-videos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 16:43:21\";s:10:\"updated_at\";s:19:\"2026-02-10 16:43:21\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:31;s:4:\"name\";s:19:\"Creación de Videos\";s:4:\"slug\";s:18:\"creacion-de-videos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 16:43:21\";s:10:\"updated_at\";s:19:\"2026-02-10 16:43:21\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:1;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:30;s:4:\"name\";s:24:\"Inteligencia de Negocios\";s:4:\"slug\";s:24:\"inteligencia-de-negocios\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 16:43:10\";s:10:\"updated_at\";s:19:\"2026-02-10 16:43:10\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:30;s:4:\"name\";s:24:\"Inteligencia de Negocios\";s:4:\"slug\";s:24:\"inteligencia-de-negocios\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 16:43:10\";s:10:\"updated_at\";s:19:\"2026-02-10 16:43:10\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:2;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:29;s:4:\"name\";s:24:\"Modelamiento de Software\";s:4:\"slug\";s:24:\"modelamiento-de-software\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:17:44\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:44\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:29;s:4:\"name\";s:24:\"Modelamiento de Software\";s:4:\"slug\";s:24:\"modelamiento-de-software\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:17:44\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:44\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:3;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:28;s:4:\"name\";s:17:\"Minería de Datos\";s:4:\"slug\";s:16:\"mineria-de-datos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:17:32\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:32\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:28;s:4:\"name\";s:17:\"Minería de Datos\";s:4:\"slug\";s:16:\"mineria-de-datos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:17:32\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:32\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:4;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:27;s:4:\"name\";s:19:\"Software Financiero\";s:4:\"slug\";s:19:\"software-financiero\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:42\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:42\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:27;s:4:\"name\";s:19:\"Software Financiero\";s:4:\"slug\";s:19:\"software-financiero\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:42\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:42\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:5;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:26;s:4:\"name\";s:28:\"Administración de Proyectos\";s:4:\"slug\";s:27:\"administracion-de-proyectos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:37\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:37\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:26;s:4:\"name\";s:28:\"Administración de Proyectos\";s:4:\"slug\";s:27:\"administracion-de-proyectos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:37\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:37\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:6;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:25;s:4:\"name\";s:10:\"Ofimática\";s:4:\"slug\";s:9:\"ofimatica\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:12\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:05\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:25;s:4:\"name\";s:10:\"Ofimática\";s:4:\"slug\";s:9:\"ofimatica\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:12\";s:10:\"updated_at\";s:19:\"2026-02-10 15:17:05\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:7;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:24;s:4:\"name\";s:21:\"Software de Marketing\";s:4:\"slug\";s:21:\"software-de-marketing\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:02\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:02\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:24;s:4:\"name\";s:21:\"Software de Marketing\";s:4:\"slug\";s:21:\"software-de-marketing\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:16:02\";s:10:\"updated_at\";s:19:\"2026-02-10 15:16:02\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:8;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:23;s:4:\"name\";s:15:\"Virtualización\";s:4:\"slug\";s:13:\"virtualizacin\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:15:32\";s:10:\"updated_at\";s:19:\"2026-02-10 15:15:32\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:23;s:4:\"name\";s:15:\"Virtualización\";s:4:\"slug\";s:13:\"virtualizacin\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 15:15:32\";s:10:\"updated_at\";s:19:\"2026-02-10 15:15:32\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:9;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:22;s:4:\"name\";s:21:\"Software Estadístico\";s:4:\"slug\";s:20:\"software-estadistico\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:29:11\";s:10:\"updated_at\";s:19:\"2026-02-10 14:29:11\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:22;s:4:\"name\";s:21:\"Software Estadístico\";s:4:\"slug\";s:20:\"software-estadistico\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:29:11\";s:10:\"updated_at\";s:19:\"2026-02-10 14:29:11\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:10;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:21;s:4:\"name\";s:22:\"Software de Networking\";s:4:\"slug\";s:22:\"software-de-networking\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#10205c\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:28:49\";s:10:\"updated_at\";s:19:\"2026-02-10 14:28:49\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:21;s:4:\"name\";s:22:\"Software de Networking\";s:4:\"slug\";s:22:\"software-de-networking\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#10205c\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:28:49\";s:10:\"updated_at\";s:19:\"2026-02-10 14:28:49\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:11;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:20;s:4:\"name\";s:7:\"Diseño\";s:4:\"slug\";s:6:\"diseno\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#511877\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:28:27\";s:10:\"updated_at\";s:19:\"2026-02-10 14:28:27\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:20;s:4:\"name\";s:7:\"Diseño\";s:4:\"slug\";s:6:\"diseno\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#511877\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-10 14:28:27\";s:10:\"updated_at\";s:19:\"2026-02-10 14:28:27\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:12;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:19;s:4:\"name\";s:14:\"Bases de datos\";s:4:\"slug\";s:14:\"bases-de-datos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:67:\"http://127.0.0.1:8000//storage/media/1770677247_bizagi-modeler.webp\";s:5:\"color\";s:7:\"#56c5e1\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 22:57:55\";s:10:\"updated_at\";s:19:\"2026-02-09 22:57:55\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:19;s:4:\"name\";s:14:\"Bases de datos\";s:4:\"slug\";s:14:\"bases-de-datos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:67:\"http://127.0.0.1:8000//storage/media/1770677247_bizagi-modeler.webp\";s:5:\"color\";s:7:\"#56c5e1\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 22:57:55\";s:10:\"updated_at\";s:19:\"2026-02-09 22:57:55\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:13;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:18;s:4:\"name\";s:20:\"Modelado de Procesos\";s:4:\"slug\";s:20:\"modelado-de-procesos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:20:\"modelado-de-procesos\";s:10:\"image_path\";s:64:\"http://127.0.0.1:8000//storage/media/1768409923_consultoria.webp\";s:5:\"color\";s:7:\"#36ce70\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 22:41:36\";s:10:\"updated_at\";s:19:\"2026-02-09 22:41:36\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:18;s:4:\"name\";s:20:\"Modelado de Procesos\";s:4:\"slug\";s:20:\"modelado-de-procesos\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:20:\"modelado-de-procesos\";s:10:\"image_path\";s:64:\"http://127.0.0.1:8000//storage/media/1768409923_consultoria.webp\";s:5:\"color\";s:7:\"#36ce70\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 22:41:36\";s:10:\"updated_at\";s:19:\"2026-02-09 22:41:36\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:14;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:17;s:4:\"name\";s:21:\"Software de Análisis\";s:4:\"slug\";s:20:\"software-de-analisis\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:66:\"http://127.0.0.1:8000//storage/media/1769716722_microfinanzas.webp\";s:5:\"color\";s:7:\"#f54336\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 21:45:54\";s:10:\"updated_at\";s:19:\"2026-02-09 21:45:54\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:17;s:4:\"name\";s:21:\"Software de Análisis\";s:4:\"slug\";s:20:\"software-de-analisis\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:66:\"http://127.0.0.1:8000//storage/media/1769716722_microfinanzas.webp\";s:5:\"color\";s:7:\"#f54336\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-09 21:45:54\";s:10:\"updated_at\";s:19:\"2026-02-09 21:45:54\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:15;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:8;s:4:\"name\";s:12:\"Interesantes\";s:4:\"slug\";s:12:\"interesantes\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:12:\"interesantes\";s:10:\"image_path\";s:64:\"http://127.0.0.1:8000//storage/media/1768409923_consultoria.webp\";s:5:\"color\";s:7:\"#be0a33\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-01-30 14:46:02\";s:10:\"updated_at\";s:19:\"2026-02-02 14:48:31\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:8;s:4:\"name\";s:12:\"Interesantes\";s:4:\"slug\";s:12:\"interesantes\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:12:\"interesantes\";s:10:\"image_path\";s:64:\"http://127.0.0.1:8000//storage/media/1768409923_consultoria.webp\";s:5:\"color\";s:7:\"#be0a33\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-01-30 14:46:02\";s:10:\"updated_at\";s:19:\"2026-02-02 14:48:31\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:16;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:5;s:4:\"name\";s:26:\"Desarrollo de Aplicaciones\";s:4:\"slug\";s:26:\"desarrollo-de-aplicaciones\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:20:\"energia-electricidad\";s:10:\"image_path\";s:60:\"http://127.0.0.1:8000//storage/media/1766007677_energia.webp\";s:5:\"color\";s:7:\"#00b151\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 21:41:43\";s:10:\"updated_at\";s:19:\"2026-02-09 22:09:27\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:5;s:4:\"name\";s:26:\"Desarrollo de Aplicaciones\";s:4:\"slug\";s:26:\"desarrollo-de-aplicaciones\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:20:\"energia-electricidad\";s:10:\"image_path\";s:60:\"http://127.0.0.1:8000//storage/media/1766007677_energia.webp\";s:5:\"color\";s:7:\"#00b151\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 21:41:43\";s:10:\"updated_at\";s:19:\"2026-02-09 22:09:27\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:17;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:3;s:4:\"name\";s:23:\"Creación de driagramas\";s:4:\"slug\";s:21:\"creacion-de-diagramas\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:11:\"transportes\";s:10:\"image_path\";s:63:\"http://127.0.0.1:8000//storage/media/1766008054_transporte.webp\";s:5:\"color\";s:7:\"#5f4d87\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 20:55:57\";s:10:\"updated_at\";s:19:\"2026-02-09 22:29:25\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:3;s:4:\"name\";s:23:\"Creación de driagramas\";s:4:\"slug\";s:21:\"creacion-de-diagramas\";s:4:\"type\";s:6:\"course\";s:9:\"parent_id\";N;s:11:\"description\";s:11:\"transportes\";s:10:\"image_path\";s:63:\"http://127.0.0.1:8000//storage/media/1766008054_transporte.webp\";s:5:\"color\";s:7:\"#5f4d87\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 20:55:57\";s:10:\"updated_at\";s:19:\"2026-02-09 22:29:25\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1770831946);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('cms_cache_categories_admin_manual', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:7:{i:0;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:15;s:4:\"name\";s:7:\"English\";s:4:\"slug\";s:7:\"english\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:59:13\";s:10:\"updated_at\";s:19:\"2026-02-06 21:59:13\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:15;s:4:\"name\";s:7:\"English\";s:4:\"slug\";s:7:\"english\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:59:13\";s:10:\"updated_at\";s:19:\"2026-02-06 21:59:13\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:1;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:14;s:4:\"name\";s:8:\"Español\";s:4:\"slug\";s:7:\"espanol\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:40:31\";s:10:\"updated_at\";s:19:\"2026-02-06 21:53:14\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:14;s:4:\"name\";s:8:\"Español\";s:4:\"slug\";s:7:\"espanol\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:40:31\";s:10:\"updated_at\";s:19:\"2026-02-06 21:53:14\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:2;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:12;s:4:\"name\";s:12:\"Aplicaciones\";s:4:\"slug\";s:12:\"aplicaciones\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:39:31\";s:10:\"updated_at\";s:19:\"2026-02-06 21:39:31\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:12;s:4:\"name\";s:12:\"Aplicaciones\";s:4:\"slug\";s:12:\"aplicaciones\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:39:31\";s:10:\"updated_at\";s:19:\"2026-02-06 21:39:31\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:3;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:11;s:4:\"name\";s:9:\"Telefonos\";s:4:\"slug\";s:9:\"telefonos\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:39:05\";s:10:\"updated_at\";s:19:\"2026-02-06 21:39:05\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:11;s:4:\"name\";s:9:\"Telefonos\";s:4:\"slug\";s:9:\"telefonos\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:39:05\";s:10:\"updated_at\";s:19:\"2026-02-06 21:39:05\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:4;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Laboratorio\";s:4:\"slug\";s:11:\"laboratorio\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:38:44\";s:10:\"updated_at\";s:19:\"2026-02-06 21:38:44\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:10;s:4:\"name\";s:11:\"Laboratorio\";s:4:\"slug\";s:11:\"laboratorio\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 21:38:44\";s:10:\"updated_at\";s:19:\"2026-02-06 21:38:44\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:5;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:9;s:4:\"name\";s:10:\"Profesores\";s:4:\"slug\";s:10:\"profesores\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008037_banca.webp\";s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 20:58:22\";s:10:\"updated_at\";s:19:\"2026-02-06 20:58:22\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:9;s:4:\"name\";s:10:\"Profesores\";s:4:\"slug\";s:10:\"profesores\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008037_banca.webp\";s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-06 20:58:22\";s:10:\"updated_at\";s:19:\"2026-02-06 20:58:22\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:6;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:1;s:4:\"name\";s:7:\"Alumnos\";s:4:\"slug\";s:7:\"alumnos\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";s:18:\"Agua y Saneamiento\";s:10:\"image_path\";s:57:\"http://127.0.0.1:8000//storage/media/1766008084_agua.webp\";s:5:\"color\";s:7:\"#01828f\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-16 16:43:07\";s:10:\"updated_at\";s:19:\"2026-02-06 20:51:06\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:1;s:4:\"name\";s:7:\"Alumnos\";s:4:\"slug\";s:7:\"alumnos\";s:4:\"type\";s:6:\"manual\";s:9:\"parent_id\";N;s:11:\"description\";s:18:\"Agua y Saneamiento\";s:10:\"image_path\";s:57:\"http://127.0.0.1:8000//storage/media/1766008084_agua.webp\";s:5:\"color\";s:7:\"#01828f\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-16 16:43:07\";s:10:\"updated_at\";s:19:\"2026-02-06 20:51:06\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1770829117),
('cms_cache_categories_admin_news', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:33;s:4:\"name\";s:27:\"Boletines de Ciberseguridad\";s:4:\"slug\";s:27:\"boletines-de-ciberseguridad\";s:4:\"type\";s:4:\"news\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-12 20:30:08\";s:10:\"updated_at\";s:19:\"2026-02-12 20:30:08\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:33;s:4:\"name\";s:27:\"Boletines de Ciberseguridad\";s:4:\"slug\";s:27:\"boletines-de-ciberseguridad\";s:4:\"type\";s:4:\"news\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-12 20:30:08\";s:10:\"updated_at\";s:19:\"2026-02-12 20:30:08\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:1;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:32;s:4:\"name\";s:11:\"Tecnología\";s:4:\"slug\";s:9:\"tecnologa\";s:4:\"type\";s:4:\"news\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-12 20:29:00\";s:10:\"updated_at\";s:19:\"2026-02-12 20:29:00\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:32;s:4:\"name\";s:11:\"Tecnología\";s:4:\"slug\";s:9:\"tecnologa\";s:4:\"type\";s:4:\"news\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";N;s:5:\"color\";s:7:\"#000000\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-02-12 20:29:00\";s:10:\"updated_at\";s:19:\"2026-02-12 20:29:00\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:2;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:7;s:4:\"name\";s:18:\"Proyectos ESANDATA\";s:4:\"slug\";s:18:\"proyectos-esandata\";s:4:\"type\";s:4:\"news\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:57:\"http://127.0.0.1:8000//storage/media/1766008084_agua.webp\";s:5:\"color\";s:7:\"#018290\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-01-13 16:29:53\";s:10:\"updated_at\";s:19:\"2026-02-12 20:17:33\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:7;s:4:\"name\";s:18:\"Proyectos ESANDATA\";s:4:\"slug\";s:18:\"proyectos-esandata\";s:4:\"type\";s:4:\"news\";s:9:\"parent_id\";N;s:11:\"description\";N;s:10:\"image_path\";s:57:\"http://127.0.0.1:8000//storage/media/1766008084_agua.webp\";s:5:\"color\";s:7:\"#018290\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2026-01-13 16:29:53\";s:10:\"updated_at\";s:19:\"2026-02-12 20:17:33\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1770931809),
('cms_cache_categories_admin_page', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:2:{i:0;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Banca y Seguros\";s:4:\"slug\";s:13:\"banca-seguros\";s:4:\"type\";s:4:\"page\";s:9:\"parent_id\";N;s:11:\"description\";s:13:\"banca-seguros\";s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008037_banca.webp\";s:5:\"color\";s:7:\"#0f6eb6\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 20:57:36\";s:10:\"updated_at\";s:19:\"2026-02-06 16:40:58\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Banca y Seguros\";s:4:\"slug\";s:13:\"banca-seguros\";s:4:\"type\";s:4:\"page\";s:9:\"parent_id\";N;s:11:\"description\";s:13:\"banca-seguros\";s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008037_banca.webp\";s:5:\"color\";s:7:\"#0f6eb6\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-17 20:57:36\";s:10:\"updated_at\";s:19:\"2026-02-06 16:40:58\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}i:1;O:28:\"App\\Models\\Category\\Category\":31:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:10:\"categories\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:12:{s:2:\"id\";i:2;s:4:\"name\";s:5:\"Salud\";s:4:\"slug\";s:5:\"salud\";s:4:\"type\";s:4:\"page\";s:9:\"parent_id\";N;s:11:\"description\";s:5:\"Salud\";s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008067_salud.webp\";s:5:\"color\";s:7:\"#43b0c2\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-16 22:32:42\";s:10:\"updated_at\";s:19:\"2026-02-06 16:41:11\";s:10:\"deleted_at\";N;}s:11:\"\0*\0original\";a:12:{s:2:\"id\";i:2;s:4:\"name\";s:5:\"Salud\";s:4:\"slug\";s:5:\"salud\";s:4:\"type\";s:4:\"page\";s:9:\"parent_id\";N;s:11:\"description\";s:5:\"Salud\";s:10:\"image_path\";s:58:\"http://127.0.0.1:8000//storage/media/1766008067_salud.webp\";s:5:\"color\";s:7:\"#43b0c2\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-12-16 22:32:42\";s:10:\"updated_at\";s:19:\"2026-02-06 16:41:11\";s:10:\"deleted_at\";N;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:2:{s:9:\"is_active\";s:7:\"boolean\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:1:{i:0;s:9:\"image_url\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:17:\"childrenRecursive\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:8:{i:0;s:9:\"parent_id\";i:1;s:4:\"name\";i:2;s:4:\"slug\";i:3;s:4:\"type\";i:4;s:11:\"description\";i:5;s:10:\"image_path\";i:6;s:5:\"color\";i:7;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1770831944),
('cms_cache_spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:41:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:9:\"dashboard\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:1;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:13:\"register_user\";s:1:\"c\";s:3:\"api\";}i:2;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:9:\"list_user\";s:1:\"c\";s:3:\"api\";}i:3;a:3:{s:1:\"a\";i:4;s:1:\"b\";s:9:\"edit_user\";s:1:\"c\";s:3:\"api\";}i:4;a:3:{s:1:\"a\";i:5;s:1:\"b\";s:11:\"delete_user\";s:1:\"c\";s:3:\"api\";}i:5;a:3:{s:1:\"a\";i:6;s:1:\"b\";s:13:\"register_role\";s:1:\"c\";s:3:\"api\";}i:6;a:3:{s:1:\"a\";i:7;s:1:\"b\";s:9:\"list_role\";s:1:\"c\";s:3:\"api\";}i:7;a:3:{s:1:\"a\";i:8;s:1:\"b\";s:9:\"edit_role\";s:1:\"c\";s:3:\"api\";}i:8;a:3:{s:1:\"a\";i:9;s:1:\"b\";s:11:\"delete_role\";s:1:\"c\";s:3:\"api\";}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:17:\"register_category\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:13:\"list_category\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:13:\"edit_category\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:15:\"delete_category\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:15:\"register_course\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:11:\"list_course\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:11:\"edit_course\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:13:\"delete_course\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:13:\"register_post\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:9:\"list_post\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:9:\"edit_post\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:11:\"delete_post\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:18:\"register_menu_item\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:14:\"list_menu_item\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:14:\"edit_menu_item\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:16:\"delete_menu_item\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:14:\"register_media\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:10:\"list_media\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:10:\"edit_media\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:12:\"delete_media\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:29;a:3:{s:1:\"a\";i:30;s:1:\"b\";s:13:\"register_lead\";s:1:\"c\";s:3:\"api\";}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:9:\"list_lead\";s:1:\"c\";s:3:\"api\";s:1:\"r\";a:1:{i:0;i:2;}}i:31;a:3:{s:1:\"a\";i:32;s:1:\"b\";s:9:\"edit_lead\";s:1:\"c\";s:3:\"api\";}i:32;a:3:{s:1:\"a\";i:33;s:1:\"b\";s:11:\"delete_lead\";s:1:\"c\";s:3:\"api\";}i:33;a:3:{s:1:\"a\";i:34;s:1:\"b\";s:13:\"register_news\";s:1:\"c\";s:3:\"api\";}i:34;a:3:{s:1:\"a\";i:35;s:1:\"b\";s:9:\"list_news\";s:1:\"c\";s:3:\"api\";}i:35;a:3:{s:1:\"a\";i:36;s:1:\"b\";s:9:\"edit_news\";s:1:\"c\";s:3:\"api\";}i:36;a:3:{s:1:\"a\";i:37;s:1:\"b\";s:11:\"delete_news\";s:1:\"c\";s:3:\"api\";}i:37;a:3:{s:1:\"a\";i:38;s:1:\"b\";s:15:\"register_manual\";s:1:\"c\";s:3:\"api\";}i:38;a:3:{s:1:\"a\";i:39;s:1:\"b\";s:11:\"list_manual\";s:1:\"c\";s:3:\"api\";}i:39;a:3:{s:1:\"a\";i:40;s:1:\"b\";s:11:\"edit_manual\";s:1:\"c\";s:3:\"api\";}i:40;a:3:{s:1:\"a\";i:41;s:1:\"b\";s:13:\"delete_manual\";s:1:\"c\";s:3:\"api\";}}s:5:\"roles\";a:2:{i:0;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:10:\"Diseñador\";s:1:\"c\";s:3:\"api\";}i:1;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:5:\"Vista\";s:1:\"c\";s:3:\"api\";}}}', 1771013824);

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
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `offering_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Respuestas del formulario dinámico' CHECK (json_valid(`payload`)),
  `marketing_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'UTMs, Source, IP, Device' CHECK (json_valid(`marketing_data`)),
  `status` enum('new','contacted','converted','spam') DEFAULT 'new',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marketing_campaigns`
--

CREATE TABLE `marketing_campaigns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `study_program_id` bigint(20) UNSIGNED NOT NULL,
  `content_id` bigint(20) UNSIGNED NOT NULL COMMENT 'La landing page asociada',
  `academic_period` varchar(50) NOT NULL COMMENT 'Ej: 2026-I',
  `price` decimal(12,2) DEFAULT 0.00,
  `price_discount` decimal(12,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `form_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Configuración dinámica del formulario de captación' CHECK (json_valid(`form_config`)),
  `utm_source` varchar(100) DEFAULT 'web',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `media`
--

CREATE TABLE `media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `folder_id` bigint(20) UNSIGNED DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `url` varchar(500) NOT NULL,
  `path` varchar(500) NOT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `size` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_items`
--

CREATE TABLE `menu_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `content_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `target` enum('_self','_blank') DEFAULT '_self',
  `order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'App\\Models\\User', 9),
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
(41, 'delete_manual', 'api', '2026-02-11 16:11:07', '2026-02-11 16:11:07');

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
(3, 'Vista', 'api', '2026-01-05 19:52:48', '2026-01-05 19:52:48');

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
(10, 2),
(11, 2),
(11, 3),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(19, 3),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(23, 3),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(27, 3),
(28, 2),
(29, 2),
(31, 2);

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
-- Estructura de tabla para la tabla `study_programs`
--

CREATE TABLE `study_programs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `branding_color` varchar(7) DEFAULT '#000000',
  `curriculum_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`curriculum_json`)),
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unit_branding`
--

CREATE TABLE `unit_branding` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `academic_unit_id` bigint(20) UNSIGNED NOT NULL,
  `primary_color` varchar(7) DEFAULT '#01828f',
  `secondary_color` varchar(7) DEFAULT '#ffffff',
  `logo_primary_path` varchar(255) DEFAULT NULL,
  `logo_footer_path` varchar(255) DEFAULT NULL,
  `header_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '{ "style": "transparent", "sticky": true }' CHECK (json_valid(`header_config`)),
  `footer_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '{ "columns": 4, "show_social": true }' CHECK (json_valid(`footer_config`)),
  `custom_css` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

INSERT INTO `users` (`id`, `name`, `surname`, `email`, `avatar`, `role_id`, `phone`, `type_document`, `n_document`, `gender`, `state`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Jhar Del Alfonso', 'Pumahuillca Llancay', 'jpumahuillca@esan.edu.pe', NULL, 1, NULL, NULL, NULL, 'M', 1, '2025-04-07 07:36:52', '$2y$12$0961rXwuun2ngdhUrri7E..vDHPzA2k2tFz9mhveBdF5OfS0RIyq2', 'Bk3vemcQBz', '2025-04-07 07:36:52', '2025-12-04 03:49:48', NULL),
(2, 'Juan', 'Diaz', 'juandiaz@gmail.com', NULL, 2, '975717177', 'TARJETA MILITAR', '74782828', 'M', 1, NULL, '$2y$12$64vOQxt7L2KlAv6J770cb..a7ArAKlY5QYPY8mqD4d56HbHjN9Feu', NULL, '2025-04-08 05:50:01', '2026-01-20 00:40:24', '2026-01-20 00:40:24'),
(3, 'Fatima', 'Lopez', 'danielopez@gmail.com', NULL, 2, '94454544', 'DNI', '74828282', 'F', 1, NULL, '$2y$12$dLI8ajL8giFLGKN6MzanDugEHrDnfA.meFhNojJC1M4G4nNMHDH1O', NULL, '2025-04-08 05:52:05', '2026-01-20 00:40:28', '2026-01-20 00:40:28'),
(4, 'Gabrieles', 'Soto', 'gabrielsoto@gmail.com', NULL, 2, '9845454', 'CARNET DE EXTRANJERIA', '478528282', 'M', 2, NULL, '$2y$12$wnxe6hcoYJBu1Y5FyenjJODlU1WRy2slRteMvZONPbjQpJjQUBkN6', NULL, '2025-04-08 06:09:28', '2026-01-20 00:40:33', '2026-01-20 00:40:33'),
(6, 'Johan Renzo', 'Mamani Simeon', 'jmamanisi@esan.edu.pe', NULL, 2, NULL, NULL, NULL, 'M', 1, NULL, '$2y$12$cGxKpbGDt6Y6qgTyYGzCs.Nko0Xc.gNYWFHEUxANsRF5mdLOIi5oa', NULL, '2025-12-04 19:29:55', '2025-12-04 19:29:55', NULL),
(8, 'Jose Jaico', NULL, 'laravest@gmail.com', NULL, 1, NULL, NULL, NULL, 'M', 1, NULL, '$2y$12$XOqiCPhSw0TrqHRr19Hx.O/65xOsvvMz5ad5kHKrS1rxde0MaqVRm', NULL, '2026-01-05 19:24:22', '2026-01-05 20:17:54', '2026-01-05 20:17:54'),
(10, 'Luis ', 'Escobar', 'lescobar@esan.edu.pe', NULL, 3, '321321321', 'DNI', '12341234', 'M', 1, NULL, '$2y$12$xGVJopHKeHMRn7aRrYqMgu0fbxwbMFAkDRb/LqrunoBO08TEatd3i', NULL, '2026-01-05 22:16:45', '2026-01-05 22:40:14', NULL),
(11, 'Cesar', 'Chavez Perez', 'cchavezp@esan.edu.pe', NULL, 2, '321321123', 'DNI', '987897789', 'M', 1, NULL, '$2y$12$pJN.JT2lFpqRkOBplg9BUef/H2TiN2PLfih0k33JAQo1xY2btXDgW', NULL, '2026-01-05 22:50:09', '2026-01-05 22:52:56', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `academic_units`
--
ALTER TABLE `academic_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unit_slug_unique` (`slug`),
  ADD UNIQUE KEY `code` (`code`);

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
  ADD KEY `fk_lead_offering` (`offering_id`);

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
  ADD KEY `fk_media_folder` (`folder_id`);

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
  ADD KEY `fk_item_menu` (`menu_id`),
  ADD KEY `fk_item_parent` (`parent_id`),
  ADD KEY `fk_item_content` (`content_id`);

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
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `academic_units`
--
ALTER TABLE `academic_units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `contents`
--
ALTER TABLE `contents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `marketing_campaigns`
--
ALTER TABLE `marketing_campaigns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `media_folders`
--
ALTER TABLE `media_folders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `study_programs`
--
ALTER TABLE `study_programs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `unit_branding`
--
ALTER TABLE `unit_branding`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
  ADD CONSTRAINT `fk_lead_offering` FOREIGN KEY (`offering_id`) REFERENCES `marketing_campaigns` (`id`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `fk_media_folder` FOREIGN KEY (`folder_id`) REFERENCES `media_folders` (`id`) ON DELETE SET NULL;

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
  ADD CONSTRAINT `fk_item_content` FOREIGN KEY (`content_id`) REFERENCES `contents` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_item_menu` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_item_parent` FOREIGN KEY (`parent_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE;

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
COMMIT;
