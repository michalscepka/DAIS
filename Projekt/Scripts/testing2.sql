
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
    SELECT COUNT(jizdenka_id) INTO v_pocet_jizdenek
        FROM jizdenka_jizda WHERE jizda_id = p_jizda_id;
        
    SELECT kapacita_mist INTO v_pocet_mist
        FROM Spoj s
            JOIN Jizda j ON s.spoj_id = j.spoj_id
        WHERE jizda_id = p_jizda_id;
    
    IF v_pocet_jizdenek < v_pocet_mist THEN
        INSERT INTO Jizdenka(uzivatel_id, stanice_id_start, stanice_id_cil, cena)
            VALUES (p_uzivatel_id, p_stanice_start, p_stanice_cil, SpocitejCenuJizdenky(p_stanice_start, p_stanice_cil, p_jizda_id));
        
        INSERT INTO jizdenka_jizda(jizda_id, jizdenka_id) VALUES (p_jizda_id, (SELECT COALESCE(MAX(jizdenka_id),0) FROM Jizdenka));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Spoj je vyprodany');
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
    
    SELECT * INTO v_jizda_datum FROM (
        SELECT datum
        FROM Jizda j
            JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
        WHERE jj.jizdenka_id = p_jizdenka_id
        ORDER BY datum
    )
    WHERE ROWNUM = 1;
    
    SELECT * INTO v_cas_odjezdu FROM (
        SELECT cas
        FROM Prijezd p
            JOIN Spoj s ON p.spoj_id = s.spoj_id
            JOIN Jizda j ON s.spoj_id = j.spoj_id
            JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
        WHERE jj.jizdenka_id = p_jizdenka_id AND p.stanice_id = v_jizdenka.stanice_id_start AND j.datum = v_jizda_datum
        ORDER BY cas
    )
    WHERE ROWNUM = 1;
    
    IF TO_DATE(v_jizda_datum, 'YYYY-MM-DD') > TO_DATE(v_aktualni_datum, 'YYYY-MM-DD') OR
        TO_DATE(v_jizda_datum, 'YYYY-MM-DD') = TO_DATE(v_aktualni_datum, 'YYYY-MM-DD') AND (v_cas_odjezdu > v_aktualni_cas)
        THEN
        DELETE FROM jizdenka_jizda WHERE jizdenka_id = p_jizdenka_id;
        DELETE FROM Jizdenka WHERE jizdenka_id = v_jizdenka.jizdenka_id;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Jizdenka jiz nelze zrusit');
        RAISE jizdenka_jiz_nelze_zrusit;
    END IF;
END;

CREATE OR REPLACE FUNCTION PrimySpoj(
    p_start_stanice_id IN INTEGER,
    p_cil_stanice_id IN INTEGER,
    p_datum IN Jizda.datum%TYPE,
    p_cas_od IN Prijezd.cas%TYPE
)
RETURN INTEGER
AS
    v_nas_spoj INTEGER;
BEGIN

    SELECT DISTINCT p.spoj_id INTO v_nas_spoj
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p.stanice_id = p_cil_stanice_id AND p.poradi > (
        SELECT DISTINCT p1.poradi
        FROM Prijezd p1
            JOIN Spoj s ON p1.spoj_id = s.spoj_id
            JOIN Jizda j ON s.spoj_id = j.spoj_id
        WHERE p1.stanice_id = p_start_stanice_id AND p.spoj_id = p1.spoj_id
    ) AND p.cas >= p_cas_od AND 
        j.datum = p_datum AND
        ROWNUM = 1;
        
    RETURN v_nas_spoj;
    
    EXCEPTION
        WHEN no_data_found THEN
    RETURN NULL;
END;

CREATE OR REPLACE PROCEDURE NajitJizdu(
    p_start_stanice_id IN INTEGER,
    p_cil_stanice_id IN INTEGER,
    p_datum IN Jizda.datum%TYPE,
    p_cas_od IN Prijezd.cas%TYPE
)
AS
    v_nas_spoj INTEGER;
