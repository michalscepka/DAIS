--------------------------------------------------------------------------------------------
-- Ukol 1: Ulozene procedury a funkce
--------------------------------------------------------------------------------------------
CREATE TABLE Student (
	login CHAR(6) PRIMARY KEY,
	fname VARCHAR(30) NOT NULL,
	lname VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL);

SELECT * FROM Student
GO

--------------------------------------------------------------------------------------------
-- 1.1
--------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE AddStudent (
	@p_login CHAR(6),
	@p_fname VARCHAR(30),
	@p_lname VARCHAR(50),
	@p_email VARCHAR(50))
AS
BEGIN
	INSERT INTO Student VALUES(@p_login, @p_fname, @p_lname, @p_email);
END

EXEC AddStudent 'nov000', 'Jan', 'Novak', 'jan.novak@gmail.com';
GO

--------------------------------------------------------------------------------------------
-- 1.2
--------------------------------------------------------------------------------------------
CREATE PROCEDURE PAddStudent(
	@p_login CHAR(6),
	@p_fname VARCHAR(30),
	@p_lname VARCHAR(50),
	@p_email VARCHAR(50),
	@p_ret VARCHAR(10) OUT)
AS
BEGIN
	BEGIN TRY
		INSERT INTO Student VALUES(@p_login, @p_fname, @p_lname, @p_email);
		SET @p_ret = 'ok';
	END TRY
	BEGIN CATCH
		SET @p_ret = 'error';
	END CATCH
END
GO

BEGIN
	DECLARE @v_str VARCHAR(10);
	EXEC PAddStudent 'nov001', 'Jana', 'Novakova', 'jana.novakova@gmail.com', @v_str OUT;
	PRINT @v_str;
END

--------------------------------------------------------------------------------------------
-- Ukol 2: Promenne
--------------------------------------------------------------------------------------------
CREATE TABLE Teacher (
	login CHAR(6) NOT NULL PRIMARY KEY,
	fname VARCHAR(30) NOT NULL,
	lname VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	department INT NOT NULL,
	specialization VARCHAR(30) NULL);

SELECT * FROM Teacher;
GO

--------------------------------------------------------------------------------------------
-- 2.1
--------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE StudentBecomeTeacher(@p_login CHAR(6), @p_department INT)
AS
BEGIN
	INSERT INTO Teacher(login, fname, lname, email, department, specialization)
		SELECT *, @p_department, NULL FROM Student WHERE login = @p_login;
	DELETE FROM Student WHERE login = @p_login;
END
GO

EXEC StudentBecomeTeacher 'nov000', 1;

SELECT * FROM Student;
SELECT * FROM Teacher;
GO

--------------------------------------------------------------------------------------------
-- 2.2
--------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE StudentBecomeTeacher(@p_login CHAR(6), @p_department INT)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO Teacher(login, fname, lname, email, department, specialization)
			SELECT *, @p_department, NULL FROM Student WHERE login = @p_login;
		DELETE FROM Student WHERE login = @p_login;
		COMMIT;
	END TRY
	BEGIN CATCH
		ROLLBACK;
	END CATCH;
END
GO

EXEC StudentBecomeTeacher 'nov001', 1;
GO

SELECT * FROM Student;
SELECT * FROM Teacher;
GO
--------------------------------------------------------------------------------------------
-- Ukol 3: Promenne
--------------------------------------------------------------------------------------------
DROP TABLE Student;
CREATE TABLE Student (
	login CHAR(6) PRIMARY KEY,
	fname VARCHAR(30) NOT NULL,
	lname VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	tallness INT NOT NULL);
GO

--------------------------------------------------------------------------------------------
-- 3.1
--------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE AddStudent2(@p_fname VARCHAR(30), @p_lname VARCHAR(50), @p_tallness INT)
AS
BEGIN
	DECLARE @v_login CHAR(6);
	DECLARE @v_email VARCHAR(50);

	SET @v_login = SUBSTRING(LOWER(@p_lname), 1, 3) + '000';
	SET @v_email = @v_login + '@vsb.cz';

	INSERT INTO Student(login, fname, lname, email, tallness)
		VALUES(@v_login, @p_fname, @p_lname, @v_email, @p_tallness);
END
GO

EXEC AddStudent2 'Teemo', 'Motac', 175;

SELECT * FROM Student;
GO
--------------------------------------------------------------------------------------------
-- Ukol 4: Ridici konstrukce
-- 4.1
--------------------------------------------------------------------------------------------
ALTER TABLE Student ADD isTall INTEGER CHECK (isTall IN (0, 1));
GO

