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
    history_id   NUMBER GENERATED ALWAYS AS IDENTITY,
    cena         INTEGER NOT NULL,
    datum        DATE NOT NULL,
    spoj_id      INTEGER NOT NULL,
    CONSTRAINT history_id PRIMARY KEY (history_id)
);

CREATE TABLE Jizda (
    jizda_id   NUMBER GENERATED ALWAYS AS IDENTITY,
    datum_start  DATE NOT NULL,
    datum_cil    DATE NOT NULL,
    spoj_id    INTEGER NOT NULL,
    CONSTRAINT jizda_id PRIMARY KEY (jizda_id)
);

CREATE TABLE Jizdenka (
    jizdenka_id        NUMBER GENERATED ALWAYS AS IDENTITY,
    uzivatel_id        INTEGER NOT NULL,
    cena               INTEGER NOT NULL,
    CONSTRAINT jizdenka_id PRIMARY KEY (jizdenka_id)
);

CREATE TABLE jizdenka_jizda (
    jizdenka_id       INTEGER NOT NULL,
    jizda_id          INTEGER NOT NULL,
    stanice_id_start  INTEGER NOT NULL,
    stanice_id_cil    INTEGER NOT NULL,
    poradi            INTEGER NOT NULL
);

ALTER TABLE jizdenka_jizda ADD CONSTRAINT jizdenka_jizda_pk PRIMARY KEY ( jizdenka_id, jizda_id );

CREATE TABLE Mesto (
    mesto_id   NUMBER GENERATED ALWAYS AS IDENTITY,
    nazev      VARCHAR(30) NOT NULL,
    kraj       VARCHAR2(30) NOT NULL,
    CONSTRAINT mesto_id PRIMARY KEY (mesto_id)
);

CREATE TABLE Prijezd (
    stanice_id   INTEGER NOT NULL,
    spoj_id      INTEGER NOT NULL,
    cas          TIMESTAMP NOT NULL,
    poradi       INTEGER NOT NULL,
    vzdalenost   INTEGER NOT NULL
);

ALTER TABLE prijezd ADD CONSTRAINT prijezd_pk PRIMARY KEY ( stanice_id, spoj_id );

CREATE TABLE Spoj (
    spoj_id         NUMBER GENERATED ALWAYS AS IDENTITY,
    nazev           VARCHAR(20) NOT NULL,
    cena_za_km      INTEGER NOT NULL,
    kapacita_mist   INTEGER NOT NULL,
    pravidelny      NUMBER(1) NOT NULL,
    spolecnost_id   INTEGER NOT NULL,
    aktivni         CHAR(1) NOT NULL,
    CONSTRAINT spoj_id PRIMARY KEY (spoj_id)
);

CREATE TABLE Spolecnost (
    spolecnost_id   NUMBER GENERATED ALWAYS AS IDENTITY,
    nazev           VARCHAR(20) NOT NULL,
    web            VARCHAR2(30) NOT NULL,
    email          VARCHAR2(30) NOT NULL,
    CONSTRAINT spolecnost_id PRIMARY KEY (spolecnost_id)
);

CREATE TABLE Stanice (
    stanice_id   NUMBER GENERATED ALWAYS AS IDENTITY,
    nazev        VARCHAR(30) NOT NULL,
    mesto_id     INTEGER NOT NULL,
    CONSTRAINT stanice_id PRIMARY KEY (stanice_id)
);

CREATE TABLE Uzivatel (
    uzivatel_id         NUMBER GENERATED ALWAYS AS IDENTITY,
    login               VARCHAR(20) NOT NULL,
    jmeno               VARCHAR(20) NOT NULL,
    prijmeni            VARCHAR(20) NOT NULL,
    email               VARCHAR(30) NOT NULL,
    typ                 VARCHAR(20) NOT NULL,
    posledni_navsteva   TIMESTAMP(3),
    aktivni        CHAR(1) NOT NULL,
    CONSTRAINT uzivatel_id PRIMARY KEY (uzivatel_id)
);

ALTER TABLE Historie_ceny
    ADD CONSTRAINT historie_ceny_spoj_fk FOREIGN KEY ( spoj_id )
        REFERENCES spoj ( spoj_id );

ALTER TABLE Jizda
    ADD CONSTRAINT jizda_spoj_fk FOREIGN KEY ( spoj_id )
        REFERENCES spoj ( spoj_id );
        
ALTER TABLE jizdenka_jizda
    ADD CONSTRAINT jizdenka_jizda_jizda_fk FOREIGN KEY ( jizda_id )
        REFERENCES jizda ( jizda_id );

ALTER TABLE jizdenka_jizda
    ADD CONSTRAINT jizdenka_jizda_jizdenka_fk FOREIGN KEY ( jizdenka_id )
        REFERENCES jizdenka ( jizdenka_id );

ALTER TABLE jizdenka_jizda
    ADD CONSTRAINT jizdenka_jizda_stanice_fk FOREIGN KEY ( stanice_id_start )
        REFERENCES stanice ( stanice_id );

ALTER TABLE jizdenka_jizda
    ADD CONSTRAINT jizdenka_jizda_stanice_fkv2 FOREIGN KEY ( stanice_id_cil )
        REFERENCES stanice ( stanice_id );

ALTER TABLE Jizdenka
    ADD CONSTRAINT jizdenka_uzivatel_fk FOREIGN KEY ( uzivatel_id )
        REFERENCES uzivatel ( uzivatel_id );

ALTER TABLE Prijezd
    ADD CONSTRAINT prijezd_spoj_fk FOREIGN KEY ( spoj_id )
        REFERENCES spoj ( spoj_id );

ALTER TABLE Prijezd
    ADD CONSTRAINT prijezd_stanice_fk FOREIGN KEY ( stanice_id )
        REFERENCES stanice ( stanice_id );

ALTER TABLE Spoj
    ADD CONSTRAINT spoj_spolecnost_fk FOREIGN KEY ( spolecnost_id )
        REFERENCES spolecnost ( spolecnost_id );

ALTER TABLE Stanice
    ADD CONSTRAINT stanice_mesto_fk FOREIGN KEY ( mesto_id )
        REFERENCES mesto ( mesto_id );

ALTER TABLE uzivatel ADD CHECK (typ IN('spravce drah', 'vlakova spolecnost', 'zakaznik'));

ALTER TABLE prijezd ADD CHECK (vzdalenost >= 0);

ALTER TABLE spoj ADD CHECK (cena_za_km > 0);
