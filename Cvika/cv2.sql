--ukol 1
--1.1
CREATE OR REPLACE PROCEDURE AddStudent(
    p_login VARCHAR2,
    p_fname VARCHAR2,
    p_lname VARCHAR2,
    p_tallness VARCHAR2)
AS
BEGIN
    INSERT INTO Student(login, fname, lname, tallness)
    VALUES(p_login, p_fname, p_lname, p_tallness);
END;

EXECUTE AddStudent('nov01', 'Jan', 'Novak', 150);

SELECT * FROM Student;

--1.2
CREATE OR REPLACE FUNCTION FAddStudent(
    p_login VARCHAR2,
    p_fname VARCHAR2,
    p_lname VARCHAR2,
    p_tallness VARCHAR2)
RETURN VARCHAR2
AS
BEGIN
    INSERT INTO Student(login, fname, lname, tallness)
        VALUES(p_login, p_fname, p_lname, p_tallness);
    COMMIT;
    RETURN 'ok';
EXCEPTION 
    WHEN OTHERS THEN
        RETURN 'error';
END;

SET SERVEROUTPUT ON;
SET AUTOCOMMIT OFF;

EXEC DBMS_OUTPUT.PUT_LINE(FAddStudent('mot01', 'Jan', 'Motak', 179));

SELECT * FROM Student;

--------------------------------------------------------------------------------------------
--ukol 2
CREATE TABLE Teacher (
    login CHAR(6) NOT NULL PRIMARY KEY,
    fname VARCHAR2(30) NOT NULL,
    lname VARCHAR2(50) NOT NULL,
    department INT NOT NULL,
    specialization VARCHAR2(30) NULL);

--2.1
CREATE OR REPLACE PROCEDURE StudentBecomeTeacher(
    p_login IN Student.login%TYPE,
    p_department IN Teacher.department%TYPE)
AS
    v_student Student%ROWTYPE;
BEGIN
    SELECT * INTO v_student
    FROM Student
    WHERE login = p_login;
    INSERT INTO Teacher(login, fname, lname, department)
        VALUES(v_student.login, v_student.fname, v_student.lname, p_department);
    DELETE FROM Student WHERE login = p_login;
COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END StudentBecomeTeacher;

--ALT
CREATE OR REPLACE PROCEDURE StudentBecomeTeacher(
    p_login IN Student.login%TYPE,
    p_department IN Teacher.department%TYPE)
AS
BEGIN
    INSERT INTO Teacher
    SELECT p_login, fname, lname, p_department, null
    FROM Student
    WHERE login = p_login;
    
    DELETE FROM Student WHERE login = p_login;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;

SELECT * FROM teacher;

EXEC StudentBecomeTeacher('nov01', 100);

--2.3
CREATE OR REPLACE PROCEDURE AddStudent2(
    p_fname IN Student.fname%TYPE,
    p_lname IN Student.lname%TYPE,
    p_tallness IN Student.tallness%TYPE)
AS
    v_login Student.lname%TYPE;
BEGIN
    v_login := (SUBSTR(p_lname, 0, 3) || '00');
    INSERT INTO Student(login, fname, lname, tallness)
        VALUES(v_login, p_fname, p_lname, p_tallness);
END;

DESC student;

EXEC AddStudent2('Teemo', 'BigSad', 175);

SELECT * FROM Student;

--------------------------------------------------------------------------------------------
--ukol 3
--3.1
ALTER TABLE Student ADD isTall INT CHECK(isTall IN(0, 1));

--3.2
CREATE OR REPLACE PROCEDURE IsStudentTall(
    p_login IN Student.login%TYPE)
AS
    v_avg_tallness Student.tallness%TYPE;
    v_student_tallness Student.tallness%TYPE;
