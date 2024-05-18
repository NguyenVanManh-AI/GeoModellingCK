-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table geobaocaock.admins
CREATE TABLE IF NOT EXISTS `admins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.admins: ~0 rows (approximately)
INSERT INTO `admins` (`id`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'admin12345@gmail.com', '$2y$10$5F3dxYKQuROH7tzD9MojAeUXFnQ.cb.GBE./cni31LTcdeCrq90HS', NULL, '2024-05-15 13:53:00', '2024-05-15 13:53:00');

-- Dumping structure for table geobaocaock.broadcasts
CREATE TABLE IF NOT EXISTS `broadcasts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `line_user_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sent_at` timestamp NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `sender_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `broadcasts_sender_id_foreign` (`sender_id`),
  CONSTRAINT `broadcasts_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.broadcasts: ~0 rows (approximately)

-- Dumping structure for table geobaocaock.channels
CREATE TABLE IF NOT EXISTS `channels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_manager_id` bigint unsigned NOT NULL,
  `channel_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_access_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `picture_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channels_account_manager_id_foreign` (`account_manager_id`),
  CONSTRAINT `channels_account_manager_id_foreign` FOREIGN KEY (`account_manager_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.channels: ~2 rows (approximately)
INSERT INTO `channels` (`id`, `account_manager_id`, `channel_id`, `channel_name`, `channel_secret`, `channel_access_token`, `picture_url`, `created_at`, `updated_at`) VALUES
	(1, 1, '2003175796', '[test]chanel_test1', '779f329a5ba363654bb7edbc2b84b6d7', 'Sgxs8tgbGJN41Q92WuIQPIggm3feQjyK3GWGClLc0t16jPhg15HXsECa4l/ce39y54Vpd2PmoxcthCJZyAjYlUeoivpkWtVeXjQQ5vGpEpa7uo2bm2j8exh4zrzIG6C7yJacZtcN1NRlOP7wYN0PnwdB04t89/1O/w1cDnyilFU=', NULL, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(2, 2, '2003308317', 'test_dut1', '1446e7d4c9eec2443fc21ce0cf4b45ec', 'txnQ8efyzbIGDv6VZ1HrATucI+rskmpJGYquRfuhTqUwnGude26UC75NIR5mtWRbyIJ6piDEaedbW3dPeJjL5Gmj0fns5EW1tDa7aXBXpH/hwDWR+KFYD0rggc3p8uplB8VIhcqSslKShINtK58JhgdB04t89/1O/w1cDnyilFU=', NULL, '2024-05-15 13:53:00', '2024-05-15 13:53:00');

-- Dumping structure for table geobaocaock.channel_statisticals
CREATE TABLE IF NOT EXISTS `channel_statisticals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` bigint unsigned NOT NULL,
  `date` date NOT NULL,
  `api_broadcast` int DEFAULT '0',
  `api_multicast` int DEFAULT '0',
  `followers` int DEFAULT '0',
  `targeted_reaches` int DEFAULT '0',
  `blocks` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channel_statisticals_channel_id_foreign` (`channel_id`),
  CONSTRAINT `channel_statisticals_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.channel_statisticals: ~60 rows (approximately)
INSERT INTO `channel_statisticals` (`id`, `channel_id`, `date`, `api_broadcast`, `api_multicast`, `followers`, `targeted_reaches`, `blocks`, `created_at`, `updated_at`) VALUES
	(1, 1, '2024-04-15', 80, 32, 9, 10, 24, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(2, 2, '2024-04-15', 67, 33, 1, 14, 17, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(3, 1, '2024-04-16', 30, 64, 3, 8, 12, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(4, 2, '2024-04-16', 49, 22, 4, 28, 7, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(5, 1, '2024-04-17', 100, 10, 14, 25, 22, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(6, 2, '2024-04-17', 4, 25, 27, 13, 14, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(7, 1, '2024-04-18', 65, 96, 15, 18, 1, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(8, 2, '2024-04-18', 22, 72, 21, 14, 20, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(9, 1, '2024-04-19', 45, 89, 22, 27, 18, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(10, 2, '2024-04-19', 57, 86, 3, 18, 14, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(11, 1, '2024-04-20', 13, 71, 13, 27, 14, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(12, 2, '2024-04-20', 11, 74, 23, 12, 9, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(13, 1, '2024-04-21', 63, 44, 4, 26, 25, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(14, 2, '2024-04-21', 31, 17, 6, 16, 9, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(15, 1, '2024-04-22', 84, 93, 25, 16, 19, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(16, 2, '2024-04-22', 62, 96, 23, 0, 26, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(17, 1, '2024-04-23', 60, 95, 0, 21, 18, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(18, 2, '2024-04-23', 9, 90, 21, 3, 4, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(19, 1, '2024-04-24', 47, 77, 1, 14, 4, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(20, 2, '2024-04-24', 9, 85, 17, 13, 1, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(21, 1, '2024-04-25', 87, 52, 0, 25, 2, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(22, 2, '2024-04-25', 19, 59, 29, 15, 14, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(23, 1, '2024-04-26', 59, 8, 11, 11, 11, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(24, 2, '2024-04-26', 36, 45, 12, 1, 6, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(25, 1, '2024-04-27', 90, 95, 24, 8, 13, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(26, 2, '2024-04-27', 99, 89, 18, 30, 25, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(27, 1, '2024-04-28', 76, 15, 22, 28, 5, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(28, 2, '2024-04-28', 60, 30, 4, 6, 21, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(29, 1, '2024-04-29', 26, 77, 24, 28, 3, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(30, 2, '2024-04-29', 73, 97, 13, 22, 7, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(31, 1, '2024-04-30', 26, 36, 20, 4, 10, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(32, 2, '2024-04-30', 84, 58, 6, 2, 21, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(33, 1, '2024-05-01', 76, 25, 5, 0, 20, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(34, 2, '2024-05-01', 57, 43, 29, 6, 20, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(35, 1, '2024-05-02', 4, 2, 23, 17, 14, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(36, 2, '2024-05-02', 19, 11, 20, 7, 4, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(37, 1, '2024-05-03', 63, 84, 5, 10, 19, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(38, 2, '2024-05-03', 17, 27, 0, 21, 22, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(39, 1, '2024-05-04', 11, 55, 22, 0, 2, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(40, 2, '2024-05-04', 46, 87, 14, 12, 7, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(41, 1, '2024-05-05', 69, 3, 10, 4, 11, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(42, 2, '2024-05-05', 14, 26, 4, 20, 21, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(43, 1, '2024-05-06', 45, 87, 2, 16, 11, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(44, 2, '2024-05-06', 22, 1, 13, 16, 16, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(45, 1, '2024-05-07', 13, 99, 0, 24, 0, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(46, 2, '2024-05-07', 61, 89, 30, 21, 15, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(47, 1, '2024-05-08', 87, 63, 24, 22, 12, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(48, 2, '2024-05-08', 17, 12, 20, 18, 25, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(49, 1, '2024-05-09', 46, 92, 9, 18, 17, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(50, 2, '2024-05-09', 69, 26, 0, 12, 3, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(51, 1, '2024-05-10', 84, 41, 14, 30, 7, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(52, 2, '2024-05-10', 55, 23, 14, 21, 9, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(53, 1, '2024-05-11', 74, 27, 21, 25, 13, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(54, 2, '2024-05-11', 55, 22, 13, 28, 14, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(55, 1, '2024-05-12', 83, 0, 21, 16, 23, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(56, 2, '2024-05-12', 73, 72, 12, 6, 12, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(57, 1, '2024-05-13', 91, 27, 21, 26, 1, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(58, 2, '2024-05-13', 93, 43, 15, 3, 11, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(59, 1, '2024-05-14', 89, 75, 15, 9, 12, '2024-05-15 13:53:00', '2024-05-15 13:53:00'),
	(60, 2, '2024-05-14', 49, 5, 1, 13, 8, '2024-05-15 13:53:00', '2024-05-15 13:53:00');

-- Dumping structure for table geobaocaock.contents
CREATE TABLE IF NOT EXISTS `contents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `content_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_data` json NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_id` bigint unsigned NOT NULL,
  `update_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contents_user_id_foreign` (`user_id`),
  KEY `contents_create_id_foreign` (`create_id`),
  KEY `contents_update_id_foreign` (`update_id`),
  CONSTRAINT `contents_create_id_foreign` FOREIGN KEY (`create_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contents_update_id_foreign` FOREIGN KEY (`update_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.contents: ~0 rows (approximately)

-- Dumping structure for table geobaocaock.content_broadcasts
CREATE TABLE IF NOT EXISTS `content_broadcasts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `broadcast_id` bigint unsigned NOT NULL,
  `content_id` bigint unsigned DEFAULT NULL,
  `content_sticker` json DEFAULT NULL,
  `sequence` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `content_broadcasts_user_id_foreign` (`user_id`),
  KEY `content_broadcasts_broadcast_id_foreign` (`broadcast_id`),
  KEY `content_broadcasts_content_id_foreign` (`content_id`),
  CONSTRAINT `content_broadcasts_broadcast_id_foreign` FOREIGN KEY (`broadcast_id`) REFERENCES `broadcasts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_broadcasts_content_id_foreign` FOREIGN KEY (`content_id`) REFERENCES `contents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_broadcasts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.content_broadcasts: ~0 rows (approximately)

-- Dumping structure for table geobaocaock.content_keywords
CREATE TABLE IF NOT EXISTS `content_keywords` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `content_id` bigint unsigned NOT NULL,
  `keyword_id` bigint unsigned NOT NULL,
  `sequence` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `content_keywords_user_id_foreign` (`user_id`),
  KEY `content_keywords_content_id_foreign` (`content_id`),
  KEY `content_keywords_keyword_id_foreign` (`keyword_id`),
  CONSTRAINT `content_keywords_content_id_foreign` FOREIGN KEY (`content_id`) REFERENCES `contents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_keywords_keyword_id_foreign` FOREIGN KEY (`keyword_id`) REFERENCES `keywords` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_keywords_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.content_keywords: ~0 rows (approximately)

-- Dumping structure for table geobaocaock.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table geobaocaock.interaction_logs
CREATE TABLE IF NOT EXISTS `interaction_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `timestamp` timestamp NOT NULL,
  `action_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `interaction_logs_user_id_foreign` (`user_id`),
  CONSTRAINT `interaction_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.interaction_logs: ~0 rows (approximately)

-- Dumping structure for table geobaocaock.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.jobs: ~0 rows (approximately)

-- Dumping structure for table geobaocaock.keywords
CREATE TABLE IF NOT EXISTS `keywords` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_id` bigint unsigned NOT NULL,
  `update_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `keywords_user_id_foreign` (`user_id`),
  KEY `keywords_create_id_foreign` (`create_id`),
  KEY `keywords_update_id_foreign` (`update_id`),
  CONSTRAINT `keywords_create_id_foreign` FOREIGN KEY (`create_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `keywords_update_id_foreign` FOREIGN KEY (`update_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `keywords_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.keywords: ~0 rows (approximately)

-- Dumping structure for table geobaocaock.maps
CREATE TABLE IF NOT EXISTS `maps` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coordinates` json NOT NULL,
  `imagefull` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `px` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nx` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `py` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ny` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pz` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nz` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.maps: ~10 rows (approximately)
INSERT INTO `maps` (`id`, `address`, `coordinates`, `imagefull`, `px`, `nx`, `py`, `ny`, `pz`, `nz`, `created_at`, `updated_at`) VALUES
	(19, 'Biển Mỹ Khê Đà Nẵng', '[16.0639056, 108.2466932]', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047070MyKheBeach360.jpg', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047076blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047078blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047079blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047080blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047084blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047087blob', '2024-05-18 15:44:49', '2024-05-18 15:44:49'),
	(21, 'Biển Mỹ An Đà Nẵng', '[16.0515477, 108.2455815]', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047217MyAnBeach.jpg', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047222blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047224blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047226blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047227blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047228blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047230blob', '2024-05-18 15:47:11', '2024-05-18 15:47:11'),
	(22, 'Đại học Bách Khoa Đà Nẵng', '[16.075017, 108.1532003]', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047298Street View 360.jpg', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047305blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047306blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047308blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047310blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047311blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047313blob', '2024-05-18 15:48:34', '2024-05-18 15:48:34'),
	(23, 'Khu C Đại học Bách Khoa Đà Nẵng', '[16.07413, 108.152709]', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047344ITF Area.jpg', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047350blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047351blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047352blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047352blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047353blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047354blob', '2024-05-18 15:49:15', '2024-05-18 15:49:15'),
	(24, 'Khu E Đại học Bách Khoa Đà Nẵng', '[16.075573, 108.15343]', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047388E Area.jpg', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047392blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047393blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047394blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047395blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047396blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047397blob', '2024-05-18 15:49:59', '2024-05-18 15:49:59'),
	(25, 'Cầu Hoa Giấy Đại học Bách Khoa Đà Nẵng', '[16.075405, 108.152413]', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047424Bridge.jpg', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047429blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047430blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047431blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047432blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047433blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047434blob', '2024-05-18 15:50:35', '2024-05-18 15:50:35'),
	(26, 'Đài phun nước Đại học Bách Khoa Đà Nẵng', '[16.07524, 108.152646]', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047459Fountain.jpg', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047463blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047464blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047465blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047466blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047467blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047468blob', '2024-05-18 15:51:09', '2024-05-18 15:51:09'),
	(27, 'Giao lộ đối diện khu E Đại học Bách Khoa Đà Nẵng', '[16.074954, 108.153419]', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047499Intersection2.jpg', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047504blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047506blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047509blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047510blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047512blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047513blob', '2024-05-18 15:51:54', '2024-05-18 15:51:54'),
	(28, 'Giao lộ Đại học Bách Khoa Đà Nẵng', '[16.075782, 108.152839]', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047545Intersection1.jpg', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047549blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047551blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047552blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047553blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047554blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047556blob', '2024-05-18 15:52:37', '2024-05-18 15:52:37'),
	(29, 'Khoa Công nghệ thông tin Đại học Bách Khoa Đà Nẵng', '[16.074691, 108.15295]', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047593ITF Area.jpg', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047598blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047599blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047601blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047603blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047604blob', 'https://linebotpro.s3.us-east-2.amazonaws.com/linebot/1716047606blob', '2024-05-18 15:53:27', '2024-05-18 15:53:27');

-- Dumping structure for table geobaocaock.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.migrations: ~15 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2024_02_04_062034_create_admins_table', 1),
	(6, '2024_02_04_103740_create_channels_table', 1),
	(7, '2024_02_04_103907_create_channel_statisticals_table', 1),
	(8, '2024_02_04_104001_create_interaction_logs_table', 1),
	(9, '2024_02_04_104024_create_contents_table', 1),
	(10, '2024_02_04_104049_create_broadcasts_table', 1),
	(11, '2024_02_04_104112_create_content_broadcasts_table', 1),
	(12, '2024_02_04_104140_create_keywords_table', 1),
	(13, '2024_02_04_104201_create_content_keywords_table', 1),
	(14, '2024_02_06_110318_create_jobs_table', 1),
	(15, '2024_05_15_204511_create_maps_table', 1);

-- Dumping structure for table geobaocaock.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.password_resets: ~0 rows (approximately)

-- Dumping structure for table geobaocaock.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.personal_access_tokens: ~0 rows (approximately)

-- Dumping structure for table geobaocaock.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `line_user_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel_id` bigint unsigned DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `is_block` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `token_verify_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_line_user_id_unique` (`line_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table geobaocaock.users: ~2 rows (approximately)
INSERT INTO `users` (`id`, `email`, `password`, `line_user_id`, `channel_id`, `role`, `is_delete`, `is_block`, `name`, `avatar`, `phone`, `address`, `gender`, `date_of_birth`, `token_verify_email`, `email_verified_at`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'nguyenvanmanh2001it1@gmail.com', '$2y$10$XaTrKroCAeR3e/vbp0aqEuNux8hFSYG0hatQ8EBdLRuU4nCE3sJp2', 'U9b60d708a68e2b81a7ff7f9c57540779', 1, 'manager', 0, 0, 'Nguyễn Văn Mạnh', 'https://res.cloudinary.com/dzve8benj/image/upload/v1716046873/avatars/bdfbvyvj0ksuz5nqvlml.jpg', '0971404372', 'Phú Đa - Phú Vang - TT Huế', 0, '2001-08-29', NULL, '2024-05-15 13:53:00', NULL, '2024-05-15 13:53:00', '2024-05-18 15:41:11'),
	(2, 'nguyenvanmanh.it1@yopmail.com', '$2y$10$5vnCH.cuuaKrQ4hym89q/eEsq9KkxlYP/KPhV5FPmyyJR38f3reVS', 'U667ca434abb5753fd28330c0441c7c78', 2, 'manager', 1, 0, 'Nhật Minh', NULL, '01236000333', '120 Nguyễn Lương Bằng - Liên Chiểu - Đà Nẵng', 0, '2001-09-29', NULL, '2024-05-15 13:53:00', NULL, '2024-05-15 13:53:00', '2024-05-15 13:53:00');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
