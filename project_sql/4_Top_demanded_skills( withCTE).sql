/*
Top 5 demanded skills for remote jobs for the role data analyst
*/

with remote_job_skills as (SELECT 
skills_job_dim.skill_id,
count(*) as job_count
FROM skills_job_dim
inner join job_postings_fact on skills_job_dim.job_id=job_postings_fact.job_id
WHERE job_work_from_home = 'True' and job_title_short = 'Data Analyst'
GROUP BY skill_id)

SELECT 
skills_dim.skill_id,
skills_dim.skills,
job_count
FROM remote_job_skills
inner join skills_dim on remote_job_skills.skill_id=skills_dim.skill_id
ORDER by job_count DESC
LIMIT 5;

/*Analysis of remote Data Analyst job postings shows SQL as the most in-demand
 skill (7,291 roles), followed by Excel (4,611) and Python (4,330), highlighting 
 the importance of data extraction and analysis. Visualization tools like Tableau
  (3,745) and Power BI (2,609) remain essential for communicating insights in remote
   environments.*/