# HR Analytics Dashboard

*Excel • SQL • Power BI*

**Author:** Pooja Jadhav
**Project:** HR Analytics — End-to-End Analysis

---

## 📌 Project Overview

This repository contains an end-to-end **HR Analytics Project** where raw employee data was cleaned in **Excel**, analyzed with **SQL**, and visualized in **Power BI** through an interactive dashboard.

The main objective is to identify attrition drivers, track employee performance, evaluate salary and training effectiveness, and provide actionable insights for HR decision-making.

---

## 📂 Dataset Description

The project uses four datasets (CSV files):

* **Employee.csv** → Employee details 
* **Attrition.csv** → Attrition-related details
* **Salary.csv** → Compensation details 
* **Training.csv** → Training data

---

## 🛠 Process & Tools Used

1. **Excel (Data Cleaning)**

   * Removed blanks and duplicates
   * Standardized categorical values (e.g., Department names)
   * Fixed date columns 
   * Exported cleaned CSVs for SQL loading

2. **SQL (Data Management & Analysis)**

   * Imported cleaned CSV files into SQL database (`hr_db`)
   * Created tables 
   * Wrote queries to calculate attrition rate, Training Participation Vs Attrition,etc

3. **Power BI (Dashboard & Visualization)**

   * Connected SQL tables
   * Built relationships between Employee, Attrition, Salary, Training
   * Created **DAX measures** for KPIs (Attrition Rate, Avg Salary, Avg Tenure)
   * Designed an interactive HR Dashboard

---

## 📑 SQL Queries (Examples)

**1. Total Employees**

```sql
select count(*) as TotalEmployees from hr_db.employee;
```

**2. Attrition Rate**

```sql
select (count(case when Attrition = 'Yes' THEN 1 END)*100.0) / count(*) as AttritionRate from hr_db.attrition;
```

**3. Attrition by Department**

```sql
select DepartmentType, COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS ExitedEmployees,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS AttritionRate
from hr_db.employee
join attrition ON employee.EmpIoyee_ID = attrition.Employee_ID
GROUP BY DepartmentType
ORDER BY AttritionRate desc
LIMIT 0, 10000;
```

---

## 📊 Power BI Dashboard Features

**KPIs**

* Total Employees
* Attrition Count
* Attrition Rate (%)
* Average Salary
* Average Tenure

**Charts **

* Employee Count by Department
* Attrition by Department
* Attrition by Gender
* Salary Distribution
* Training Hours vs Attrition
* Attrition Trend over Time
* Performance Score by Department

---

## 🔑 Key Insights

* Departments with the highest attrition rate need targeted retention policies.
* Overtime strongly correlates with higher attrition.
* Employees with low training hours show higher exit rates.
* Certain salary ranges have higher attrition compared to others.

---

