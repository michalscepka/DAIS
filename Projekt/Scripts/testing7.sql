
BEGIN
	DECLARE @cas_od TIME = '14:00'
	DECLARE @datum DATE = '2020-03-30'
	DECLARE @start_stanice_id INTEGER = 1
	DECLARE @cil_stanice_id INTEGER = 6
	DECLARE @nas_spoj INTEGER

	EXEC NajitJizdu @start_stanice_id, @cil_stanice_id, @datum, @cas_od;
END


GO

CREATE OR ALTER TRIGGER trigHistorieCeny
ON Spoj
FOR INSERT, UPDATE
AS
BEGIN
	INSERT INTO Historie_ceny(cena, datum, spoj_id) VALUES((SELECT cena_za_km FROM inserted), GETDATE(), (SELECT spoj_id FROM inserted));
END

GO



INSERT INTO Spoj VALUES('ccc', 100, 100, 1, 1, 1)

SELECT * FROM Spoj
SELECT * FROM Historie_ceny

UPDATE Spoj SET cena_za_km = 999 WHERE spoj_id = 14

SELECT * FROM Uzivatel

SELECT * FROM Jizda

GO

CREATE OR ALTER PROCEDURE CreateScript
AS
BEGIN
	ALTER TABLE stanice DROP CONSTRAINT stanice_mesto_fk;
	ALTER TABLE spoj DROP CONSTRAINT spoj_spolecnost_fk;
	ALTER TABLE prijezd DROP CONSTRAINT prijezd_stanice_fk;
	ALTER TABLE prijezd DROP CONSTRAINT prijezd_spoj_fk;
	ALTER TABLE jizdenka DROP CONSTRAINT jizdenka_uzivatel_fk;
	ALTER TABLE jizdenka_jizda DROP CONSTRAINT jizdenka_jizda_stanice_fkv2;
	ALTER TABLE jizdenka_jizda DROP CONSTRAINT jizdenka_jizda_stanice_fk;
	ALTER TABLE jizdenka_jizda DROP CONSTRAINT jizdenka_jizda_jizdenka_fk;
	ALTER TABLE jizdenka_jizda DROP CONSTRAINT jizdenka_jizda_jizda_fk;
	ALTER TABLE jizda DROP CONSTRAINT jizda_spoj_fk;
	ALTER TABLE historie_ceny DROP CONSTRAINT historie_ceny_spoj_fk;

	DROP TABLE uzivatel;
	DROP TABLE stanice;
	DROP TABLE spolecnost;
	DROP TABLE spoj;
	DROP TABLE prijezd;
	DROP TABLE mesto;
	DROP TABLE jizdenka;
	DROP TABLE jizdenka_jizda;
	DROP TABLE jizda;
	DROP TABLE historie_ceny;

	CREATE TABLE Historie_ceny (
		history_id   INTEGER PRIMARY KEY IDENTITY,
		cena         INTEGER NOT NULL,
		datum        DATETIME NOT NULL,
		spoj_id      INTEGER NOT NULL
	)

	CREATE TABLE Jizda (
		jizda_id	INTEGER PRIMARY KEY IDENTITY,
		datum_start	DATE NOT NULL,
		datum_cil   DATE NOT NULL,
		spoj_id		INTEGER NOT NULL
	)

	CREATE TABLE Jizdenka (
		jizdenka_id        INTEGER PRIMARY KEY IDENTITY,
		uzivatel_id        INTEGER NOT NULL,
		cena               INTEGER NOT NULL
	)

	CREATE TABLE jizdenka_jizda (
		jizdenka_id       INTEGER NOT NULL,
		jizda_id          INTEGER NOT NULL,
		stanice_id_start  INTEGER NOT NULL,
		stanice_id_cil    INTEGER NOT NULL,
		poradi            INTEGER NOT NULL
	)

	ALTER TABLE Jizdenka_Jizda ADD CONSTRAINT Jizdenka_Jizda_PK PRIMARY KEY CLUSTERED (jizdenka_id, jizda_id)
		WITH (
		ALLOW_PAGE_LOCKS = ON , 
		ALLOW_ROW_LOCKS = ON )

	CREATE TABLE Mesto (
		mesto_id   INTEGER PRIMARY KEY IDENTITY,
		nazev      VARCHAR(30) NOT NULL,
		kraj       VARCHAR(30) NOT NULL
	)

	CREATE TABLE Prijezd (
		stanice_id   INTEGER NOT NULL,
		spoj_id      INTEGER NOT NULL,
		cas          TIME NOT NULL,
		poradi       INTEGER NOT NULL,
		vzdalenost   INTEGER NOT NULL
	)

	ALTER TABLE Prijezd ADD CONSTRAINT Prijezd_PK PRIMARY KEY CLUSTERED (stanice_id, spoj_id)
		 WITH (
		 ALLOW_PAGE_LOCKS = ON , 
		 ALLOW_ROW_LOCKS = ON )

	CREATE TABLE Spoj (
		spoj_id         INTEGER PRIMARY KEY IDENTITY,
		nazev           VARCHAR(20) NOT NULL,
		cena_za_km      INTEGER NOT NULL,
		kapacita_mist   INTEGER NOT NULL,
		pravidelny      BIT NOT NULL,
		spolecnost_id   INTEGER NOT NULL,
		aktivni         BIT NOT NULL
	)

	CREATE TABLE Spolecnost (
		spolecnost_id   INTEGER PRIMARY KEY IDENTITY,
		nazev           VARCHAR(20) NOT NULL,
		web             VARCHAR(30) NOT NULL,
		email           VARCHAR(30) NOT NULL
	)

	CREATE TABLE Stanice (
		stanice_id   INTEGER PRIMARY KEY IDENTITY,
		nazev        VARCHAR(30) NOT NULL,
		mesto_id     INTEGER NOT NULL
	)

	CREATE TABLE Uzivatel (
		uzivatel_id         INTEGER PRIMARY KEY IDENTITY,
		login               VARCHAR(20) NOT NULL,
		jmeno               VARCHAR(20) NOT NULL,
		prijmeni            VARCHAR(20) NOT NULL,
		email               VARCHAR(30) NOT NULL,
		typ                 VARCHAR(20) NOT NULL,
		posledni_navsteva   DATETIME,
		aktivni             BIT NOT NULL
	)

	ALTER TABLE Historie_ceny 
		ADD CONSTRAINT Historie_ceny_Spoj_FK FOREIGN KEY ( spoj_id ) 
		REFERENCES Spoj ( spoj_id ) 
		ON DELETE NO ACTION 
		ON UPDATE NO ACTION 

	ALTER TABLE Jizda 
		ADD CONSTRAINT Jizda_Spoj_FK FOREIGN KEY (  spoj_id ) 
		REFERENCES Spoj (  spoj_id ) 
		ON DELETE NO ACTION 
		ON UPDATE NO ACTION 

	ALTER TABLE Jizdenka_Jizda 
		ADD CONSTRAINT Jizdenka_Jizda_Jizda_FK FOREIGN KEY (  jizda_id ) 
		REFERENCES Jizda (  jizda_id ) 
		ON DELETE CASCADE 
		ON UPDATE NO ACTION 

	ALTER TABLE Jizdenka_Jizda 
		ADD CONSTRAINT Jizdenka_Jizda_Jizdenka_FK FOREIGN KEY (  jizdenka_id ) 
		REFERENCES Jizdenka ( jizdenka_id ) 
		ON DELETE NO ACTION 
		ON UPDATE NO ACTION 

	ALTER TABLE Jizdenka_Jizda 
		ADD CONSTRAINT Jizdenka_Jizda_Stanice_FK FOREIGN KEY (  stanice_id_start ) 
		REFERENCES Stanice ( stanice_id ) 
		ON DELETE NO ACTION 
		ON UPDATE NO ACTION 

	ALTER TABLE Jizdenka_Jizda 
		ADD CONSTRAINT Jizdenka_Jizda_Stanice_FKv2 FOREIGN KEY ( stanice_id_cil ) 
		REFERENCES Stanice ( stanice_id ) 
		ON DELETE NO ACTION 
		ON UPDATE NO ACTION 

	ALTER TABLE Jizdenka 
		ADD CONSTRAINT Jizdenka_Uzivatel_FK FOREIGN KEY ( uzivatel_id ) 
		REFERENCES Uzivatel ( uzivatel_id ) 
		ON DELETE NO ACTION 
		ON UPDATE NO ACTION 

	ALTER TABLE Prijezd 
		ADD CONSTRAINT Prijezd_Spoj_FK FOREIGN KEY ( spoj_id ) 
		REFERENCES Spoj ( spoj_id ) 
		ON DELETE NO ACTION 
		ON UPDATE NO ACTION 

	ALTER TABLE Prijezd 
		ADD CONSTRAINT Prijezd_Stanice_FK FOREIGN KEY ( stanice_id ) 
		REFERENCES Stanice ( stanice_id ) 
		ON DELETE NO ACTION 
		ON UPDATE NO ACTION 

	ALTER TABLE Spoj 
		ADD CONSTRAINT Spoj_Spolecnost_FK FOREIGN KEY ( spolecnost_id ) 
		REFERENCES Spolecnost ( spolecnost_id ) 
		ON DELETE NO ACTION 
		ON UPDATE NO ACTION 

	ALTER TABLE Stanice 
		ADD CONSTRAINT Stanice_Mesto_FK FOREIGN KEY ( mesto_id ) 
		REFERENCES Mesto ( mesto_id ) 
		ON DELETE NO ACTION 
		ON UPDATE NO ACTION 

	ALTER TABLE uzivatel ADD CHECK (typ IN('spravce drah', 'vlakova spolecnost', 'zakaznik'));

	ALTER TABLE prijezd ADD CHECK (vzdalenost >= 0);

	ALTER TABLE spoj ADD CHECK (cena_za_km > 0);

	INSERT INTO mesto (nazev, kraj) VALUES ('Bohumin', 'Moravskoslezsky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Ostrava', 'Moravskoslezsky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Studenka', 'Moravskoslezsky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Suchodol nad Odrou', 'Moravskoslezsky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Hranice na Morave', 'Olomoucky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Prerov', 'Olomoucky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Olomouc', 'Olomoucky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Zabreh na Morave', 'Olomoucky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Pardubice', 'Pardubicky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Kolin', 'Stredocesky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Praha', 'Hlavni mesto Praha');
	INSERT INTO mesto (nazev, kraj) VALUES ('Plzen', 'Plzensky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Stribro', 'Plzensky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Plana', 'Plzensky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Ceska Trebova', 'Pardubicky');
	INSERT INTO mesto (nazev, kraj) VALUES ('Havirov', 'Moravskoslezsky');

	INSERT INTO stanice (nazev, mesto_id) VALUES ('Bohumin', 1);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Ostrava hl.n.', 2);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Ostrava-Svinov', 2);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Studenka', 3);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Suchodol n. Odrou', 4);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Hranice na Morave', 5);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Prerov', 6);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Olomouc hl.n.', 7);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Zabreh na Morave', 8);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Pardubice hl.n.', 9);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Kolin', 10);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Praha-Liben', 11);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Praha hl.n.', 11);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Praha-Smichov', 11);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Plzen hl.n.', 12);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Plzen-Jizni Predmesti', 12);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Stribro', 13);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Plana u Mar.Lazni', 14);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Ceska Trebova', 15);
	INSERT INTO stanice (nazev, mesto_id) VALUES ('Havirov', 16);

	INSERT INTO spolecnost (nazev, web, email) VALUES ('Ceske Drahy', 'www.cd.cz', 'info@cd.cz');
	INSERT INTO spolecnost (nazev, web, email) VALUES ('RegioJet', 'www.regiojet.cz', 'info@regiojet.cz');
	INSERT INTO spolecnost (nazev, web, email) VALUES ('LeoExpress', 'www.leoexpress.com', 'info@le.cz');

