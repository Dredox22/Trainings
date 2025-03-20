-- Задача 1: 
-- Найти вторую по величине зарплату

--  Таблица Employee
CREATE TABLE Employee (
    Id INT PRIMARY KEY,
    Salary INT
);

INSERT INTO Employee (Id, Salary) VALUES
(1, 1000),
(2, 2000),
(3, 3000);

-- Требуется:
-- Написать SQL-запрос, который вернет вторую по величине зарплату (SecondHighestSalary).
-- Если такой зарплаты нет, вернуть NULL.

--  Ожидаемый результат:
-- SecondHighestSalary
-- 2000

-- Решнеие 1:

SELECT DISTINCT Salary as SecondHighestSalary
FROM Employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;

-- Решнеие 2:

SELECT MAX(Salary) as SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee);

-- Решнеие 3:

SELECT Salary as SecondHighestSalary
FROM (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) as rnk
    FROM Employee
) ranked
WHERE rnk = 2;

-- Решнеие 4:

SELECT Coalesce(
    (SELECT DISTINCT Salary
    FROM Employee
    ORDER BY Salary DESC
    LIMIT 1 OFFSET 1),
    NULL
) as SecondHighestSalary;

---

-- Задача 2:
-- Найти сотрудников, у которых зарплата выше, чем у их менеджеров

--  Таблица Employee

CREATE TABLE Employee (
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
    Salary INT,
    ManagerId INT
);

INSERT INTO Employee (Id, Name, Salary, ManagerId) VALUES
(1, 'John', 1000, NULL),
(2, 'Sally', 2000, 1),
(3, 'Mark', 3000, 1),
(4, 'Pam', 4000, 2),
(5, 'Alex', 5000, 2);

-- Требуется:

-- Написать SQL-запрос, который вернет имена сотрудников, у которых зарплата выше, чем у их менеджеров.

--  Ожидаемый результат:

-- Employee

-- Sally

-- Alex

-- Решение:

