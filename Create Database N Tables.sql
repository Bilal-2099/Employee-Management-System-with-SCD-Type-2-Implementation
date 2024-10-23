Create Database Company;

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(100)
);

-- Job Titles Table
CREATE TABLE JobTitles (
    JobTitleID INT PRIMARY KEY IDENTITY(1,1),
    JobTitleName VARCHAR(100)
);

-- Employees Table (without CurrentSalaryID FK)
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    HireDate DATE,
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    JobTitleID INT FOREIGN KEY REFERENCES JobTitles(JobTitleID)
    -- CurrentSalaryID will be added later
);

-- Salaries Table (SCD Type 2) without the EmployeeID FK
CREATE TABLE Salaries (
    SalaryID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,  -- FK will be added later
    Amount DECIMAL(10,2),
    EffectiveDate DATE,
    IsCurrent BIT
);

-- Attendance Table
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    AttendanceDate DATE,
    CheckInTime DATETIME,
    CheckOutTime DATETIME,
    TotalHoursWorked DECIMAL(4,2)
);

-- Employee History Table (SCD Type 2 for Job Title & Department)
CREATE TABLE EmployeeHistory (
    HistoryID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    JobTitleID INT FOREIGN KEY REFERENCES JobTitles(JobTitleID),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    EffectiveStartDate DATE,
    EffectiveEndDate DATE
);

-- Add the EmployeeID foreign key to the Salaries table
ALTER TABLE Salaries
ADD CONSTRAINT FK_Salaries_EmployeeID FOREIGN KEY (EmployeeID)
REFERENCES Employees(EmployeeID);

-- Add the CurrentSalaryID column to the Employees table and the foreign key constraint
ALTER TABLE Employees
ADD CurrentSalaryID INT;

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_CurrentSalaryID FOREIGN KEY (CurrentSalaryID)
REFERENCES Salaries(SalaryID);