END

EXEC CreateScript


SELECT * FROM Uzivatel

SELECT * FROM Prijezd p
JOIN Spoj s ON p.spoj_id = s.spoj_id
JOIN Jizda j ON s.spoj_id = j.jizda_id

SELECT * FROM Jizda


EXEC SeznamPrijezdu 'ost', '', '14:00', '2020-03-30'

SELECT * FROM Jizdenka j
JOIN jizdenka_jizda jj ON j.jizdenka_id = jj.jizdenka_id



EXEC ZrusitJizdenku 1

EXEC NajitJizdu 1, 6, '2033-04-20', '13:00'


BEGIN
	DECLARE @cas_od TIME = '13:00'
	DECLARE @datum DATE = '2020-06-05'
	DECLARE @start_stanice_id INTEGER = 1
	DECLARE @cil_stanice_id INTEGER = 8
	DECLARE @nas_spoj INTEGER

	EXEC NajitJizdu @start_stanice_id, @cil_stanice_id, @datum, @cas_od;

	/*DECLARE @prvni_jizda int;
	EXEC NajdiPrimouJizdu @start_stanice_id, @cil_stanice_id, @datum, @cas_od, 0, @prvni_jizda OUT;
	PRINT(CAST(@prvni_jizda AS VARCHAR));*/
