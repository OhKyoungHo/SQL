SELECT employee_id, first_name, last_name, phone_number FROM employees 
WHERE salary=3000; 

SELECT index_name,index_type
FROM user_indexes
WHERE table_name ='EMPLOYEES';

CREATE INDEX idx_emp_salary ON employees(salary);

SELECT employee_id, first_name, last_name, phone_number FROM employees 
WHERE salary=3000; 

SELECT employee_id, first_name, last_name, phone_number FROM employees 
WHERE employee_id=8000; 