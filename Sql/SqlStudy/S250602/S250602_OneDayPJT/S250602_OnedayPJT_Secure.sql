show databases;

CREATE USER 'staff'@'localhost' IDENTIFIED BY 'sm^xpq$9482@@';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'Ex@MpL3-pA55w0rD.sTr0nG!7#';

SELECT User, Host FROM mysql.user;
GRANT SELECT ON user_db.* TO 'staff'@'localhost';	# select 권한만alter
GRANT ALL PRIVILEGES ON user_db.* TO 'admin'@'localhost';


select * from users;
SHOW GRANTS FOR 'staff'@'localhost';

SELECT User, Host FROM mysql.user WHERE User = 'staff';

GRANT Execute ON procedure user_db.sp_loginSelect_test TO 'staff'; 
FLUSH PRIVILEGES;
GRANT Execute ON procedure user_db.sp_loginSelect_test TO 'admin'; 
FLUSH PRIVILEGES;
GRANT Execute ON procedure user_db.sp_loginInsert_test TO 'admin'; 
FLUSH PRIVILEGES;
call sp_loginSelect_test('magekty', '1111');
call sp_loginInsert_test('magekty', '1111', '김태영', 'mage@na.com', @RESULT);
SHOW GRANTS FOR 'staff'@'localhost';

DELIMITER $$
Create procedure `sp_loginSelect_test`(
in uname varchar(50), 
in pwd varchar(100)
)
begin 
    select * from users where username=uname and password=pwd;
end $$
DELIMITER ;

drop procedure `sp_loginInsert_test`;
DELIMITER $$
Create procedure `sp_loginInsert_test`(
in _username varchar(50), 
in _password varchar(100),
in _name varchar(100),
in _email varchar(100)

)
begin 
    insert into users (username, password, name, email) 
    values(_username, _password, _name, _email
	);
end $$
DELIMITER ;

GRANT EXECUTE ON PROCEDURE `user_db`.`procedure_Test` TO 'staff'@'host' ;
FLUSH PRIVILEGES;

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


SELECT order_id FROM orders WHERE table_id = 1 AND is_paid = false;