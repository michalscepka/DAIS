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
GO

CREATE TABLE Jizda (
    jizda_id	INTEGER PRIMARY KEY IDENTITY,
    datum_start	DATE NOT NULL,
    datum_cil   DATE NOT NULL,
    spoj_id		INTEGER NOT NULL
)
GO

CREATE TABLE Jizdenka (
    jizdenka_id        INTEGER PRIMARY KEY IDENTITY,
    uzivatel_id        INTEGER NOT NULL,
    cena               INTEGER NOT NULL
)
GO

CREATE TABLE jizdenka_jizda (
    jizdenka_id       INTEGER NOT NULL,
    jizda_id          INTEGER NOT NULL,
    stanice_id_start  INTEGER NOT NULL,
    stanice_id_cil    INTEGER NOT NULL,
    poradi            INTEGER NOT NULL
)
GO

ALTER TABLE Jizdenka_Jizda ADD CONSTRAINT Jizdenka_Jizda_PK PRIMARY KEY CLUSTERED (jizdenka_id, jizda_id)
    WITH (
    ALLOW_PAGE_LOCKS = ON , 
    ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Mesto (
    mesto_id   INTEGER PRIMARY KEY IDENTITY,
    nazev      VARCHAR(30) NOT NULL,
    kraj       VARCHAR(30) NOT NULL
)
GO

CREATE TABLE Prijezd (
    stanice_id   INTEGER NOT NULL,
    spoj_id      INTEGER NOT NULL,
    cas          TIME NOT NULL,
    poradi       INTEGER NOT NULL,
    vzdalenost   INTEGER NOT NULL
)
GO

ALTER TABLE Prijezd ADD CONSTRAINT Prijezd_PK PRIMARY KEY CLUSTERED (stanice_id, spoj_id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Spoj (
    spoj_id         INTEGER PRIMARY KEY IDENTITY,
    nazev           VARCHAR(20) NOT NULL,
    cena_za_km      INTEGER NOT NULL,
    kapacita_mist   INTEGER NOT NULL,
    pravidelny      BIT NOT NULL,
    spolecnost_id   INTEGER NOT NULL,
    aktivni         BIT NOT NULL
)
GO

CREATE TABLE Spolecnost (
    spolecnost_id   INTEGER PRIMARY KEY IDENTITY,
    nazev           VARCHAR(20) NOT NULL,
    web             VARCHAR(30) NOT NULL,
    email           VARCHAR(30) NOT NULL
)
GO

CREATE TABLE Stanice (
    stanice_id   INTEGER PRIMARY KEY IDENTITY,
    nazev        VARCHAR(30) NOT NULL,
    mesto_id     INTEGER NOT NULL
)
GO

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
GO

ALTER TABLE Historie_ceny 
    ADD CONSTRAINT Historie_ceny_Spoj_FK FOREIGN KEY ( spoj_id ) 
    REFERENCES Spoj ( spoj_id ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Jizda 
    ADD CONSTRAINT Jizda_Spoj_FK FOREIGN KEY (  spoj_id ) 
    REFERENCES Spoj (  spoj_id ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Jizdenka_Jizda 
    ADD CONSTRAINT Jizdenka_Jizda_Jizda_FK FOREIGN KEY (  jizda_id ) 
    REFERENCES Jizda (  jizda_id ) 
    ON DELETE CASCADE 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Jizdenka_Jizda 
    ADD CONSTRAINT Jizdenka_Jizda_Jizdenka_FK FOREIGN KEY (  jizdenka_id ) 
    REFERENCES Jizdenka ( jizdenka_id ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Jizdenka_Jizda 
    ADD CONSTRAINT Jizdenka_Jizda_Stanice_FK FOREIGN KEY (  stanice_id_start ) 
    REFERENCES Stanice ( stanice_id ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Jizdenka_Jizda 
    ADD CONSTRAINT Jizdenka_Jizda_Stanice_FKv2 FOREIGN KEY ( stanice_id_cil ) 
    REFERENCES Stanice ( stanice_id ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Jizdenka 
    ADD CONSTRAINT Jizdenka_Uzivatel_FK FOREIGN KEY ( uzivatel_id ) 
    REFERENCES Uzivatel ( uzivatel_id ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Prijezd 
    ADD CONSTRAINT Prijezd_Spoj_FK FOREIGN KEY ( spoj_id ) 
    REFERENCES Spoj ( spoj_id ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Prijezd 
    ADD CONSTRAINT Prijezd_Stanice_FK FOREIGN KEY ( stanice_id ) 
    REFERENCES Stanice ( stanice_id ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Spoj 
    ADD CONSTRAINT Spoj_Spolecnost_FK FOREIGN KEY ( spolecnost_id ) 
    REFERENCES Spolecnost ( spolecnost_id ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Stanice 
    ADD CONSTRAINT Stanice_Mesto_FK FOREIGN KEY ( mesto_id ) 
    REFERENCES Mesto ( mesto_id ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

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