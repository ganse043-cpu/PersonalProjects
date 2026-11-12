CREATE DATABASE Restaurant;
USE Restaurant;

-- ==================================
-- TABLES
-- ==================================

CREATE TABLE Department (
DepartmentID INT AUTO_INCREMENT,
DepartmentName VARCHAR(25),
PRIMARY KEY (DepartmentID)
);

CREATE TABLE Positions (
PositionID INT AUTO_INCREMENT,
PositionTitle VARCHAR(25),
HourlyRate DECIMAL(6, 2),
PRIMARY KEY (PositionID)
);

CREATE TABLE Employees (
EmployeeID INT AUTO_INCREMENT,
FirstName VARCHAR(25),
LastName VarChar(25),
Phone VarChar(15),
Email VarChar(100),
DepartmentID INT NOT NULL,
PositionID INT NOT NULL,
HireDate DATE,
PRIMARY KEY (EmployeeID),
FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
FOREIGN KEY (PositionID) REFERENCES Positions (PositionID)
);

CREATE TABLE Shifts (
ShiftID INT AUTO_INCREMENT,
ShiftName VARCHAR(50),
StartTime TIME, 
EndTime TIME,
PRIMARY KEY (ShiftID)
);

CREATE TABLE TimeLogs (
TimeLogID INT AUTO_INCREMENT,
EmployeeID INT NOT NULL,
ClockIn DATETIME,
ClockOut DATETIME,
PRIMARY KEY (TimeLogID),
FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);

CREATE TABLE Attendance (
AttendanceID INT AUTO_INCREMENT,
EmployeeID INT NOT NULL,
WorkDate DATE,
Status VARCHAR(20),
PRIMARY KEY (AttendanceID),
FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);

CREATE TABLE Payroll (
PayrollID INT AUTO_INCREMENT,
EmployeeID INT NOT NULL,
PayPeriodStart DATE,
PayPeriodEnd DATE,
TotalHours DECIMAL(6,2),
OvertimeHours DECIMAL(6, 2),
TotalPay DECIMAL(10, 2),
PRIMARY KEY (PayrollID),
FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);

CREATE TABLE OvertimeRecords (
OvertimeID INT AUTO_INCREMENT,
EmployeeID INT NOT NULL,
WorkDate DATE,
Hours DECIMAL(5,2),
PRIMARY KEY (OvertimeID),
FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);

CREATE TABLE Managers (
ManagerID INT AUTO_INCREMENT,
EmployeeID INT NOT NULL,
PRIMARY KEY (ManagerID),
FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);

CREATE TABLE Approvals (
ApprovalID INT AUTO_INCREMENT,
ManagerID INT NOT NULL,
TimeLogID INT NOT NULL,
ApprovalStatus VARCHAR(20),
ApprovalDate DATETIME,
FOREIGN KEY (ManagerID) REFERENCES Managers(ManagerID),
FOREIGN KEY (TimeLogID) REFERENCES TimeLogs(TimeLogID),
PRIMARY KEY (ApprovalID)
);

CREATE TABLE LeaveRequests (
LeaveID INT AUTO_INCREMENT,
EmployeeID INT NOT NULL,
StartDate DATE,
EndDate DATE,
Reason VARCHAR(100),
Status VarChar(20),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
PRIMARY KEY (LeaveID)
);

CREATE TABLE Breaks (
BreakID INT AUTO_INCREMENT,
TimeLogID INT NOT NULL,
BreakStart DATETIME,
BreakEnd DATETIME,
FOREIGN KEY (TimeLogID) REFERENCES TimeLogs(TimeLogID),
PRIMARY KEY (BreakID)
);

CREATE TABLE Schedules (
ScheduleID INT AUTO_INCREMENT,
EmployeeID INT NOT NULL,
ShiftID INT NOT NULL,
WorkDate DATE,
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
FOREIGN KEY (ShiftID) REFERENCES Shifts(ShiftID),
PRIMARY KEY (ScheduleID)
);


-- =======================================
-- SAMPLE DATA
-- =======================================


INSERT INTO Department(DepartmentName)
VALUES ('Kitchen'), ('Front of House'), ('Bar'), ('Management'), ('Cleaning'),
('Prep'), ('Delivery'), ('Catering'), ('Inventory'), ('HR');

