SELECT count(*) FROM hr_database.hr;
describe hr;

drop table hr;
RENAME TABLE hr TO hr;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

alter table hr
change column ï»¿id emp_id varchar(20);


-- :::: DATA CLEANING PROCESS :::: --

-- For dob column::

SET sql_safe_updates = 0;
UPDATE hr
SET dob = CASE
    WHEN dob LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(dob, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN dob LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(dob, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

alter table hr
modify column dob Date;
select dob from hr;


-- For hire_date column::

SET sql_safe_updates = 0;
UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

alter table hr
modify column hire_date Date;
select hire_date from hr;


-- For termdate column::

SET sql_safe_updates = 0;
update hr 
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate !='';

UPDATE hr
SET termdate = "0000-00-00"
WHERE termdate = NULL;

ALTER TABLE hr
MODIFY termdate DATE;

select termdate from hr;
desc hr;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr 
SET age = timestampdiff(YEAR, dob, curdate());

UPDATE hr 
SET age = YEAR(CURDATE()) - YEAR(dob) - (DATE_FORMAT(CURDATE(), '%m%d') < DATE_FORMAT(dob, '%m%d'));

select dob, age from hr;

select 
min(age) as youngest,
max(age) as oldest 
from hr;

select gender, count(*) from hr
where age <= 18 and termdate =Null;

select termdate from hr;



--  further Data Cleaning:::::
-- Changed all the the "TEXT" datatypes to "varchar()".

select distinct(length(location_state)) as len from hr 
order by len desc;

ALTER TABLE hr
MODIFY COLUMN first_name varchar(30),
MODIFY COLUMN last_name varchar(30),
MODIFY COLUMN gender varchar(15),
MODIFY COLUMN race varchar(50),
MODIFY COLUMN department varchar(40),
MODIFY COLUMN jobtitle varchar(40),
MODIFY COLUMN location varchar(15),
MODIFY COLUMN location_city varchar(20),
MODIFY COLUMN location_state varchar(15)
;


























