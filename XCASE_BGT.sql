USE BGT_CLASS;
# this states that are represented
SELECT distinct State_ID FROM States;

# states represented in the data and percentages
select *, (tab.count / tab.Total) as PCT
from
(
select distinct Jobs.State_ID, States.State_Name, count(*) as count, (select count(*) from Jobs) as Total
from Jobs
join States 
on Jobs.State_ID = States.State_ID
group by Jobs.State_ID) as tab;

# view for states represented in the data and percentages
create view fibiteye_statesPCT
as select distinct Jobs.State_ID, States.State_Name, count(*) as count, (select count(*) from Jobs) as Total
from Jobs
join States 
on Jobs.State_ID = States.State_ID
group by Jobs.State_ID;

create view fibiteye_statesPCT2
as select *, (count / Total) as PCT
from fibiteye_statesPCT;


#distribution of posting duration
SELECT Posting_Duration
FROM Jobs;


#view for distribution of posting duration
create view fibiteye_posting_duration
as SELECT Posting_Duration
FROM Jobs;

#  posting duration distribution across states
select State_ID, Posting_Duration
from Jobs;

#  views for posting duration distribution across states
create view fibiteye_state_posting
as select State_ID, Posting_Duration
from Jobs;

# there are states with different posting duration

# posting duration distribution similar across occupations
select Jobs.Occupation_Code, Occupations.Occupation_Name, Posting_Duration
from Jobs
Join Occupations
on Jobs.Occupation_Code = Occupations.Occupation_Code
group by Posting_Duration
order by Occupation_Code;



select Occupation_Name, Posting_Duration, count(Posting_Duration) from fibiteye_duration_occupation
where Occupation_Name = 'Banking Branch Manager'
group by Posting_Duration
order by Posting_Duration desc;

select Occupation_Name, Posting_Duration, count(Posting_Duration) from RECORDS
where Occupation_Name = 'Banking Branch Manager'
group by Posting_Duration
order by Posting_Duration desc;


# view for posting duration distribution similar across occupations
create view fibiteye_duration_occupation_correct
as select Jobs.Occupation_Code, Occupations.Occupation_Name, Posting_Duration
from Jobs
Join Occupations
on Jobs.Occupation_Code = Occupations.Occupation_Code;

select * from RECORDS
where Salary !=0;



# correct posting duration distribution across occupations
select Jobs.Occupation_Code, Occupations.Occupation_Name, Posting_Duration
from Jobs
Join Occupations
on Jobs.Occupation_Code = Occupations.Occupation_Code;


# top listed occupation names as percent of total listings
select Tab.Occupation_Code, Tab.Occupation_Name, count, (Tab.count / Tab.Total) as PCT
from
(
select Jobs.Occupation_Code, Occupations.Occupation_Name, count(*) as count, (select count(*) from Jobs) as Total
from Jobs
join Occupations on
Jobs.Occupation_Code =  Occupations.Occupation_Code
group by Occupation_Code
) as Tab
order by PCT desc;


# top listed occupation names as percent of total listings @NY
select Tab.Occupation_Code, Tab.Occupation_Name, count, (Tab.count / Tab.Total) as PCT
from
(
select Jobs.Occupation_Code, Occupations.Occupation_Name, count(*) as count, (select count(*) from Jobs) as Total
from Jobs
join Occupations on
Jobs.Occupation_Code =  Occupations.Occupation_Code
where State_ID = 38
group by Occupation_Code
) as Tab
order by PCT desc;


# view for top listed occupation names as percent of total listings @NY
create view fibiteye_occupation_names_Percent1
as select Jobs.Occupation_Code, Occupations.Occupation_Name, count(*) as count, (select count(*) from Jobs) as Total
from Jobs
join Occupations on
Jobs.Occupation_Code =  Occupations.Occupation_Code
where State_ID = 38
group by Occupation_Code;


create view fibiteye_occupation_names_Percent2
as select Occupation_Code, Occupation_Name, count, (count / Total) as PCT
from fibiteye_occupation_names_Percent1
order by PCT desc;

select * from fibiteye_occupation_names_Percent2;