INSERT INTO Positions(PositionTitle, HourlyRate)
VALUES ('Chef', 25.00), ('Server', 15.75), ('Bartender', 15.00), ('Manager', 30.00),
('Cleaner', 14.00), ('Prep Cook', 16.00), ('Delivery Driver', 15.00), ('Caterer', 18.00),
('Inventory Management', 17.00), ('HR Rep', 23.00);

INSERT INTO Employees (FirstName, LastName, Phone, Email, DepartmentID, PositionID, HireDate) 
VALUES('John','Doe','1111111111','john@email.com',1,1,'2023-01-01'),
('Jane','Smith','2222222222','jane@email.com',2,2,'2025-02-01'),
('Mike','Brown','3333333333','mike@email.com',3,3,'2023-03-01'),
('Sara','Davis','4444444444','sara@email.com',4,4,'2023-04-01'),
('Tom','Wilson','5555555555','tom@email.com',5,5,'2026-05-01'),
('Emma','Taylor','6666666666','emma@email.com',1,6,'2023-06-01'),
('Liam','Anderson','7777777777','liam@email.com',7,7,'2023-07-01'),
('Olivia','Thomas','8888888888','olivia@email.com',8,8,'2023-08-01'),
('Noah','Jackson','9999999999','noah@email.com',9,9,'2025-09-01'),
('Ava','White','1010101010','ava@email.com',10,10,'2023-10-01');

INSERT INTO Shifts (ShiftName, StartTime, EndTime) VALUES
('Morning','08:00:00','12:00:00'),
('Lunch','12:00:00','16:00:00'),
('Evening','16:00:00','20:00:00'),
('Night','20:00:00','00:00:00'),
('Early','06:00:00','10:00:00'),
('Late','18:00:00','22:00:00'),
('Split1','10:00:00','14:00:00'),
('Split2','14:00:00','18:00:00'),
('Weekend','09:00:00','17:00:00'),
('Holiday','10:00:00','18:00:00');

INSERT INTO Managers (EmployeeID) 
VALUES (8), (1), (4), (7);

INSERT INTO TimeLogs (EmployeeID, ClockIn, ClockOut) VALUES
(1,'2026-04-10 08:00:00','2026-04-10 16:00:00'),
(2,'2026-04-10 09:00:00','2026-04-10 17:00:00'),
(3,'2026-04-10 10:00:00','2026-04-10 18:00:00'),
(4,'2026-04-10 08:00:00','2026-04-10 17:00:00'),
(5,'2026-04-10 07:00:00','2026-04-10 15:00:00'),
(6,'2026-04-10 08:00:00','2026-04-10 14:00:00'),
(7,'2026-04-10 11:00:00','2026-04-10 19:00:00'),
(8,'2026-04-10 12:00:00','2026-04-10 20:00:00'),
(9,'2026-04-10 13:00:00','2026-04-10 21:00:00'),
(10,'2026-04-10 09:00:00','2026-04-10 17:00:00');

INSERT INTO Attendance (EmployeeID, WorkDate, Status) VALUES
(1,'2026-04-10','Present'),
(2,'2026-04-10','Present'),
(3,'2026-04-10','Late'),
(4,'2026-04-10','Present'),
(5,'2026-04-10','Absent'),
(6,'2026-04-10','Present'),
(7,'2026-04-10','Present'),
(8,'2026-04-10','Late'),
(9,'2026-04-10','Present'),
(10,'2026-04-10','Present');

INSERT INTO Payroll 
(EmployeeID, PayPeriodStart, PayPeriodEnd, TotalHours, OvertimeHours, TotalPay) VALUES
(1,'2026-04-10','2026-04-17',40,5,1350),
(2,'2026-04-10','2026-04-17',38,2,620),
(3,'2026-04-10','2026-04-17',42,6,800),
(4,'2026-04-10','2026-04-17',45,8,1590),
(5,'2026-04-10','2026-04-17',35,0,490),
(6,'2026-04-10','2026-04-17',30,0,480),
(7,'2026-04-10','2026-04-17',40,4,1320),
(8,'2026-04-10','2026-04-17',40,3,1290),
(9,'2026-04-10','2026-04-17',40,2,680),
(10,'2026-04-10','2026-04-17',40,1,880);

INSERT INTO OvertimeRecords (EmployeeID, WorkDate, Hours) VALUES
(1,'2026-04-10',2),(2,'2026-04-10',1),(3,'2026-04-10',3),
(4,'2026-04-10',4),(5,'2026-04-10',0),(6,'2026-04-10',0),
(7,'2026-04-10',2),(8,'2026-04-10',1),(9,'2026-04-10',1),
(10,'2026-04-10',1);

