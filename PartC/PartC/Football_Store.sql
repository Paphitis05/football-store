-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2025 at 09:27 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `Customer_ID` varchar(10) NOT NULL,
  `Customer_Name` varchar(25) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `Customer_address` varchar(50) DEFAULT NULL,
  `Customer_Phone` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`Customer_ID`, `Customer_Name`, `email`, `Customer_address`, `Customer_Phone`) VALUES
('36-3141613', 'Kizzie', 'kheditch8@multiply.com', '0677 Sugar Point', '3569353028'),
('42-1830421', 'Rowan', 'rshakle6@earthlink.net', '2157 Maywood Crossing', '2239241615'),
('57-4478428', 'John', 'jmachel3@unblog.fr', '5636 Shelley Trail', '7234639915'),
('58-4175829', 'Allix', 'ajurgen4@imgur.com', '7 Hintze Way', '2058252696'),
('64-2119505', 'Stavros', 'socahsedy9@columbia.edu', '94 Brown Circle', '2712323635'),
('64-3014843', 'Orelle', 'oletixier7@squidoo.com', '8 Sullivan Circle', '2312029509'),
('67-8457851', 'Thain', 'tmitten1@yellowbook.com', '54475 Killdeer Hill', '4077833164'),
('72-7574226', 'Donia', 'dmawhinney0@usa.gov', '54104 Caliangt Place', '3426719028'),
('75-7272734', 'Rodolphe', 'rdranfield2@nytimes.com', '27881 Starford Parkway', '9411976343'),
('92-7764655', 'Ahmad', 'aguare5@wsj.com', '602 Liverpool Lane', '1928834053');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `item_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `availability` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `color` varchar(50) NOT NULL,
  `size` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `name`, `description`, `price`, `availability`, `category`, `color`, `size`) VALUES
(1, 'Home Jersey', 'Official home jersey for the season.', 90.00, 100, 'Apparel', 'Blue', 'L'),
(2, 'Away Jersey', 'Official away jersey for the season.', 90.00, 80, 'Apparel', 'White', 'L'),
(3, 'Football Shorts', 'Matching shorts for the team jerseys.', 40.00, 120, 'Apparel', 'Blue', 'L'),
(4, 'Goalkeeper Gloves', 'Professional grade goalkeeper gloves.', 50.00, 40, 'Equipment', 'Black', '10'),
(5, 'Football Boots', 'Lightweight boots for maximum performance.', 120.00, 60, 'Footwear', 'Red', '43'),
(6, 'Shin Guards', 'Protective gear for legs.', 12.50, 200, 'Equipment', 'White', 'M'),
(7, 'Training Cones', 'Cones for training drills.', 7.99, 300, 'Equipment', 'Orange', 'One Size');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Order_ID` int(11) NOT NULL,
  `order_code` varchar(50) NOT NULL,
  `Customer_ID` varchar(10) NOT NULL,
  `sales_person_id` int(11) DEFAULT NULL,
  `items_qty` int(11) NOT NULL,
  `Date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`Order_ID`, `order_code`, `Customer_ID`, `sales_person_id`, `items_qty`, `Date`) VALUES
(1, 'ORD001', '36-3141613', 1, 2, '2025-12-16 20:47:14'),
(2, 'ORD002', '36-3141613', 2, 2, '2025-12-16 20:47:14'),
(3, 'ORD003', '64-2119505', 3, 2, '2025-12-16 20:47:14'),
(4, 'ORD004', '72-7574226', 1, 1, '2025-12-16 20:47:14'),
(5, 'ORD005', '67-8457851', 2, 2, '2025-12-16 20:47:14');

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `order_item_id` int(11) NOT NULL,
  `Order_ID` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`order_item_id`, `Order_ID`, `item_id`, `quantity`) VALUES
(10, 1, 1, 1),
(11, 1, 3, 1),
(12, 2, 2, 1),
(13, 2, 5, 1),
(14, 3, 4, 1),
(15, 3, 1, 1),
(16, 4, 1, 1),
(17, 5, 3, 1),
(18, 5, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `player_id` int(11) NOT NULL,
  `player_name` varchar(100) NOT NULL,
  `team_customer_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player`
--

INSERT INTO `player` (`player_id`, `player_name`, `team_customer_id`) VALUES
(1, 'Bartłomiej Drągowski', '36-3141613'),
(2, 'Giorgos Vagiannidis', '36-3141613'),
(3, 'Tin Jedvaj', '36-3141613'),
(4, 'Hörður Magnússon', '36-3141613'),
(5, 'Rubén Pérez', '36-3141613'),
(6, 'Adam Gnezda Čerin', '36-3141613'),
(7, 'Anastasios Bakasetas', '36-3141613'),
(8, 'Daniel Mancini', '36-3141613'),
(9, 'Fotis Ioannidis', '36-3141613'),
(10, 'Andraž Šporar', '36-3141613'),
(11, 'Bernard Duarte', '36-3141613'),
(12, 'Alexandros Paschalakis', '64-2119505'),
(13, 'Rodinei', '64-2119505'),
(14, 'Panagiotis Retsos', '64-2119505'),
(15, 'Francisco Ortega', '64-2119505'),
(16, 'Santiago Hezze', '64-2119505'),
(17, 'Daniel Podence', '64-2119505'),
(18, 'Chiquinho', '64-2119505'),
(19, 'Yusuf Yazıcı', '64-2119505'),
(20, 'Ayoub El Kaabi', '64-2119505'),
(21, 'Roman Yaremchuk', '64-2119505'),
(22, 'Mehdi Taremi', '64-2119505');

-- --------------------------------------------------------

--
-- Table structure for table `retail_customer`
--

CREATE TABLE `retail_customer` (
  `Customer_ID` varchar(10) NOT NULL,
  `Purchase_Quantity` int(11) DEFAULT NULL,
  `Payment_Amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `retail_customer`
