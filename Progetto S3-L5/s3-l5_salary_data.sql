-- ho importato una tabella excel su MySqlWorkbench, la quale contiene (età, anni di esperienza, salario annuo, job title, livello di istruzione)
-- su questi dati ho creato le seguente query


-- quanti ragazzi di 33 anni hanno piu di 8 anni di esperienza e guadagnano meno di 125000
SELECT COUNT(age) AS mag_8_anni
FROM salary_date.`salary_data_2`
WHERE years_of_experience >= 8 AND salary < 125000 AND age=33;

-- quanti dei precedenti possiedono un PhD
SELECT COUNT(age) AS mag_8_anni
FROM salary_date.`salary_data_2`
WHERE years_of_experience >= 8 AND salary < 125000 AND age=33 AND education_level= 'PhD';

-- la media salaria annua dei ragazzi con 0 anni di esperienza
SELECT AVG(salary) AS salario_medio
FROM salary_date.`salary_data_2`
WHERE years_of_experience = 0;

-- analizza i job title dei ragazzi i quali hanno una media di 5 anni di esperienza, e il loro salario medio
SELECT job_title, 
		AVG(years_of_experience) AS esperienza_med_5,
        AVG(salary) AS salario_medio
FROM salary_date.`salary_data_2`
GROUP BY job_title
HAVING ROUND(esperienza_med_5)=5;

-- trovare i TOP 5 job title con il massimo salario
SELECT job_title, MAX(salary) AS max_salary
FROM salary_date.`salary_data_2`
GROUP BY job_title
ORDER BY max_salary DESC
LIMIT 5;