INSERT INTO Approvals (ManagerID, TimeLogID, ApprovalStatus, ApprovalDate) VALUES
(1,1,'Approved','2026-04-11'),
(2,2,'Approved','2026-04-11'),
(3,3,'Approved','2026-04-11'),
(4,4,'Approved','2026-04-11'),
(1,5,'Rejected','2026-04-11'),
(2,6,'Approved','2026-04-11'),
(3,7,'Approved','2026-04-11'),
(4,8,'Approved','2026-04-11'),
(1,9,'Approved','2026-04-11'),
(2,10,'Approved','2026-04-11');

INSERT INTO LeaveRequests (EmployeeID, StartDate, EndDate, Reason, Status) VALUES
(1,'2026-05-01','2026-05-07','Vacation','Approved'),
(2,'2026-05-02','2026-05-04','Sick','Approved'),
(3,'2026-05-05','2026-05-06','Personal','Pending'),
(4,'2026-05-07','2026-05-08','Travel','Approved'),
(5,'2026-05-09','2026-05-10','Family','Rejected'),
(6,'2026-05-11','2026-05-12','Medical','Approved'),
(7,'2026-05-13','2026-05-18','Vacation','Pending'),
(8,'2026-05-15','2026-05-16','Event','Approved'),
(9,'2026-05-17','2026-05-18','Personal','Approved'),
(10,'2026-05-19','2026-05-20','Sick','Approved');

INSERT INTO Breaks (TimeLogID, BreakStart, BreakEnd) VALUES
(1,'2026-04-10 12:00:10','2026-04-10 12:30:00'),
(2,'2026-04-10 13:00:00','2026-04-10 13:30:00'),
(3,'2026-04-10 14:00:00','2026-04-10 14:30:00'),
(4,'2026-04-10 12:30:00','2026-04-10 13:00:00'),
(5,'2026-04-10 11:30:00','2026-04-10 12:00:00'),
(6,'2026-04-10 10:30:00','2026-04-10 11:00:00'),
(7,'2026-04-10 15:00:00','2026-04-10 15:30:00'),
(8,'2026-04-10 16:00:00','2026-04-10 16:30:00'),
(9,'2026-04-10 17:00:00','2026-04-10 17:30:00'),
(10,'2026-04-10 13:30:00','2026-04-10 14:00:00');

INSERT INTO Schedules (EmployeeID, ShiftID, WorkDate) VALUES
(1, 1, '2026-04-10'),
(2, 2, '2026-04-10'),
(3, 3, '2026-04-10'),
(4, 4, '2026-04-10'),
(5, 5, '2026-04-10'),
(6, 6, '2026-04-10'),
(7, 7, '2026-04-10'),
(8, 8, '2026-04-10'),
(9, 9, '2026-04-10'),
(10, 10,'2026-04-10'),
(1, 1, '2026-04-11'),
(2, 2, '2026-04-11'),
(3, 3, '2026-04-11'),
(4, 4, '2026-04-11'),
(5, 5, '2026-04-11'),
(6, 6, '2026-04-11'),
(7, 7, '2026-04-11'),
(8, 8, '2026-04-11'),
(9, 9, '2026-04-11'),
(10, 10,'2026-04-11'),
(1, 1,'2026-04-25');

-- ==================================
-- KPI's/VIEWS
-- ==================================

-- KPI 1: Total Hours Worked for each employee
CREATE VIEW TotalHoursWorked AS
SELECT
e.EmployeeID,
e.FirstName, 
e.LastName,
ROUND(SUM(TIMESTAMPDIFF(SECOND, t.ClockIn, t.ClockOut)) / 3600, 2) AS TotalHours
FROM Employees e
JOIN TimeLogs t ON e.EmployeeID = t.EmployeeID
GROUP BY e.EmployeeID;

SELECT * FROM TotalHoursWorked;

-- KPI 2: Total Overtime Hours for each employee
CREATE VIEW OvertimeHours AS
SELECT 
e.EmployeeID,
e.FirstName,
e.LastName,
SUM(o.Hours) AS TotalOverTimeHours
FROM Employees e
JOIN OvertimeRecords o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID;

SELECT * FROM OvertimeHours;

-- KPI 3: Attendance Rate for all employees
CREATE VIEW AttendanceRate AS
SELECT 
EmployeeID,
COUNT(CASE WHEN Status = 'Present' THEN 1 END) * 100 / COUNT(*) AS AttendanceRate
FROM Attendance
GROUP BY EmployeeID;

