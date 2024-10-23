EXEC AddEmployee 
    @FirstName = 'Will',
    @LastName = 'Smith',
    @Email = 'will.smith@example.com',
    @PhoneNumber = '123-456-7890',
    @HireDate = '2023-01-15',
    @DepartmentID = 1,
    @JobTitleID = 1,
    @Salary = 60000,
    @SalaryEffectiveDate = '2023-01-15';

Select * From Employees;

EXEC UpdateEmployeeSalary 
    @EmployeeID = 1, 
    @NewSalary = 65000, 
    @SalaryEffectiveDate = '2024-01-01';

Select * From Salaries;

EXEC UpdateEmployeeJobTitleAndDepartment
    @EmployeeID = 1,
    @NewJobTitleID = 2,
    @NewDepartmentID = 2,
    @EffectiveDate = '2024-01-01';

Select * From EmployeeHistory;

EXEC GetEmployeeDetails @EmployeeID = 1;

EXEC GetDepartmentSalaryReport;

EXEC GetEmployeeAttendance 
    @EmployeeID = 1, 
    @StartDate = '2023-10-01', 
    @EndDate = '2023-10-31';
