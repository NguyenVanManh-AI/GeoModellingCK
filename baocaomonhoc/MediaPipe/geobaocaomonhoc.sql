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

-- Dumping structure for table geomodellingck.actions
CREATE TABLE IF NOT EXISTS `actions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text COLLATE armscii8_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table geomodellingck.actions: ~25 rows (approximately)
INSERT INTO `actions` (`id`, `name`) VALUES
	(166, 'zoomIn'),
	(167, 'moveFar'),
	(168, 'moveFar'),
	(169, 'moveFar'),
	(170, 'moveFar'),
	(171, 'moveLeft'),
	(172, 'rotateZC'),
	(173, 'rotateZC'),
	(174, 'zoomOut'),
	(175, 'moveFar'),
	(176, 'rotateZC'),
	(177, 'rotateZC'),
	(178, 'moveFar'),
	(179, 'rotateZC'),
	(180, 'moveFar'),
	(181, 'rotateZC'),
	(182, 'moveFar'),
	(183, 'moveFar'),
	(184, 'moveFar'),
	(185, 'moveFar'),
	(186, 'moveFar'),
	(187, 'moveFar'),
	(188, 'rotateZC'),
	(189, 'rotateZC'),
	(190, 'moveFar'),
	(191, 'moveFar'),
	(192, 'rotateYC');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
