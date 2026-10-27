
CREATE DATABASE PlacementDB;
GO

USE PlacementDB;
GO

CREATE TABLE Students
(
    StudentId INT PRIMARY KEY,
    EnrollmentNo VARCHAR(20) NOT NULL,
    StudentName VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    PassingYear INT NOT NULL,
    IsPlaced BIT NOT NULL DEFAULT 0
);

CREATE TABLE Placements
(
    PlacementId INT PRIMARY KEY,
    StudentId INT NOT NULL UNIQUE,
    CompanyName VARCHAR(100) NOT NULL,
    JobRole VARCHAR(100) NOT NULL,
    PackageLPA DECIMAL(6,2) NOT NULL,
    FOREIGN KEY (StudentId)
        REFERENCES Students(StudentId)
);

INSERT INTO Students VALUES
(1, 'CE001', 'Aarav Patel', 'CE', 2026, 1),
(2, 'CE002', 'Diya Shah', 'CE', 2026, 1),
(3, 'CE003', 'Krish Mehta', 'CE', 2026, 1),
(4, 'CE004', 'Riya Joshi', 'CE', 2026, 0),
(5, 'CE005', 'Arjun Desai', 'CE', 2026, 0),
(6, 'CE006', 'Neha Trivedi', 'CE', 2026, 1),
(7, 'CE007', 'Dev Patel', 'CE', 2026, 1),
(8, 'CE008', 'Mira Shah', 'CE', 2026, 0);

INSERT INTO Placements VALUES
(1, 1, 'TCS', 'System Engineer', 3.60),
(2, 2, 'Infosys', 'Systems Engineer', 4.00),
(3, 3, 'Wipro', 'Project Engineer', 3.50),
(4, 6, 'TCS', 'Assistant System Engineer', 3.60),
(5, 7, 'Pinnacle IIT', 'Software Developer', 6.00);
GO
