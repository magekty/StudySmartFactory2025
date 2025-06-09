-- 1. 데이터베이스 생성 (필요하다면)
CREATE DATABASE IF NOT EXISTS smart_factory_erp;

-- 2. 데이터베이스 선택
USE smart_factory_erp;

-- 3. 사원 정보 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_employees (
    EmployeeID INT PRIMARY KEY,              -- 사번 (이미지상 '사번' 컬럼이 문자열 형태일 수 있으나, 검색/관리 용이성을 위해 INT로 가정)
    EmployeeName VARCHAR(100) NOT NULL,      -- 사원명
    Department VARCHAR(100),                 -- 부서 (예: 총무팀, 생산1팀)
    WorkDepartment VARCHAR(100),             -- 근무부서 (예: 생산1팀, 생산2팀) - 부서와 다를 수 있음
    Position VARCHAR(50),                    -- 직위 (예: 대리, 사원)
    JobRank VARCHAR(50),                     -- 직급 (예: 2급)
    AppointmentDate DATE,                    -- 발령일 (입사일 또는 최종 발령일)
    Status VARCHAR(20),                      -- 재직/퇴직구분 (재직자, 퇴직자)
    EmployeeType VARCHAR(50),                -- 사원구분 (상임, 비상임, 계약직상임, 계약직비상임)
    AddressType VARCHAR(50),                 -- 주소지 종류 (본적, 주민등록상거주지, 실거주지, 근무지 주소)
    PhoneNumber VARCHAR(20),                 -- 전화번호
    RoadAddress VARCHAR(255),                -- 도로명주소
    JibunAddress VARCHAR(255),               -- 지번주소
    Email VARCHAR(100)                       -- 이메일 (이미지에 있음)
    -- 추가적으로 필요한 컬럼들을 여기에 추가할 수 있습니다.
    -- 예: BirthDate DATE, Gender VARCHAR(10), HireDate DATE 등
);

-- 4. 테스트를 위한 샘플 데이터 삽입
INSERT INTO tbl_employees (EmployeeID, EmployeeName, Department, WorkDepartment, Position, JobRank, AppointmentDate, Status, EmployeeType, AddressType, PhoneNumber, RoadAddress, JibunAddress, Email) VALUES
(20080807, '강봉무', '총무팀', '총무팀', '대리', '', '2016-03-01', '재직자', '상임', '주민등록상거주지', '010-1234-5678', '서울시 강남구 테헤란로 123', '서울시 강남구 역삼동 123-1', 'kbmoo@example.com'),
(20111235, '고생산', '생산1팀', '생산1팀', '사원', '', '2011-12-12', '재직자', '상임', '실거주지', '010-2345-6789', '부산시 해운대구 센텀중앙로 45', '부산시 해운대구 우동 456-2', 'gsaengsan@example.com'),
(20160302, '공생산', '생산1부', '생산1부', '상무', '', '2016-03-03', '재직자', '상임', '주민등록상거주지', '010-3456-7890', '대구시 달서구 성서로 789', '대구시 달서구 이곡동 789-3', 'gsaengsan2@example.com'),
(20141101, '곽영업', '영업1팀', '영업1팀', '대리', '', '2014-11-24', '재직자', '상임', '근무지 주소', '010-4567-8901', '인천시 연수구 송도과학로 100', '인천시 연수구 송도동 100-4', 'gyoungup@example.com'),
(20150604, '구생산', '생산2팀', '생산2팀', '사원', '', '2015-06-09', '재직자', '상임', '실거주지', '010-5678-9012', '광주시 서구 상무대로 200', '광주시 서구 치평동 200-5', 'gsaengsan3@example.com'),
(20110524, '권생산', '생산1팀', '생산1팀', '사원', '', '2011-05-02', '재직자', '상임', '주민등록상거주지', '010-6789-0123', '대전시 유성구 대학로 300', '대전시 유성구 궁동 300-6', 'gwon@example.com'),
(20120646, '기생산', '생산3팀', '생산3팀', '사원', '', '2016-03-01', '재직자', '상임', '본적', '010-7890-1234', '울산시 남구 삼산로 400', '울산시 남구 삼산동 400-7', 'gisaengsan@example.com'),
(20160301, '김영업', '영업2팀_PC유통', '영업2팀_PC유통', '과장', '2급', '2016-03-02', '재직자', '상임', '주민등록상거주지', '010-8901-2345', '경기도 성남시 분당구 판교역로 500', '경기도 성남시 분당구 삼평동 500-8', 'kyoungup@example.com'),
(20071001, '김대표', '대표이사', '대표이사', '대표이사', '2급', '2007-10-01', '재직자', '상임', '실거주지', '010-9012-3456', '서울시 강남구 테헤란로 10', '서울시 강남구 역삼동 10-9', 'kceo@example.com'),
(20150703, '나업무', '영업1팀', '영업1팀', '과장', '', '2015-07-08', '재직자', '상임', '근무지 주소', '010-0123-4567', '부산시 동래구 중앙대로 600', '부산시 동래구 온천동 600-10', 'naumoo@example.com'),
(20130302, '남생산', '생산3팀', '생산3팀', '사원', '', '2013-03-05', '재직자', '상임', '주민등록상거주지', '010-1122-3344', '대구시 북구 동성로 700', '대구시 북구 침산동 700-11', 'nsaengsan@example.com');

USE smart_factory_erp;
select * from tbl_employees where EmployeeName = '김태영';
-- 컬럼 추가 (필요 시 주석 해제 후 실행)
ALTER TABLE tbl_employees
ADD COLUMN Gender VARCHAR(10),            -- 성별 (예: 남, 여)
ADD COLUMN BirthDate DATE,               -- 생년월일
ADD COLUMN MaritalStatus VARCHAR(20),    -- 혼인 여부 (예: 미혼, 기혼)
ADD COLUMN Nationality VARCHAR(50),      -- 국적
ADD COLUMN HireDate DATE;                -- 입사일 (AppointmentDate와 다르게 초기 입사일)

-- 인덱스 추가 (조회 성능 향상용)
CREATE INDEX idx_employee_name ON tbl_employees (EmployeeName);
CREATE INDEX idx_department ON tbl_employees (Department);
Select * from smart_factory_erp.tbl_employees;

-- Java 연동
create table users (
user_id INT PRIMARY KEY auto_increment,              -- 사번 (이미지상 '사번' 컬럼이 문자열 형태일 수 있으나, 검색/관리 용이성을 위해 INT로 가정)
username VARCHAR(100) unique NOT NULL,   
password VARCHAR(100) not null,
email varchar(100)
);
drop table users;
insert into users (username, password, email) values(
'abc','1234','ma@hanmail.net'
);
SELECT * FROM smart_factory_erp.users;