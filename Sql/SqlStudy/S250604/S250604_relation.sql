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
citizens_id int primary key auto_increment,

);
create table id_cards(
citizens_id int primary key auto_increment,
id_number varchar(20) unique not null

);
-- 1:N (일대다)





-- N:N (다대다)