# view for top listed occupation names as percent of total listings in NY
create view fibiteye_occupation_percent1
as select Jobs.Occupation_Code, Occupations.Occupation_Name, Jobs.State_ID, count(*) as count, (select count(*) from Jobs) as Total
from Jobs
join Occupations on
Jobs.Occupation_Code =  Occupations.Occupation_Code
where State_ID = 38
group by Occupation_Code;


create view fibiteye_occupation_percent2
as select Occupation_Code, Occupation_Name, count, State_ID, (count / Total) as PCT
from fibiteye_occupation_percent1
order by PCT desc;


# occupation names that have the longest durations
select distinct Jobs.Occupation_Code, Occupations.Occupation_Name, Jobs.Posting_Duration
from Jobs
Join Occupations
on Jobs.Occupation_Code = Occupations.Occupation_Code
order by Posting_Duration desc;

# view for occupation names that have the longest durations
create view fibiteye_names_duration as 
select distinct Jobs.Occupation_Code, Occupations.Occupation_Name, Jobs.Posting_Duration
from Jobs
Join Occupations
on Jobs.Occupation_Code = Occupations.Occupation_Code
order by Posting_Duration desc;

select * from fibiteye_names_duration;

# this is used to measure what metrics i would use to to know unfilled demands
# result is 36.09
select avg(Posting_Duration)
from RECORDS
where State_Name = 'NY';


# this is used to know average of title id count
select *, avg(pt)
from
(
select Title_ID, count(Title_ID) as pt
from RECORDS
where State_Name = 'NY'
group by Title_ID
order by Title_ID desc) as T;



# fields or industries where there are greatest unfilled demands 
SELECT *, count(*) as no_of_posting, avg(Posting_Duration) as avg_posting_duration_per_title
FROM RECORDS 
where State_Name = 'NY' 
group by Title_ID
order by avg_posting_duration_per_title desc;

# view for fields or industries where there are greatest unfilled demands 
create view fibiteye_unfilled_demands as
SELECT *, count(*) as no_of_posting, avg(Posting_Duration) as avg_posting_duration_per_title
FROM RECORDS 
where State_Name = 'NY' 
group by Title_ID
order by avg_posting_duration_per_title desc
limit 10;


# corrected view for fields or industries where there are greatest unfilled demands 
create view fibiteye_demands_v4 as
SELECT *, count(*) as no_of_posting, avg(Posting_Duration) as avg_posting_duration_per_title
FROM RECORDS 
where State_Name = 'NY' and Posting_Duration > 36
group by Title_ID
order by no_of_posting desc
limit 10;

# corrected view for fields or industries where there are greatest unfilled demands 
create view fibiteye_demands_v5 as
SELECT *, count(*) as no_of_posting, avg(Posting_Duration) as avg_posting_duration_per_title
FROM RECORDS 
where State_Name = 'NY' and Posting_Duration > 36
group by Title_ID
order by no_of_posting desc;


# top 10
create view fibiteye_top10 as
SELECT Title_ID, Occupation_Title, count(*) as no_of_posting, avg(Posting_Duration) as avg_posting_duration_per_title, Posting_Duration
FROM RECORDS 
where State_Name = 'NY' and Posting_Duration > 36
group by Title_ID
order by avg_posting_duration_per_title desc
limit 10;

# top 10 v3
create view fibiteye_top10_v3 as
SELECT Title_ID, Occupation_Title, Occupation_Name, count(*) as no_of_posting, avg(Posting_Duration) as avg_posting_duration_per_title, Posting_Duration
FROM RECORDS 
where State_Name = 'NY' and Posting_Duration > 36
group by Title_ID
order by no_of_posting desc
limit 10;




# this is fields where there are greatest unfilled demands based on Degree level
SELECT *, count(Degree_Level) as ct
FROM RECORDS 
group by Degree_Level
having Posting_Duration > 36 and State_Name = 'NY'
order by ct desc LIMIT 10;

select * from RECORDS;

