
-- 1. Write an SQL Statement to de-group the following data.
WITH DeGrouper AS (
    SELECT Product, Quantity, 1 AS N
    FROM Grouped
    UNION ALL
    SELECT Product, Quantity, N + 1
    FROM DeGrouper
    WHERE N < Quantity
)
SELECT Product, 1 AS Quantity
FROM DeGrouper
ORDER BY Product;

-- 2. You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, provide a zero-dollar value for that day. Assume there is at least one sale for each region
SELECT
    DISTINCT r.Region,
    d.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM
    (SELECT DISTINCT Region FROM #RegionSales) AS r
CROSS JOIN
    (SELECT DISTINCT Distributor FROM #RegionSales) AS d
LEFT JOIN
    #RegionSales AS rs ON r.Region = rs.Region AND d.Distributor = rs.Distributor
ORDER BY
    d.Distributor, r.Region;

-- 3. Find managers with at least five direct reports
SELECT E.name
FROM Employee E
JOIN Employee M ON E.id = M.managerId
GROUP BY E.id, E.name
HAVING COUNT(M.id) >= 5;

-- 4. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
SELECT
    P.product_name,
    SUM(O.unit) AS unit
FROM
    Products P
JOIN
    Orders O ON P.product_id = O.product_id
WHERE
    O.order_date >= '2020-02-01' AND O.order_date < '2020-03-01'
GROUP BY
    P.product_name
HAVING
    SUM(O.unit) >= 100;

-- 5. Write an SQL statement that returns the vendor from which each customer has placed the most orders
WITH CustomerVendorOrderCount AS (
    SELECT
        CustomerID,
        Vendor,
        COUNT(OrderID) AS OrderCount,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY COUNT(OrderID) DESC) AS rn
    FROM
        Orders
    GROUP BY
        CustomerID, Vendor
)
SELECT
    CustomerID,
    Vendor
FROM
    CustomerVendorOrderCount
WHERE
    rn = 1;

-- 6. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'
DECLARE @Check_Prime INT = 91;
DECLARE @IsPrime BIT = 1;
IF @Check_Prime <= 1
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    DECLARE @i INT = 2;
    WHILE @i * @i <= @Check_Prime
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END;
END;
SELECT CASE WHEN @IsPrime = 1 THEN 'This number is prime' ELSE 'This number is not prime' END AS Result;

-- 7. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.
WITH LocationCounts AS (
    SELECT
        Device_id,
        Locations,
        COUNT(*) AS SignalCount,
        ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY COUNT(*) DESC) AS rn
    FROM
        Device
    GROUP BY
        Device_id, Locations
)
SELECT
    d.Device_id,
    COUNT(DISTINCT d.Locations) AS no_of_location,
    MAX(CASE WHEN lc.rn = 1 THEN lc.Locations ELSE NULL END) AS max_signal_location,
    COUNT(*) AS no_of_signals
FROM
    Device d
JOIN
    LocationCounts lc ON d.Device_id = lc.Device_id
GROUP BY
    d.Device_id
ORDER BY d.Device_id;


-- 8. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output
SELECT
    e.EmpID,
    e.EmpName,
    e.Salary
FROM
    Employee e
JOIN (
    SELECT
        DeptID,
        AVG(Salary) AS AvgDeptSalary
    FROM
        Employee
    GROUP BY
        DeptID
) AS DeptAvg ON e.DeptID = DeptAvg.DeptID
WHERE
    e.Salary > DeptAvg.AvgDeptSalary;

WITH TicketMatches AS (
    SELECT
        T.TicketID,
        COUNT(DISTINCT T.Number) AS MatchedNumbers
    FROM
        Tickets T
    INNER JOIN
        WinningNumbers W ON T.Number = W.Number
    GROUP BY
        T.TicketID
),
TotalWinningNumbers AS (
    SELECT COUNT(DISTINCT Number) AS CountWinningNumbers
    FROM WinningNumbers
)
SELECT
    SUM(CASE
        WHEN TM.MatchedNumbers = TWN.CountWinningNumbers THEN 100 
        WHEN TM.MatchedNumbers > 0 AND TM.MatchedNumbers < TWN.CountWinningNumbers THEN 10
        ELSE 0
    END) AS TotalWinnings
FROM
    TicketMatches TM
CROSS JOIN
    TotalWinningNumbers TWN;

-- 10. Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.
WITH DailyPlatformUsers AS (
    SELECT
        Spend_date,
        User_id,
        MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS IsMobile,
        MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS IsDesktop,
        SUM(Amount) AS TotalAmountPerUser
    FROM
        Spending
    GROUP BY
        Spend_date, User_id
),
CategorizedSpending AS (
    SELECT
        Spend_date,
        CASE
            WHEN IsMobile = 1 AND IsDesktop = 0 THEN 'Mobile'
            WHEN IsMobile = 0 AND IsDesktop = 1 THEN 'Desktop'
            WHEN IsMobile = 1 AND IsDesktop = 1 THEN 'Both'
            ELSE 'Unknown' -- Should not happen with given data
        END AS PlatformCategory,
        User_id,
        TotalAmountPerUser
    FROM
        DailyPlatformUsers
)
SELECT
    Spend_date,
    PlatformCategory AS Platform,
    SUM(TotalAmountPerUser) AS Total_Amount,
    COUNT(DISTINCT User_id) AS Total_users
FROM
    CategorizedSpending
GROUP BY
    Spend_date, PlatformCategory
UNION ALL
SELECT
    Spend_date,
    'Both' AS Platform,
    SUM(TotalAmountPerUser) AS Total_Amount,
    COUNT(DISTINCT User_id) AS Total_users
FROM
    DailyPlatformUsers
WHERE
    IsMobile = 1 AND IsDesktop = 1
GROUP BY Spend_date;
