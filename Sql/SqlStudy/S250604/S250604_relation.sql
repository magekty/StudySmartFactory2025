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