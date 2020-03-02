CREATE TABLE Student (
    login CHAR(6) PRIMARY KEY,
    fname VARCHAR(30) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

SELECT * FROM Student;

--------------------------------------------------------------------------------------------
--Ukol 1: Uvodni kroky
ALTER TABLE Student ADD tallness INT;
ALTER TABLE Student MODIFY email VARCHAR(50) NULL;

DESC student; --describe

BEGIN
    INSERT INTO Student (login, fname, lname, tallness)
    VALUES ('buh05', 'Jan', 'Buhda', 175);
END;

SET SERVEROUTPUT ON

SET AUTOCOMMIT OFF

--------------------------------------------------------------------------------------------
--Ukol 2
BEGIN
    DBMS_OUTPUT.PUT_LINE('PL/SQL Output');
END;

DECLARE 
    v_login Student.login%TYPE;
BEGIN
    v_login := 'buh008';
    INSERT INTO Student (login, fname, lname, tallness)
    VALUES (v_login, 'Jan', 'Buhda', 175);
END;

DECLARE
    v_student Student%ROWTYPE;
BEGIN
    SELECT * INTO v_student
    FROM Student WHERE login = 'buh05';
    DBMS_OUTPUT.PUT_LINE(v_student.login || ' ' || v_student.fname || ' ' || v_student.lname);
END;

DECLARE
    v_student Student%ROWTYPE;
BEGIN
    SELECT * INTO v_student
    FROM Student WHERE fname = 'Jan';
    DBMS_OUTPUT.PUT_LINE(v_student.login || ' ' || v_student.fname || ' ' || v_student.lname);
END; --error, protoze to vraci vice nez jeden radek

--------------------------------------------------------------------------------------------
--Ukol 3
BEGIN
    INSERT INTO Student (login, fname, lname, tallness)
    VALUES ('buh06', 'Jana', 'Buhdova', 175);
    INSERT INTO Student (login, fname, lname, tallness)
    VALUES ('hrac', 'Pepa', 'Buh', 175);
END;

SELECT * FROM Student;

ROLLBACK;

COMMIT;

SET AUTOCOMMIT ON











