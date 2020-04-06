


SELECT p.cas, j.datum_start
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE j.jizda_id = 1 AND p.poradi = 1;


SET SERVEROUTPUT ON;

EXEC NajitJizdu(1, 8, to_timestamp('2020-03-30', 'YYYY-MM-DD') ,to_timestamp('00:00', 'HH24:MI'));



SELECT p.cas, j.datum_start
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE j.jizda_id = 1 AND p.poradi = 1 AND s.aktivni = 1;













































