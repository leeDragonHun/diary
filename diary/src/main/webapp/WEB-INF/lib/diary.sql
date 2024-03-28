-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.4.33-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- diary 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `diary` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `diary`;

-- 테이블 diary.diary 구조 내보내기
CREATE TABLE IF NOT EXISTS `diary` (
  `diary_date` date NOT NULL,
  `title` text NOT NULL,
  `weather` enum('희','노','애','락') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text NOT NULL,
  `update_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`diary_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 diary.diary:~17 rows (대략적) 내보내기
INSERT IGNORE INTO `diary` (`diary_date`, `title`, `weather`, `content`, `update_date`, `create_date`) VALUES
	('2024-03-01', '삼일절', '락', '대한독립!! 만세!!!!', '2024-03-26 23:33:45', '2024-03-26 23:33:45'),
	('2024-03-10', '첫일기', '락', '첫일기다다다', '2024-03-26 22:05:40', '2024-03-26 22:05:40'),
	('2024-03-11', '11일 찐막', '노', '찐찐찐찐찐막', '2024-03-26 18:41:58', '2024-03-26 18:41:58'),
	('2024-03-12', '빨리하고', '락', '집에 가서 스파이더맨 봐야지!!', '2024-03-26 18:31:40', '2024-03-26 18:31:40'),
	('2024-03-13', '13일의 목요일', '희', '오늘은 13일의 목요일이다. 엇 아니네 수요일이네?', '2024-03-26 18:31:03', '2024-03-26 18:31:03'),
	('2024-03-14', '일기다', '애', '일기입니다', '2024-03-26 18:25:52', '2024-03-26 18:25:52'),
	('2024-03-15', '가가', '희', '레이디가가', '2024-03-26 16:56:59', '2024-03-26 16:56:59'),
	('2024-03-16', '주차장', '희', '주차장에 어떤 차가 내 차를 가로막았다.', '2024-03-26 15:13:45', '2024-03-26 15:13:45'),
	('2024-03-17', '쉬는게맞나', '애', '쉬는날이 쉬는날이 아니다. 수업때 배운 거 복습 열심히 하자. 내것으로 만들자.', '2024-03-26 15:13:21', '2024-03-26 15:13:21'),
	('2024-03-18', '블로그', '애', '블로그를 어떤 것으로 쓸까 고민이 된다.', '2024-03-26 15:12:45', '2024-03-26 15:12:45'),
	('2024-03-19', '어려워', '노', '오늘 배운 게 너무 어렵다.', '2024-03-26 15:11:24', '2024-03-26 15:11:24'),
	('2024-03-20', '피곤하다', '애', '피곤해죽겠다.', '2024-03-26 15:12:00', '2024-03-26 15:12:00'),
	('2024-03-22', '열심히 하자', '애', '코딩을 진짜 잘 하고 싶다.', '2024-03-26 15:10:59', '2024-03-26 15:10:59'),
	('2024-03-23', '진지한 일기', '희', '진지하게 임하자', '2024-03-26 15:09:21', '2024-03-26 15:09:21'),
	('2024-03-24', '토욜이다', '락', '영화를 봤다', '2024-03-26 15:07:10', '2024-03-26 15:07:10'),
	('2024-03-25', '비오는날에', '노', '비가주룩주룩온다', '2024-03-26 10:55:57', '2024-03-26 10:55:57'),
	('2024-03-26', '제발되라', '희', '제발요제발제발!', '2024-03-26 11:03:38', '2024-03-26 11:03:38');

-- 테이블 diary.login 구조 내보내기
CREATE TABLE IF NOT EXISTS `login` (
  `my_session` enum('ON','OFF') NOT NULL,
  `on_date` datetime DEFAULT NULL,
  `off_date` datetime DEFAULT NULL,
  PRIMARY KEY (`my_session`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 diary.login:~1 rows (대략적) 내보내기
INSERT IGNORE INTO `login` (`my_session`, `on_date`, `off_date`) VALUES
	('ON', '2024-03-27 00:00:55', '2024-03-27 00:00:46');

-- 테이블 diary.lunch 구조 내보내기
CREATE TABLE IF NOT EXISTS `lunch` (
  `lunch_date` date NOT NULL,
  `menu` varchar(50) NOT NULL,
  `update_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`lunch_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 diary.lunch:~0 rows (대략적) 내보내기

-- 테이블 diary.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `member_id` varchar(50) NOT NULL,
  `member_pw` varchar(50) NOT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 diary.member:~1 rows (대략적) 내보내기
INSERT IGNORE INTO `member` (`member_id`, `member_pw`) VALUES
	('admin', '1234');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
