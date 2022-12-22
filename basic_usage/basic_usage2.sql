-- *******************************
-- SELECT 더 깊이 파보기
-- *******************************
-- 쿼리 안에 서브 쿼리

-- *******************************
-- 1. 비상관 서브쿼리
SELECT
  CategoryID, CategoryName, Description,
  (SELECT ProductName FROM Products WHERE ProductID = 1)
FROM Categories;

SELECT * FROM Products
WHERE Price < (
  SELECT AVG(Price) FROM Products
);

SELECT
  CategoryID, CategoryName, Description
FROM Categories
WHERE
  CategoryID =
  (SELECT CategoryID FROM Products
  WHERE ProductName = 'Chais');

SELECT
  CategoryID, CategoryName, Description
FROM Categories
WHERE
  CategoryID IN
  (SELECT CategoryID FROM Products
  WHERE Price > 50);

-- ALL 서브쿼리의 모든 결과에 대해 ~하다
-- ANY 서브쿼리의 하나 이상의 결과에 대해 ~하다

SELECT * FROM Products
WHERE Price > ALL (
  SELECT Price FROM Products
  WHERE CategoryID = 2
);

SELECT
  CategoryID, CategoryName, Description
FROM Categories
WHERE
  CategoryID = ANY
  (SELECT CategoryID FROM Products
  WHERE Price > 50);

-- *******************************
-- 2. 상관 서브쿼리
SELECT
  ProductID, ProductName,
  (
    SELECT CategoryName FROM Categories C
    WHERE C.CategoryID = P.CategoryID
  ) AS CategoryName
FROM Products P;

SELECT
  SupplierName, Country, City,
  (
    SELECT COUNT(*) FROM Customers C
    WHERE C.Country = S.Country
  ) AS CustomersInTheCountry,
  (
    SELECT COUNT(*) FROM Customers C
    WHERE C.Country = S.Country 
      AND C.City = S.City
  ) AS CustomersInTheCity
FROM Suppliers S;

SELECT
  CategoryID, CategoryName,
  (
    SELECT MAX(Price) FROM Products P
    WHERE P.CategoryID = C.CategoryID
  ) AS MaximumPrice,
  (
    SELECT AVG(Price) FROM Products P
    WHERE P.CategoryID = C.CategoryID
  ) AS AveragePrice
FROM Categories C;

SELECT
  ProductID, ProductName, CategoryID, Price
  -- ,(SELECT AVG(Price) FROM Products P2
  -- WHERE P2.CategoryID = P1.CategoryID)
FROM Products P1
WHERE Price < (
  SELECT AVG(Price) FROM Products P2
  WHERE P2.CategoryID = P1.CategoryID
);

-- EXISTS / NOT EXISTS 연산자
SELECT
  CategoryID, CategoryName
  -- ,(SELECT MAX(P.Price) FROM Products P
  -- WHERE P.CategoryID = C.CategoryID
  -- ) AS MaxPrice
FROM Categories C
WHERE EXISTS (
  SELECT * FROM Products P
  WHERE P.CategoryID = C.CategoryID
  AND P.Price > 80
);

-- *******************************
-- 3. JOIN(INNER JOIN) - 내부 조인
--양쪽 모두에 값이 있는 행(NOT NULL) 반환
--'INNER '는 선택사항
SELECT * FROM Categories C
JOIN Products P 
  ON C.CategoryID = P.CategoryID; 

SELECT C.CategoryID, C.CategoryName, P.ProductName
FROM Categories C
JOIN Products P 
  ON C.CategoryID = P.CategoryID; 
-- ambiguous 주의!

SELECT
  CONCAT(
    P.ProductName, ' by ', S.SupplierName
  ) AS Product,
  S.Phone, P.Price
FROM Products P
JOIN Suppliers S
  ON P.SupplierID = S.SupplierID
WHERE Price > 50
ORDER BY ProductName;

--💡 여러 테이블을 JOIN할 수 있습니다.
SELECT 
  C.CategoryID, C.CategoryName, 
  P.ProductName, 
  O.OrderDate,
  D.Quantity
FROM Categories C
JOIN Products P 
  ON C.CategoryID = P.CategoryID
JOIN OrderDetails D
  ON P.ProductID = D.ProductID
JOIN Orders O
  ON O.OrderID = D.OrderID;

--💡 JOIN한 테이블 GROUP하기
SELECT 
  C.CategoryName,
  MIN(O.OrderDate) AS FirstOrder,
  MAX(O.OrderDate) AS LastOrder,
  SUM(D.Quantity) AS TotalQuantity
FROM Categories C
JOIN Products P 
  ON C.CategoryID = P.CategoryID
JOIN OrderDetails D
  ON P.ProductID = D.ProductID
JOIN Orders O
  ON O.OrderID = D.OrderID
GROUP BY C.CategoryID;

SELECT 
  C.CategoryName, P.ProductName,
  MIN(O.OrderDate) AS FirstOrder,
  MAX(O.OrderDate) AS LastOrder,
  SUM(D.Quantity) AS TotalQuantity
FROM Categories C
JOIN Products P 
  ON C.CategoryID = P.CategoryID
JOIN OrderDetails D
  ON P.ProductID = D.ProductID
JOIN Orders O
  ON O.OrderID = D.OrderID
GROUP BY C.CategoryID, P.ProductID;


--💡 SELF JOIN - 같은 테이블끼리
SELECT
  E1.EmployeeID, CONCAT_WS(' ', E1.FirstName, E1.LastName) AS Employee,
  E2.EmployeeID, CONCAT_WS(' ', E2.FirstName, E2.LastName) AS NextEmployee
FROM Employees E1 JOIN Employees E2
ON E1.EmployeeID + 1 = E2.EmployeeID;

-- 1번의 전, 마지막 번호의 다음은?

-- *******************************
-- 4. LEFT/RIGHT OUTER JOIN - 외부 조인
-- 반대쪽에 데이터가 있든 없든(NULL), 선택된 방향에 있으면 출력 - 행 수 결정
-- 'OUTER '는 선택사항
SELECT
  E1.EmployeeID, CONCAT_WS(' ', E1.FirstName, E1.LastName) AS Employee,
  E2.EmployeeID, CONCAT_WS(' ', E2.FirstName, E2.LastName) AS NextEmployee
FROM Employees E1
LEFT JOIN Employees E2
ON E1.EmployeeID + 1 = E2.EmployeeID
ORDER BY E1.EmployeeID;

-- LEFT를 RIGHT로 바꿔서도 실행해 볼 것

SELECT
  C.CustomerName, S.SupplierName,
  C.City, C.Country
FROM Customers C
LEFT JOIN Suppliers S
ON C.City = S.City AND C.Country = S.Country;

-- LEFT를 RIGHT로 바꿔서도 실행해 볼 것

SELECT
  IFNULL(C.CustomerName, '-- NO CUSTOMER --'),
  IFNULL(S.SupplierName, '-- NO SUPPLIER --'),
  IFNULL(C.City, S.City),
  IFNULL(C.Country, S.Country)
FROM Customers C
LEFT JOIN Suppliers S
ON C.City = S.City AND C.Country = S.Country;

-- LEFT를 RIGHT로 바꿔서도 실행해 볼 것
