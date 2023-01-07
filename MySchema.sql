-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.25-MariaDB - mariadb.org binary distribution
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


-- Dumping database structure for bluff
DROP DATABASE IF EXISTS `bluff`;
CREATE DATABASE IF NOT EXISTS `bluff` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `bluff`;

-- Dumping structure for procedure bluff.bluff_check
DROP PROCEDURE IF EXISTS `bluff_check`;
DELIMITER //
CREATE PROCEDURE `bluff_check`()
BEGIN
DECLARE tot INT;
SELECT total INTO tot FROM calls;
INSERT INTO last_played
SELECT  card_text,card_symbol FROM board ORDER BY ID DESC LIMIT tot ;
SELECT COUNT(*) FROM last_played WHERE last_text = (SELECT TEXT FROM calls);
DELETE FROM last_played;
END//
DELIMITER ;

-- Dumping structure for table bluff.board
DROP TABLE IF EXISTS `board`;
CREATE TABLE IF NOT EXISTS `board` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `card_text` varchar(50) DEFAULT NULL,
  `card_symbol` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_BOARD_CARDS` (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=753 DEFAULT CHARSET=latin1;

-- Dumping data for table bluff.board: ~0 rows (approximately)
DELETE FROM `board`;

-- Dumping structure for table bluff.calls
DROP TABLE IF EXISTS `calls`;
CREATE TABLE IF NOT EXISTS `calls` (
  `total` int(11) DEFAULT NULL,
  `text` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bluff.calls: ~1 rows (approximately)
DELETE FROM `calls`;
INSERT INTO `calls` (`total`, `text`) VALUES
	(0, NULL);

-- Dumping structure for procedure bluff.call_cards
DROP PROCEDURE IF EXISTS `call_cards`;
DELIMITER //
CREATE PROCEDURE `call_cards`(
	IN `totals` INT,
	IN `texts` VARCHAR(50),
	IN `turn` VARCHAR(50)
)
BEGIN
DELETE FROM calls;
INSERT INTO calls(total,TEXT) VALUES (totals,texts);

UPDATE game_status
	SET player_turn = turn;
END//
DELIMITER ;

-- Dumping structure for table bluff.cards
DROP TABLE IF EXISTS `cards`;
CREATE TABLE IF NOT EXISTS `cards` (
  `ID` int(11) NOT NULL,
  `card_text` varchar(50) DEFAULT NULL,
  `card_symbol` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bluff.cards: ~54 rows (approximately)
DELETE FROM `cards`;
INSERT INTO `cards` (`ID`, `card_text`, `card_symbol`) VALUES
	(1, 'A', 'hearts'),
	(2, '2', 'hearts'),
	(3, '3', 'hearts'),
	(4, '4', 'hearts'),
	(5, '5', 'hearts'),
	(6, '6', 'hearts'),
	(7, '7', 'hearts'),
	(8, '8', 'hearts'),
	(9, '9', 'hearts'),
	(10, '10', 'hearts'),
	(11, 'J', 'hearts'),
	(12, 'Q', 'hearts'),
	(13, 'K', 'hearts'),
	(14, 'A', 'spades'),
	(15, '2', 'spades'),
	(16, '3', 'spades'),
	(17, '4', 'spades'),
	(18, '5', 'spades'),
	(19, '6', 'spades'),
	(20, '7', 'spades'),
	(21, '8', 'spades'),
	(22, '9', 'spades'),
	(23, '10', 'spades'),
	(24, 'J', 'spades'),
	(25, 'Q', 'spades'),
	(26, 'K', 'spades'),
	(27, 'A', 'diamonds'),
	(28, '2', 'diamonds'),
	(29, '3', 'diamonds'),
	(30, '4', 'diamonds'),
	(31, '5', 'diamonds'),
	(32, '6', 'diamonds'),
	(33, '7', 'diamonds'),
	(34, '8', 'diamonds'),
	(35, '9', 'diamonds'),
	(36, '10', 'diamonds'),
	(37, 'J', 'diamonds'),
	(38, 'Q', 'diamonds'),
	(39, 'K', 'diamonds'),
	(40, 'A', 'clubs'),
	(41, '2', 'clubs'),
	(42, '3', 'clubs'),
	(43, '4', 'clubs'),
	(44, '5', 'clubs'),
	(45, '6', 'clubs'),
	(46, '7', 'clubs'),
	(47, '8', 'clubs'),
	(48, '9', 'clubs'),
	(49, '10', 'clubs'),
	(50, 'J', 'clubs'),
	(51, 'Q', 'clubs'),
	(52, 'K', 'clubs'),
	(53, 'joker', 'red'),
	(54, 'joker', 'black');

-- Dumping structure for procedure bluff.change_the_turn
DROP PROCEDURE IF EXISTS `change_the_turn`;
DELIMITER //
CREATE PROCEDURE `change_the_turn`(
	IN `turn` VARCHAR(50)
)
BEGIN

	UPDATE game_status
	SET player_turn = turn;

END//
DELIMITER ;

-- Dumping structure for procedure bluff.change_turn
DROP PROCEDURE IF EXISTS `change_turn`;
DELIMITER //
CREATE PROCEDURE `change_turn`(
	IN `playerturn` VARCHAR(50)
)
BEGIN

END//
DELIMITER ;

-- Dumping structure for procedure bluff.dealcards
DROP PROCEDURE IF EXISTS `dealcards`;
DELIMITER //
CREATE PROCEDURE `dealcards`()
BEGIN

INSERT INTO PLAYER1_CARDS

SELECT * FROM CARDS ORDER BY RAND()

LIMIT 27;

INSERT INTO PLAYER2_CARDS

SELECT * FROM CARDS C WHERE  C.ID  NOT IN (SELECT C1.ID FROM PLAYER1_CARDS C1);



	END//
DELIMITER ;

-- Dumping structure for table bluff.game_status
DROP TABLE IF EXISTS `game_status`;
CREATE TABLE IF NOT EXISTS `game_status` (
  `status` varchar(50) DEFAULT NULL,
  `player_turn` varchar(50) DEFAULT NULL,
  `winner` varchar(50) DEFAULT NULL,
  `last_change` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bluff.game_status: ~0 rows (approximately)
DELETE FROM `game_status`;
INSERT INTO `game_status` (`status`, `player_turn`, `winner`, `last_change`) VALUES
	('Hold', NULL, NULL, NULL);

-- Dumping structure for table bluff.last_played
DROP TABLE IF EXISTS `last_played`;
CREATE TABLE IF NOT EXISTS `last_played` (
  `last_symbol` varchar(50) DEFAULT NULL,
  `last_text` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table bluff.last_played: ~0 rows (approximately)
DELETE FROM `last_played`;

-- Dumping structure for procedure bluff.newgame
DROP PROCEDURE IF EXISTS `newgame`;
DELIMITER //
CREATE PROCEDURE `newgame`()
BEGIN

DELETE  FROM PLAYER1_CARDS;

DELETE  FROM PLAYER2_CARDS;

DELETE FROM board;

UPDATE game_status
SET 	
	winner = NULL;
	
UPDATE game_status
SET 	
	player_turn = NULL;
	
UPDATE users
SET 	
	username = NULL;

	END//
DELIMITER ;

-- Dumping structure for procedure bluff.pass
DROP PROCEDURE IF EXISTS `pass`;
DELIMITER //
CREATE PROCEDURE `pass`()
BEGIN



DELETE FROM BOARD;



	END//
DELIMITER ;

-- Dumping structure for table bluff.player1_cards
DROP TABLE IF EXISTS `player1_cards`;
CREATE TABLE IF NOT EXISTS `player1_cards` (
  `ID` int(11) DEFAULT NULL,
  `card_text` varchar(50) DEFAULT NULL,
  `card_symbol` varchar(50) DEFAULT NULL,
  KEY `ID` (`ID`) USING BTREE,
  CONSTRAINT `ID` FOREIGN KEY (`ID`) REFERENCES `cards` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bluff.player1_cards: ~27 rows (approximately)
DELETE FROM `player1_cards`;
INSERT INTO `player1_cards` (`ID`, `card_text`, `card_symbol`) VALUES
	(2, '2', 'hearts'),
	(23, '10', 'spades'),
	(39, 'K', 'diamonds'),
	(38, 'Q', 'diamonds'),
	(52, 'K', 'clubs'),
	(40, 'A', 'clubs'),
	(10, '10', 'hearts'),
	(47, '8', 'clubs'),
	(37, 'J', 'diamonds'),
	(26, 'K', 'spades'),
	(42, '3', 'clubs'),
	(14, 'A', 'spades'),
	(51, 'Q', 'clubs'),
	(9, '9', 'hearts'),
	(45, '6', 'clubs'),
	(41, '2', 'clubs'),
	(21, '8', 'spades'),
	(24, 'J', 'spades'),
	(54, 'joker', 'black'),
	(1, 'A', 'hearts'),
	(46, '7', 'clubs'),
	(48, '9', 'clubs'),
	(12, 'Q', 'hearts'),
	(5, '5', 'hearts'),
	(32, '6', 'diamonds'),
	(7, '7', 'hearts'),
	(31, '5', 'diamonds');

-- Dumping structure for procedure bluff.player1_plays
DROP PROCEDURE IF EXISTS `player1_plays`;
DELIMITER //
CREATE PROCEDURE `player1_plays`(
	IN `text` VARCHAR(50),
	IN `symbol` VARCHAR(50)
)
BEGIN
INSERT INTO board 
SELECT 0,card_symbol,card_text FROM player1_cards WHERE card_symbol=symbol AND card_text=text;

SELECT 0,card_symbol,card_text FROM player1_cards WHERE card_symbol=symbol AND card_text=text;

DELETE FROM player1_cards WHERE card_symbol=symbol AND card_text=text;
	
-- UPDATE game_status
-- SET 	
--	player_turn = "B";

SELECT * FROM player1_cards;
END//
DELIMITER ;

-- Dumping structure for table bluff.player2_cards
DROP TABLE IF EXISTS `player2_cards`;
CREATE TABLE IF NOT EXISTS `player2_cards` (
  `ID` int(11) DEFAULT NULL,
  `card_text` varchar(50) DEFAULT NULL,
  `card_symbol` varchar(50) DEFAULT NULL,
  KEY `FK_PLAYER2_CARDS_CARDS` (`ID`) USING BTREE,
  CONSTRAINT `FK_PLAYER2_CARDS_CARDS` FOREIGN KEY (`ID`) REFERENCES `cards` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bluff.player2_cards: ~27 rows (approximately)
DELETE FROM `player2_cards`;
INSERT INTO `player2_cards` (`ID`, `card_text`, `card_symbol`) VALUES
	(3, '3', 'hearts'),
	(4, '4', 'hearts'),
	(6, '6', 'hearts'),
	(8, '8', 'hearts'),
	(11, 'J', 'hearts'),
	(13, 'K', 'hearts'),
	(15, '2', 'spades'),
	(16, '3', 'spades'),
	(17, '4', 'spades'),
	(18, '5', 'spades'),
	(19, '6', 'spades'),
	(20, '7', 'spades'),
	(22, '9', 'spades'),
	(25, 'Q', 'spades'),
	(27, 'A', 'diamonds'),
	(28, '2', 'diamonds'),
	(29, '3', 'diamonds'),
	(30, '4', 'diamonds'),
	(33, '7', 'diamonds'),
	(34, '8', 'diamonds'),
	(35, '9', 'diamonds'),
	(36, '10', 'diamonds'),
	(43, '4', 'clubs'),
	(44, '5', 'clubs'),
	(49, '10', 'clubs'),
	(50, 'J', 'clubs'),
	(53, 'joker', 'red');

-- Dumping structure for procedure bluff.player2_plays
DROP PROCEDURE IF EXISTS `player2_plays`;
DELIMITER //
CREATE PROCEDURE `player2_plays`(
	IN `text` VARCHAR(50),
	IN `symbol` VARCHAR(50)
)
BEGIN
INSERT INTO board 
SELECT 0,card_symbol,card_text FROM player2_cards WHERE card_symbol=symbol AND card_text=text;

SELECT 0,card_symbol,card_text FROM player2_cards WHERE card_symbol=symbol AND card_text=text;

DELETE FROM player2_cards WHERE card_symbol=symbol AND card_text=text;

-- UPDATE game_status
-- SET 	
--	player_turn = "A";

SELECT * FROM player2_cards;
END//
DELIMITER ;

-- Dumping structure for procedure bluff.play_card
DROP PROCEDURE IF EXISTS `play_card`;
DELIMITER //
CREATE PROCEDURE `play_card`()
BEGIN

END//
DELIMITER ;

-- Dumping structure for procedure bluff.roundwin_P1
DROP PROCEDURE IF EXISTS `roundwin_P1`;
DELIMITER //
CREATE PROCEDURE `roundwin_P1`()
BEGIN

INSERT INTO PLAYER2_CARDS

SELECT * FROM BOARD; 

DELETE FROM BOARD;

	END//
DELIMITER ;

-- Dumping structure for procedure bluff.roundwin_P2
DROP PROCEDURE IF EXISTS `roundwin_P2`;
DELIMITER //
CREATE PROCEDURE `roundwin_P2`()
BEGIN



INSERT INTO PLAYER1_CARDS

SELECT * FROM BOARD; 

DELETE FROM BOARD;



	END//
DELIMITER ;

-- Dumping structure for table bluff.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(50) DEFAULT NULL,
  `playerno` varchar(50) DEFAULT NULL,
  `token` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bluff.users: ~2 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`username`, `playerno`, `token`) VALUES
	(NULL, 'A', '9521228aa06b602c4a0d12dc4f158ef4'),
	(NULL, 'B', 'b8d8469376fec30516c745cc082022f2');

-- Dumping structure for procedure bluff.win_check
DROP PROCEDURE IF EXISTS `win_check`;
DELIMITER //
CREATE PROCEDURE `win_check`(
	IN `player` CHAR(50)
)
BEGIN

	UPDATE game_status
	SET winner = player;
	
END//
DELIMITER ;

-- Dumping structure for trigger bluff.users_after_insert
DROP TRIGGER IF EXISTS `users_after_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `users_after_insert` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
DECLARE rowcount INT;
DECLARE player1_cownt INT;
DECLARE player2_cownt INT;