--

INSERT INTO `retail_customer` (`Customer_ID`, `Purchase_Quantity`, `Payment_Amount`) VALUES
('42-1830421', 4, 150.00),
('57-4478428', 1, 25.00),
('58-4175829', 3, 80.25),
('64-3014843', 1, 15.50),
('67-8457851', 2, 50.00),
('72-7574226', 5, 120.50),
('75-7272734', 10, 350.75),
('92-7764655', 7, 210.00);

-- --------------------------------------------------------

--
-- Table structure for table `sales_person`
--

CREATE TABLE `sales_person` (
  `ID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Commission_Percent` decimal(4,3) DEFAULT NULL,
  `Total_Commission` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales_person`
--

INSERT INTO `sales_person` (`ID`, `Name`, `Address`, `Phone`, `Email`, `Commission_Percent`, `Total_Commission`) VALUES
(1, 'Giorgos Papadopoulos', 'Athens 123', '6971234567', 'giorgos@istore.gr', 0.100, 500.00),
(2, 'Maria Dimitriou', 'Thessaloniki 45', '6977654321', 'maria@feistore.gr', 0.120, 1200.00),
(3, 'John Smith', 'London UK', '+44201234', 'john@store.gr', 0.150, 800.00);

-- --------------------------------------------------------

--
-- Table structure for table `team_customer`
--

CREATE TABLE `team_customer` (
  `Customer_ID` varchar(10) NOT NULL,
  `Team_Name` varchar(50) DEFAULT NULL,
  `Discount` decimal(4,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `team_customer`
--

INSERT INTO `team_customer` (`Customer_ID`, `Team_Name`, `Discount`) VALUES
('36-3141613', 'Panathinaikos', 0.10),
('64-2119505', 'Olympiakos', 0.15);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`Customer_ID`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Order_ID`),
  ADD UNIQUE KEY `order_code` (`order_code`),
  ADD KEY `Customer_ID` (`Customer_ID`),
  ADD KEY `sales_person_id` (`sales_person_id`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `Order_ID` (`Order_ID`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `team_customer_id` (`team_customer_id`);

--
-- Indexes for table `retail_customer`
--
ALTER TABLE `retail_customer`
  ADD PRIMARY KEY (`Customer_ID`);

--
-- Indexes for table `sales_person`
--
ALTER TABLE `sales_person`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `team_customer`
--
ALTER TABLE `team_customer`
  ADD PRIMARY KEY (`Customer_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Order_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `player`
--
ALTER TABLE `player`
  MODIFY `player_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`sales_person_id`) REFERENCES `sales_person` (`ID`);

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`Order_ID`) REFERENCES `orders` (`Order_ID`),
  ADD CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`);

--
-- Constraints for table `player`
--
ALTER TABLE `player`
  ADD CONSTRAINT `player_ibfk_1` FOREIGN KEY (`team_customer_id`) REFERENCES `team_customer` (`Customer_ID`);

--
-- Constraints for table `retail_customer`
--
ALTER TABLE `retail_customer`
  ADD CONSTRAINT `retail_customer_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`);

--
-- Constraints for table `team_customer`
--
ALTER TABLE `team_customer`
  ADD CONSTRAINT `team_customer_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
