--Employees Attendence
SELECT e.FirstName, e.LastName, a.AttendanceDate, a.TotalHoursWorked
FROM Attendance a
JOIN Employees e ON a.EmployeeID = e.EmployeeID
WHERE a.AttendanceDate BETWEEN '2023-10-01' AND '2023-10-31';

--Track Employee Title Change
SELECT e.FirstName, e.LastName, jt.JobTitleName, eh.EffectiveStartDate, eh.EffectiveEndDate
FROM EmployeeHistory eh
JOIN Employees e ON eh.EmployeeID = e.EmployeeID
JOIN JobTitles jt ON eh.JobTitleID = jt.JobTitleID
WHERE e.EmployeeID = 1;

--Get Current Employee Listt
SELECT e.FirstName, e.LastName, d.DepartmentName, jt.JobTitleName, s.Amount AS CurrentSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN JobTitles jt ON e.JobTitleID = jt.JobTitleID
JOIN Salaries s ON e.CurrentSalaryID = s.SalaryID
WHERE s.IsCurrent = 1;


