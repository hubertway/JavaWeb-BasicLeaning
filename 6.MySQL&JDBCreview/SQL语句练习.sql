--建表语句

CREATE DATABASE mysqltest2;
USE mysqltest2;


-- 部门表
	
CREATE TABLE DEPT(
    DEPTNO INT PRIMARY KEY,  -- 部门编号
    DNAME VARCHAR(14) ,  -- 部门名称
    LOC VARCHAR(13) ) ; -- 部门地址

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

-- 员工表

CREATE TABLE EMP
    (
	EMPNO INT  PRIMARY KEY,  -- 员工编号
    ENAME VARCHAR(10),  -- 员工名称
    JOB VARCHAR(9), -- 工作
    MGR DOUBLE, -- 直属领导编号
    HIREDATE DATE,  -- 入职时间
    SAL DOUBLE, -- 工资
    COMM DOUBLE, -- 奖金
    DEPTNO INT, -- 部门号
    FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO));
    
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1987-07-13',3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1987-07-13',1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-12-03',950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-12-03',3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,NULL,10); 
    


-- 工资等级表

CREATE TABLE SALGRADE
      ( GRADE INT,  -- 工资等级
    LOSAL DOUBLE, -- 最低工资
    HISAL DOUBLE ); -- 最高工资
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

-- 查询练习

-- 1.返回拥有员工的部门名、部门号。(dept,emp)	
SELECT DISTINCT dept.deptno , dept.dname FROM dept INNER JOIN emp ON emp.deptno=dept.deptno;
-- 去重操作 distinct ,用内连接。外连接如果没有满足条件，还是会以null的形式显示。

-- 2.工资多于smith的员工信息。
SELECT * FROM emp WHERE sal>(SELECT sal FROM emp WHERE ename='smith');
-- 子查询

-- 3.返回员工和其所属领导的姓名。
SELECT a.ename AS clerk,b.ename AS manager FROM emp a INNER JOIN emp b ON a.mgr = b.empno;
-- 自连接

-- 4.返回雇员的雇佣日期早于其领导雇佣日期的员工及其领导姓名。
SELECT a.ename AS clerk,b.ename AS manager FROM emp a INNER JOIN emp b ON a.mgr = b.empno AND a.hiredate < b.hiredate;
-- 在日期类型可以直接比较

-- 5.返回员工姓名及其所在的部门名称。
SELECT e.ename,d.DNAME FROM emp e,dept d WHERE e.deptno=d.deptno;

-- 6.返回从事clerk工作的员工姓名和所在部门名称
SELECT e.ename,d.DNAME FROM emp e,dept d WHERE e.deptno=d.deptno AND e.job='clerk';

-- 7.返回部门号及其本部门的最低工资。
SELECT deptno,MIN(sal) FROM emp GROUP BY deptno;
-- 分组语句 group by

-- 8.返回销售部(sales)所有员工的姓名。
SELECT ename FROM emp WHERE deptno=(SELECT deptno FROM dept WHERE dname='sales');

-- 9.返回工资多于平均工资的员工。
SELECT * FROM emp WHERE sal>(SELECT AVG(sal) FROM emp);

-- 10.返回与SCOTT从事相同工作的员工。
SELECT * FROM emp WHERE job=(SELECT job FROM emp WHERE ename = 'SCOTT') AND ename <> 'SCOTT';
-- <> 也就是 !=

-- 11.返回与30部门员工工资相同的员工姓名与工资。
SELECT ename,sal FROM emp WHERE sal IN (SELECT sal FROM emp WHERE deptno=30);
-- in() 在某个范围中获得值.

-- 12.返回工资高于30部门所有员工工资水平的员工信息。
SELECT * FROM emp WHERE sal >(SELECT MAX(sal) FROM emp WHERE deptno=30);
-- 或：
SELECT * FROM emp WHERE sal >ALL(SELECT sal FROM emp WHERE deptno=30);

-- 13.返回部门号、部门名、部门所在位置及其每个部门的员工总数。
SELECT d.*,tmp.total FROM dept d LEFT OUTER JOIN (SELECT deptno,COUNT(*) total FROM emp GROUP BY(deptno)) tmp ON d.deptno=tmp.deptno;
-- 临时表temp;左外连接

-- 14.返回员工的姓名、所在部门名及其工资。
SELECT e.ename,d.dname,e.sal FROM emp e,dept d WHERE e.deptno = d.deptno;
-- 隐式内连接

-- 15.返回员工的详细信息。(包括部门名)
SELECT e.*,d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno;
-- 显式内连接

-- 16.返回员工工作及其从事此工作的最低工资。
SELECT job ,MIN(sal) FROM emp GROUP BY job;

-- 17.返回不同部门经理的最低工资。
SELECT deptno, MIN(sal) FROM emp WHERE job='manager'GROUP BY deptno;

-- 18.计算出员工的年薪，并且以年薪排序。
SELECT ename,sal*12 AS ysal FROM emp ORDER BY ysal;
-- 排序 ORDER BY 语句

-- 19.返回工资处于第四级别的员工的姓名。
SELECT e.ename FROM emp e JOIN (SELECT losal ,hisal FROM salgrade WHERE grade=4) tmp ON e.sal BETWEEN tmp.losal AND tmp.hisal;
-- between 较小值 and 较大值

-- 20.返回工资为二等级的职员名字、部门所在地、和二等级的最低工资和最高工资
SELECT e.ename,d.loc,s.losal,s.hisal 
FROM emp e
JOIN salgrade s 
	ON s.grade=2 AND e.sal BETWEEN s.losal AND s.hisal 
JOIN dept d
	ON e.deptno = d.deptno
-- 学习join的写法

-- 21.工资等级多于smith的员工信息。
SELECT * FROM emp WHERE sal >(SELECT s.hisal FROM emp e,salgrade s WHERE e.ename='smith' AND e.sal BETWEEN s.losal AND s.hisal);

