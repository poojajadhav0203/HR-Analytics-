use hr_db;

-- Total Employee
select count(*) as TotalEmployees from hr_db.employee;

-- Active VS Terminated
select EmployeeStatus , count(*) AS EmployeeCount from hr_db.employee group by EmployeeStatus;

-- Attrition Rate
select (count(case when Attrition = 'Yes' THEN 1 END)*100.0) / count(*) as AttritionRate from hr_db.attrition;

-- Attrition by department

use hr_db;

select DepartmentType, COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS ExitedEmployees,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS AttritionRate
from hr_db.employee
join attrition ON employee.EmpIoyee_ID = attrition.Employee_ID
GROUP BY DepartmentType
ORDER BY AttritionRate desc
LIMIT 0, 10000;

-- Attrition by Gender
select GenderCode , count(*) as TotalEmployees,
sum(CASE WHEN attrition = 'Yes' then 1 else 0 end) as ExitedEmployees,
(sum(CASE WHEN attrition = 'Yes' then 1 else 0 end) * 1000.0 / count(*)) as AttritionRate
from hr_db.employee join attrition on employee.EmpIoyee_Id = attrition.Employee_ID
group by employee.GenderCode;

-- Average salary by Department
select DepartmentType,round(AVG(attrition.MonthlyIncome) , 2) AS AVGMonthlyIncome
from hr_db.employee
join attrition on employee.EmpIoyee_ID = attrition.Employee_ID
group by employee.DepartmentType 
order by AvgMonthlyIncome DESC;

-- Training Participation Vs Attrition 
select 
    CASE WHEN training.Employee_ID IS NOT NULL THEN 'Trained' ELSE 'Not Trained' END AS TrainingStatus,
    COUNT(DISTINCT employee.EmpIoyee_ID) AS Employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS ExitedEmployees,
    (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(DISTINCT employee.EmpIoyee_ID)) AS AttritionRate
FROM hr_db.employee
LEFT JOIN training  ON employee.EmpIoyee_ID = training.Employee_ID
JOIN attrition ON employee.EmpIoyee_ID = attrition.Employee_ID
GROUP BY TrainingStatus;

-- overtime vs Attrition
select OverTime,
       COUNT(*) AS employees,
       SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS ExitedEmployees,
       (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS AttritionRate
from hr_db.attrition
group by attrition.OverTime;

-- Average Tenure of Employee
SELECT ROUND(AVG(DATEDIFF(
    COALESCE(TerminationDate, CURDATE()), HireDate
) / 365.0), 2) AS AvgTenureYears
FROM hr_db.employee;

-- Attrition by Performnce Score
select `Performance Score`,
       COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS ExitedEmployees,
       (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS AttritionRate
FROM hr_db.employee
JOIN attrition  ON employee.EmpIoyee_ID = attrition.Employee_ID
GROUP BY `Performance Score`
ORDER BY AttritionRate DESC;







