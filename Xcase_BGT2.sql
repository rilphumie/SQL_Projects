USE BGT_CLASS;

SELECT * FROM RECORDS;

#General degree PCT.... 
select Degree_Level, ct, Total, (ct/Total) * 100 as PCT
from
(
select Degree_Level, count(*) as ct, (select count(*) from RECORDS)as Total
from RECORDS
group by Degree_Level) as Tab
order by PCT desc;

# create view 
create view funmi_degree as
select Degree_Level, count(*) as ct, (select count(*) from RECORDS)as Total
from RECORDS
group by Degree_Level;

create view funmi_degree_PCT as 
select Degree_Level, ct, Total, (ct/Total) * 100 as PCT
from funmi_degree
order by PCT desc;
#
#
#


# Cert PCT for general
select Cert_Name, ct2, Total2, (ct2/Total2) * 100 as PCT2
from
(
select Cert_Name, count(*) as ct2, (select count(*) from RECORDS)as Total2
from RECORDS
group by Cert_Name) as Tab
where Cert_Name != 'Null'
order by PCT2 desc;


#create view
create view funmi_Cert as
select Cert_Name, count(*) as ct2, (select count(*) from RECORDS)as Total2
from RECORDS
group by Cert_Name;

create view funmi_Cert_PCT as
select Cert_Name, ct2, Total2, (ct2/Total2) * 100 as PCT2
from funmi_Cert
where Cert_Name != 'Null'
order by PCT2 desc;
#
#
#



# this is to determine why a job posting stays too long. is it because of salary?
select distinct Occupation_Name, count(*), avg(Posting_Duration) as avg_Posting_Duration, avg(salary)
from RECORDS
where salary != 0 and Occupation_Name != 'Null'
group by Occupation_Name
order by avg_Posting_Duration desc;

#create view
create view funmi_demand_salary as
select distinct Occupation_Name, count(*), avg(Posting_Duration) as avg_Posting_Duration, avg(salary)
from RECORDS
where salary != 0 and Occupation_Name != 'Null'
group by Occupation_Name
order by avg_Posting_Duration desc;
#
#
#


# this is to determine why a job posting stays too long in NY. is it because of salary?
select distinct Occupation_Name, count(*), avg(Posting_Duration) as avg_Posting_Duration, avg(salary)
from RECORDS
where salary != 0 and Occupation_Name != 'Null' and State_Name = 'NY'
group by Occupation_Name
order by avg_Posting_Duration desc;

# cretae view
create view funmi_demand_salary_NY as
select distinct Occupation_Name, count(*), avg(Posting_Duration) as avg_Posting_Duration, avg(salary)
from RECORDS
where salary != 0 and Occupation_Name != 'Null' and State_Name = 'NY'
group by Occupation_Name
order by avg_Posting_Duration desc;




# check the max of the salary.
select Occupation_Name, salary
from RECORDS
where Occupation_Name = 'Nurse Case Manager' and salary != 0;


# avarage salary over all
select avg(salary) from RECORDS
where salary!= 0;

# avarage salary NY
select avg(salary) from RECORDS
where salary!= 0 and State_Name = 'NY';

# NY salary according to degree
select Degree_Level, avg(salary)
from RECORDS
where salary !=0 and State_Name = 'NY'
group by Degree_Level
order by avg(salary) desc;

#create view
create view funmi_degree_salary_NY as
select Degree_Level, avg(salary)
from RECORDS
where salary !=0 and State_Name = 'NY'
group by Degree_Level
order by avg(salary) desc;
#
#
#


#national salary according to degree
select Degree_Level, avg(salary)
from RECORDS
where salary !=0 
group by Degree_Level
order by avg(salary) desc;


#create view
create view funmi_degree_salary_NA as
select Degree_Level, avg(salary)
from RECORDS
where salary !=0 
group by Degree_Level
order by avg(salary) desc;


#NY salary according to cert
select Cert_Name, avg(salary)
from RECORDS
where salary !=0 and State_Name = 'NY'
group by Cert_Name
order by avg(salary) desc;

# create view
create view funmi_cert_salary_NY as
select Cert_Name, avg(salary)
from RECORDS
where salary !=0 and State_Name = 'NY'
group by Cert_Name
order by avg(salary) desc;




#national salary according to cert
select Cert_Name, avg(salary)
from RECORDS
where salary !=0 
group by Cert_Name
order by avg(salary) desc;

#create view
create view funmi_cert_salary_NA as
select Cert_Name, avg(salary)
from RECORDS
where salary !=0 
group by Cert_Name
order by avg(salary) desc;


# experience in NY
select Experience_Level, avg(salary)
from RECORDS
where salary !=0 and State_Name = 'NY'
group by Experience_Level
order by avg(salary) desc;

#create view
create view funmi_Exp_salary_NY as
select Experience_Level, avg(salary)
from RECORDS
where salary !=0 and State_Name = 'NY'
group by Experience_Level
order by avg(salary) desc;



# experience national
select Experience_Level, avg(salary)
from RECORDS
where salary !=0 
group by Experience_Level
order by avg(salary) desc;


#create view
create view funmi_Exp_salary_NA as
select Experience_Level, avg(salary)
from RECORDS
where salary !=0 
group by Experience_Level
order by avg(salary) desc;