--------------------------------------------------------------------------------------------
-- 4.2
--------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE IsStudentTall(@p_login CHAR(6))
AS
BEGIN
	DECLARE @v_avg INTEGER;
	DECLARE @v_tallness INTEGER;

	SELECT @v_avg = AVG(tallness) FROM Student;
	SELECT @v_tallness = tallness FROM Student WHERE login = @p_login;
	
	IF @v_avg < @v_tallness
		UPDATE Student SET isTall = 1 WHERE login = @p_login;
	ELSE
		UPDATE Student SET isTall = 0 WHERE login = @p_login;
END
GO

EXEC IsStudentTall 'mot000';

SELECT * FROM Student;
GO
--------------------------------------------------------------------------------------------
-- 4.3
--------------------------------------------------------------------------------------------
CREATE OR ALTER FUNCTION LoginExist(@p_login CHAR(6))
RETURNS BIT
AS
BEGIN
	IF EXISTS(SELECT * FROM Student WHERE login = @p_login)
		RETURN 1;
	RETURN 0;
END
GO

CREATE OR ALTER PROCEDURE AddStudent3(@p_fname VARCHAR(30), @p_lname VARCHAR(50), @p_tallness INT)
AS
BEGIN
	DECLARE @v_login CHAR(6);
	DECLARE @v_email VARCHAR(50);
	DECLARE @v_i INTEGER;
	DECLARE @v_tmp_login VARCHAR(20);

	SET @v_tmp_login = SUBSTRING(LOWER(@p_lname), 1, 3);
	SET @v_i = 0;

	WHILE @v_i < 1000 BEGIN
		IF @v_i < 10
			SET @v_login = @v_tmp_login + '00' + CAST(@v_i AS CHAR);
		ELSE IF @v_i < 100
			SET @v_login = @v_tmp_login + '0' + CAST(@v_i AS CHAR);
		ELSE
			SET @v_login = @v_tmp_login + CAST(@v_i AS CHAR);

		IF dbo.LoginExist(@v_login) = 0
			BREAK;
		
		SET @v_i = @v_i + 1;
	END

	SET @v_email = @v_login + '@vsb.cz';
	INSERT INTO Student(login, fname, lname, email, tallness)
		VALUES(@v_login, @p_fname, @p_lname, @v_email, @p_tallness);
END
GO

EXEC AddStudent3 'Motac', 'Teemo', 185;

SELECT * FROM Student;
GO

--------------------------------------------------------------------------------------------
-- Ukol 5: Kurzor
--------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetStudentTallness
AS
BEGIN
	DECLARE @v_login CHAR(6);
	DECLARE @v_avg INTEGER;
	DECLARE @v_tallness INTEGER;

	DECLARE studentList CURSOR FOR SELECT login, tallness FROM Student;

	SELECT @v_avg = AVG(tallness) FROM Student;

	OPEN studentList;
	FETCH NEXT FROM studentList INTO @v_login, @v_tallness;
	
	WHILE @@FETCH_STATUS = 0 BEGIN
		IF @v_avg < @v_tallness
			UPDATE Student SET isTall = 1 WHERE login = @v_login;
		ELSE
			UPDATE Student SET isTall = 0 WHERE login = @v_login;

		FETCH NEXT FROM studentList INTO @v_login, @v_tallness;
	END

	CLOSE studentList
	DEALLOCATE studentList
END
GO

EXEC SetStudentTallness;

SELECT * FROM Student;
GO

--------------------------------------------------------------------------------------------
-- Ukol 6: Zaloha tabulky
--------------------------------------------------------------------------------------------
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_CATALOG = 'sce0007' AND TABLE_NAME = 'Student';

GO

CREATE OR ALTER PROCEDURE CopyTableStructure(@p_table_catalog VARCHAR(30), @p_table_name VARCHAR(30))
AS
BEGIN
	DECLARE c_columnList CURSOR FOR
		SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_CATALOG = @p_table_catalog AND TABLE_NAME = @p_table_name;
	DECLARE @v_command NVARCHAR(1000);
	DECLARE @v_column_name VARCHAR(30);
	DECLARE @v_data_type VARCHAR(10);
	DECLARE @v_char_max_length INT;
	DECLARE @v_index INT;
	DECLARE @v_delim VARCHAR(1);

	OPEN c_columnList;
	FETCH NEXT FROM c_columnList INTO @v_column_name, @v_data_type, @v_char_max_length;

	SET @v_command = 'CREATE TABLE ' + @p_table_name + '_old (';
	SET @v_index = 0;
  
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @v_index > 0
			SET @v_delim = ',';
		ELSE  
			SET @v_delim = '';

		SET @v_command = @v_command + @v_delim + @v_column_name + ' ' + @v_data_type;
    
		IF (@v_data_type = 'char' OR @v_data_type = 'varchar')
			SET @v_command = @v_command + '(' + CAST(@v_char_max_length AS VARCHAR(10)) + ')';
      
		FETCH NEXT FROM c_columnList INTO @v_column_name,@v_data_type,@v_char_max_length;
		SET @v_index = @v_index + 1;
	END
  
	SET @v_command = @v_command + ')';  
	PRINT @v_command;
  
	EXEC sp_executesql @v_command;
  
	CLOSE c_columnList;
	DEALLOCATE c_columnList;  
