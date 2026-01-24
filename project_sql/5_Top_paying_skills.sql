/*
 What are the top skills based on salary?
Look at the average salary associated with each skill for Data Analyst positions
Focuses on roles with specified salaries, regardless of location
 It can reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/
SELECT 
skills,
round (avg (job_postings_fact.salary_year_avg),2) as avg_salary
from job_postings_fact
left JOIN skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
LEFT join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where job_title_short= 'Data Analyst' and salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
limit 25;
/*Insight:
High-paying Data Analyst roles are strongly associated with specialized and 
infrastructure-focused skills.
Skills like SVN ($400k) and Solidity ($179k) command exceptionally high average 
salaries, while data engineering and ML tools such as Couchbase ($160k), DataRobot ($155k),
Golang ($155k), Terraform ($146k), and Kafka ($130k) consistently exceed the $120k range.
This indicates that analysts with engineering, ML, and cloud-related expertise tend to earn 
significantly higher salaries than those with only core analytics skills.*/