BEGIN
    IF PrimySpojXY(p_start_stanice_id, p_cil_stanice_id, p_datum, p_cas_od) IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('primy: ' || PrimySpojXY(p_start_stanice_id, p_cil_stanice_id, p_datum, p_cas_od));
    ELSE
        --DBMS_OUTPUT.PUT_LINE('Nenasel');
        SELECT DISTINCT p.spoj_id INTO v_nas_spoj
        FROM Prijezd p
            JOIN Spoj s ON p.spoj_id = s.spoj_id
            JOIN Jizda j ON s.spoj_id = j.spoj_id
        WHERE p.stanice_id = p_start_stanice_id AND
            p.cas >= p_cas_od AND 
            j.datum = p_datum AND
            ROWNUM = 1;
        DBMS_OUTPUT.PUT_LINE('neprimy: ' || v_nas_spoj);
        
        FOR radek IN (SELECT * FROM Prijezd WHERE spoj_id = v_nas_spoj) LOOP
            IF PrimySpojXY(radek.stanice_id, p_cil_stanice_id, p_datum, p_cas_od) IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE('prestup: ' || PrimySpojXY(radek.stanice_id, p_cil_stanice_id, p_datum, p_cas_od));
            ELSE
                DBMS_OUTPUT.PUT_LINE('nenalezen dalsi');
            END IF;
        END LOOP;
    END IF;
END;













create or replace FUNCTION PrimySpoj(
    p_start_stanice_id IN INTEGER,
    p_cil_stanice_id IN INTEGER,
    p_datum IN Jizda.datum%TYPE,
    p_cas_od IN Prijezd.cas%TYPE,
    p_i IN INTEGER
)
RETURN INTEGER
AS
    v_nas_spoj INTEGER;
BEGIN

    SELECT spoj_id INTO v_nas_spoj
    FROM (
        SELECT spoj_id, ROWNUM AS rn
        FROM (
            SELECT DISTINCT p.spoj_id, p.cas
            FROM Prijezd p
                JOIN Spoj s ON p.spoj_id = s.spoj_id
                JOIN Jizda j ON s.spoj_id = j.spoj_id
            WHERE p.stanice_id = p_cil_stanice_id AND p.poradi > (
                SELECT DISTINCT p1.poradi
                FROM Prijezd p1
                    JOIN Spoj s ON p1.spoj_id = s.spoj_id
                    JOIN Jizda j ON s.spoj_id = j.spoj_id
                WHERE p1.stanice_id = p_start_stanice_id AND p.spoj_id = p1.spoj_id
            ) AND p.cas >= p_cas_od AND 
                j.datum = p_datum
            ORDER BY p.cas
        )
    ) WHERE rn = p_i + 1;

    RETURN v_nas_spoj;

    EXCEPTION
        WHEN no_data_found THEN
    RETURN NULL;
END;

create or replace PROCEDURE NajitJizdu(
    p_start_stanice_id IN INTEGER,
    p_cil_stanice_id IN INTEGER,
    p_datum IN Jizda.datum%TYPE,
    p_cas_od IN Prijezd.cas%TYPE
)
AS
    v_nas_spoj INTEGER;
    v_tmp VARCHAR(2000);
    v_pocet INTEGER;
    v_i INTEGER := 0;
    v_pocet_stanic INTEGER;
    v_j INTEGER := 0;
    v_prestupni_stanice INTEGER;