END;

GO

CREATE OR ALTER PROCEDURE CopyTable(@p_table_catalog VARCHAR(30), @p_table_name VARCHAR(30))
AS
BEGIN
	EXEC CopyTableStructure @p_table_catalog, @p_table_name;
  
	DECLARE @v_command NVARCHAR(1000);
	SET @v_command = 'INSERT INTO ' + @p_table_name + '_old SELECT * FROM ' + @p_table_name;
	EXEC sp_executesql @v_command;  
END;

EXEC CopyTable 'sce0007', 'Student';

SELECT * from Student_old;
DROP TABLE Student_old;

--------------------------------------------------------------------------------------------
-- Ukol 7: Triggery
-- 7.1
--------------------------------------------------------------------------------------------
CREATE TABLE Statistiky (
	operace VARCHAR(20),
	pocet INTEGER)
INSERT INTO statistiky VALUES ('insert', 0)
INSERT INTO statistiky VALUES ('update', 0)
INSERT INTO statistiky VALUES ('delete', 0)

SELECT * FROM Statistiky

GO

CREATE TRIGGER insertStudent
ON Student
FOR INSERT
AS
BEGIN
	UPDATE statistiky SET pocet = pocet + 1 WHERE operace = 'insert'
END

GO

CREATE TRIGGER deleteStudent
ON Student
FOR DELETE
AS
BEGIN
	UPDATE statistiky SET pocet = pocet + 1 WHERE operace = 'delete'
END

GO

CREATE TRIGGER updateStudent
ON Student
FOR UPDATE
AS
BEGIN
	UPDATE statistiky SET pocet = pocet + 1 WHERE operace = 'update'
END

GO

--------------------------------------------------------------------------------------------
-- 7.2
--------------------------------------------------------------------------------------------
CREATE TABLE Kurz (
	id INTEGER PRIMARY KEY,
	name VARCHAR(30),
	kapacita INTEGER);

CREATE TABLE StudijniPlan (
	idStudent CHAR(6),
	idKurz INT);

GO

CREATE TRIGGER kontrolaKapacity
ON Studijniplan
FOR INSERT
AS
BEGIN
	IF (SELECT COUNT(*) FROM StudijniPlan, Inserted WHERE Studijniplan.idKurz = inserted.idKurz) >
		(SELECT kapacita FROM Kurz, Inserted WHERE id = inserted.idKurz)
		PRINT 'Kapacita prekrocena';
END;

GO

--------------------------------------------------------------------------------------------
-- Ukol 8.1: Vytvoreni tabulky
--------------------------------------------------------------------------------------------
DROP TABLE Teacher
CREATE TABLE Teacher (
	login CHAR(5) PRIMARY KEY NOT NULL,
	fname VARCHAR(30) NOT NULL,
	lname VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	department INTEGER NOT NULL)

CREATE TABLE Department (
	id INTEGER PRIMARY KEY IDENTITY,
	name VARCHAR(50) NOT NULL,
	head CHAR(5))

ALTER TABLE Teacher ADD CONSTRAINT fk_teacher_department FOREIGN KEY(department) REFERENCES Department(id);
ALTER TABLE Department ADD CONSTRAINT fk_department_teacher FOREIGN KEY(head) REFERENCES Teacher;

--------------------------------------------------------------------------------------------
-- Ukol 8.2: Zruseni tabulek
--------------------------------------------------------------------------------------------
ALTER TABLE Teacher DROP CONSTRAINT fk_teacher_department;
ALTER TABLE Department DROP CONSTRAINT fk_department_teacher;

DROP TABLE Department;
DROP TABLE Teacher;

--------------------------------------------------------------------------------------------
-- Ukol 8.3: Vlozeni zaznamu
--------------------------------------------------------------------------------------------
INSERT INTO Department(name) VALUES('Katedra informatiky');
INSERT INTO Department(name) VALUES('Katedra aplikovane matematiky');
INSERT INTO Department(name) VALUES('Katedra softwaroveho inzenyrstvi');

INSERT INTO Teacher VALUES('sob28', 'Jan', 'Sobota', 'jan.sobota@vsb,cz', 1);
INSERT INTO Teacher VALUES('pon28', 'Jan', 'Pondeli', 'jan.pondeli@vsb.cz', 1);

INSERT INTO Teacher VALUES('ned29', 'Petr', 'Nedele', 'petr.nedele@vsb,cz', 2);
INSERT INTO Teacher VALUES('ute29', 'Petr', 'Utery', 'petr.utery@vsb,cz', 2);

