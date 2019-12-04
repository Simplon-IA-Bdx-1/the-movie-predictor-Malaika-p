-- Adminer 4.7.3 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;



DROP TABLE IF EXISTS `compagnies`;
CREATE TABLE `compagnies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `original_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `rating` enum('TP','-12','-16','-18') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `production_budget` int(11) DEFAULT NULL,
  `marketing_budget` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `3d` tinyint(1) DEFAULT '0',
  `synopsis` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `movies` (`id`, `original_title`, `title`, `rating`, `production_budget`, `marketing_budget`, `duration`, `release_date`, `3d`, `synopsis`) VALUES
(1,	'Demolition Man',	NULL,	'-16',	NULL,	NULL,	NULL,	'1993-10-08',	0,	'A police officer is brought out of suspended animation in prison to pursue an old ultra-violent nemesis who is loose in a non-violent future society.'),
(2,	'The Running Man',	'Running Man',	NULL,	NULL,	NULL,	101,	'1987-11-13',	0,	'Los Angeles, 2019 : les USA sont sous la coupe d\'une dictature qui a réduit les libertés publiques à néant et qui, grâce à des programmes télévisés bassement démagogiques, parvient à conditionner le comportement populaire. Le jeu-vedette, suivi avec passion par le pays entier, s\'appelle « The Running Man ».');

DROP TABLE IF EXISTS `movies_compagnies_roles`;
CREATE TABLE `movies_compagnies_roles` (
  `role_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  KEY `movies_compagnies_roles_fk0` (`role_id`),
  KEY `movies_compagnies_roles_fk1` (`movie_id`),
  KEY `movies_compagnies_roles_fk2` (`company_id`),
  CONSTRAINT `movies_compagnies_roles_fk0` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `movies_compagnies_roles_fk1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`),
  CONSTRAINT `movies_compagnies_roles_fk2` FOREIGN KEY (`company_id`) REFERENCES `compagnies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `movies_origin_countries`;
CREATE TABLE `movies_origin_countries` (
  `movie_id` int(11) NOT NULL,
  `country_iso2` char(2) NOT NULL,
  KEY `movies_origin_countries_fk0` (`movie_id`),
  CONSTRAINT `movies_origin_countries_fk0` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `movies_people_roles`;
CREATE TABLE `movies_people_roles` (
  `movie_id` int(11) NOT NULL,
  `people_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  KEY `movies_people_roles_fk0` (`movie_id`),
  KEY `movies_people_roles_fk1` (`people_id`),
  KEY `movies_people_roles_fk2` (`role_id`),
  CONSTRAINT `movies_people_roles_fk0` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`),
  CONSTRAINT `movies_people_roles_fk1` FOREIGN KEY (`people_id`) REFERENCES `people` (`id`),
  CONSTRAINT `movies_people_roles_fk2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 2019-11-12 08:55:52
