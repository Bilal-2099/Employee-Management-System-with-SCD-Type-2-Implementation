-- Insert Departments
INSERT INTO Departments (DepartmentName)
VALUES ('Human Resources'), ('IT'), ('Marketing');

-- Insert Job Titles
INSERT INTO JobTitles (JobTitleName)
VALUES ('Software Engineer'), ('HR Manager'), ('Marketing Specialist');

-- Insert Employees (without CurrentSalaryID initially)
INSERT INTO Employees (FirstName, LastName, Email, PhoneNumber, HireDate, DepartmentID, JobTitleID)
VALUES ('John', 'Doe', 'john.doe@example.com', '123-456-7890', '2023-01-15', 1, 1),
       ('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '2022-05-10', 2, 2);

-- Insert Salaries (without EmployeeID FK)
INSERT INTO Salaries (EmployeeID, Amount, EffectiveDate, IsCurrent)
VALUES (1, 60000, '2023-01-15', 1),
       (2, 70000, '2022-05-10', 1);

-- Update Employees table with the CurrentSalaryID
UPDATE Employees
SET CurrentSalaryID = (SELECT SalaryID FROM Salaries WHERE Salaries.EmployeeID = Employees.EmployeeID);

-- Insert Attendance
INSERT INTO Attendance (EmployeeID, AttendanceDate, CheckInTime, CheckOutTime, TotalHoursWorked)
VALUES (1, '2023-10-01', '2023-10-01 09:00:00', '2023-10-01 17:00:00', 8),
       (2, '2023-10-01', '2023-10-01 09:30:00', '2023-10-01 17:30:00', 8);