INSERT INTO Teacher VALUES('str29', 'Jana', 'Stredova', 'jana.stredova@vsb,cz', 3);

UPDATE Department SET head='sob28' WHERE id=1;
UPDATE Department SET head='ned29' WHERE id=2;

SELECT * FROM Department;
SELECT * FROM Teacher;

GO

--------------------------------------------------------------------------------------------
-- Ukol 9: Tiskova sestava
--------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE PrintReport
AS
BEGIN
	DECLARE @v_login CHAR(5);
	DECLARE @v_fname VARCHAR(30);
	DECLARE @v_lname VARCHAR(50);
	DECLARE @v_email VARCHAR(50);
	DECLARE @v_department INT;
	DECLARE tchList CURSOR FOR SELECT * FROM Teacher WHERE department IN 
		(SELECT department FROM Teacher GROUP BY department HAVING COUNT(*) > 1) ORDER BY department;
  
	OPEN tchList;
	FETCH NEXT FROM tchList INTO @v_login, @v_fname, @v_lname, @v_email, @v_department;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'Teacher ' + @v_login + ': ' + @v_fname + ' ' + @v_lname + ', email: ' + @v_email + ', Department ID: ' +  CAST(@v_department AS VARCHAR(3));
  
    FETCH NEXT FROM tchList INTO @v_login,@v_fname,@v_lname,@v_email,@v_department;
  END
  
  CLOSE tchList;
  DEALLOCATE tchList;  
END;

EXEC PrintReport;

--------------------------------------------------------------------------------------------
-- Ukol 10: Kopie tabulky
--------------------------------------------------------------------------------------------
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_CATALOG = 'sce0007' AND TABLE_NAME = 'Department';

SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

GO

CREATE OR ALTER PROCEDURE CopyTableDate(@p_table_schema VARCHAR(30), @p_tableName VARCHAR(30))
AS
BEGIN
	EXEC CreateTableDate @p_table_schema, @p_tableName;
	EXEC CopyTableDcp @p_table_schema, @p_tableName;
END

GO

CREATE OR ALTER PROCEDURE CreateTableDate(@p_table_schema VARCHAR(30), @p_tableName VARCHAR(30))
AS
BEGIN
	DECLARE c_columnList CURSOR FOR 
    SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH 
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = @p_table_schema AND TABLE_NAME = @p_tableName;
	DECLARE @v_command NVARCHAR(1000);
	DECLARE @v_column_name VARCHAR(30);
	DECLARE @v_data_type VARCHAR(10);
	DECLARE @v_char_max_length INT;
	DECLARE @v_index INT;
	DECLARE @v_delim VARCHAR(1);
  
	OPEN c_columnList;
	FETCH NEXT FROM c_columnList INTO @v_column_name, @v_data_type, @v_char_max_length;

	SET @v_command = 'CREATE TABLE ' + @p_tableName + '_dcp (';
	SET @v_index = 0;
  
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @v_index > 0
			SET @v_delim = ',';
		ELSE  
			SET @v_delim = '';

		SET @v_command = @v_command + @v_delim + @v_column_name + ' ' + @v_data_type;
    
		IF (@v_data_type = 'char' OR @v_data_type = 'varchar')
			SET @v_command = @v_command + '(' + CAST(@v_char_max_length AS VARCHAR(10)) + ')';
      
		FETCH NEXT FROM c_columnList INTO @v_column_name,@v_data_type,@v_char_max_length;
		SET @v_index = @v_index + 1;
	END
  
	SET @v_command = @v_command + ', date_copy DATE NOT NULL)';  
	print @v_command;
  
	EXEC sp_executesql @v_command;
  
	CLOSE c_columnList;
	DEALLOCATE c_columnList;  
END;

GO

CREATE OR ALTER PROCEDURE CopyTableDcp(@p_table_schema VARCHAR(30), @p_tableName VARCHAR(30)) 
AS
BEGIN
	DECLARE @v_command NVARCHAR(1000);
	SET @v_command = 'INSERT INTO ' + @p_tableName + '_dcp SELECT *,GETDATE() from ' + @p_tableName;
	EXEC sp_executesql @v_command;
END

EXEC CopyTableDate 'sce0007','Department';
SELECT * FROM Student;
SELECT * FROM Department_dcp;
DROP TABLE Student_dcp;

SELECT CURRENT_TIMESTAMP;
PRINT CAST('01-JAN-2009' AS DATETIME)
PRINT CONVERT(DATETIME,'01/JAN/2009')
PRINT CONVERT(DATETIME,'01.01.2011')

DECLARE @mDate DATETIME
SELECT @MDate = '01/JAN/09'
SELECT CONVERT(VARCHAR(20), @mDate,106)
