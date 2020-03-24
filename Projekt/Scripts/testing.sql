
create or replace PROCEDURE AktualizovatJizdu(
    p_jizda_id IN Jizda.jizda_id%TYPE,
    p_novy_datum IN Jizda.datum%TYPE,
    p_novy_spoj_id IN Jizda.spoj_id%TYPE)
AS
    v_jizda Jizda%ROWTYPE;
    v_aktualni_datum Jizda.datum%TYPE;
    v_start_cas Prijezd.cas%TYPE;
    v_aktualni_cas Prijezd.cas%TYPE;
    jizda_jiz_bezi EXCEPTION;
BEGIN
    SELECT * INTO v_jizda FROM Jizda WHERE jizda_id = p_jizda_id;
    
    SELECT CURRENT_DATE, to_timestamp(TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI'), 'HH24:MI')
        INTO v_aktualni_datum, v_aktualni_cas FROM dual;
    
    SELECT p.cas INTO v_start_cas
        FROM Prijezd p
            JOIN Spoj s ON p.spoj_id = s.spoj_id
            JOIN Jizda j ON s.spoj_id = j.spoj_id
        WHERE p.spoj_id = v_jizda.spoj_id AND j.datum = v_jizda.datum AND
            p.poradi IN (SELECT MIN(poradi) FROM prijezd WHERE spoj_id = v_jizda.spoj_id);
    
    IF to_date(v_jizda.datum, 'YYYY-MM-DD') > to_date(v_aktualni_datum, 'YYYY-MM-DD') OR
       (to_date(v_jizda.datum, 'YYYY-MM-DD') = to_date(v_aktualni_datum, 'YYYY-MM-DD') AND v_start_cas < v_aktualni_cas) THEN
        UPDATE Jizda SET Jizda.datum = p_novy_datum, Jizda.spoj_id = p_novy_spoj_id WHERE Jizda.jizda_id = v_jizda.jizda_id;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Jizda neni bezici!');
        RAISE jizda_jiz_bezi;
    END IF;
END;

create or replace PROCEDURE ObjednatJizdenku(
    p_uzivatel_id INTEGER,
    p_jizda_id INTEGER,
    p_stanice_start INTEGER,
    p_stanice_cil INTEGER)
AS
    v_pocet_jizdenek INTEGER;
    v_pocet_mist INTEGER;
    vyprodano EXCEPTION;
BEGIN
    SELECT COUNT(j.jizdenka_id) INTO v_pocet_jizdenek
        FROM Jizdenka j WHERE j.jizda_id = p_jizda_id;
        
    SELECT kapacita_mist INTO v_pocet_mist
        FROM Spoj s
            JOIN Jizda j ON s.spoj_id = j.spoj_id
        WHERE jizda_id = p_jizda_id;
    
    IF v_pocet_jizdenek < v_pocet_mist THEN
        INSERT INTO Jizdenka(uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena)
            VALUES (p_uzivatel_id, p_jizda_id, p_stanice_start, p_stanice_cil, SpocitejCenuJizdenky(p_stanice_start, p_stanice_cil, p_jizda_id));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Spoj je vyprodany!');
        RAISE vyprodano;
    END IF;
END;

create or replace PROCEDURE ZrusitJizdenku(
    p_jizdenka_id INTEGER)
AS
    v_cas_odjezdu Prijezd.cas%TYPE;
    v_jizdenka Jizdenka%ROWTYPE;
    v_aktualni_datum DATE;
    v_aktualni_cas Prijezd.cas%TYPE;
    v_jizda_datum Jizda.datum%TYPE;
    jizdenka_jiz_nelze_zrusit EXCEPTION;
BEGIN
    SELECT * INTO v_jizdenka FROM Jizdenka WHERE jizdenka_id = p_jizdenka_id;
    
    SELECT CURRENT_DATE, to_timestamp(TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI'), 'HH24:MI') 
        INTO v_aktualni_datum, v_aktualni_cas FROM dual;
    
    SELECT p.cas INTO v_cas_odjezdu
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
        JOIN Jizdenka ji ON j.jizda_id = ji.jizda_id
    WHERE ji.jizdenka_id = v_jizdenka.jizdenka_id AND p.stanice_id = v_jizdenka.stanice_id_start;
    
    SELECT datum INTO v_jizda_datum FROM Jizda WHERE jizda.jizda_id = v_jizdenka.jizda_id;
    
    IF TO_DATE(v_jizda_datum, 'YYYY-MM-DD') = TO_DATE(v_aktualni_datum, 'YYYY-MM-DD') AND (v_cas_odjezdu > v_aktualni_cas) THEN
        DELETE FROM Jizdenka WHERE jizdenka_id = v_jizdenka.jizdenka_id;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Jizdenka jiz nelze zrusit!');
        RAISE jizdenka_jiz_nelze_zrusit;
    END IF;
END;

create or replace FUNCTION SpocitejCenuJizdenky(
    p_stanice_id_start INTEGER,
    p_stanice_id_cil INTEGER,
    p_jizda_id INTEGER)
RETURN INTEGER
AS
    v_start_vzdalenost INTEGER;
    v_cil_vzdalenost INTEGER;
    v_cena_za_km INTEGER;
BEGIN
    SELECT DISTINCT vzdalenost INTO v_start_vzdalenost
    FROM prijezd
        JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
        JOIN jizda ON spoj.spoj_id = jizda.spoj_id
    WHERE prijezd.stanice_id = p_stanice_id_start AND jizda.jizda_id = p_jizda_id;

    SELECT DISTINCT vzdalenost INTO v_cil_vzdalenost
    FROM prijezd
        JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
        JOIN jizda ON spoj.spoj_id = jizda.spoj_id
    WHERE prijezd.stanice_id = p_stanice_id_cil AND jizda.jizda_id = p_jizda_id;

    SELECT DISTINCT cena_za_km INTO v_cena_za_km
    FROM spoj
        JOIN jizda ON spoj.spoj_id = jizda.spoj_id
    WHERE jizda.jizda_id = p_jizda_id;

    RETURN (v_cil_vzdalenost - v_start_vzdalenost) * v_cena_za_km;
END;

-------------------------------------------------------------------------------



















SELECT * FROM Jizda;

SELECT p.cas
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p.spoj_id = 1 AND j.datum = to_timestamp('2020-03-22', 'YYYY-MM-DD') AND
        p.poradi IN (SELECT MAX(poradi) FROM prijezd WHERE spoj_id = 1);


EXEC AktualizovatJizdu(2, to_timestamp('2020-09-09', 'YYYY-MM-DD'), 2)

SELECT * FROM Jizda WHERE jizda_id = 2;

SELECT to_timestamp(TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI'), 'HH24:MI') FROM dual;



SET SERVEROUTPUT ON


EXEC DBMS_OUTPUT.PUT_LINE(CenaJizdenky(3, 13, 1));

CREATE OR REPLACE TRIGGER ZapsatCenu
BEFORE DELETE OR INSERT OR UPDATE ON Spoj
FOR EACH ROW
DECLARE
BEGIN
    CASE
        WHEN inserting THEN
        
        WHEN updating THEN
            
        WHEN deleting THEN
        
    END CASE;
END;


INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id) VALUES ('LE 400', 3, 200, 1, 3);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id) VALUES ('RJ 106', 2, 150, 1, 2);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id) VALUES ('SC 512 Pendolino', 4, 170, 1, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id) VALUES ('RJ 1006', 5, 100, 0, 2);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id) VALUES ('LE 401', 2, 180, 1, 3);

