# Drop and Create database
DROP DATABASE IF EXISTS moviego;
CREATE DATABASE moviego;
USE moviego;


# Drop user table if exists
DROP TABLE IF EXISTS `user`;

# Create table user
CREATE TABLE `user` (
	`user_id` int(11) NOT NULL AUTO_INCREMENT,
	`username` varchar(255) DEFAULT NULL,
	`password` varchar(255) DEFAULT NULL,
	`admin_access` BOOLEAN DEFAULT 0,
	`create_date` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Drop user_detail if exists
DROP TABLE IF EXISTS `user_detail`;

# Create table user_detail-
CREATE TABLE `user_detail` (
	`user_detail_id` int(11) NOT NULL AUTO_INCREMENT,
	`first_name` varchar(255) DEFAULT NULL,
	`last_name` varchar(255) DEFAULT NULL,
	`street_address` varchar(255) DEFAULT NULL,
	`city` varchar(255) DEFAULT NULL,
	`zipcode` int(5) DEFAULT NULL,
	`genre_preference` int(32) DEFAULT 0,
	PRIMARY KEY (`user_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Drop genre if exists
DROP TABLE IF EXISTS `genre`;

# Create table genre
CREATE TABLE `genre` (
	`genre_id` int(11) NOT NULL AUTO_INCREMENT,
	`genre_name` varchar(255) DEFAULT NULL,
	`mask_number` int (32) DEFAULT 0,
	PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO user VALUES (DEFAULT, 'stefancao', '123456', DEFAULT, DEFAULT);
INSERT INTO user_detail VALUES (DEFAULT, 'Stefan', 'Cao', '9401 Westminster Avenue', 'Garden Grove', '92844', '12');

INSERT INTO user VALUES (DEFAULT, 'elisahuang', '123456', DEFAULT, DEFAULT);
INSERT INTO user_detail VALUES (DEFAULT, 'Elisa', 'Huang', '260 Aldrich Hall', 'Irvine', '92697', '12');

INSERT INTO genre VALUES (DEFAULT, 'action', 1);
INSERT INTO genre VALUES (DEFAULT, 'animation', 2);
INSERT INTO genre VALUES (DEFAULT, 'comedy', 4);
INSERT INTO genre VALUES (DEFAULT, 'documentary', 8);
INSERT INTO genre VALUES (DEFAULT, 'family', 16);
INSERT INTO genre VALUES (DEFAULT, 'film-noir', 32);
INSERT INTO genre VALUES (DEFAULT, 'horror', 64);
INSERT INTO genre VALUES (DEFAULT, 'musical', 128);
INSERT INTO genre VALUES (DEFAULT, 'romance', 256);
INSERT INTO genre VALUES (DEFAULT, 'sport', 512);
INSERT INTO genre VALUES (DEFAULT, 'war', 1024);
INSERT INTO genre VALUES (DEFAULT, 'adventure', 2048);
INSERT INTO genre VALUES (DEFAULT, 'biography', 4096);
INSERT INTO genre VALUES (DEFAULT, 'crime', 8192);
INSERT INTO genre VALUES (DEFAULT, 'drama', 16384);
INSERT INTO genre VALUES (DEFAULT, 'fantasy', 32768);
INSERT INTO genre VALUES (DEFAULT, 'history', 65536);
INSERT INTO genre VALUES (DEFAULT, 'music', 131072);
INSERT INTO genre VALUES (DEFAULT, 'mystery', 262144);
INSERT INTO genre VALUES (DEFAULT, 'sci-fi', 524288);
INSERT INTO genre VALUES (DEFAULT, 'thriller', 1048576);
INSERT INTO genre VALUES (DEFAULT, 'western', 2097152);

# Create user
CREATE USER 'moviego'@'localhost' IDENTIFIED BY 'eecs118';
GRANT ALL PRIVILEGES ON moviego.* To 'moviego'@'localhost' IDENTIFIED BY 'eecs118';
