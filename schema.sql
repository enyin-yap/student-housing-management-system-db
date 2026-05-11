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
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset` (
  `AssetID` varchar(10) NOT NULL,
  `AssetType` varchar(20) DEFAULT NULL,
  `AssetDescription` varchar(100) DEFAULT NULL,
  `States` varchar(30) DEFAULT NULL,
  `PlaceNumber` int NOT NULL,
  PRIMARY KEY (`AssetID`),
  KEY `fk_Room_PlaceNumber` (`PlaceNumber`),
  CONSTRAINT `asset_ibfk_1` FOREIGN KEY (`PlaceNumber`) REFERENCES `room` (`PlaceNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) NOT NULL,
  `action` varchar(10) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cleaning_request`
--

DROP TABLE IF EXISTS `cleaning_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cleaning_request` (
  `CleaningRequestID` int NOT NULL,
  `CleaningArea` varchar(50) DEFAULT NULL,
  `CleaningDate` date DEFAULT NULL,
  PRIMARY KEY (`CleaningRequestID`),
  CONSTRAINT `cleaning_request_ibfk_1` FOREIGN KEY (`CleaningRequestID`) REFERENCES `maintenance_request` (`MaintenanceRequestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `CourseID` varchar(10) NOT NULL,
  `CourseTitle` varchar(30) DEFAULT NULL,
  `Course_LeaderID` varchar(10) DEFAULT NULL,
  `DepartmentName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`CourseID`),
  KEY `fk_Course_LeaderID` (`Course_LeaderID`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`Course_LeaderID`) REFERENCES `staff` (`StaffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hall`
--

DROP TABLE IF EXISTS `hall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hall` (
  `HallID` varchar(10) NOT NULL,
  `HallName` varchar(20) NOT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `PhoneNumber` varchar(11) DEFAULT NULL,
  `MonthlyRent` decimal(10,2) DEFAULT NULL,
  `Hall_SupervisorID` varchar(10) NOT NULL,
  PRIMARY KEY (`HallID`),
  KEY `fk_Hall_SupervisorID` (`Hall_SupervisorID`),
  CONSTRAINT `hall_ibfk_1` FOREIGN KEY (`Hall_SupervisorID`) REFERENCES `staff` (`StaffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_hallrent_update` AFTER UPDATE ON `hall` FOR EACH ROW BEGIN
    UPDATE Invoice
    SET Amount = NEW.MonthlyRent,
        TotalAmount = NEW.MonthlyRent + IFNULL(Penalty, 0)     
    WHERE LeaseNumber IN (
        SELECT LeaseNumber
        FROM Room
        WHERE HallID = NEW.HallID
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `InvoiceID` int NOT NULL AUTO_INCREMENT,
  `Amount` decimal(10,2) DEFAULT NULL,
  `DueDate` date DEFAULT NULL,
  `PaymentDate` date DEFAULT NULL,
  `Is_paid` tinyint(1) DEFAULT '0',
  `Penalty` decimal(10,2) DEFAULT '0.00',
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  `LeaseNumber` int NOT NULL,
  `StudentID` varchar(10) NOT NULL,
  PRIMARY KEY (`InvoiceID`),
  KEY `fk_lease_number` (`LeaseNumber`),
  KEY `fk_studentID` (`StudentID`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`LeaseNumber`) REFERENCES `lease` (`LeaseNumber`),
  CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_invoice_insert` BEFORE INSERT ON `invoice` FOR EACH ROW BEGIN
    SET NEW.TotalAmount = NEW.Amount + IFNULL(NEW.Penalty, 0);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lease`
--

DROP TABLE IF EXISTS `lease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lease` (
  `LeaseNumber` int NOT NULL AUTO_INCREMENT,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  PRIMARY KEY (`LeaseNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_archive_lease` BEFORE DELETE ON `lease` FOR EACH ROW BEGIN
    INSERT INTO Lease_Archive (LeaseNumber, StartDate, EndDate)
    VALUES (OLD.LeaseNumber, OLD.StartDate, OLD.EndDate);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lease_archive`
--

DROP TABLE IF EXISTS `lease_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lease_archive` (
  `LeaseNumber` int NOT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `ArchivedOn` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LeaseNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `maintenance_request`
--

DROP TABLE IF EXISTS `maintenance_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_request` (
  `MaintenanceRequestID` int NOT NULL AUTO_INCREMENT,
  `RequestDate` date DEFAULT (curdate()),
  `RequestType` varchar(20) DEFAULT NULL,
  `RequestStatus` varchar(10) DEFAULT NULL,
  `StudentID` varchar(10) NOT NULL,
  `AssetID` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`MaintenanceRequestID`),
  KEY `fk_StudentID` (`StudentID`),
  KEY `fk_AssetID` (`AssetID`),
  CONSTRAINT `maintenance_request_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`),
  CONSTRAINT `maintenance_request_ibfk_2` FOREIGN KEY (`AssetID`) REFERENCES `asset` (`AssetID`),
  CONSTRAINT `maintenance_request_chk_1` CHECK ((`RequestType` in (_utf8mb4'RepairRequest',_utf8mb4'CleaningRequest',_utf8mb4'OtherRequest')))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `next_of_kin`
--

