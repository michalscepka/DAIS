
SELECT * FROM Uzivatel
GO



UPDATE Uzivatel SET aktivni = 0 WHERE uzivatel_id = @id







SELECT h.history_id, h.cena, h.datum, h.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.spolecnost_id, s.aktivni, sp.nazev, sp.web, sp.email
FROM Historie_Ceny h
	JOIN Spoj s ON h.spoj_id = s.spoj_id
	JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id

SELECT *
FROM Historie_Ceny h JOIN Spoj s ON h.spoj_id = s.spoj_id
	JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id



SELECT mesto_id, nazev, kraj FROM Mesto


SELECT mesto_id, nazev, kraj FROM Mesto WHERE mesto_id = 1


SELECT * FROM Stanice

SELECT s.stanice_id, s.nazev, s.mesto_id, m.nazev, m.kraj
FROM stanice s
	JOIN Mesto m ON s.mesto_id = m.mesto_id
WHERE s.nazev LIKE '%' + 'os' + '%'

SELECT spolecnost_id, nazev, web, email FROM Spolecnost WHERE nazev LIKE '%' + 'e' + '%'



SELECT h.history_id, h.cena, h.datum, h.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, 
	s.spolecnost_id, s.aktivni, sp.nazev, sp.web, sp.email
FROM Historie_Ceny h
JOIN Spoj s ON h.spoj_id = s.spoj_id JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id WHERE uzivatel_id = @id


SELECT p.stanice_id, p.spoj_id, CAST(p.cas AS DATETIME), p.poradi, p.vzdalenost, st.nazev, s.nazev
FROM Prijezd p
	JOIN Stanice st ON p.stanice_id = st.stanice_id
	JOIN Spoj s ON p.spoj_id = s.spoj_id

SELECT * FROM Uzivatel


DECLARE @v_stanice VARCHAR(30)
SET @v_stanice = 'ostr'
DECLARE @v_spoj VARCHAR(20)
SET @v_spoj = 'LE 4'
DECLARE @v_cas TIME
SET @v_cas = '16:00'
DECLARE @v_datum DATETIME
SET @v_datum = '2020-03-28'

SELECT p.stanice_id, p.spoj_id, CAST(p.cas AS DATETIME), p.poradi, p.vzdalenost, st.nazev, s.nazev, j.datum_start, j.datum_cil
FROM Prijezd p
	JOIN Stanice st ON p.stanice_id = st.stanice_id
	JOIN Spoj s ON p.spoj_id = s.spoj_id
	JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE st.nazev LIKE '%' + @v_stanice + '%' AND s.nazev LIKE '%' + @v_spoj + '%' AND p.cas >= @v_cas AND j.datum_start >= @v_datum


GO

DECLARE @v_stanice VARCHAR(30)
SET @v_stanice = 'ostr'
DECLARE @v_spoj VARCHAR(20)
SET @v_spoj = 'LE 4'
DECLARE @v_cas TIME
SET @v_cas = '16:00'
DECLARE @v_datum DATETIME
SET @v_datum = '2020-03-28'

GO

CREATE OR ALTER PROCEDURE SeznamPrijezdu(
	@p_stanice VARCHAR(30),
	@p_spoj VARCHAR(20),
	@p_cas TIME,
	@p_datum DATETIME
)
AS
BEGIN
	SELECT p.stanice_id, p.spoj_id, CAST(p.cas AS DATETIME), p.poradi, p.vzdalenost, st.nazev, s.nazev, j.datum_start, j.datum_cil
	FROM Prijezd p
		JOIN Stanice st ON p.stanice_id = st.stanice_id
		JOIN Spoj s ON p.spoj_id = s.spoj_id
		JOIN Jizda j ON s.spoj_id = j.spoj_id
	WHERE st.nazev LIKE '%' + @p_stanice + '%' AND s.nazev LIKE '%' + @p_spoj + '%' AND p.cas >= @p_cas AND j.datum_start >= @p_datum
END
GO

EXEC SeznamPrijezdu 'ostr','LE 4', '16:00', '2020-03-28'

SELECT * FROM Jizda
SELECT * FROM jizdenka_jizda

DELETE FROM Jizda WHERE jizda_id = 1

SELECT * FROM Jizdenka

SELECT * FROM Spoj

SELECT * FROM Prijezd
