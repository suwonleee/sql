-- 프로그램 데이터/ 실행 하는 곳  https://www.w3schools.com/mysql/trymysql.asp?filename=trysql_select_all

-- *******************************
-- SELECT - 내가 원하는 정보 가져오기
-- *******************************

-- 1. 테이블의 모든 내용 보기
SELECT * FROM Customers;

-- 2. 원하는 column(열)만 골라서 보기
SELECT CustomerName FROM Customers;
SELECT CustomerName, ContactName, Country FROM Customers;

-- 테이블의 컬럼이 아닌 값도 선택할 수 있다.
SELECT
  CustomerName, 1, 'Hello', NULL
FROM Customers;

-- 3. 원하는 조건의 row(행)만 걸러서 보기
SELECT * FROM Orders
WHERE EmployeeID = 3;

SELECT * FROM OrderDetails 
WHERE Quantity < 5;


-- 4. 원하는 순서로 데이터 가져오기
SELECT * FROM Customers
ORDER BY ContactName;

SELECT * FROM OrderDetails
ORDER BY ProductID ASC, Quantity DESC;

-- 5. 원하는 만큼만 데이터 가져오기
SELECT * FROM Customers
LIMIT 10;

SELECT * FROM Customers
LIMIT 0, 10;

SELECT * FROM Customers
LIMIT 30, 10;

-- 6. 원하는 별명(alias)으로 데이터 가져오기
SELECT
  CustomerId AS ID,
  CustomerName AS NAME,
  Address AS ADDR
FROM Customers;

SELECT
  CustomerId AS '아이디',
  CustomerName AS '고객명',
  Address AS '주소'
FROM Customers;

-- 모두 활용
SELECT
  CustomerID AS '아이디',
  CustomerName AS '고객명',
  City AS '도시',
  Country AS '국가'
FROM Customers
WHERE
  City = 'London' OR Country = 'Mexico'
ORDER BY CustomerName
LIMIT 0, 5;


-- 7. 사칙연산
SELECT 1 + 2;
SELECT 5 - 2.5 AS DIFFERENCE;
SELECT 3 * (2 + 4) / 2, 'Hello';
SELECT 10 % 3;
-- 문자열에 사칙연산을 가하면 0으로 인식
SELECT 'ABC' + 3;
SELECT 'ABC' * 3;
SELECT '1' + '002' * 3;

SELECT
  OrderID + ProductID
FROM OrderDetails;

SELECT
  ProductName,
  Price / 2 AS HalfPrice
FROM Products;

-- 8. 참/거짓 관련 연산자
SELECT TRUE, FALSE;
SELECT !TRUE, NOT 1, !FALSE, NOT FALSE;
SELECT 0 = TRUE, 1 = TRUE, 0 = FALSE, 1 = FALSE;
SELECT * FROM Customers WHERE TRUE;
SELECT * FROM Customers WHERE FALSE;

-- IS / IS NOT
SELECT TRUE IS TRUE;
SELECT TRUE IS NOT FALSE;
SELECT (TRUE IS FALSE) IS NOT TRUE;

-- AND && / OR ||
SELECT TRUE AND FALSE, TRUE OR FALSE;
SELECT 2 + 3 = 6 OR 2 * 3 = 6;

SELECT * FROM Orders
WHERE
  CustomerId = 15 AND EmployeeId = 4;

SELECT * FROM Products 
WHERE
  ProductName = 'Tofu' OR CategoryId = 8;

SELECT * FROM OrderDetails
WHERE
  ProductId = 20
  AND (OrderId = 10514 OR Quantity = 50);

-- = != <> <,> , >=, <=
SELECT 1 = 1, !(1 <> 1), NOT (1 < 2), 1 > 0 IS NOT FALSE;
SELECT 'A' = 'A', 'A' != 'B', 'A' < 'B', 'A' > 'B';
SELECT 'Apple' > 'Banana' OR 1 < 2 IS TRUE;

--기본 사칙연산자는 대소문자 구분 안함
SELECT 'A' = 'a';

SELECT
  ProductName, Price,
  Price > 20 AS EXPENSIVE 
FROM Products;

SELECT
  ProductName, Price,
  NOT Price > 20 AS CHEAP 
FROM Products;

--Between A AND B
SELECT 5 BETWEEN 1 AND 10;
SELECT 'banana' NOT BETWEEN 'Apple' AND 'camera';

SELECT * FROM OrderDetails
WHERE ProductID BETWEEN 1 AND 4;

SELECT * FROM Customers
WHERE CustomerName BETWEEN 'b' AND 'c';


-- IN / NOT IN
SELECT 1 + 2 IN (2, 3, 4) 
SELECT 'Hello' IN (1, TRUE, 'hello') 

SELECT * FROM Customers
WHERE City IN ('Torino', 'Paris', 'Portland', 'Madrid') 

--LIKE
SELECT
  'HELLO' LIKE 'hel%',
  'HELLO' LIKE 'H%',
  'HELLO' LIKE 'H%O',
  'HELLO' LIKE '%O',
  'HELLO' LIKE '%HELLO%',
  'HELLO' LIKE '%H',
  'HELLO' LIKE 'L%'

SELECT
  'HELLO' LIKE 'HEL__',
  'HELLO' LIKE 'h___O',
  'HELLO' LIKE 'HE_LO',
  'HELLO' LIKE '_____',
  'HELLO' LIKE '_HELLO',
  'HELLO' LIKE 'HEL_',
  'HELLO' LIKE 'H_O'

SELECT * FROM Employees
WHERE Notes LIKE '%economics%'

SELECT * FROM OrderDetails
WHERE OrderID LIKE '1025_'


-- 숫자로 구성된 문자열은 숫자로 자동인식
-- *******************************
-- 각종 연산자들