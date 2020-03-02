--Ukol 1: Triggery
--1.1
CREATE TABLE TStatistics (
    op VARCHAR2(20),
    operationCount INT
);

INSERT INTO TStatistics VALUES ('insert', 0);
INSERT INTO TStatistics VALUES ('update', 0);
INSERT INTO TStatistics VALUES ('delete', 0);

SELECT * FROM TStatistics;

CREATE OR REPLACE
TRIGGER OperationCount
BEFORE DELETE OR INSERT OR UPDATE ON Student
FOR EACH ROW
DECLARE
BEGIN
    IF inserting THEN
        UPDATE TStatistics SET operationCount = operationCount + 1
        WHERE op = 'insert';
    END IF;
    IF updating THEN
        UPDATE TStatistics SET operationCount = operationCount + 1
        WHERE op = 'update';
    END IF;
    IF deleting THEN
        UPDATE TStatistics SET operationCount = operationCount + 1
        WHERE op = 'delete';
    END IF;
END;

EXEC AddStudent2('Jana', 'Motakova', 155);

EXEC IsStudentTall();

SELECT * FROM Student;

UPDATE Student SET isTall = NULL;

--1.2, 1.3
EXEC AddStudent('pla457', 'Jan', 'Plavacek', 175);
EXEC AddStudent('sob458', 'Yveta', 'Sobotova', 175);
EXEC AddStudent('sob451', 'Honza', 'Sob', 175);

ALTER TABLE Kurz ADD kapacita INT;

UPDATE Kurz SET kapacita = 3;

SELECT * FROM Kurz;
SELECT * FROM StudijniPlan;

CREATE OR REPLACE TRIGGER kontrolaKapacity
BEFORE INSERT ON StudijniPlan
FOR EACH ROW
DECLARE
    v_pocet_studentu INT;
    v_kapacita INT;
    plna_kapacita EXCEPTION;
BEGIN
    SELECT kapacita INTO v_kapacita FROM Kurz 
        WHERE kurz.kod = :NEW.kurzkod;
        
    SELECT COUNT(*) INTO v_pocet_studentu FROM StudijniPlan
        WHERE kurzkod = :NEW.kurzkod;
        
    IF v_pocet_studentu >= v_kapacita THEN
        DBMS_OUTPUT.PUT_LINE('Kapacita naplnena!');
        RAISE plna_kapacita;
    END IF;
END;

SELECT * FROM StudijniPlan;
SELECT * FROM Student;
SET SERVEROUTPUT ON;

INSERT INTO StudijniPlan
VALUES ('nov01', '456-dais-01', 2009);
INSERT INTO StudijniPlan
VALUES ('Big000', '456-dais-01', 2009);
INSERT INTO StudijniPlan
VALUES ('sob458', '456-dais-01', 2009);

INSERT INTO StudijniPlan
VALUES ('Big000', '456-sd-01', 2009);
INSERT INTO StudijniPlan
VALUES ('nov01', '456-sd-01', 2009);

--Ukol 2: Zaloha tabulky
--2.1
SELECT * FROM USER_TAB_COLUMNS WHERE table_name = 'STUDENT';

create or replace PROCEDURE CopyTableStructure(p_table_name VARCHAR2)
AS
    v_sql VARCHAR2(2000);
    v_first_row BOOLEAN := TRUE;
BEGIN
    v_sql := 'CREATE TABLE ' || p_table_name || '_old (';

    FOR one_param IN (SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH FROM USER_TAB_COLUMNS WHERE table_name = UPPER(p_table_name))
    LOOP
        IF v_first_row = FALSE THEN
            v_sql := v_sql || ',';
        END IF;
        v_sql := v_sql || one_param.COLUMN_NAME || ' ' || one_param.DATA_TYPE || '(' || one_param.DATA_LENGTH || ')';
        v_first_row := FALSE;
    END LOOP;
    v_sql := v_sql || ')';

    EXECUTE IMMEDIATE v_sql;
    DBMS_OUTPUT.PUT_LINE(v_sql);
END;

EXEC CopyTableStructure('student');

SELECT * FROM student_old;
DROP TABLE student_old;

--2.2
create or replace PROCEDURE CopyTable(
    p_table_name VARCHAR2)
AS
BEGIN
    CopyTableStructure(p_table_name);
    EXECUTE IMMEDIATE 'INSERT INTO ' || p_table_name || '_old SELECT * FROM ' || p_table_name;
END;

EXEC CopyTable('Student');

SELECT * FROM Student;
SELECT * FROM student_old;
DROP TABLE student_old;

INSERT INTO student_old (SELECT * FROM Student);

---------------------------------PROJIT SI UKOL 3--------------------------
--Ukol 3a: Vazane promenne
-- 570.53s
DECLARE
  TYPE rc IS REF CURSOR;
  v_rc rc;
  v_dummy ALL_OBJECTS.OBJECT_NAME%type;
  v_start NUMBER DEFAULT DBMS_UTILITY.GET_TIME;