BEGIN
    SELECT AVG(tallness) INTO v_avg_tallness
        FROM Student;
    SELECT Student.tallness INTO v_student_tallness
        FROM Student WHERE Student.login = p_login;

    IF v_student_tallness > v_avg_tallness THEN
        UPDATE Student
            SET Student.isTall = 1
            WHERE Student.login = p_login;
    ELSE
        UPDATE Student
            SET Student.isTall = 0
            WHERE Student.login = p_login;
    END IF;
END;

EXEC IsStudentTall('mot01');
EXEC IsStudentTall('nov01');

SELECT * FROM Student;

--3.3
CREATE OR REPLACE FUNCTION LoginExist(
    p_login student.login%TYPE)
RETURN BOOLEAN
AS
    v_login student.login%TYPE;
BEGIN
    SELECT login INTO v_login
    FROM student WHERE login = p_login;
    RETURN TRUE;
EXCEPTION
    WHEN no_data_found THEN
    RETURN FALSE;
END;

--test funkce
BEGIN
    IF LoginExist('buh06') THEN
        DBMS_OUTPUT.PUT_LINE('Existuje');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Neexistuje');        
    END IF;
END;

CREATE OR REPLACE PROCEDURE AddStudent2(
    p_fname IN Student.fname%TYPE,
    p_lname IN Student.lname%TYPE,
    p_tallness IN Student.tallness%TYPE)
AS
    v_login Student.lname%TYPE;
    v_counter INT := 0;
BEGIN
    LOOP
        v_login := (SUBSTR(p_lname, 0, 3) || '00' || TO_CHAR(v_counter));
        EXIT WHEN NOT LoginExist(v_login);
        v_counter := v_counter + 1;
    END LOOP;
    INSERT INTO Student(login, fname, lname, tallness)
        VALUES(v_login, p_fname, p_lname, p_tallness);
END;

EXEC AddStudent2('Teemo', 'BigSad', 175);

SELECT * FROM Student;

--------------------------------------------------------------------------------------------
--ukol 4
--4.1
CREATE OR REPLACE PROCEDURE IsStudentTall
AS
    CURSOR c_cursor IS SELECT * FROM Student;
    v_avg_tallness Student.tallness%TYPE;
    v_student Student%ROWTYPE;
BEGIN
    SELECT AVG(tallness) INTO v_avg_tallness
        FROM Student;
    
    OPEN c_cursor;
    LOOP
        FETCH c_cursor INTO v_student;
        EXIT WHEN c_cursor%NOTFOUND;

        IF v_student.tallness > v_avg_tallness THEN
            UPDATE Student
                SET Student.isTall = 1
                WHERE Student.login = v_student.login;
        ELSE
            UPDATE Student
                SET Student.isTall = 0
                WHERE Student.login = v_student.login;
        END IF;
    END LOOP;
END;

EXEC AddStudent2('Teemo', 'BigSad', 75);
EXEC AddStudent2('Teemo', 'BigSad', 195);
EXEC AddStudent2('Teemo', 'BigSad', 155);
EXEC AddStudent2('Teemo', 'BigSad', 148);

EXEC IsStudentTall();

SELECT * FROM Student;

--4.2
CREATE OR REPLACE PROCEDURE IsStudentTall
AS
    v_avg_tallness Student.tallness%TYPE;
BEGIN
    SELECT AVG(tallness) INTO v_avg_tallness FROM Student;
    
    FOR one_student IN (SELECT login, tallness FROM Student)
    LOOP
        IF one_student.tallness > v_avg_tallness THEN
            UPDATE Student
                SET Student.isTall = 1
                WHERE Student.login = one_student.login;
        ELSE
            UPDATE Student
                SET Student.isTall = 0
                WHERE Student.login = one_student.login;
        END IF;
    END LOOP;
END;

EXEC AddStudent2('Teemo', 'Sad', 88);
EXEC AddStudent2('Teemo', 'Sad', 197);
EXEC AddStudent2('Teemo', 'Sad', 156);
EXEC AddStudent2('Teemo', 'Sad', 142);

EXEC IsStudentTall();

SELECT * FROM Student;




