DECLARE PlayersCount INT;

SELECT COUNT(*) INTO rowcount FROM users;


SELECT COUNT(*) INTO PlayersCount FROM users WHERE username IS NOT NULL;
IF PlayersCount < 2 THEN
	UPDATE game_status SET STATUS='Hold';
ELSE
	UPDATE game_status SET STATUS='Started';
END IF;

IF PlayersCount = 2 THEN
	UPDATE game_status
	SET player_turn = "A";
END IF;

IF rowcount  =0 
then 
CALL newgame;
    end if ;
IF rowcount  =1
then 
CALL dealcards; 
    end if ;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger bluff.users_before_insert
DROP TRIGGER IF EXISTS `users_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `users_before_insert` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
DECLARE rowcount INT;
DECLARE player1_cownt INT;
DECLARE player2_cownt INT;
SELECT COUNT(*) INTO rowcount FROM users;
SELECT COUNT(*) INTO player1_cownt FROM users WHERE playerno='player1';
SELECT COUNT(*) INTO player2_cownt FROM users WHERE playerno='player2';
IF rowcount  =2 
then 
SIGNAL sqlstate '45001' set message_text = "Table is currently full!";

    end if ;
    
IF player1_cownt  =1 AND NEW.playerno='player1'
then 
SIGNAL sqlstate '45001' set message_text = "PLayer1 is already taken!Please select Player2";

    end if ;
IF player2_cownt  =1 AND NEW.playerno='player2'
then 
SIGNAL sqlstate '45001' set message_text = "PLayer2 is already taken!Please select Player1";

    end if ;    
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;