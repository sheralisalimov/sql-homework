CREATE TABLE InputTbl ( col1 VARCHAR(10), col2 VARCHAR(10));
INSERT INTO InputTbl (col1, col2) 
VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');

-- 1 usul
SELECT * 
FROM TestMultipleZero
WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0);
--2 usul
SELECT * 
FROM TestMultipleZero
WHERE A + B + C + D > 0;
);

-- 2 Barcha nollar bilan qatorlarni olib tashlash
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);
INSERT INTO TestMultipleZero(A,B,C,D)VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

SELECT * FROM TestMultipleZero
WHERE A IS NOT NULL OR B IS NOT NULL OR C IS NOT NULL OR D IS NOT NULL;


-- 3 G'alati identifikatorlilarni toping
create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro');

SELECT * FROM section1
WHERE id % 2 = 1;

-- 4 eng kichik identifikatorga ega odam 
SELECT name FROM section1
WHERE id = (SELECT MIN(id) FROM section1);

-- 5 eng yuqori identifikatorga ega shaxs 
SELECT name FROM section1
WHERE id = (SELECT MAX(id) FROM section1);

-- 6 Ismi b harfidan boshlanadigan odamlar 
SELECT * FROM section1
WHERE name LIKE 'B%';

-- Jumboq 7: Kodda faqat pastki chiziq _ bo'lgan satrlarni qaytarish uchun so'rov yozing (joker belgi sifatida emas).
CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);
INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

SELECT *FROM ProductCodes
WHERE Code LIKE 'X\_%' ESCAPE '\';

