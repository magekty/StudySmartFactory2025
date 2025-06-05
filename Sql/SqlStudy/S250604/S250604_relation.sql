-- 1:1 (일대일)
-- 사용자(users) <-> 사용자 프로필(user _profiles)
-- 사용자(users): 회원 가입 정보(계정들)
-- 사용자 프로필(user_profiles): 프로필 사진, 자기소개 글 개인 정보 페이지
create table users(
user_id int primary key auto_increment,
username varchar(50) not null unique, 	# 회원 가입시 ID
user_password varchar(50) not null,
email varchar(50),
address varchar(50)
);
create table users_profiles(
user_id int primary key auto_increment,
self_intro Text,
user_profile_pic varchar(50),
foreign key(user_id) references users(user_id)

);
-- 주민(citizens) <-> 주민 등록증(id_cards)
create table citizens(
citizen_id int primary key auto_increment
);
create table id_cards(
id_cards_id int primary key auto_increment,
citizen_id int not null,
foreign key(citizen_id) references citizens(citizen_id)
);
-- 직원(employees) <-> 사무실 의자(office_seats)
create table students(
student_id int primary key auto_increment,
name varchar(100),
classname varchar(100)
);
create table office_seats(
office_seat_id int primary key auto_increment,
student_id int unique,
seat_number varchar(20) unique,
floor int,
foreign key (student_id) references students(student_id)
);
-- 소유자(owners) <> 개인컴퓨터(pcs)
create table owners(
owner_id int primary key auto_increment,
name varchar(100)
);
create table pcs(
pc_id int primary key auto_increment,
owner_id int unique,
pc_name varchar(50),
foreign key (owner_id) references owners(owner_id)
);
-- 1:N (일대다) A갑 B(여러개) 갖는다, B는 A하나에 속한다.
-- 고객이 복수의 주문을 갖는다. 상품은 한 명의 주문자를 갖는다.
create table customers(
customer_id int primary key auto_increment,
name varchar(100),
email varchar(100)
);
create table orders(
order_id int primary key auto_increment,
customer_id int unique not null,
order_date date,
total_amount int,
foreign key (customer_id) references customer(customer_id)
);
-- 게시글 하나가 여러개를 갖는다. 댓글은 게시글 소속으로 하나를 갖는다.
create table posts(
post_id int primary key auto_increment,
title varchar(100),
content text,
created_at datetime default current_timestamp
);
create table comments(
comment_id int primary key auto_increment,
post_id int unique not null,
commenter varchar(100),
comment text,
foreign key (post_id) references posts(post_id)
);
-- 선생님 한명이 학생 여러명을 갖는다. 학생은 선생님 한 사람을 따른다.
create table ssams(
ssam_id int primary key auto_increment,
name varchar(100),
classname varchar(100)
);
create table students(
student_id int primary key auto_increment,
ssam_id int unique not null,
name varchar(100),
foreign key (ssam_id) references ssams(ssam_id)
);
-- N:N (다대다)
-- 대학교 학생이 수강 신청을 한다.
-- 한 학생이 여러 과목을 수강 신청한다.
-- 한 과목에는 여러 학생이 신청했다.
-- students <- student_course -> courses 
create table students(
student_id int primary key auto_increment,
name varchar(100)
);
create table courses(
course_id int primary key auto_increment,
course_name varchar(100)
);
create table student_course(
student_course_id int primary key auto_increment,
student_id int unique not null,
course_id int unique not null,
applied_at datetime default current_timestamp,
foreign key (student_id) references students(student_id),
foreign key (course_id) references courses(course_id)
);
-- 사용자(users)와 역할(roles)
-- 사용자 한 명은 여러 역할을 할 수 있다. (ex : 관리자, 작업자, 사용자)
-- 역할 하나는 여러 사용자들에게 할당 될 수 있다.
-- N:M Users:Roles	users<-user_roles->roles
create table users(
user_id int primary key auto_increment,
user_name varchar(100)
);
create table roles(
role_id int primary key auto_increment,
role_name varchar(100)
);
create table user_roles(
user_role_id int primary key auto_increment,
user_id int unique not null,
role_id int unique not null,
assigned_at datetime default current_timestamp,
foreign key (user_id) references users(user_id),
foreign key (role_id) references roles(role_id)
);
-- 자동차 제조 공장
create database car_factory;
use car_factory;
-- <생산품 product_model>
create table product_model(
model_id int primary key auto_increment,
model_name varchar(100) unique not null,
description text
);
insert into product_model(model_name, description) values 
('Model X','전기 SUV'),
('Model S','고성능 세단'),
('Model C','소형차');
-- <주문 production_order>
create table product_order(
order_id int primary key auto_increment,
model_id int not null,
order_date date not null,
handover_date datetime,
status ENUM('planned','in_progress','completed') default 'planned',
foreign key (model_id) references product_model(model_id)
);
insert into product_order(model_id, order_date, handover_date, status) values 
(1, '2025-06-04', '2025-07-04', 'planned'),
(2, '2025-06-05', '2025-07-05', 'in_progress'),
(3, '2025-06-06', '2025-07-06', 'completed');
-- 라인 workstation
create table workstation(
station_id int primary key auto_increment,
name varchar(100) not null,
station_type varchar(100),
location varchar(100)
);
insert into workstation(name, station_type, location) values 
('용접 공정 A','Welding','1층 라인 A'),
('도장 공정 B','Painting','2층 라인 B'),
('조립 공정 C','Assembly','3층 라인 C');
-- 작업 결과 관리 work_result
create table work_result(
result_id  int primary key auto_increment,
order_id int not null,
station_id int not null,
compledted_at datetime not null,
quantity int default 1,
foreign key (order_id) references product_order(order_id),
foreign key (station_id) references workstation(station_id)
);
insert into work_result(order_id, station_id, compledted_at, quantity) values 
(1, 1, '2025-06-04 15:40:10', 5),
(2, 2, '2025-06-05 15:40:10', 3),
(3, 3, '2025-06-06 15:40:10', 4);
-- 1:1 연습
-- 작업 결과와 공정 매칭
select * from work_result as wr 
join workstation as ws on wr.station_id = ws.station_id
where wr.station_id = 1;
-- 1:N 연습
-- 하나의 자동차 모델에 대해서 여러 개의 생산 지시서가 존재
select * from product_model as pm
join product_order as po on pm.model_id = po.model_id;

