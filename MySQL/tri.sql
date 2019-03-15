CREATE OR REPLACE TRIGGER Print_salary_changes
  BEFORE DELETE OR INSERT OR UPDATE ON emp
  FOR EACH ROW
WHEN (NEW.EMPNO > 0)
DECLARE
    sal_diff number;
BEGIN
    sal_diff  := :NEW.SAL  - :OLD.SAL;
    dbms_output.put('Old salary: ' || :OLD.sal);
    dbms_output.put('  New salary: ' || :NEW.sal);
    dbms_output.put_line('  Difference ' || sal_diff);
END;