BEGIN
  FOR i IN 1 .. 10000
  LOOP
    OPEN v_rc FOR 
      'select object_name from all_objects
         where object_id = ' || i;
    FETCH v_rc INTO v_dummy;
    -- DBMS_OUTPUT.PUT_LINE(i || ': ' || v_dummy);
    CLOSE v_rc;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(round((DBMS_UTILITY.GET_TIME-v_start)/100, 2) || ' s' );
END;
/

-------------------------------------------------------------------------------

-- 1.62s
DECLARE
  TYPE rc IS REF CURSOR;
  v_rc rc;
  v_dummy ALL_OBJECTS.OBJECT_NAME%type;
  v_start NUMBER DEFAULT DBMS_UTILITY.GET_TIME;
BEGIN
  FOR i IN 1 .. 10000
  LOOP
    OPEN v_rc FOR
      'select object_name from all_objects
         where object_id = :x' USING i;
    FETCH v_rc INTO v_dummy;
    CLOSE v_rc;
    -- DBMS_OUTPUT.PUT_LINE(i || ': ' || v_dummy);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(round((DBMS_UTILITY.GET_TIME-v_start)/100, 2) || ' s' );
END;

--Ukol 3b: Vazane promenne
CREATE TABLE Usertab(
  ID NUMBER PRIMARY KEY,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL)
  
-------------------------------------------------------------------------------
-- 34,88 s
DECLARE
  v_fname Usertab.fname%TYPE;
  v_lname Usertab.lname%TYPE;
  v_str VARCHAR(100);
  v_start NUMBER DEFAULT DBMS_UTILITY.GET_TIME;
BEGIN
  FOR i IN 1 .. 100000
  LOOP
    v_fname := 'fname' || i;
    v_lname := 'lname' || i;
    v_str := 'INSERT INTO Usertab VALUES(' || i || ',''' || v_fname || ''',''' || v_lname || ''')';
    EXECUTE IMMEDIATE v_str;
    -- DBMS_OUTPUT.PUT_LINE(v_str);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(round((DBMS_UTILITY.GET_TIME-v_start)/100, 2) || ' s' );
END;
/

-------------------------------------------------------------------------------
-- 5,07 s 
DECLARE
  v_fname Usertab.fname%TYPE;
  v_lname Usertab.lname%TYPE;
  v_str VARCHAR(100);
  v_start NUMBER DEFAULT DBMS_UTILITY.GET_TIME;
BEGIN
  FOR i IN 1 .. 100000
  LOOP
    v_fname := 'fname' || i;
    v_lname := 'lname' || i;
    v_str := 'INSERT INTO Usertab VALUES(:1,:2,:3)';
    EXECUTE IMMEDIATE v_str USING i,v_fname,v_lname;
    -- DBMS_OUTPUT.PUT_LINE(v_str);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(round((DBMS_UTILITY.GET_TIME-v_start)/100, 2) || ' s' );
END;

--Ukol 3c: COMMIT

--Ukol 4: Vyjimky 1/2
--4.1
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

--4.2
create or replace FUNCTION InsertStudent(
    p_login student.login%TYPE,
    p_fname student.fname%TYPE,
    p_lname student.lname%TYPE)
RETURN BOOLEAN
AS
BEGIN
    INSERT INTO Student(login, fname, lname)
        VALUES(p_login, p_fname, p_lname);
    RETURN TRUE;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
    RETURN FALSE;
END;

BEGIN
    IF insertStudent('pav025', 'Jan', 'Pavel') THEN
        DBMS_OUTPUT.PUT_LINE('Vlozeno');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nevlozeno');
    END IF;
END;

--Ukol 4: Vyjimky 2/2
--4.1
--------------------------------------------------------------------NEDODELANE
create or replace PROCEDURE StudentBecomeTeacher(
    p_login IN Student.login%TYPE,
    p_department INT)
AS
    v_student Student%ROWTYPE;
    p_login_exists EXCEPTION;
    PRAGMA exception_init(p_login_exists, -1);
BEGIN
    SELECT * INTO v_student
        FROM Student WHERE login = p_login;
    INSERT INTO Teacher(login, fname, lname, department)
        VALUES(v_student.login, v_student.fname, v_student.lname, p_department);
    DELETE FROM Student WHERE login = p_login;
COMMIT;
EXCEPTION
    WHEN p_login_exists THEN
        DBMS_OUTPUT.PUT_LINE('Login jiz existuje!');
    WHEN OTHERS THEN
        ROLLBACK;
END StudentBecomeTeacher;

SELECT * FROM Teacher;
SELECT * FROM Student;
SELECT * FROM StudijniPlan;

EXEC StudentBecomeTeacher('Big000', 100);













