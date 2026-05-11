-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: student_housing_db
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `asset`
--

LOCK TABLES `asset` WRITE;
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
INSERT INTO `asset` VALUES ('A001','Furniture','Chair','Good',1),('A002','Appliance','Refrigerator','Fair',2),('A003','Furniture','Table','Good',3),('A004','Appliance','Microwave','Excellent',4),('A005','Electronics','Fan','Fair',5),('A006','Electronics','Air Conditioner','Fair',5),('A007','Furniture','Door','Good',2),('A008','Security','Door Key','Good',3);
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,'User','DELETE','2026-05-11 16:15:38');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cleaning_request`
--

LOCK TABLES `cleaning_request` WRITE;
/*!40000 ALTER TABLE `cleaning_request` DISABLE KEYS */;
INSERT INTO `cleaning_request` VALUES (2,'Room study chair','2024-01-11'),(5,'Kitchen refrigerator','2024-04-05'),(8,'Kitchen refrigerator','2024-05-01'),(11,'Kitchen microwave','2024-05-25'),(14,'Living Room Fan','2024-06-15');
/*!40000 ALTER TABLE `cleaning_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('C001','Software Engineering','S005','Engineering'),('C002','Business Administration','S006','Business'),('C003','Mechanical Engineering','S005','Engineering'),('C004','Civil Engineering','S005','Engineering'),('C005','Digital Multimedia','S005','Engineering');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `hall`
--

