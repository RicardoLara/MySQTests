select * from emp, dept where emp.deptno = dept.deptno(+)
UNION ALL
select * from emp, dept where emp.deptno(+) = dept.deptno AND emp.deptno is null;