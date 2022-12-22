-- *******************************
-- SELECT 더 깊이 파보기
-- *******************************

-- 쿼리 안에 서브 쿼리

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