SELECT * FROM AttendanceRate;

-- KPI 4: Weekly Payroll Cost
CREATE VIEW PayrollCost AS
SELECT
	PayPeriodStart,
    PayPeriodEnd,
    COUNT(EmployeeID) AS TotalEmployeesPaid,
    SUM(TotalHours) AS TotalHoursWorked,
    SUM(OverTimeHours) AS TotalOvertimeHours,
    SUM(TotalPay) AS TotalPayrollCost,
    ROUND(AVG(TotalPay), 2) AS AvgPayPerEmp
FROM Payroll
GROUP BY PayPeriodStart, PayPeriodEnd
ORDER BY PayPeriodStart;

SELECT * FROM PayrollCost;

-- ==================================
-- TRIGGERS
-- ==================================


-- Trigger 1: Auto-insert overtime record when a shift exceeds 8 hours
DELIMITER $$

CREATE TRIGGER calculate_overtime
AFTER INSERT ON TimeLogs
FOR EACH ROW
BEGIN
	DECLARE hoursWorked DECIMAL(10, 4);
    SET hoursWorked = TIMESTAMPDIFF(SECOND, NEW.ClockIn, NEW.ClockOut) / 3600;
    IF hoursWorked > 8 THEN
		INSERT INTO OvertimeRecords (EmployeeID, WorkDate, Hours)
        VALUES (NEW.EmployeeID, DATE(NEW.ClockIn), hoursWorked - 8);
	END IF;
END $$

DELIMITER ;

-- Trigger 2: Auto-mark attendance as Present when a time log is added
DELIMITER $$

CREATE TRIGGER mark_attendance
AFTER INSERT ON TimeLogs
FOR EACH ROW
BEGIN 
	INSERT INTO Attendance(EmployeeID, WorkDate, Status)
    VALUES (NEW.EmployeeID, DATE(NEW.ClockIn), 'Present');
END$$

DELIMITER ;

-- Trigger 3: Accumulate total payroll hours when a new time log is added
DELIMITER $$

CREATE TRIGGER update_payroll_hours
AFTER INSERT ON TimeLogs
FOR EACH ROW
BEGIN
	UPDATE Payroll
    SET TotalHours = TotalHours + TIMESTAMPDIFF(SECOND, NEW.ClockIn, NEW.ClockOut) / 3600
    WHERE EmployeeID = NEW.EmployeeID
      AND DATE(NEW.ClockIn) BETWEEN PayPeriodStart AND PayPeriodEnd;
END$$

DELIMITER ;

-- Trigger 4: Block invalid time entries (Clock out before clock in)
DELIMITER $$

CREATE TRIGGER validate_timelog
BEFORE INSERT ON TimeLogs
FOR EACH ROW
BEGIN
    IF NEW.ClockIn IS NULL OR NEW.ClockOut IS NULL OR NEW.ClockOut <= NEW.ClockIn THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Both timestamps are required and ClockOut must be after ClockIn';
    END IF;
END$$

DELIMITER ;

-- =====================================
-- STORED PROCEDURE
-- =====================================


-- STORED PROCEDURE: Returns all scheduled shifts for a given employee, including shift name, start time, and end time
DELIMITER $$

CREATE PROCEDURE GetEmployeeSchedule(IN empID INT)
BEGIN
	SELECT 
		s.WorkDate,
        sh.ShiftName,
        sh.StartTime,
        sh.EndTime
	FROM Schedules s
    JOIN Shifts sh ON s.ShiftID = sh.ShiftID
    WHERE s.EmployeeID = empID
    ORDER BY s.WorkDate;
END$$

DELIMITER ;

CALL GetEmployeeSchedule(1);

-- Shows total hours and pay for each employee
SELECT e.FirstName, e.LastName, p.TotalHours, p.OvertimeHours, p.TotalPay
FROM Payroll p
JOIN Employees e ON p.EmployeeID = e.EmployeeID;


-- View all employee schedules
SELECT e.FirstName, e.LastName, sh.ShiftName, s.WorkDate
FROM Schedules s
JOIN Employees e ON s.EmployeeID = e.EmployeeID
JOIN Shifts sh ON s.ShiftID = sh.ShiftID;


-- Identify employees who exceeded 8 hours in a shift(Overtime)
SELECT e.FirstName, e.LastName, o.WorkDate, o.Hours
FROM OvertimeRecords o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE o.Hours > 0;
