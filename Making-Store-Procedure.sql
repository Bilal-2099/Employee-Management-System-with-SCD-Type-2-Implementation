--Store Procedure
--Adding New Employee
CREATE PROCEDURE AddEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @PhoneNumber VARCHAR(15),
    @HireDate DATE,
    @DepartmentID INT,
    @JobTitleID INT,
    @Salary DECIMAL(10, 2),
    @SalaryEffectiveDate DATE
AS
BEGIN
    -- Insert into Employees table
    INSERT INTO Employees (FirstName, LastName, Email, PhoneNumber, HireDate, DepartmentID, JobTitleID)
    VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @HireDate, @DepartmentID, @JobTitleID);
    
    -- Get the EmployeeID of the newly added employee
    DECLARE @EmployeeID INT = SCOPE_IDENTITY();
    
    -- Insert initial salary into the Salaries table
    INSERT INTO Salaries (EmployeeID, Amount, EffectiveDate, IsCurrent)
    VALUES (@EmployeeID, @Salary, @SalaryEffectiveDate, 1);

    -- Update the CurrentSalaryID in Employees table
    UPDATE Employees
    SET CurrentSalaryID = SCOPE_IDENTITY()
    WHERE EmployeeID = @EmployeeID;

    -- Insert record into EmployeeHistory for tracking JobTitle and Department
    INSERT INTO EmployeeHistory (EmployeeID, JobTitleID, DepartmentID, EffectiveStartDate)
    VALUES (@EmployeeID, @JobTitleID, @DepartmentID, @HireDate);

    PRINT 'Employee successfully added.';
END;

--Updating Employees
CREATE PROCEDURE UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10, 2),
    @SalaryEffectiveDate DATE
AS
BEGIN
    -- Mark the old salary as no longer current
    UPDATE Salaries
    SET IsCurrent = 0
    WHERE EmployeeID = @EmployeeID AND IsCurrent = 1;

    -- Insert the new salary into the Salaries table
    INSERT INTO Salaries (EmployeeID, Amount, EffectiveDate, IsCurrent)
    VALUES (@EmployeeID, @NewSalary, @SalaryEffectiveDate, 1);

    -- Update the CurrentSalaryID in Employees table
    UPDATE Employees
    SET CurrentSalaryID = SCOPE_IDENTITY()
    WHERE EmployeeID = @EmployeeID;

    PRINT 'Salary updated successfully.';
END;

--Updating Employee Job Titles
CREATE PROCEDURE UpdateEmployeeJobTitleAndDepartment
    @EmployeeID INT,
    @NewJobTitleID INT,
    @NewDepartmentID INT,
    @EffectiveDate DATE
AS
BEGIN
    -- Close the current JobTitle and Department record in EmployeeHistory
    UPDATE EmployeeHistory
    SET EffectiveEndDate = @EffectiveDate
    WHERE EmployeeID = @EmployeeID AND EffectiveEndDate IS NULL;

    -- Insert new JobTitle and Department into EmployeeHistory
    INSERT INTO EmployeeHistory (EmployeeID, JobTitleID, DepartmentID, EffectiveStartDate)
    VALUES (@EmployeeID, @NewJobTitleID, @NewDepartmentID, @EffectiveDate);

    -- Update the JobTitle and Department in Employees table
    UPDATE Employees
    SET JobTitleID = @NewJobTitleID, DepartmentID = @NewDepartmentID
    WHERE EmployeeID = @EmployeeID;

    PRINT 'Job title and department updated successfully.';
END;

--Getting Employee Details
CREATE PROCEDURE GetEmployeeDetails
    @EmployeeID INT
AS
BEGIN
    SELECT 
        e.FirstName, 
        e.LastName, 
        e.Email, 
        e.PhoneNumber, 
        e.HireDate,
        d.DepartmentName, 
        jt.JobTitleName,
        s.Amount AS CurrentSalary
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    JOIN JobTitles jt ON e.JobTitleID = jt.JobTitleID
    JOIN Salaries s ON e.CurrentSalaryID = s.SalaryID
    WHERE e.EmployeeID = @EmployeeID;
END;

--Generating Department Wise Salary Report
CREATE PROCEDURE GetDepartmentSalaryReport
AS
BEGIN
    SELECT 
        d.DepartmentName,
        COUNT(e.EmployeeID) AS NumberOfEmployees,
        SUM(s.Amount) AS TotalSalary,
        AVG(s.Amount) AS AverageSalary
    FROM Departments d
    JOIN Employees e ON e.DepartmentID = d.DepartmentID
    JOIN Salaries s ON e.CurrentSalaryID = s.SalaryID
    GROUP BY d.DepartmentName
    ORDER BY TotalSalary DESC;
END;

--Tracking Employee Attendance
CREATE PROCEDURE GetEmployeeAttendance
    @EmployeeID INT,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        a.AttendanceDate, 
        a.CheckInTime, 
        a.CheckOutTime, 
        a.TotalHoursWorked
    FROM Attendance a
    WHERE a.EmployeeID = @EmployeeID
    AND a.AttendanceDate BETWEEN @StartDate AND @EndDate;
END;
