CREATE OR REPLACE VIEW manager_info AS
  SELECT e.ename, e.empno, d.dept_type, d.deptno, p.prj_level,  p.projno
    FROM emp e, dept d, Project_tab p
      WHERE e.empno =  d.mgr_no
        AND d.deptno = p.resp_dept;

CREATE OR REPLACE TRIGGER manager_info_insert
  INSTEAD OF INSERT ON manager_info
    REFERENCING NEW AS n  -- new manager information
      FOR EACH ROW
DECLARE
  rowcnt number;
BEGIN
  SELECT COUNT(*) INTO rowcnt FROM emp WHERE empno = :n.empno;
  IF rowcnt = 0  THEN
    INSERT INTO emp (empno,ename) VALUES (:n.empno, :n.ename);
  ELSE
    UPDATE emp SET emp.ename = :n.ename WHERE emp.empno = :n.empno;
  END IF;
  SELECT COUNT(*) INTO rowcnt FROM dept WHERE deptno = :n.deptno;
  IF rowcnt = 0 THEN
    INSERT INTO dept (deptno, dept_type) 
      VALUES(:n.deptno, :n.dept_type);
  ELSE
    UPDATE dept SET dept.dept_type = :n.dept_type
      WHERE dept.deptno = :n.deptno;
  END IF;
  SELECT COUNT(*) INTO rowcnt FROM Project_tab
    WHERE Project_tab.projno = :n.projno;
  IF rowcnt = 0 THEN
    INSERT INTO Project_tab (projno, prj_level) 
      VALUES(:n.projno, :n.prj_level);
  ELSE
    UPDATE Project_tab SET Project_tab.prj_level = :n.prj_level
      WHERE Project_tab.projno = :n.projno;
  END IF;
END;