BEGIN

    SELECT COUNT(DISTINCT p.spoj_id) INTO v_pocet
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p.stanice_id = p_start_stanice_id AND 
        p.cas >= p_cas_od AND 
        j.datum = p_datum;
    --DBMS_OUTPUT.PUT_LINE('v_pocet: ' || v_pocet);
    
    WHILE v_i < v_pocet LOOP
        
        IF PrimySpoj(p_start_stanice_id, p_cil_stanice_id, p_datum, p_cas_od, v_i) IS NOT NULL THEN
            --DBMS_OUTPUT.PUT_LINE('primy: ' || PrimySpoj(p_start_stanice_id, p_cil_stanice_id, p_datum, p_cas_od, v_i));
            v_tmp := v_tmp || 'primy: ' || PrimySpoj(p_start_stanice_id, p_cil_stanice_id, p_datum, p_cas_od, v_i) || chr(10);
        ELSE
            SELECT spoj_id INTO v_nas_spoj
            FROM (
                SELECT spoj_id, ROWNUM AS rn
                FROM (
                    SELECT DISTINCT p.spoj_id, p.cas
                    FROM Prijezd p
                        JOIN Spoj s ON p.spoj_id = s.spoj_id
                        JOIN Jizda j ON s.spoj_id = j.spoj_id
                    WHERE p.stanice_id = p_start_stanice_id AND
                        p.cas >= p_cas_od AND 
                        j.datum = p_datum
                    ORDER BY p.cas
                )
            ) WHERE rn = v_i + 1;
            --DBMS_OUTPUT.PUT_LINE('neprimy: ' || v_nas_spoj);
            
            SELECT COUNT(stanice_id) INTO v_pocet_stanic
            FROM Prijezd WHERE spoj_id = v_nas_spoj;
            
            --DBMS_OUTPUT.PUT_LINE('v_pocet_stanic: ' || v_pocet_stanic);
            
            v_j := 0;
            WHILE v_j < v_pocet_stanic LOOP
                
                SELECT stanice_id INTO v_prestupni_stanice
                FROM (
                    SELECT stanice_id, ROWNUM AS rn
                    FROM (
                        SELECT stanice_id, cas
                        FROM Prijezd
                        WHERE spoj_id = v_nas_spoj
                        ORDER BY cas
                    )
                ) WHERE rn = v_j + 1;
                
                --DBMS_OUTPUT.PUT_LINE('v_prestupni_stanice: ' || v_prestupni_stanice);
                
                IF PrimySpoj(v_prestupni_stanice, p_cil_stanice_id, p_datum, p_cas_od, v_i) IS NOT NULL THEN
                    --DBMS_OUTPUT.PUT_LINE('prestup: ' || PrimySpoj(radek.stanice_id, p_cil_stanice_id, p_datum, p_cas_od, v_i));
                    v_tmp := v_tmp || 'neprimy: ' || v_nas_spoj || '; prestup: ' || PrimySpoj(v_prestupni_stanice, p_cil_stanice_id, p_datum, p_cas_od, v_i) || chr(10);
                END IF;
                
                v_j := v_j + 1;
            END LOOP;
        END IF;
        --DBMS_OUTPUT.PUT_LINE(v_i);
        v_i := v_i + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_tmp);
END;



























SET SERVEROUTPUT ON;

SELECT * FROM jizdenka;

SELECT * FROM jizda;

SELECT * FROM jizdenka_jizda;

SELECT COUNT(jizdenka_id)
FROM jizdenka_jizda WHERE jizda_id = 2;

EXEC ObjednatJizdenku(1, 1, 2, 12);

DECLARE
    p_jizdenka_id INTEGER := 1;
    v_jizda_datum Jizda.datum%TYPE;
BEGIN
    SELECT datum INTO v_jizda_datum
        FROM Jizda j
            JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
        WHERE jj.jizdenka_id = p_jizdenka_id;
    
    DBMS_OUTPUT.PUT_LINE(v_jizda_datum);
END;

INSERT INTO jizdenka_jizda(jizda_id, jizdenka_id) VALUES (2, 1);

SELECT * FROM Jizdenka WHERE jizdenka_id = 1;

SELECT *
    FROM Jizda j
        JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
        JOIN Spoj s ON j.spoj_id = s.spoj_id
        JOIN Prijezd p ON s.spoj_id = p.spoj_id
    WHERE jj.jizdenka_id = 1 AND p.stanice_id = 3;
    
DECLARE
    v_cas_odjezdu Prijezd.cas%TYPE;
BEGIN
    SELECT p.cas INTO v_cas_odjezdu
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
        JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
    WHERE jj.jizdenka_id = v_jizdenka.jizdenka_id AND p.stanice_id = v_jizdenka.stanice_id_start AND j.datum = v_jizda_datum;
    
    DBMS_OUTPUT.PUT_LINE(v_cas_odjezdu);
END;

SELECT * FROM (
    SELECT cas
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
        JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
    WHERE jj.jizdenka_id = 16 AND p.stanice_id = 2 AND j.datum = to_timestamp('2019-03-28', 'YYYY-MM-DD')
    ORDER BY cas
)
WHERE ROWNUM = 1;


DECLARE
    p_jizdenka_id INTEGER := 1;
    v_jizda_datum Jizda.datum%TYPE;
BEGIN
    SELECT * INTO v_jizda_datum
    FROM (
        SELECT datum
        FROM Jizda j
            JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
        WHERE jj.jizdenka_id = p_jizdenka_id
        ORDER BY datum
    )
    WHERE ROWNUM = 1;
    
    DBMS_OUTPUT.PUT_LINE(v_jizda_datum);
