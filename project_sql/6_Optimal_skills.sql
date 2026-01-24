/*Which Data Analyst skills are most frequently requested by employers while also offering higher average salaries?

Which skills provide the strongest earning potential in remote Data Analyst roles with disclosed pay?

Which in-demand skills combine market demand with financial rewards for Data Analysts?

Which technical skills enhance both job stability and salary growth in the data analytics field?

Which skills should aspiring Data Analysts prioritize to maximize long-term career and income prospects?*/

-- Use Query #3
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True 
    GROUP BY
        skills_dim.skill_id
), 
-- Skills with high average salaries for Data Analyst roles
-- Use Query #4
average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True 
    GROUP BY
        skills_job_dim.skill_id
)
-- Return high demand and high salaries for 10 skills 
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN  average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE  
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

-- rewriting this same query more concisely
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*Insights:

Python (236 roles, ~$101k) and Tableau (230 roles, ~$99k) stand out as the strongest balance of high demand and solid pay, making them core skills for Data Analyst roles.

Cloud and data warehouse technologies such as Snowflake (37 roles, ~$113k), Azure (34 roles, ~$111k), and AWS (32 roles, ~$108k) offer higher-than-average salaries despite lower demand than Python, indicating strong value for specialization.

Programming and big data tools like Go (~$115k), Hadoop (~$113k), and Java (~$107k) command higher salaries but appear in fewer postings, suggesting they are niche, premium skills.

Visualization and BI tools such as Looker (49 roles, ~$104k) and Tableau remain critical for employability, though salary growth is maximized when paired with cloud or engineering skills.

Overall, the most optimal skill strategy combines high-demand fundamentals (Python, Tableau, SQL-related tools) with select high-paying specializations (cloud platforms, big data, or backend languages) to achieve both job security and higher earnings.*/