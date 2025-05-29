show databases;
create database smartfactory;
use smartfactory;

create table doit_create_table(
col_1 int,
col_2 varchar(50),
col_3 datetime 
);

select * from doit_create_table;

drop table doit_create_table;
show tables;