END


EXEC AktualizovatJizdu 5, '2033-06-05', '2033-06-05', 3

SELECT *
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE p.poradi = 1;

SELECT * FROM Prijezd
SELECT * FROM Spoj


SELECT * FROM Spoj s JOIN Prijezd p ON s.spoj_id = p.spoj_id
WHERE p.stanice_id = 2



EXEC SeznamPrijezdu 'Ostrava-Svinov', 'LE', '14:00', '2020-04-20'



SELECT * FROM jizdenka_jizda

GO

BEGIN
	DECLARE @p_cas_od TIME = '13:00'
	DECLARE @p_datum DATE = '2020-06-05'
	DECLARE @p_start_stanice_id INTEGER = 1
	DECLARE @p_cil_stanice_id INTEGER = 8
	DECLARE @p_nas_spoj INTEGER

	SELECT  j.jizda_id
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p.stanice_id = @p_start_stanice_id AND 
        p.cas >= @p_cas_od AND 
        j.datum_start = @p_datum AND
        s.aktivni = 1;
END

GO

BEGIN 
	DECLARE @p_cas_od TIME = '13:00'
	DECLARE @p_datum DATE = '2020-06-05'
	DECLARE @p_start_stanice_id INTEGER = 5
	DECLARE @p_cil_stanice_id INTEGER = 8
	DECLARE @p_nas_spoj INTEGER
	DECLARE @v_i int = 1
	declare @p_i int = 0
	DECLARE @v_prvni_jizda INT
	declare @v_druha_jizda int

	SELECT jizda_id
	FROM (
		SELECT DISTINCT j.jizda_id, p.cas
		FROM Prijezd p
			JOIN Spoj s ON p.spoj_id = s.spoj_id
			JOIN Jizda j ON s.spoj_id = j.spoj_id
		WHERE p.stanice_id = @p_cil_stanice_id AND p.poradi > (
			SELECT DISTINCT p1.poradi
			FROM Prijezd p1
				JOIN Spoj s ON p1.spoj_id = s.spoj_id
				JOIN Jizda j ON s.spoj_id = j.spoj_id
			WHERE p1.stanice_id = @p_start_stanice_id AND p.spoj_id = p1.spoj_id AND s.aktivni = 1
		) AND p.cas >= @p_cas_od AND j.datum_start = @p_datum
		ORDER BY p.cas
		OFFSET @p_i ROWS
		FETCH NEXT 1 ROWS ONLY
	) nalezena_jizda
