CREATE TABLE temp (
      tempid   NUMBER(6),
      tempsal  NUMBER(8,2),
      tempname VARCHAR2(25)
    );
 
 DECLARE
    sal             employees.salary%TYPE := 0;
    mgr_id          employees.manager_id%TYPE;
    lname           employees.last_name%TYPE;
    starting_empid  employees.employee_id%TYPE := 120;
  
   BEGIN
     SELECT manager_id INTO mgr_id
       FROM employees
         WHERE employee_id = starting_empid;
  
     WHILE sal <= 15000 LOOP
       SELECT salary, manager_id, last_name INTO sal, mgr_id, lname
         FROM employees
           WHERE employee_id = mgr_id;
     END LOOP;
  
     INSERT INTO temp
        VALUES (NULL, sal, lname);
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO temp VALUES (NULL, NULL, 'Not found');
  END;
