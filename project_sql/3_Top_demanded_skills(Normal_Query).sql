/*
Top 5 demanded skills for remote jobs by (job_location = 'Anywhere')

*/

SELECT 
skills,
count (skills_job_dim.job_id) as job_count
from job_postings_fact
left JOIN skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
LEFT join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_work_from_home = True AND job_postings_fact.job_title_short= 'Data Analyst'
GROUP BY skills
ORDER BY job_count DESC
limit 5;