END

GO

BEGIN 
	DECLARE @p_cas_od TIME = '13:00'
	DECLARE @p_datum DATE = '2020-06-05'
	DECLARE @p_start_stanice_id INTEGER = 5
	DECLARE @p_cil_stanice_id INTEGER = 8
	DECLARE @p_nas_spoj INTEGER
	DECLARE @v_i int = 0
	DECLARE @v_prvni_jizda INT


		SELECT *
		FROM Prijezd p
			JOIN Spoj s ON p.spoj_id = s.spoj_id
			JOIN Jizda j ON s.spoj_id = j.spoj_id
		WHERE p.stanice_id = @p_start_stanice_id AND
			p.cas >= @p_cas_od AND 
			j.datum_start = @p_datum AND
			s.aktivni = 1


END

SELECT *
FROM Prijezd p
JOIN Spoj s ON p.spoj_id = s.spoj_id
JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE p.stanice_id = 8 AND datum_start = '2020-06-05'



BEGIN
	DECLARE @cas_od TIME = '13:00'
	DECLARE @datum DATE = '2020-06-05'
	DECLARE @start_stanice_id INTEGER = 1
	DECLARE @cil_stanice_id INTEGER = 8
	DECLARE @nas_spoj INTEGER

	EXEC NajitJizdu @start_stanice_id, @cil_stanice_id, @datum, @cas_od;
END

