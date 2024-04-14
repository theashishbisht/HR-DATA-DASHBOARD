-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
select gender, count(*) as COUNT_of_EMP 
from hr
where age >= 18 and termdate is null  
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
select race, count(*) as COUNT_of_EMP 
from hr
where age >= 18 and termdate is null  
group by race
order by COUNT_of_EMP desc;

-- 3. What is the age distribution of employees in the company?
select min(age) as youngest, max(age) as oldest 
from hr
where age >= 18 and termdate is null;

select case	
	when age >= 18 and age <=24 then "18-24"
    when age >= 25 and age <=34 then "25-34"
    when age >= 35 and age <=44 then "35-44"
    when age >= 45 and age <=54 then "45-54"
    when age >= 55 and age <=64 then "55-64"
	else "65+"
END as Age_Group,
count(*) as COUNT_of_EMP
from hr
where age >= 18 and termdate is null
group by Age_Group
order by Age_Group;

-- or

select case	
	when age >= 18 and age <=24 then "18-24"
    when age >= 25 and age <=34 then "25-34"
    when age >= 35 and age <=44 then "35-44"
    when age >= 45 and age <=54 then "45-54"
    when age >= 55 and age <=64 then "55-64"
	else "65+"
END as Age_Group, gender,
count(*) as COUNT_of_EMP
from hr
where age >= 18 and termdate is null
group by Age_Group, gender
order by Age_Group, gender;

    
-- 4. How many employees work at headquarters versus remote locations?
select location, count(*) as COUNT_of_EMP
from hr
where age >= 18 and termdate is null
group by location;

-- 5. What is the average length of employment for employees who have been terminated?
select round(avg(datediff(termdate, hire_date))/365,0) as Avg_length_employment
from hr
where termdate <= curdate() and termdate is not null and age >= 18;

-- 6. How does the gender distribution vary across departments and job titles?
select department, gender, count(*) as COUNT_of_EMP
from hr
where age >= 18 and termdate is null
group by department, gender
order by department;

-- 7. What is the distribution of job titles across the company?
select jobtitle, count(*) as COUNT_of_EMP
from hr
where age >= 18 and termdate is null
group by jobtitle
order by jobtitle;

-- 8. Which department has the highest turnover rate?
select department, total_count, terminated_count, 
terminated_count/total_count as Termination_Rate
from (
		select department, count(*) as total_count, 
        sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end) as terminated_count
        from hr
where age >= 18
group by department
) as Subquery
order by Termination_Rate desc;


-- 9. What is the distribution of employees across locations by city and state?
select location_state as state, count(*) as COUNT_of_EMP
from hr where age >= 18 and termdate is null
group by location_state
order by COUNT_of_EMP desc;

-- 10. How has the company's employee count changed over time based on hire and term dates?
select 
	Years,
    hires,
    terminations,
    hires-terminations as Net_change,
    round((hires-terminations)/hires * 100, 2) as Net_Change_percentage
from (
		select 
			year(hire_date) as Years,
            count(*) as hires,
            sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end) as terminations
		from hr where age >= 18
		group by year(hire_date)
		) as Subquery
order by Years asc;
        

    

-- 11. What is the tenure distribution for each department?
select department, 
round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure
from hr
where termdate <= curdate() 
and termdate is not null 
and age >= 18
group by department
order by department;




