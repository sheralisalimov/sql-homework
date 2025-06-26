-- homework 14
--1. Butun son va belgilar qiymatlarini ikki xil ustunga ajratish uchun SQL so‘rovini yozing.(SeperateNumbersAndCharcters)
DECLARE @str VARCHAR(100) = 'tf56sd#%OqH';

WITH Numbers AS (
  SELECT TOP (LEN(@str)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
  FROM sys.all_objects
),
Chars AS (
  SELECT SUBSTRING(@str, n, 1) AS ch
  FROM Numbers
)
SELECT
  STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch END, '') AS Uppercase_Letters,
  STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch END, '') AS Lowercase_Letters,
  STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch END, '') AS Digits,
  STRING_AGG(CASE WHEN ch LIKE '[^a-zA-Z0-9]' THEN ch END, '') AS Other_Chars;

--2 Oldingi (kechagi) sanalarga nisbatan yuqori haroratli barcha sanalarning identifikatorlarini topish uchun SQL soʻrovini yozing.(ob-havo)

SELECT w1.id
FROM Weather w1
JOIN Weather w2 ON DATEDIFF(day, w2.recordDate, w1.recordDate) = 1
WHERE w1.temperature > w2.temperature;

--3 Har bir oʻyinchi uchun birinchi kirgan qurilma haqida xabar beruvchi SQL soʻrovini yozing.(Faoliyat)

WITH FirstLogin AS (
  SELECT
    player_id,
    MIN(event_date) AS first_date
  FROM Activity
  GROUP BY player_id
)
SELECT
  f.player_id,
  a.device_id
FROM FirstLogin f
JOIN Activity a ON a.player_id = f.player_id AND a.event_date = f.first_date;

--4. Har bir oʻyinchi uchun birinchi kirish sanasi haqida xabar beruvchi SQL soʻrovini yozing.(Faoliyat)

WITH RankedActivity AS (
  SELECT player_id,event_date, ROW_NUMBER() OVER 
  (PARTITION BY player_id
  ORDER BY event_date) AS rn
  FROM Activity
)
SELECT 
  player_id,
  event_date AS first_login
FROM RankedActivity
WHERE rn = 1;

--5  Har bir o‘yinchi (player_id) uchun, avvalgi (eng birinchi) login sanalarini toping.

SELECT 
  player_id,
  MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

--6 Jadvalni yaratish uchun SQL so'rovini yozing, unda satrdagi har bir belgi bir qatorga aylantiriladi, har bir satr bitta ustunga ega.(sdgfhsdgfhs@121313131)

DECLARE @str varchar(100) = 'sdgfhsdgfhs@121313131';

WITH Numbers AS (
  SELECT TOP (LEN(@str))
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
  FROM sys.all_objects
),
Chars AS (
  SELECT n, SUBSTRING(@str, n, 1) AS ch
  FROM Numbers
)
SELECT ch AS Character
FROM Chars
ORDER BY n;

--7 Sizga ikkita jadval beriladi: p1 va p2. Ushbu jadvallarni id ustuniga qo'shing. Qachonki, p1.code qiymati 0 bo'lsa, uni p2.code qiymati bilan almashtiring.(p1,p2)

SELECT p1.id,
  CASE  WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS final_code
FROM p1
LEFT JOIN p2
  ON p1.id = p2.id;

--8 Sizga savdo jadvali beriladi. Har bir moliyaviy hafta uchun hududga to'g'ri keladigan savdoning haftalik ulushini hisoblang. Har bir hafta uchun jami savdolar 100% ko'rib chiqiladi va haftaning har bir kuni uchun foizli sotuvlar o'sha haftadagi hudud savdosi asosida hisoblanishi kerak.(WeekPercentagePuzzle)

SELECT 
  s2.item_id,
  s2.date_sale,
  SUM(s2.items) AS total_items,
  (SELECT SUM(s.items)
   FROM sales s
   WHERE s.item_id = s2.item_id
     AND DATEPART(wk, s.date_sale) = DATEPART(wk, s2.date_sale)
   GROUP BY s.item_id, DATEPART(wk, s.date_sale)
  ) AS total_week,
  SUM(s2.items) * 100.0 
    / (SELECT SUM(s.items)
       FROM sales s
       WHERE s.item_id = s2.item_id
         AND DATEPART(wk, s.date_sale) = DATEPART(wk, s2.date_sale)
       GROUP BY s.item_id, DATEPART(wk, s.date_sale)
      ) AS percentage
FROM sales s2
GROUP BY s2.item_id, s2.date_sale;

--3. Bu boshqotirmada siz nuqta (.) ga asoslangan satrni bo'lishingiz kerak bo'ladi.(Splitter)

DECLARE @myString VARCHAR(255) = 'www.example.com.uz';
SELECT VALUE AS Segment
FROM STRING_SPLIT(@myString,'.');

--4. Satrdagi barcha butun sonlarni (raqamlarni) “X” bilan almashtirish uchun SQL so‘rovini yozing.(1234ABC123456XYZ1234567890ADS)