-- 자동차 제조 공장
create database car_factory;
use car_factory;
-- <생산품 product_model>
create table product_model(
model_id int primary key auto_increment,
model_name varchar(100) not null,
description text
);

insert into product_model(model_name,description) values ('Model X','전기 SUV'),('Model S','고성능 세단'),('Model C','소형차');

-- <주문 production_order>
create table production_order(
order_id int primary key auto_increment,
model_id int not null,
order_date date not null,
handover_date date,
status enum('planned','in_progress','completed') default 'planned',
foreign key (model_id) references product_model(model_id)
);

insert into production_order(model_id,order_date,handover_date,status) values
('1','2025-06-04','2025-07-04','planned'),
('2','2025-06-05','2025-07-05','in_progress'),
('3','2025-06-06','2025-07-06','completed');

-- 라인 work_station
create table work_station(
station_id int primary key auto_increment,
name varchar(100) not null,
station_type varchar(100),
location varchar(100)
);

insert into work_station(name,station_type,location) values
('용접 공정 A','Welding','1층 라인 A'),
('도장 공정 B','Painting','2층 라인 B'),
('조립 공정 C','Assembly','3층 라인 C');

-- 작업 결과 work_result
create table work_result(
result_id int primary key auto_increment,
order_id int not null,
station_id int not null,
complete_at datetime not null,
quantity int default 1,
foreign key (order_id) references production_order(order_id),
foreign key (station_id) references work_station(station_id)
);

insert into work_result(order_id,station_id,complete_at,quantity) values
(1,1,'2025-06-04 15:40:10',5),
(2,2,'2025-06-05 15:40:10',3),
(3,3,'2025-06-06 15:40:10',2);

