-- =========================================================================================
-- PROJECT: Student Housing Management System
-- COMPONENT: Analytical & Operational Query Suite
-- AUTHOR: Yap En Yin (Lead), Ong Shi Ning, Nicholas Ng Yan Zhe, Nik Zhi An, Yap Jiunn Yu
-- PURPOSE: This script contains 20 business logic queries designed to provide actionable
--          insights for housing administrators.
-- =========================================================================================


-- Q1 Count the number of staff and student in the accommodation system
Select UserType, COUNT(*) AS UserCount
From User
group by UserType
order by UserType;

-- Q2 Display the hall with a monthly rent less than 600
SELECT HallName, Address, CONCAT('RM', MonthlyRent) AS MonthlyRent 
FROM Hall 
WHERE MonthlyRent <= 600;

-- Q3 Display the asset with fair condition
SELECT AssetID, AssetType, AssetDescription, States
FROM Asset 
WHERE States = 'Fair';

-- Q4 Display the maintenance request in June
SELECT MaintenanceRequestID, RequestDate, RequestType, RequestStatus, StudentID, AssetID
FROM Maintenance_request
WHERE RequestDate BETWEEN '2024-06-01' AND '2024-06-30';

-- Q5 Display total payment separated by payment method
SELECT PaymentMethod, SUM(AmountPaid) AS TotalCollected
FROM Payment
GROUP BY PaymentMethod
HAVING PaymentMethod IN ('Credit Card', 'Debit Card', 'Cash', 'Bank Transfer');

-- Q6 Display student details whose lease started from 2024
select Student.StudentID, CONCAT(User.FirstName, ' ', User.LastName) AS StudentName, 
CONCAT(Student.Street,' ', Student.City,' ', Student.Postcode) AS StudentAddress, 
Student.LeaseNumber,Lease.StartDate, Room.HallID, Hall.HallName, Room.RoomNumber
from Student
inner join User on Student.UserID = User.UserID
inner join Room on Student.PlaceNumber = Room.PlaceNumber
inner join Hall on Room.HallID = Hall.HallID
inner join Lease on Student.LeaseNumber = Lease.LeaseNumber
where Lease.StartDate >= '2024-01-01';

-- Q7 Retrieve student details with unpaid invoice. 
SELECT Student.StudentID, CONCAT(User.FirstName,' ', User.LastName) AS StudentName , user.email, 
Invoice.InvoiceID, CONCAT('RM',Invoice.Amount) AS UnsettlePayment, Invoice.DueDate
FROM Invoice
INNER JOIN Student ON Invoice.StudentID = Student.StudentID
INNER JOIN User ON User.UserID = Student.UserID
WHERE Invoice.Is_paid = FALSE;

-- Q8 List out every student include the student that has not yet rent the accommodation
-- student that has no place number is the one in waiting list
SELECT Student.StudentID, CONCAT (User.FirstName,' ', User.LastName) AS StudentName, Room.PlaceNumber
FROM Student
LEFT OUTER JOIN User ON Student.UserID = User.UserID
LEFT OUTER JOIN Room ON Student.PlaceNumber = Room.PlaceNumber;

-- Q9 Display the number of request without needing repair work 
-- so that the office can better manage and allocate their repair workers
SELECT Student.StudentID, CONCAT(User.FirstName, ' ', User.LastName) AS StudentName,
       COUNT(Maintenance_request.MaintenanceRequestID) AS Request_Without_Repair
FROM Student
INNER JOIN User ON Student.UserID = User.UserID
INNER JOIN Maintenance_request ON Student.StudentID = Maintenance_request.StudentID
		  AND (Maintenance_request.RequestType LIKE '%CleaningRequest%' OR Maintenance_request.RequestType LIKE '%OtherRequest%')
GROUP BY Student.StudentID, User.FirstName, User.LastName;


-- Q10 Calculate students' total rent per semester
select Student.StudentID, CONCAT( User.FirstName,' ', User.LastName) AS StudentName, 
   CONCAT('RM', Hall.MonthlyRent * CEIL(TIMESTAMPDIFF(MONTH, Lease.StartDate, Lease.EndDate) / 3)) as TotalRentPerSem
from Student
left outer join User on Student.UserID = User.UserID
left outer join Room on Student.PlaceNumber = Room.PlaceNumber
left outer join Hall on Room.HallID = Hall.HallID
left outer join Lease on Student.LeaseNumber = Lease.LeaseNumber;

