show tables;

create database sakila_small;

use sakila;
use sakila_small;

desc customer;

create table customer(
customer_id int unsigned primary key
);

create table inventory(
inventroy_id int unsigned primary key
);

create table rental(
rental_id int unsigned primary key,
customer_id int unsigned,
inventroy_id int unsigned,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (inventroy_id) REFERENCES inventory(inventroy_id)
);
-- [[ mysql -u root -p sakila < C:\Users\magek\Downloads\sakila-db\sakila-data.sql ]] - 명령 프롬프트에서 sql문을 직접 실행
select * from actor;
select * from address;
select * from category;
select * from city;
select * from country;
select * from customer;
select * from film;
select * from film_actor;
select * from film_category;
select * from film_text;
select * from inventory;
select * from language;
select * from payment;
select * from rental;
select * from staff;
select * from store;

select first_name from customer;
select first_name, last_name from customer;
select * from customer where first_name = 'maria';
select * from customer where first_name < 'maria';

select * from payment where payment_date = '2005-07-09 13:24:07';
select * from payment where payment_date < '2005-07-09 13:24:07';

select * from customer where address_id between 5 and 10;
select * from payment where payment_date between '2005-06-17' and '2005-07-19';

select * from city where city = 'sunnyvale' and country_id = 103;
select * from payment where payment_date >= '2005-06-01' and payment_date <= '2005-06-15';
select * from customer where first_name = 'maria' or first_name = 'linda' or first_name = 'nancy';
select * from address where address2 is not null;
select * from customer order by first_name;
select * from customer order by customer_id asc limit 10 offset 100;
select * from customer where first_name like '%A%';

