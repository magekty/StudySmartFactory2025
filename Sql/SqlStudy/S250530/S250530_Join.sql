select * from film;

select special_features, count(*) from film group by special_features;
select special_features, count(*) from film group by special_features
having count(*) >= 70;
select passfail, count(*) from todayproduction group by passfail;
-- pass 93 
# fail 7
select passfail, count(*) from todayproduction group by passfail
having passfail='fail';

create database user_db;
use user_db;
create table users(
id int primary key auto_increment,
username varchar(50) unique not null,
password varchar(100) not null,
name varchar(100),
email varchar(100)
);
desc users;
SELECT * FROM user_db.users;
select ROW_NUMBER() OVER (ORDER BY name) AS row_num,
id, username, password, name, email
from user_db.users;
insert into users (username, password, name, email) values(
'hjseo1', '1234', '서호준', 'hj@hj.com'
);

update users set password = '1111', name = '김민철', email = 'hj@hj.com' 
where username = 'hjseo';

delete from users where username = 'hjseo1';

UPDATE users SET id=2 where id =3;

alter table users auto_increment=5;

UPDATE users SET id=3 where id =6;
UPDATE users SET id=4 where id =7;
SELECT * FROM user_db.users;
use sakila;
create table doit_cross1(num int);
create table doit_cross2(name varchar(10));
insert into doit_cross1 values(1),(2),(3);
insert into doit_cross2 values('do'),('it'),('sql');
select * from doit_cross1;
select * from doit_cross2;
select a.num, b.name from doit_cross1 as a Cross join doit_cross2 as b order by a.num;

use sakila;
select * from customer limit 10;
select * from address limit 10;
select c.address_id as a_adress_id, c.customer_id, c.store_id, c.first_name, c.last_name, c.email, a.address, a.district, a.city_id, a.postal_code, a.phone, a.location from customer as c inner join address as a
on c.address_id = a.address_id where c.first_name='rosa';
select * from customer as c inner join address as a
on c.address_id = a.address_id limit 100;

select * from customer as c
inner join address as a on c.address_id = a.address_id
inner join city as t on a.city_id = t.city_id;

select c.first_name, a.address, t.city from customer as c
inner join address as a on c.address_id = a.address_id
inner join city as t on a.city_id = t.city_id
where c.first_name = 'rosa';

select c.first_name, t.city from customer as c
inner join address as a on c.address_id = a.address_id
inner join city as t on a.city_id = t.city_id
where c.first_name = 'rosa';

select customer_id from customer where first_name = 'rosa';

select * from customer where customer_id = 112;
select * from customer where customer_id = 
(select customer_id from customer where first_name = 'rosa');