DECLARE @inputString VARCHAR(255) = '1234ABC123456XYZ1234567890ADS';
DECLARE @outputString VARCHAR(255) = @inputString;
DECLARE @digit INT = 0;

WHILE @digit <=9
BEGIN
     SET @outputString = REPLACE(@outputString, CAST(@digit AS VARCHAR(1)),'X');
     SET @digit = @digit +1;
END;

SELECT @inputString AS OriginalString, @outputString AS ReplacedString;

--5. Vals ustunidagi qiymat ikki nuqtadan (.) ortiq bo'lgan barcha satrlarni qaytarish uchun SQL so'rovini yozing.(testDots)

SELECT ID, vals 
FROM testDots
WHERE (LEN(Vals) - LEN(REPLACE(Vals,'.','')))>2;
     
--6. Berilgan ustundagi satr ichidagi pastki satrning takrorlanishini hisoblash uchun SQL so'rovini yozing.(Jadval emas)

DECLARE @mainString VARCHAR(255) = 'Bugun ob-havo ochiq, va juda ham ajoyib ob-havo.';
DECLARE @subString VARCHAR(50) = 'ob-havo';

SELECT (LEN(@mainString) - LEN(REPLACE(@mainString, @subString, '')))/LEN(@subString) AS OccurrencesCount;

--7. Satrdagi bo'shliqlarni hisoblash uchun SQL so'rovini yozing.(CountSpaces)

DECLARE @myString VARCHAR(255) = 'Bu bir sinov matni, unda bo''shliqlar bor.';

SELECT
    LEN(@myString) - LEN(REPLACE(@myString, ' ', '')) AS SpaceCount;

--8. menejerlaridan ko'proq maosh oladigan xodimlarni aniqlaydigan SQL so'rovini yozing.(Xodim)
SELECT E.FIRST_NAME + ' ' + E.LAST_NAME AS EmployeeName,  
       E.SALARY AS EmployeeSalary,                        
       M.FIRST_NAME + ' ' + M.LAST_NAME AS ManagerName,   
       M.SALARY AS ManagerSalary                          
FROM Employees E
INNER JOIN Employees M ON E.MANAGER_ID = M.EMPLOYEE_ID 
WHERE E.SALARY > M.SALARY; -- Xodimning maoshi menejerining maoshidan ko'p bo'lsa

--Qiyin vazifalarIzoh qo'shish Qo'shimcha harakatlar
--1. Bu boshqotirmada siz vergul bilan ajratilgan satrning birinchi ikki harfini almashtirishingiz kerak.(MultipleVals)
SELECT 
  STRING_AGG(
    STUFF(val, 1, 2, SUBSTRING(val, 2, 1) + SUBSTRING(val, 1, 1)),
    ','
  ) AS SwappedString
FROM STRING_SPLIT('AB,CD,EF', ',') AS t(val);

--2. Barcha belgilar bir xil va uzunligi 1 dan katta bo‘lgan qatorni toping.(FindSameCharacters)
SELECT *
FROM FindSameCharacters
WHERE Vals IS NOT NULL
  AND LEN(Vals) > 1
  AND REPLACE(Vals, SUBSTRING(Vals, 1, 1), '') = '';

--3. Satr ustunida mavjud ikki nusxadagi butun son qiymatlarini olib tashlash uchun T-SQL so'rovini yozing. Bundan tashqari, satrda paydo bo'ladigan bitta butun son belgisini olib tashlang.(RemoveDuplicateIntsFromNames)
WITH parts AS (
  SELECT
    PawanName,
    value AS part
  FROM RemoveDuplicateIntsFromNames
  CROSS APPLY STRING_SPLIT(Pawan_slug_name, '-') 
),
counts AS (
  SELECT
    PawanName,
    part,
    COUNT(*) AS cnt
  FROM parts
  GROUP BY PawanName, part
  HAVING COUNT(*) > 1
)
SELECT DISTINCT r.PawanName,
  STRING_AGG(c.part, '-') AS NewSlug
FROM counts AS c
JOIN RemoveDuplicateIntsFromNames AS r ON c.PawanName = r.PawanName
GROUP BY r.PawanName;

--4. Barcha belgilar bir xil va uzunligi 1 dan katta bo‘lgan qatorni toping.(FindSameCharacters)
SELECT *
FROM FindSameCharacters
WHERE Vals IS NOT NULL
  AND LEN(Vals) > 1
  AND REPLACE(Vals, SUBSTRING(Vals, 1, 1), '') = '';

  
--5. Vals.(GetIntegers) nomli ustunda satr boshida paydo bo'ladigan butun son qiymatini chiqarish uchun SQL so'rovini yozing.
SELECT
  Vals AS Original,
  CASE
    WHEN PATINDEX('%[^0-9]%', Vals) = 0 THEN CAST(Vals AS INT)
    ELSE CAST(SUBSTRING(Vals, 1, PATINDEX('%[^0-9]%', Vals)-1) AS INT)
  END AS LeadingInteger
FROM GetIntegers;
