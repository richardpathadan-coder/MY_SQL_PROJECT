/*
Top 5 demanded skills for remote jobs by (job_location = 'Anywhere')

*/

SELECT 
skills_dim.skills,
count (job_postings_fact.job_id) as job_count
from job_postings_fact
LEFT JOIN skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
LEFT JOIN skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_postings_fact.job_location= 'Anywhere'
GROUP BY skills_dim.skills
ORDER BY job_count DESC
limit 5;