# unfilled demand positions
SELECT Occupation_Title, Title_ID, Posting_Duration, State_Name, Degree_Level, count(Title_ID) as ct
FROM RECORDS 
group by Title_ID
having Posting_Duration > 36 and ct > 43 and State_Name = 'NY' and Degree_Level != 'Unknown'
order by ct desc LIMIT 10;

SELECT Title_ID, Occupation_Title, count(*) as no_of_posting, avg(Posting_Duration) as avg_posting_duration_per_title, Posting_Duration
FROM RECORDS 
where State_Name = 'NY' and Posting_Duration > 36
group by Title_ID
order by no_of_posting desc
limit 10;

# Highest degrees requested in New York
select Degree_Level, count(Degree_Level)
from RECORDS
where State_Name = 'NY'
group by Degree_Level;

# degree level required
SELECT Occupation_Title, Title_ID, Posting_Duration, Title_ID, Skill_Name, Experience_Level, Cert_Name, count(*) as no_of_posting, avg(Posting_Duration) as avg_posting_duration_per_title
FROM RECORDS 
where Posting_Duration > 36 and State_Name = 'NY' 
group by Title_ID
order by no_of_posting desc LIMIT 30;

# view degree level required
create view fibiteye_cert as
SELECT Occupation_Title, Posting_Duration, Title_ID, Skill_Name, Experience_Level, Cert_Name, count(*) as no_of_posting, avg(Posting_Duration) as avg_posting_duration_per_title
FROM RECORDS 
where Posting_Duration > 36 and State_Name = 'NY' 
group by Title_ID
order by no_of_posting desc LIMIT 30;



SELECT Occupation_Title, Title_ID, Posting_Duration, State_Name, Degree_Level, count(*) 
FROM RECORDS 
where Posting_Duration > 36 and ct > 43 and State_Name = 'NY' and Degree_Level != 'Unknown'
group by Title_ID
order by no;


# skill name
SELECT Occupation_Title, Title_ID, Posting_Duration, State_Name, Skill_Type, Skill_Name, count(Title_ID) as ct
FROM RECORDS 
group by Title_ID
having Posting_Duration > 36 and ct > 43 and State_Name = 'NY' 
order by ct desc LIMIT 10;

# experience level
SELECT Occupation_Title, Title_ID, Posting_Duration, State_Name, Exp_ID, Experience_Level, count(Title_ID) as ct
FROM RECORDS 
group by Title_ID
having Posting_Duration > 36 and ct > 43 and State_Name = 'NY' 
order by ct desc LIMIT 10;

# cert name
SELECT Occupation_Title, Title_ID, Posting_Duration, State_Name, Cert_Name, Degree_Level, count(Title_ID) as ct
FROM RECORDS 
group by Title_ID
having Posting_Duration > 36 and ct > 43 and State_Name = 'NY' 
order by ct desc LIMIT 10;

# county with most count of posting duration
SELECT Occupation_Title, Title_ID, Posting_Duration, State_Name, Degree_Level, County, count(Posting_Duration) as ct
FROM RECORDS 
group by Posting_Duration
having Posting_Duration > 36 and State_Name = 'NY' 
order by ct desc LIMIT 10;

# county with most posting duration in NY
SELECT Occupation_Title, Posting_Duration, State_Name, Degree_Level, County
FROM RECORDS 
group by Posting_Duration
having Posting_Duration > 36 and State_Name = 'NY' 
order by Posting_Duration desc LIMIT 10;

# occupation with most post duration
select State_Name, Posting_Duration
from RECORDS
group by Posting_Duration
order by Posting_Duration desc LIMIT 10;

# this is grouped by cert because while in high school, students can get these jobs based on exp and certifications and have a higher chance with more experience
SELECT Cert_Name, Occupation_Title, Title_ID, Posting_Duration, State_Name, Degree_Level, County, Experience_Level, Exp_ID,count(Exp_ID), count(Title_ID) as ct
FROM RECORDS 
group by Cert_Name
having Posting_Duration > 36 and ct > 43 and State_Name = 'NY' and Exp_ID != 5
order by count(Exp_ID) desc LIMIT 10;

select Experience_Level, Exp_ID, count(Exp_ID)
from RECORDS
group by Exp_ID
