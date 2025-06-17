-- 1. Harflarni, raqamlarni va boshqa belgilarni ajratish
DECLARE @str VARCHAR(100) = 'tf56sd#%OqH';

WITH Numbers AS (
  SELECT TOP (LEN(@str)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
  FROM sys.all_objects
),
chars AS(
	SELECT SUBSTRING(@str,n,1)CHAR
	FROM Numbers
)
SELECT 
STRING_AGG(CASE WHEN ch LIKE['A-Z'] THEN ch END,'')AS Uppercase_Letters,
STRING_AGG(CASE WHEN ch LIKE['a-z'] THEN ch END,'')AS Lowercase_Letters,
STRING_AGG(CASE WHEN ch LIKE['0-9'] THEN ch END,'')AS Digits,
STRING_AGG(CASE WHEN ch LIKE['^a-zA-Z0-9'] THEN ch END,'')AS Other_Chars;

-- 2. Har bir qatordagi qiymatni avvalgilar bilan yig‘ish (nizomli yig‘indi)
SELECT StudentID, Score SUM(Score) OVER(ORDER BY StudentID ROWS UNBOUNDED PRECEDING) AS CumulativeScore
FROM Students;

-- 3. Matematik tenglamalarni yig'ish (Equations table)
-- Namuna "Equations" jadvalini yaratish
CREATE TABLE Equations (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Equation VARCHAR(255)
);

-- Namuna ma'lumotlarini kiritish
INSERT INTO Equations (Equation) VALUES
('10 + 5'),
('2 * 3 + 1'),
('100 / 2 - 15'),
('7 + 8 * 2 - 3'),
('(5 + 5) * 2');

-- Tenglamalarni hisoblash
DECLARE @sql_query NVARCHAR(MAX);
DECLARE @equation_value INT;
DECLARE @total_sum INT = 0;
DECLARE @id INT;
DECLARE @equation_string VARCHAR(255);

-- Cursor yordamida har bir tenglamani aylanib chiqish
DECLARE equation_cursor CURSOR FOR
SELECT ID, Equation FROM Equations;

OPEN equation_cursor;
FETCH NEXT FROM equation_cursor INTO @id, @equation_string;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Dinamik SQL so'rovini yaratish
    SET @sql_query = N'SELECT @result = ' + @equation_string;

    -- sp_executesql yordamida dinamik SQLni bajarish
    EXEC sp_executesql
        @sql_query,
        N'@result INT OUTPUT',
        @result = @equation_value OUTPUT;

    -- Har bir tenglama natijasini umumiy yig'indiga qo'shish
    SET @total_sum = @total_sum + @equation_value;

    PRINT 'ID: ' + CAST(@id AS VARCHAR(10)) + ', Equation: ' + @equation_string + ', Result: ' + CAST(@equation_value AS VARCHAR(10));

    FETCH NEXT FROM equation_cursor INTO @id, @equation_string;
END;

CLOSE equation_cursor;
DEALLOCATE equation_cursor;

-- Umumiy yig'indini chiqarish
SELECT @total_sum AS TotalSumOfEquations;

-- 4. Tug'ilgan kuni bir xil bo'lgan talabalar
SELECT s1.*
FROM Students s1
JOIN Students s2 ON s1.BirthDate = s2.BirthDate AND s1.StudentID <> s2.StudentID;

-- 5. O‘yinchi juftlari uchun yakuniy ballarni baho
SELECT 
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
  CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
  SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
  CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;

 -- 6. Toq raqamga MovieIdega filmlarni topish va "boring" bo'lmagan filmlarni chiqarish ( cinemajadvali misolida)

SELECT *
FROM cinema
WHERE id % 2 = 1           -- toq raqamli ID
  AND description != 'boring';

-- 7. Idbo'yicha tartiblash, lekin 0IDga ega bo'lgan qatorda bo'lishi kerak ( SingleOrder)

SELECT *
FROM SingleOrder
ORDER BY CASE WHEN id = 0 THEN 1 ELSE 0 END, id;

-- 8. Birinchi NULLbo'lmagan qiymatni olish (bir nechta ustunlar orasidan) — yordam COALESCE( personjadvali)

SELECT 
  COALESCE(column1, column2, column3, column4) AS first_non_null
FROM person;

-- 9. Ishga kirganiga 10 yildan ko'p, lekin 15 yildan kam bo'lgan ( Employees)

SELECT 
  EMPLOYEE_ID,
  FIRST_NAME,
  LAST_NAME,
  HIRE_DATE,
  DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Years_of_Service
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 11 AND 14;