DROP TABLE IF EXISTS `next_of_kin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `next_of_kin` (
  `NOK_ID` varchar(10) NOT NULL,
  `NOK_Name` varchar(30) NOT NULL,
  `Relationship` varchar(20) NOT NULL,
  `Street` varchar(20) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `Postcode` int DEFAULT NULL,
  `ContactNumber` varchar(11) DEFAULT NULL,
  `StudentID` varchar(10) NOT NULL,
  PRIMARY KEY (`NOK_ID`),
  KEY `fk_StudentID` (`StudentID`),
  CONSTRAINT `next_of_kin_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`),
  CONSTRAINT `next_of_kin_chk_1` CHECK ((`Postcode` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `other_request`
--

DROP TABLE IF EXISTS `other_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `other_request` (
  `OtherRequestID` int NOT NULL,
  `RequestDetails` varchar(100) DEFAULT NULL,
  `RequestDate` date DEFAULT NULL,
  PRIMARY KEY (`OtherRequestID`),
  CONSTRAINT `other_request_ibfk_1` FOREIGN KEY (`OtherRequestID`) REFERENCES `maintenance_request` (`MaintenanceRequestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `PaymentDate` date DEFAULT NULL,
  `AmountPaid` decimal(10,2) DEFAULT NULL,
  `PaymentMethod` varchar(20) DEFAULT NULL,
  `StudentID` varchar(10) NOT NULL,
  `InvoiceID` int NOT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `fk_StudentID` (`StudentID`),
  KEY `fk_invoiceID` (`InvoiceID`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`),
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`InvoiceID`) REFERENCES `invoice` (`InvoiceID`),
  CONSTRAINT `payment_chk_1` CHECK ((`PaymentMethod` in (_utf8mb4'Credit Card',_utf8mb4'Debit Card',_utf8mb4'Bank Transfer',_utf8mb4'Cash')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_payment_insert` AFTER INSERT ON `payment` FOR EACH ROW BEGIN
    UPDATE Invoice
    SET Is_paid = TRUE,
        PaymentDate = NEW.PaymentDate
    WHERE InvoiceID = NEW.InvoiceID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `repair_request`
--

DROP TABLE IF EXISTS `repair_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repair_request` (
  `RepairRequestID` int NOT NULL,
  `IssueDescription` varchar(100) DEFAULT NULL,
  `RepairDate` date DEFAULT NULL,
  PRIMARY KEY (`RepairRequestID`),
  CONSTRAINT `repair_request_ibfk_1` FOREIGN KEY (`RepairRequestID`) REFERENCES `maintenance_request` (`MaintenanceRequestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `PlaceNumber` int NOT NULL,
  `RoomNumber` int NOT NULL,
  `HallID` varchar(10) NOT NULL,
  `LeaseNumber` int NOT NULL,
  PRIMARY KEY (`PlaceNumber`),
  KEY `fk_HallID` (`HallID`),
  KEY `fk_LeaseNumber` (`LeaseNumber`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`HallID`) REFERENCES `hall` (`HallID`),
  CONSTRAINT `room_ibfk_2` FOREIGN KEY (`LeaseNumber`) REFERENCES `lease` (`LeaseNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `StaffID` varchar(10) NOT NULL,
  `ContactNumber` varchar(11) DEFAULT NULL,
  `DeptName` varchar(30) DEFAULT NULL,
  `UserID` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`StaffID`),
  KEY `fk_userID` (`UserID`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `StudentID` varchar(10) NOT NULL,
  `Street` varchar(20) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `Postcode` int DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `StudentCategory` varchar(20) DEFAULT NULL,
  `CurrentStatus` varchar(20) DEFAULT NULL,
  `CourseID` varchar(10) NOT NULL,
  `PlaceNumber` int DEFAULT NULL,
  `LeaseNumber` int DEFAULT NULL,
  `UserID` varchar(10) NOT NULL,
  PRIMARY KEY (`StudentID`),
  KEY `fk_UserID` (`UserID`),
  KEY `fk_CourseID` (`CourseID`),
  KEY `fk_Room_PlaceNumber` (`PlaceNumber`),
  KEY `fk_LeaseNumber` (`LeaseNumber`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`),
  CONSTRAINT `student_ibfk_3` FOREIGN KEY (`PlaceNumber`) REFERENCES `room` (`PlaceNumber`),
  CONSTRAINT `student_ibfk_4` FOREIGN KEY (`LeaseNumber`) REFERENCES `lease` (`LeaseNumber`),
  CONSTRAINT `student_chk_1` CHECK ((`Postcode` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_update_student_address` BEFORE UPDATE ON `student` FOR EACH ROW BEGIN
    UPDATE Next_Of_Kin
    SET Street = NEW.Street,
        City = NEW.City,
        Postcode = NEW.Postcode
    WHERE StudentID = NEW.StudentID
      AND (NEW.Street <> OLD.Street OR NEW.City <> OLD.City OR NEW.Postcode <> OLD.Postcode);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UserID` varchar(10) NOT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `UserType` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`),
  CONSTRAINT `user_chk_1` CHECK ((`UserType` in (_utf8mb4'Student',_utf8mb4'Staff')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_user_delete` AFTER DELETE ON `user` FOR EACH ROW BEGIN
   INSERT INTO audit_log(table_name, action, timestamp)
   VALUES ('User', 'DELETE', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-12  1:01:51