-- Q12 Query for amount to pay first semester for new intake student with discount and registration fee
SELECT Student.StudentID, CONCAT(User.FirstName, ' ', User.LastName) AS StudentName, 
       Lease.LeaseNumber, Lease.StartDate, Lease.EndDate, CONCAT ('RM', Hall.MonthlyRent * 3) AS TotalRentPerSemester,
       CONCAT('RM', (Hall.MonthlyRent * 3) * 0.8 + 200) AS AmountToPayFirstSemester 
       -- Applying 20% discount and adding $200 registration fee
FROM Student
INNER JOIN User ON Student.UserID = User.UserID
INNER JOIN Lease ON Student.LeaseNumber = Lease.LeaseNumber
INNER JOIN Room ON Student.PlaceNumber = Room.PlaceNumber
INNER JOIN Hall ON Room.HallID = Hall.HallID
WHERE Lease.StartDate >= '2024-01-01';  

-- Q13 Display the contact number of each hall supervisor
SELECT CONCAT(User.FirstName, ' ', User.LastName) AS HallSupervisorName, Staff.ContactNumber, 
       Hall.HallID, Hall.HallName
FROM  Staff
INNER JOIN User ON Staff.UserID = User.UserID
INNER JOIN Hall ON Staff.StaffID = Hall.Hall_SupervisorID;

-- Q14 Find all rooms in Suria Hall along with their lease numbers and student names
SELECT Room.RoomNumber, Room.LeaseNumber, 
       CONCAT(User.FirstName, ' ', User.LastName) AS StudentName
FROM Room
INNER JOIN Student ON Room.PlaceNumber = Student.PlaceNumber
INNER JOIN User ON Student.UserID = User.UserID
INNER JOIN Hall ON Room.HallID = Hall.HallID
WHERE Hall.HallName LIKE '%Suria%';


-- Q15 Display students and their maintenance request details.
select Student.StudentID, Concat(User.FirstName,' ', User.LastName) AS StudentName, room.RoomNumber, 
Maintenance_request.MaintenanceRequestID, Maintenance_request.RequestType, 
Maintenance_request.RequestDate
from Student
inner join User on Student.UserID = User.UserID
inner join Maintenance_request on Student.StudentID = Maintenance_request.StudentID
inner join Room on Student.placeNumber = room.PlaceNumber;

-- Q16 Display the student details and their courses for students enrolled in 'Software Engineering'.
-- query for course leader in the system to create a list for students enrolled in the same course
SELECT Student.StudentID, User.FirstName, User.LastName, Course.CourseTitle
FROM Student
INNER JOIN User ON Student.UserID = User.UserID
INNER JOIN Course ON Student.CourseID = Course.CourseID
WHERE Course.CourseTitle = 'Software Engineering';

-- Q17 Display the hall ID, hall name, and the number of maintenance requests for each hall.
-- so that office can estimate how much time the maintenance workers need for each hall.
SELECT Hall.HallID, Hall.HallName, COUNT(Maintenance_request.MaintenanceRequestID) AS MaintenanceRequestCount
FROM Hall
INNER JOIN Room ON Hall.HallID = Room.HallID
INNER JOIN Student ON Room.PlaceNumber = Student.PlaceNumber
INNER JOIN Maintenance_request ON Student.StudentID = Maintenance_request.StudentID
GROUP BY Hall.HallID, Hall.HallName;

-- Q18 query for the list of assets along with their room numbers and hall names.
SELECT a.AssetID, a.AssetType, a.AssetDescription, r.RoomNumber, h.HallName
FROM Asset a
INNER JOIN Room r ON a.PlaceNumber = r.PlaceNumber
INNER JOIN Hall h ON r.HallID = h.HallID;

-- Q19 query for calculating remaining date for payment before duedate
SELECT Invoice.InvoiceID, Invoice.Amount,
       Invoice.DueDate, (TO_DAYS(Invoice.DueDate) - TO_DAYS(CURDATE())) AS DaysUntilDue
FROM Invoice
WHERE Invoice.Is_paid = FALSE;


-- Q20 query for the number of count of students per hall
SELECT Hall.HallName, COUNT(Student.StudentID) AS NumberOfStudents
FROM Student
INNER JOIN Room ON Student.PlaceNumber = Room.PlaceNumber
INNER JOIN Hall ON Room.HallID = Hall.HallID
GROUP BY Hall.HallName;