-- 부품 및 BOM(Bill Of Material, 자재 명세서)
create table part(
part_id int primary key auto_increment,
part_name varchar(100) not null,
specification text
);

insert into part(part_name, specification) values
('배터리 모듈','72kwh 리튬 이온'),
('모터','3상 AC 150kwh'),
('섀시','강철 프레임'),
('도어 패널','알루미늄 합금');

create table bom(
bom_id int primary key auto_increment,
model_id int not null,
part_id int not null,
quantity_required int not null,
foreign key (model_id) references product_model(model_id),
foreign key (part_id) references part(part_id)
);

insert into bom(model_id,part_id,quantity_required) values
(1,1,1), -- Model X,1,battery,1
(1,2,2),
(1,3,1),
(2,1,1),
(2,2,1),
(2,3,1),
(2,4,4);

select pm.model_name, sum(b.quantity_required)
from product_model as pm
join bom as b on pm.model_id = b.model_id
group by pm.model_id;
-- n:m 부품이 사용된 자동차 모델 목록
select p.part_name, pm.model_name
from part as p
join bom as b on p.part_id = b.part_id
join product_model as pm on b.model_id = pm.model_id
order by p.part_name;
-- 작업자 및 작업 지시 배정
create table worker(
worker_id int primary key auto_increment,
name varchar(100) not null,
role varchar(50),
hire_date date
);

insert into worker(name,role,hire_date) values
('김민철','용접 기사', '2025-06-05'),
('이영희','도장 기사', '2024-06-05'),
('박철민','조립 기사', '2022-01-10');

create table worker_assignment(
work_assignment_id int primary key auto_increment,
worker_id int not null,
station_id int not null,
order_id int not null,
assignment_date date not null,
foreign key (worker_id) references worker(worker_id),
foreign key (order_id) references production_order(order_id),
foreign key (station_id) references work_station(station_id)
);

insert into worker_assignment(worker_id,station_id,order_id,assignment_date) values
(1,1,1,'2025-06-05'),
(2,2,2,'2025-06-03'),
(3,3,3,'2025-06-04');

create table inspection_result(
result_id int primary key auto_increment,
passed boolean not null,
inspected_at datetime not null,
inspector_name varchar(100),
notes text,
foreign key (result_id) references work_result(result_id)
);

insert into inspection_result(result_id,passed,inspected_at,inspector_name,notes) values
(1,true,'2025-06-05 11:19:30','카리나','양호'),
(2,false,'2025-06-04 11:19:30','장원영','도장 미흡'),
(3,true,'2025-06-03 11:19:30','김채원','정상');

create table sensor_data(
sensor_id int primary key auto_increment,
station_id int not null,
timestamp datetime not null,
temperature decimal(5,2),
vibration decimal(5,2),
voltage decimal(5,2),
foreign key (station_id) references work_station(station_id)
);

insert into sensor_data(station_id, timestamp, temperature,vibration,voltage) values
(1,'2025-06-05 11:28:30',25.1,0.23,220.0),
(2,'2025-06-05 11:28:30',25.4,0.34,219.0),
(3,'2025-06-05 11:28:30',24.8,0.15,222.2);

-- 창고 / 재고 흐름(transaction)
create table ware_house(
ware_house_id int primary key auto_increment,
name varchar(100) not null,
location varchar(100)
);

insert into ware_house(name,location) values
('부품 창고 A','본관 1층'),
('부품 창고 B','별관 지하');

create table stock_transaction(
transaction_id int primary key auto_increment,
part_id int not null,
ware_house_id int not null,
transaction_type enum('IN','OUT') not null,
quantity int not null,
transaction_date datetime not null,
foreign key (part_id) references part(part_id),
foreign key (ware_house_id) references ware_house(ware_house_id)
);

insert into stock_transaction (part_id,ware_house_id,transaction_type,quantity,transaction_date) values
(1,1,'IN',50,'2025-06-05 12:14:30'),
(1,1,'OUT',10,'2025-06-05 13:14:30'),
(2,2,'IN',20,'2025-06-04 12:14:30'),
(2,2,'OUT',5,'2025-06-04 13:14:30');