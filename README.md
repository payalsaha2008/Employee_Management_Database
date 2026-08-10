\# Employee Management Database



\## 📌 Project Overview



This project is a PostgreSQL-based Employee Management Database designed to store, manage, and analyze employee information.



\## 🛠️ Technologies Used



\- PostgreSQL

\- SQL

\- pgAdmin 4



\## 📂 Database Tables



\### 1. Employees

Stores information about employees, including:

\- Employee ID

\- Employee Name

\- Age

\- Gender

\- Department

\- Job Title

\- Salary

\- Joining Date



\### 2. Departments

Stores:

\- Department ID

\- Department Name

\- Manager Name

\- Location



\## 🔗 Database Relationship



The `employees` table is connected to the `departments` table using a Foreign Key.



```text

employees.department\_id

&#x20;       ↓

departments.department\_id

