CREATE database project;

use  project;
-- data cleaning
select * from hr;
alter table hr 
change column ï»¿id emp_id varchar(20);


UPDATE hr 
SET birthdate = CASE
    WHEN birthdate LIKE '%/%/%' THEN STR_TO_DATE(birthdate, '%m/%d/%Y')
    WHEN birthdate LIKE '%-%-%' THEN STR_TO_DATE(birthdate, '%d-%m-%y')
    ELSE NULL
END;
alter table hr
modify birthdate date;

UPDATE hr 
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN STR_TO_DATE(hire_date, '%m/%d/%Y')
    WHEN hire_date LIKE '%-%' THEN STR_TO_DATE(hire_date, '%d-%m-%y')
    ELSE NULL
    END;
alter table hr
modify hire_date DATE;



-- Step 1: Update valid date values
UPDATE hr
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '' AND STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC') IS NOT NULL;

-- Step 2: Set remaining invalid or empty date values to '0000-00-00'
UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate IS NULL OR termdate = '' OR STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC') IS NULL;

alter table hr 
modify termdate date;
describe hr;

select termdate from hr;

alter table hr add column age int;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());


select 
   min(age) AS youngest,
   max(age) AS oldest
   from hr;
   
   select count(*) from hr where age<18;
   
    -- query 
    






