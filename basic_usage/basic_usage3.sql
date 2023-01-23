-- *******************************
-- 데이터 조작하기
-- *******************************
-- 쿼리 안에 서브 쿼리

-- *******************************
-- 1. 테이블 생성/수정/삭제
-- * CREATE TABLE - 테이블 만들기
CREATE TABLE people (
  person_id INT,
  person_name VARCHAR(10),
  age TINYINT,
  birthday DATE
);

-- * ALTER TABLE - 테이블 변경
-- 테이블명 변경
ALTER TABLE people RENAME TO  friends,
-- 컬럼 자료형 변경
CHANGE COLUMN person_id person_id TINYINT,
-- 컬럼명 변경
CHANGE COLUMN person_name person_nickname VARCHAR(10), 
-- 컬럼 삭제
DROP COLUMN birthday,
-- 컬럼 추가
ADD COLUMN is_married TINYINT AFTER age;

-- *DROP TABLE - 테이블 삭제
DROP TABLE friends;