LOCK TABLES `hall` WRITE;
/*!40000 ALTER TABLE `hall` DISABLE KEYS */;
INSERT INTO `hall` VALUES ('H001','Suria Hall','123 Jalan Utama','01234567890',500.00,'S001'),('H002','Senja Hall','456 Jalan Melati','09876543210',600.00,'S007'),('H003','Bulan Hall','789 Jalan Mawar','01122334455',550.00,'S003'),('H004','Bintang Hall','101 Jalan Kenanga','06677889900',700.00,'S009'),('H005','Galaksi Hall','202 Jalan Teratai','02233445566',650.00,'S008');
/*!40000 ALTER TABLE `hall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,500.00,'2024-06-01','2024-05-22',1,0.00,500.00,1,'ST001'),(2,500.00,'2024-06-01','2024-05-22',1,0.00,500.00,2,'ST002'),(3,600.00,'2024-07-01','2024-06-24',1,0.00,600.00,3,'ST003'),(4,600.00,'2024-07-01','2024-06-30',1,0.00,600.00,4,'ST004'),(5,550.00,'2024-08-01','2024-07-27',1,0.00,550.00,5,'ST005'),(6,500.00,'2024-08-01',NULL,0,0.00,500.00,2,'ST002');
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lease`
--

LOCK TABLES `lease` WRITE;
/*!40000 ALTER TABLE `lease` DISABLE KEYS */;
INSERT INTO `lease` VALUES (1,'2022-01-01','2025-12-31'),(2,'2023-02-01','2027-11-30'),(3,'2022-03-01','2026-02-28'),(4,'2024-02-01','2027-10-31'),(5,'2023-05-01','2026-09-30');
/*!40000 ALTER TABLE `lease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lease_archive`
--

LOCK TABLES `lease_archive` WRITE;
/*!40000 ALTER TABLE `lease_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `lease_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `maintenance_request`
--

LOCK TABLES `maintenance_request` WRITE;
/*!40000 ALTER TABLE `maintenance_request` DISABLE KEYS */;
INSERT INTO `maintenance_request` VALUES (1,'2024-01-10','RepairRequest','Completed','ST001','A001'),(2,'2024-01-10','CleaningRequest','Completed','ST001','A001'),(3,'2024-03-20','OtherRequest','Completed','ST003','A003'),(4,'2024-03-30','RepairRequest','Completed','ST001','A001'),(5,'2024-04-19','CleaningRequest','Completed','ST002','A002'),(6,'2024-04-20','OtherRequest','Completed','ST003','A008'),(7,'2024-04-25','RepairRequest','Completed','ST002','A007'),(8,'2024-05-01','CleaningRequest','Completed','ST002','A002'),(9,'2024-05-05','OtherRequest','Completed','ST003','A003'),(10,'2024-05-20','RepairRequest','Completed','ST003','A003'),(11,'2024-05-25','CleaningRequest','Completed','ST004','A004'),(12,'2024-06-01','OtherRequest','Completed','ST004','A004'),(13,'2024-06-10','RepairRequest','Completed','ST005','A006'),(14,'2024-06-15','CleaningRequest','Completed','ST005','A005'),(15,'2024-06-20','OtherRequest','Completed','ST001','A001');
/*!40000 ALTER TABLE `maintenance_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `next_of_kin`
--

LOCK TABLES `next_of_kin` WRITE;
/*!40000 ALTER TABLE `next_of_kin` DISABLE KEYS */;
INSERT INTO `next_of_kin` VALUES ('NOK001','Nik Clark','Father','456 Jalan Merdeka','Kuala Lumpur',50000,'09876543210','ST001'),('NOK002','Ong Li','Mother','789 Jalan Ampang','Shah Alam',40000,'12312312312','ST002'),('NOK003','Wong Wei','Brother','101 Jalan Bukit','Petaling Jaya',46000,'32132132132','ST003'),('NOK004','Mei Clark','Sister','202 Jalan Raja','Johor Bahru',80000,'45645645645','ST004'),('NOK005','Wong Ling','Guardian','303 Jalan Melaka','Ipoh',30000,'78978978978','ST005'),('NOK006','Ng Ching','Father','47 Jalan Johnson','Kuala Lumpur',51000,'0189965774','ST006');
/*!40000 ALTER TABLE `next_of_kin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `other_request`
--

LOCK TABLES `other_request` WRITE;
/*!40000 ALTER TABLE `other_request` DISABLE KEYS */;
INSERT INTO `other_request` VALUES (3,'Request for bigger size study table','2024-03-20'),(6,'Need new keys','2024-04-20'),(9,'Request for new table cover','2024-05-05'),(12,'Request for 2 in 1 microwave oven','2024-06-01'),(15,'Request for chair cushion','2024-06-20');
/*!40000 ALTER TABLE `other_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'2024-05-22',500.00,'Credit Card','ST001',1),(2,'2024-05-22',500.00,'Debit Card','ST002',2),(3,'2024-06-24',600.00,'Bank Transfer','ST003',3),(4,'2024-06-30',600.00,'Cash','ST004',4),(5,'2024-07-27',550.00,'Credit Card','ST005',5);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `repair_request`
--

LOCK TABLES `repair_request` WRITE;
/*!40000 ALTER TABLE `repair_request` DISABLE KEYS */;
INSERT INTO `repair_request` VALUES (1,'Broken chair leg','2024-01-12'),(4,'Termites in chair','2024-04-01'),(7,'Door Broken','2024-04-25'),(10,'Table Broken','2024-05-20'),(13,'Air Conditioner Broken','2024-06-10');
/*!40000 ALTER TABLE `repair_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,101,'H001',1),(2,212,'H001',2),(3,301,'H002',3),(4,402,'H002',4),(5,507,'H003',5);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES ('S001','12345678901','Maintenance','U001'),('S002','98765432109','IT','U002'),('S003','11223344556','Maintenance','U003'),('S004','66778899001','Finance','U004'),('S005','22334455667','Academic','U005'),('S006','01113345687','Academic','U006'),('S007','0146782340','Maintenance','U007'),('S008','0173398771','Maintenance','U008'),('S009','0164320987','Maintenance','U009');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('ST001','456 Jalan Merdeka','Kuala Lumpur',50000,'2000-01-01','Undergraduate','Placed','C001',1,1,'U101'),('ST002','789 Jalan Ampang','Shah Alam',40000,'1999-02-02','Postgraduate','Placed','C002',2,2,'U102'),('ST003','101 Jalan Bukit','Petaling Jaya',46000,'2001-03-03','Undergraduate','Placed','C001',3,3,'U103'),('ST004','202 Jalan Raja','Johor Bahru',80000,'2000-04-04','Postgraduate','Placed','C003',4,4,'U104'),('ST005','303 Jalan Melaka','Ipoh',30000,'1998-05-05','Undergraduate','Placed','C004',5,5,'U105'),('ST006','01 Jalan Melaka','Ipoh',30000,'1998-05-23','Undergraduate','Waiting','C004',NULL,NULL,'U106');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('U001','An','Nik','Nik@example.com','Staff'),('U002','Dafeny','Ong','dafeny@example.com','Staff'),('U003','Nicholas','Ng','iamthemosthandsome@example.com','Staff'),('U004','Peter','Yap','quaq@example.com','Staff'),('U005','Yin','Yap','enyin@example.com','Staff'),('U006','Jane','Chen','jane@example.com','Staff'),('U007','Choo','Leong','choo@example.com','Staff'),('U008','Ted','Lee','ted@example.com','Staff'),('U009','Barney','Tan','barney@example.com','Staff'),('U101','Emily','Clark','emilyclark@example.com','Student'),('U102','Sam','Wong','SamWong@example.com','Student'),('U103','Jack','Wong','JackWong@example.com','Student'),('U104','Geeta','Clark','Geetaclark@example.com','Student'),('U105','Nicholas','Yap','NicholasYap@example.com','Student'),('U106','Dafeny','Ng','DafenyNg@example.com','Student'),('U107','Jack','Yap','JackYap@example.com','Student');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-12  1:04:49
