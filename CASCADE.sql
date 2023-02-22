USE DATABASE DEMO_DATABASE;
USE WAREHOUSE DEMO_WAREHOUSE;

CREATE TABLE NT_Employee 
(
emp_id NUMBER (10) NOT NULL,
name varchar(40) NOT NULL,
birthdate date NOT NULL,
gender varchar(10) NOT NULL,
hire_date date NOT NULL,
PRIMARY KEY (emp_id)
);

INSERT INTO NT_Employee (emp_id, name, birthdate, gender, hire_date) 
VALUES
(101, 'Bryan', '1988-08-12', 'M', '2015-08-26'),
(102, 'Joseph', '1978-05-12', 'M', '2014-10-21'),
(103, 'Mike', '1984-10-13', 'M', '2017-10-28'),
(104, 'Daren', '1979-04-11', 'M', '2006-11-01'),
(105, 'Marie', '1990-02-11', 'F', '2018-10-12');

SELECT * FROM NT_EMPLOYEE;

CREATE TABLE NT_Payment 
(
payment_id NUMBER(10) PRIMARY KEY NOT NULL,
emp_id NUMBER(10) NOT NULL,
amount float NOT NULL,
payment_date date NOT NULL,
FOREIGN KEY (emp_id) REFERENCES NT_Employee (emp_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO NT_Payment (payment_id, emp_id, amount, payment_date) 
VALUES
(301, 101, 1200, '2015-09-15'),
(302, 101, 1200, '2015-09-30'),
(303, 101, 1500, '2015-10-15'),
(304, 101, 1500, '2015-10-30'),
(305, 102, 1800, '2015-09-15'),
(306, 102, 1800, '2015-09-30');

SELECT * FROM NT_Payment;

CREATE OR REPLACE TABLE NT_MASTERTABLE_CASCADE AS
SELECT NE.EMP_ID, NE.name, NE.birthdate, NE.gender, NE.hire_date, 
NP.payment_id,  NP.payment_date, NP.amount
FROM NT_EMPLOYEE AS NE
LEFT OUTER JOIN NT_PAYMENT AS NP ON NE.EMP_ID = NP.EMP_ID;

SELECT * FROM NT_MASTERTABLE_CASCADE;

-- DELETING RECORDING FROM THE PARENT TABLE--
DELETE FROM NT_EMPLOYEE WHERE EMP_ID = 102;
SELECT * FROM NT_EMPLOYEE;
SELECT * FROM NT_PAYMENT;