END;

EXEC ZrusitJizdenku(5);

SELECT * FROM jizdenka;

SELECT * FROM jizdenka_jizda;





EXEC ZobrazitSeznamJizd(to_timestamp('2019-03-30', 'YYYY-MM-DD'), to_timestamp('13:50', 'HH24:MI'), 1, 5);

SELECT *
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE p.spoj_id IN (
    SELECT DISTINCT p.spoj_id
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE (p.stanice_id = 1 OR p.stanice_id = 5) AND 
        p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
        j.datum = to_timestamp('2019-03-28', 'YYYY-MM-DD')
    GROUP BY p.spoj_id
    HAVING COUNT(p.spoj_id) > 1
) AND p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
    j.datum = to_timestamp('2019-03-28', 'YYYY-MM-DD') AND
    (p.stanice_id = 1 OR p.stanice_id = 5)


SELECT *
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE p.spoj_id IN (
    SELECT p.spoj_id, p.poradi
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p.stanice_id = 1 AND 
        p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
        j.datum = to_timestamp('2019-03-28', 'YYYY-MM-DD')
    --GROUP BY p.spoj_id
    --HAVING COUNT(p.spoj_id) > 1
) AND p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
    j.datum = to_timestamp('2019-03-28', 'YYYY-MM-DD') AND
    (p.stanice_id = 1 OR p.stanice_id = 5)
    
    
DECLARE
    v_i INT := 0;
    v_pocet INT;
    v_first_start_stanice_id INT;
    v_first_cil_stanice_id INT;
    v_first_spoj_id INT;
    v_second_start_stanice_id INT;
    v_second_cil_stanice_id INT;
    v_second_spoj_id INT;
BEGIN
    SELECT COUNT(DISTINCT p.spoj_id) INTO v_pocet
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p.stanice_id = 1 AND 
        p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
        j.datum = to_timestamp('2019-03-28', 'YYYY-MM-DD');
        
    DBMS_OUTPUT.PUT_LINE(v_pocet);
    
    WHILE v_i < v_pocet LOOP
        
        
        
        DBMS_OUTPUT.PUT_LINE(v_i);
        v_i := v_i + 1;
    END LOOP;
END;



SELECT p.spoj_id
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE (p.stanice_id = 1 OR p.stanice_id = 5) AND 
    p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
    j.datum = to_timestamp('2019-03-28', 'YYYY-MM-DD')
GROUP BY p.spoj_id
HAVING COUNT(p.spoj_id) > 1



SELECT *
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE (p.stanice_id = 1 OR p.stanice_id = 5) AND 
    p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
    j.datum = to_timestamp('2019-03-29', 'YYYY-MM-DD')
    
    
    
    
    
    
    
    
    

SELECT DISTINCT p1.spoj_id
FROM Prijezd p1
    JOIN Spoj s ON p1.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE p.stanice_id = 1 AND
    p1.cas >= to_timestamp('00:00', 'HH24:MI') AND 
    j.datum = to_timestamp('2019-03-30', 'YYYY-MM-DD')
INTERSECT
SELECT DISTINCT p.spoj_id
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE p.stanice_id = 6 AND
    p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
    j.datum = to_timestamp('2019-03-30', 'YYYY-MM-DD') AND
    p.poradi > p1.poradi





--------------------------------------------------------------------------
SELECT DISTINCT p.spoj_id
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE p.stanice_id = 3 AND p.poradi > (
    SELECT DISTINCT p1.poradi
    FROM Prijezd p1
        JOIN Spoj s ON p1.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p1.stanice_id = 1 AND p.spoj_id = p1.spoj_id
) AND p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
    j.datum = to_timestamp('2019-03-30', 'YYYY-MM-DD') AND
    ROWNUM = 1;
--------------------------------------------------------------------------
SELECT *
FROM (
  SELECT *, ROWNUM AS rn
  FROM your_table
  ORDER BY some_column
) 
WHERE rn = 2

