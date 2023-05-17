use role dba;
use database db1;
use schema public;


create or replace table employees(
    id number,
    w_date date,
    temp float );

INSERT INTO employees(id,w_date,temp) VALUES
(100,'2013-06-17',75),
(100,'2013-06-18',74),
(100,'2013-06-19',12),
(100,'2014-06-17',75),
(100,'2014-06-18',74),
(100,'2014-06-19',12),
(101,'2017-06-17',15),
(101,'2017-06-18',19),
(101,'2017-06-19',110);

create or replace table role_mapping(
    id int,
    w_date date,
    role_name varchar(50)
);

INSERT INTO  role_mapping(id,w_date, role_name) VALUES
(100,'2013-06-17','DBA'),
(100,'2013-06-18','DBA'),
(100,'2013-06-19','DBA'),
(101,'2017-06-17','OTHER'),
(101,'2017-06-18','OTHER'),
(101,'2017-06-19','OTHER');

create or replace row access policy weather_access as (map_id int, map_w_date date) returns boolean ->
      exists (
            select 1 from role_mapping
              where role_name = current_role()
                and map_id = id
                    and map_w_date = w_date
          );

alter table employees 
add row access policy weather_access on (id,w_date);

---only to clear
alter table employees drop row access policy country_role_policy;


select * from employees; 
