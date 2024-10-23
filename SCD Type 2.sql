-- Update current salary to old
UPDATE Salaries
SET IsCurrent = 0
WHERE EmployeeID = 1 AND IsCurrent = 1;

SELECT * From Salaries;

-- Insert new salary
INSERT INTO Salaries (EmployeeID, Amount, EffectiveDate, IsCurrent)
VALUES (1, 65000, '2024-01-01', 1);

-- Close the current job title history
UPDATE EmployeeHistory
SET EffectiveEndDate = GETDATE()
WHERE EmployeeID = 1 AND EffectiveEndDate IS NULL;

-- Insert new job title history
INSERT INTO EmployeeHistory (EmployeeID, JobTitleID, DepartmentID, EffectiveStartDate)
VALUES (1, 2, 1, GETDATE());

SELECT * From EmployeeHistory;