SELECT spoj_id
FROM (
    SELECT spoj_id, ROWNUM AS rn
    FROM (
        SELECT DISTINCT p.spoj_id, p.cas
        FROM Prijezd p
            JOIN Spoj s ON p.spoj_id = s.spoj_id
            JOIN Jizda j ON s.spoj_id = j.spoj_id
        WHERE p.stanice_id = 8 AND p.poradi > (
            SELECT DISTINCT p1.poradi
            FROM Prijezd p1
                JOIN Spoj s ON p1.spoj_id = s.spoj_id
                JOIN Jizda j ON s.spoj_id = j.spoj_id
            WHERE p1.stanice_id = 1 AND p.spoj_id = p1.spoj_id
        ) AND p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
            j.datum = to_timestamp('2019-03-29', 'YYYY-MM-DD')
        ORDER BY p.cas
    )
) WHERE rn = 1


BEGIN
    DBMS_OUTPUT.PUT_LINE(PrimySpojXY(1, 8,
        to_timestamp('2019-03-30', 'YYYY-MM-DD') ,to_timestamp('00:00', 'HH24:MI')));
END;

SET SERVEROUTPUT ON;

EXEC NajitJizdu(1, 8, to_timestamp('2020-03-30', 'YYYY-MM-DD') ,to_timestamp('00:00', 'HH24:MI'));


SELECT stanice_id, cas
FROM Prijezd
WHERE spoj_id = 9
ORDER BY cas

SELECT * FROM Prijezd WHERE spoj_id = 6


SELECT *
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE (p.stanice_id = 1 OR p.stanice_id = 8) AND
    p.cas >= to_timestamp('00:00', 'HH24:MI') AND 
    j.datum = to_timestamp('2019-03-29', 'YYYY-MM-DD')
ORDER BY p.cas









create or replace PROCEDURE PridatJizduDoJizdenky(
    p_uzivatel_id INTEGER,
    p_jizda_id INTEGER,
    p_stanice_id_start INTEGER,
    p_stanice_id_cil INTEGER)
AS
    v_pocet_jizdenek INTEGER;
    v_pocet_mist INTEGER;
    v_nove_jizdenka_id INTEGER;
    vyprodano EXCEPTION;
BEGIN
    SELECT COUNT(jizdenka_id) INTO v_pocet_jizdenek
    FROM jizdenka_jizda WHERE jizda_id = p_jizda_id;
    
    SELECT kapacita_mist INTO v_pocet_mist
    FROM Spoj s
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE jizda_id = p_jizda_id;
    
    IF v_pocet_jizdenek < v_pocet_mist THEN
        INSERT INTO Jizdenka(uzivatel_id, cena)
            VALUES (p_uzivatel_id, SpocitejCenuJizdenky(p_stanice_id_start, p_stanice_id_cil, p_jizda_id));
            
        SELECT COALESCE(MAX(jizdenka_id), 0) INTO v_nove_jizdenka_id FROM Jizdenka;
        
        INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi)
            VALUES (v_nove_jizdenka_id, p_jizda_id, p_stanice_id_start, p_stanice_id_cil, 
                (SELECT COALESCE(MAX(poradi), 1) FROM jizdenka_jizda WHERE jizdenka_id = v_nove_jizdenka_id) + 1);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Spoj je vyprodany');
        RAISE vyprodano;
    END IF;
END;



SELECT *
FROM Jizdenka j
    LEFT JOIN jizdenka_jizda jj ON j.jizdenka_Id = jj.jizdenka_id;

EXEC PridatJizduDoJizdenky(18, 3, 1, 4);

DELETE FROM jizdenka_jizda WHERE jizdenka_id = 17
DELETE FROM jizdenka WHERE jizdenka_id = 17

INSERT INTO jizdenka(uzivatel_id, cena) VALUES (1, 50000)
SELECT * FROM Jizdenka


EXEC ZrusitJizdenku(18)



SELECT *
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
    JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
WHERE jj.jizdenka_id = 18 AND p.stanice_id = 1 AND j.datum_start = to_timestamp('2020-03-27', 'YYYY-MM-DD')
ORDER BY cas

SELECT * FROM (
    SELECT cas
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
        JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
    WHERE jj.jizdenka_id = 18 AND p.stanice_id = 1 AND j.datum_start = to_timestamp('2020-03-27', 'YYYY-MM-DD')
    ORDER BY cas
)
WHERE ROWNUM = 1;



SELECT datum_start, stanice_id_start
FROM Jizda j
    JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
WHERE jj.jizdenka_id = 18
ORDER BY datum_start






































