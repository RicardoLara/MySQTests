DECLARE
     jobid      employees.job_id%TYPE;
     empid      employees.employee_id%TYPE := 115;
     sal        employees.salary%TYPE;
     sal_raise  NUMBER(3,2);
  BEGIN
    SELECT job_id, salary INTO jobid, sal
      FROM employees
        WHERE employee_id = empid;
  
    CASE
      WHEN jobid = 'PU_CLERK' THEN
        IF sal < 3000 THEN
          sal_raise := .12;
        ELSE
          sal_raise := .09;
        END IF;
  
      WHEN jobid = 'SH_CLERK' THEN
        IF sal < 4000 THEN
          sal_raise := .11;
        ELSE
          sal_raise := .08;
        END IF;
  
      WHEN jobid = 'ST_CLERK' THEN
        IF sal < 3500 THEN
          sal_raise := .10;
        ELSE
          sal_raise := .07;
        END IF;
  
      ELSE
        BEGIN
          DBMS_OUTPUT.PUT_LINE('No raise for this job: ' || jobid);
        END;
     END CASE;
  
     UPDATE employees
       SET salary = salary + salary * sal_raise
         WHERE employee_id = empid;
  END;
