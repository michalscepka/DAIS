CREATE TABLE Student (
    login CHAR(6) PRIMARY KEY,
    jmeno VARCHAR(30) NOT NULL,
    prijmeni VARCHAR(50) NOT NULL
);

CREATE TABLE Ucitel (
    login CHAR(5) PRIMARY KEY,
    jmeno VARCHAR(30) NOT NULL,
    prijmeni VARCHAR(50) NOT NULL
);

CREATE TABLE Kurz (
    kod CHAR(11) PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL
);

CREATE TABLE StudijniPlan (
    studentLogin CHAR(6) NOT NULL REFERENCES Student,
    kurzKod CHAR(11) NOT NULL REFERENCES Kurz,
    rok NUMBER(4) NOT NULL,
    PRIMARY KEY(studentLogin, kurzKod, rok)
);

CREATE TABLE Garant (
    ucitelLogin CHAR(5) NOT NULL REFERENCES Ucitel,
    kurzKod CHAR(11) NOT NULL REFERENCES Kurz,
    rok NUMBER(4) NOT NULL,
    PRIMARY KEY(ucitelLogin, kurzKod, rok)
);

SELECT * FROM Student;
SELECT * FROM Ucitel;
SELECT * FROM Kurz;
SELECT * FROM StudijniPlan;
SELECT * FROM Garant;

--smazani vsech zaznamu z tabulek
DELETE FROM StudijniPlan;
DELETE FROM Garant;
DELETE FROM Kurz;
DELETE FROM Student;
DELETE FROM Ucitel;

--smazani tabulek
DROP TABLE StudijniPlan;
DROP TABLE Garant;
DROP TABLE Kurz;
DROP TABLE Student;
DROP TABLE Ucitel;

--naplneni tabulek
INSERT INTO Student VALUES('pla457', 'Jan', 'Plavacek');
INSERT INTO Student VALUES('sob458', 'Yveta', 'Sobotova');
INSERT INTO Student VALUES('sob451', 'Honza', 'Sob');

INSERT INTO Kurz VALUES('456-dais-01', 'Databazove a informacni systemy');
INSERT INTO Kurz VALUES('456-tzd-01', 'Teorie zpracovani dat');
INSERT INTO Kurz VALUES('456-tis-01', 'Tvorba informacnich systemu');
INSERT INTO Kurz VALUES('456-sd-01', 'Sprava databazi');
INSERT INTO Kurz VALUES('456-sd2-01', 'Sprava databazi 2');

INSERT INTO Ucitel VALUES('bay01', 'Josef', 'Bayer');
INSERT INTO Ucitel VALUES('cod02', 'Stanislav', 'Codd');

INSERT INTO StudijniPlan VALUES('pla457', '456-dais-01', 2009);
INSERT INTO StudijniPlan VALUES('pla457', '456-tis-01', 2009);
INSERT INTO StudijniPlan VALUES('pla457', '456-sd-01', 2009);
INSERT INTO StudijniPlan VALUES('sob458', '456-tzd-01', 2009);
INSERT INTO StudijniPlan VALUES('sob458', '456-sd-01', 2009);
INSERT INTO StudijniPlan VALUES('sob458', '456-sd2-01', 2009);
INSERT INTO StudijniPlan VALUES('sob451', '456-dais-01', 2009);
INSERT INTO StudijniPlan VALUES('sob451', '456-tis-01', 2009);
INSERT INTO StudijniPlan VALUES('sob451', '456-sd2-01', 2009);

INSERT INTO Garant VALUES('bay01', '456-sd-01', 2009);
INSERT INTO Garant VALUES('bay01', '456-sd2-01', 2009);
INSERT INTO Garant VALUES('cod02', '456-dais-01', 2009);
INSERT INTO Garant VALUES('cod02', '456-tzd-01', 2009);

--ukol 2.4
SELECT *
FROM Student
JOIN StudijniPlan ON Student.login = studijniplan.studentlogin
JOIN Kurz ON studijniplan.kurzkod = kurz.kod
JOIN Garant ON kurz.kod = garant.kurzkod
JOIN Ucitel ON garant.ucitellogin = ucitel.login
WHERE studijniplan.rok = 2009 AND ucitel.prijmeni = 'Codd';

SELECT k.nazev
FROM Kurz k
JOIN StudijniPlan sp ON k.kod = sp.kurzKod
JOIN Student s ON sp.studentlogin = s.login
WHERE sp.rok = 2009 AND s.prijmeni = 'Plavacek';

SELECT k.nazev
FROM Kurz k
JOIN StudijniPlan sp ON k.kod = sp.kurzKod
JOIN Student s ON sp.studentlogin = s.login
WHERE s.prijmeni = 'Plavacek';

SELECT DISTINCT kurz.kod
FROM kurz
JOIN studijniplan sp ON kurz.kod = sp.kurzkod;

SELECT DISTINCT u.login
FROM ucitel u
JOIN garant g ON u.login = g.ucitellogin
JOIN kurz k ON g.kurzkod = k.kod
JOIN studijniplan sp ON k.kod = sp.kurzkod
WHERE g.rok = 2009 AND sp.rok = 2009;

--ukol 2.5
ALTER TABLE Ucitel
ADD pracPomerZacatek DATE
ADD pracPomerKonec DATE;

INSERT INTO Ucitel VALUES('pain0', 'Big', 'Sad', TO_DATE('15.08.2009', 'DD.MM.YYYY'), TO_DATE('15.08.2019', 'DD.MM.YYYY'));

UPDATE ucitel
SET ucitel.pracpomerzacatek = TO_DATE('05.08.2018', 'DD.MM.YYYY')
WHERE ucitel.login = 'bay01';

UPDATE ucitel
SET ucitel.pracpomerzacatek = TO_DATE('15.08.2009', 'DD.MM.YYYY')
WHERE ucitel.login = 'cod02';

SELECT DISTINCT u.login
FROM ucitel u
JOIN garant g ON u.login = g.ucitellogin
WHERE ((SELECT CURRENT_DATE FROM dual) - ADD_MONTHS(u.pracpomerzacatek, 36)) > 0;

--odecte 36 mesicu od aktualniho data
SELECT TO_DATE('11.2.2020', 'DD.MM.YYYY') FROM dual;
SELECT ADD_MONTHS(SYSDATE, -36) FROM dual;

--ukol 4.1
SELECT * FROM USER_TABLES;

SELECT * FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'STUDENT';

--ukol 5
SELECT COLUMN_NAME, DATA_TYPE
FROM USER_TAB_COLUMNS 
WHERE TABLE_NAME = UPPER('Student');

--ukol 6.1
ALTER TABLE Student ADD Vek DECIMAL(5,2)
CHECK(Vek BETWEEN 0 AND 150);

ALTER TABLE Ucitel ADD oddeleni INT CHECK(oddeleni IN (100, 200, 300));

--ukol 6.2
UPDATE student
SET student.vek = 20
WHERE student.login = 'pla457';

UPDATE student
SET student.vek = 19
WHERE student.login = 'sob451';

UPDATE student
SET student.vek = 23
WHERE student.login = 'sob458';

SELECT DISTINCT sp.kurzkod
FROM studijniplan sp
JOIN student s ON sp.studentlogin = s.login
WHERE s.vek BETWEEN 20 AND 26;

SELECT st.login, COUNT(DISTINCT sp.kurzkod) AS pocet_kurzu
FROM Student st
LEFT JOIN StudijniPlan sp ON st.login = sp.studentlogin AND rok = 2009
GROUP BY st.login;

--ukol 7

--ukol 8