SELECT * FROM spoj;

SELECT * FROM Historie_ceny;

UPDATE Spoj SET Spoj.cena_za_km = 90 WHERE spoj_id = 1;


SELECT (MAX(spoj_id) + 1) FROM Spoj;

INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (1, to_timestamp('2019-12-01', 'YYYY-MM-DD'), 20);






SELECT * FROM jizdenka;

SELECT *
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
    JOIN Jizdenka ji ON j.jizda_id = ji.jizda_id
WHERE ji.jizdenka_id = 1 AND p.stanice_id = 1



SELECT to_timestamp(TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI'), 'HH24:MI') FROM dual;


SELECT * FROM jizdenka;

EXEC ZrusitJizdenku(1);

SELECT COUNT(j.jizdenka_id)
        FROM Jizdenka j WHERE j.jizda_id = 5
        
EXEC ObjednatJizdenku(1, 1, 1, 13);
















SELECT *
FROM Stanice st
    JOIN Prijezd p ON st.stanice_id = p.stanice_id
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE datum = TO_DATE('2019-12-06', 'YYYY-MM-DD') AND st.nazev = 'Ostrava-Svinov' AND p.cas > to_timestamp('14:10', 'HH24:MI');

SELECT *
FROM Stanice st
    JOIN Prijezd p ON st.stanice_id = p.stanice_id
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE datum = TO_DATE('2019-12-06', 'YYYY-MM-DD') AND st.nazev = 'Praha hl.n.';


EXEC ZobrazitSeznamJizd(TO_DATE('2019-12-06', 'YYYY-MM-DD'), to_timestamp('14:10', 'HH24:MI'), 'Ostrava-Svinov', 'Praha hl.n.');




































