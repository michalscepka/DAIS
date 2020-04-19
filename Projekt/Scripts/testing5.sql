
CREATE OR ALTER PROCEDURE SeznamPrijezdu(
	@p_stanice VARCHAR(30),
	@p_spoj VARCHAR(20),
	@p_cas TIME,
	@p_datum DATETIME)
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

GO

--------------------------------------------------------------------------------------------
--3.2 Zapsani jizdy do jizdenky
--------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE PridatJizduDoJizdenky(
    @p_jizdenka_id INTEGER,
    @p_jizda_id INTEGER,
    @p_stanice_id_start INTEGER,
    @p_stanice_id_cil INTEGER)
AS
BEGIN
	DECLARE @v_pocet_jizdenek INTEGER;
    DECLARE @v_pocet_mist INTEGER;

    SELECT @v_pocet_jizdenek = COUNT(jizdenka_id)
    FROM jizdenka_jizda WHERE jizda_id = @p_jizda_id;

    SELECT @v_pocet_mist = kapacita_mist
    FROM Spoj s
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE jizda_id = @p_jizda_id AND s.aktivni = 1;

	IF @v_pocet_jizdenek < @v_pocet_mist BEGIN
		INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi)
			VALUES (@p_jizdenka_id, @p_jizda_id, @p_stanice_id_start, @p_stanice_id_cil, 
				(SELECT COALESCE(MAX(poradi), 0) FROM jizdenka_jizda WHERE jizdenka_id = @p_jizdenka_id) + 1);
		
		--upravit v analyze
		DECLARE @v_cena_spoje INTEGER;
		EXEC SpocitejCenuJizdy @p_jizda_id, @p_stanice_id_start, @p_stanice_id_cil, @v_cena_spoje OUT;
		UPDATE Jizdenka SET cena = cena + @v_cena_spoje WHERE jizdenka_id = @p_jizdenka_id;
	END
	ELSE
		RAISERROR('Spoj je vyprodany', 16, 1);
END

GO

EXEC PridatJizduDoJizdenky 2, 5, 1, 5

SELECT * FROM Jizdenka ji
	JOIN jizdenka_jizda jj ON ji.jizdenka_id = jj.jizdenka_id
WHERE ji.jizdenka_id = 2

DELETE FROM jizdenka_jizda WHERE jizdenka_id = 2

SELECT * FROM Jizdenka
SELECT * FROM jizdenka_jizda
SELECT * FROM Jizda

GO

--------------------------------------------------------------------------------------------
--2.6 Vypocitani ceny jizdy
--------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE SpocitejCenuJizdy(
    @p_jizda_id INTEGER,
	@p_stanice_id_start INTEGER,
    @p_stanice_id_cil INTEGER,
	@p_result INTEGER OUT)
AS
BEGIN
	DECLARE @v_start_vzdalenost INTEGER;
    DECLARE @v_cil_vzdalenost INTEGER;
    DECLARE @v_cena_za_km INTEGER;

    SELECT DISTINCT @v_start_vzdalenost = vzdalenost
    FROM prijezd
        JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
        JOIN jizda ON spoj.spoj_id = jizda.spoj_id
    WHERE prijezd.stanice_id = @p_stanice_id_start AND jizda.jizda_id = @p_jizda_id;

    SELECT DISTINCT @v_cil_vzdalenost = vzdalenost
    FROM prijezd
        JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
        JOIN jizda ON spoj.spoj_id = jizda.spoj_id
    WHERE prijezd.stanice_id = @p_stanice_id_cil AND jizda.jizda_id = @p_jizda_id;

    SELECT DISTINCT @v_cena_za_km = cena_za_km
    FROM spoj
        JOIN jizda ON spoj.spoj_id = jizda.spoj_id
    WHERE jizda.jizda_id = @p_jizda_id;

    SET @p_result = (@v_cil_vzdalenost - @v_start_vzdalenost) * @v_cena_za_km;
END

GO

BEGIN
	DECLARE @v_cislo INTEGER;
	EXEC SpocitejCenuJizdy 3, 1, 5, @v_cislo OUT;
	PRINT @v_cislo;
END


SELECT * FROM Jizdenka
SELECT * FROM jizdenka_jizda
SELECT * FROM Jizda

SELECT * FROM Jizdenka ji
	JOIN jizdenka_jizda jj ON ji.jizdenka_id = jj.jizdenka_id
WHERE ji.jizdenka_id = 2

GO






--------------------------------------------------------------------------------------------
--2.2 Aktualizovani jizdy
--------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE AktualizovatJizdu(
    @p_jizda_id INTEGER,
    @p_novy_datum DATE,
    @p_novy_spoj_id INTEGER)
AS
BEGIN
	DECLARE @v_aktualni_cas TIME = GETDATE();
	DECLARE @v_aktualni_datum DATE = GETDATE();
    DECLARE @v_start_cas TIME;
    DECLARE @v_start_datum DATE;
    
    SELECT @v_start_cas = p.cas, @v_start_datum = j.datum_start
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE j.jizda_id = @p_jizda_id AND p.poradi = 1;

	PRINT(@v_start_cas)
    
    IF DATEDIFF(day, @v_aktualni_datum, @v_start_datum) > 0 OR (DATEDIFF(day, @v_aktualni_datum, @v_start_datum) = 0 AND DATEDIFF(minute, @v_aktualni_cas, @v_start_cas) > 0)
        UPDATE Jizda SET Jizda.datum_start = @p_novy_datum, Jizda.spoj_id = @p_novy_spoj_id WHERE Jizda.jizda_id = @p_jizda_id;
    ELSE
		RAISERROR('Jizda se jiz neda aktualizovat', 16, 1)
END
GO


INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-04-30', '2020-04-30', 11);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-04-18', '2020-04-18', 11);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-04-17', '2020-04-18', 11);
SELECT * FROM Jizda

EXEC AktualizovatJizdu 22, '2022-02-02', 11

SELECT p.cas, j.datum_start
FROM Prijezd p
    JOIN Spoj s ON p.spoj_id = s.spoj_id
    JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE j.jizda_id = 21 AND p.poradi = 1;


DECLARE @aktualni_cas TIME = GETDATE()
DECLARE @aktualni_datum DATE = GETDATE()
DECLARE @start_cas TIME = '16:10:00'
DECLARE @start_datum DATE = '2020-04-18'

PRINT(DATEDIFF(day, @aktualni_datum, @start_datum))

IF DATEDIFF(day, @aktualni_datum, @start_datum) > 0 OR (DATEDIFF(day, @aktualni_datum, @start_datum) = 0 AND DATEDIFF(minute, @aktualni_cas, @start_cas) > 0)
	PRINT('true')
ELSE
	PRINT('Jizda se jiz neda aktualizovat');
GO


--------------------------------------------------------------------------------------------
--3.3 Zrušení jízdenky
--------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ZrusitJizdenku(
    @p_jizdenka_id INTEGER)
AS
BEGIN
	DECLARE @v_aktualni_datum DATE = GETDATE();
    DECLARE @v_aktualni_cas TIME = GETDATE();
    DECLARE @v_cas_odjezdu TIME;
    DECLARE @v_datum_odjezdu DATE;
    DECLARE @v_prvni_stanice INTEGER;
    
    SELECT @v_datum_odjezdu = datum_start, @v_prvni_stanice = stanice_id_start
    FROM Jizda j
        JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
    WHERE jj.jizdenka_id = @p_jizdenka_id AND poradi = 1
    
    SELECT TOP 1 @v_cas_odjezdu = cas
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
        JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
    WHERE jj.jizdenka_id = @p_jizdenka_id AND p.stanice_id = @v_prvni_stanice AND j.datum_start = @v_datum_odjezdu
    ORDER BY cas
    
    IF DATEDIFF(day, @v_aktualni_datum, @v_datum_odjezdu) > 0 OR (DATEDIFF(day, @v_aktualni_datum, @v_datum_odjezdu) = 0 AND 
		DATEDIFF(minute, @v_aktualni_cas, DATEADD(MINUTE, -15, @v_cas_odjezdu)) > 0)
	BEGIN
        DELETE FROM jizdenka_jizda WHERE jizdenka_id = @p_jizdenka_id;
        DELETE FROM Jizdenka WHERE jizdenka_id = @p_jizdenka_id;
	END
    ELSE
        RAISERROR('Jizdenka jiz nelze zrusit', 16, 1)
END

GO

EXEC ZrusitJizdenku 16

DECLARE @aktualni_datum DATE = GETDATE()
DECLARE @aktualni_cas TIME = GETDATE()
DECLARE @cas_odjezdu TIME = '15:19:00'
DECLARE @datum_odjezdu DATE = '2020-04-18'

PRINT(DATEDIFF(day, @aktualni_datum, @datum_odjezdu))

IF DATEDIFF(day, @aktualni_datum, @datum_odjezdu) > 0 OR (DATEDIFF(day, @aktualni_datum, @datum_odjezdu) = 0 AND 
	DATEDIFF(minute, @aktualni_cas, DATEADD(MINUTE, -15, @cas_odjezdu)) > 0)
	PRINT('true')
ELSE
	PRINT('Jizdenka jiz nelze zrusit');
GO

SELECT datum_start, stanice_id_start
FROM Jizda j
    JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
WHERE jj.jizdenka_id = 16 AND jj.poradi = 1
ORDER BY datum_start


SELECT * FROM Jizdenka ji
	JOIN jizdenka_jizda jj ON ji.jizdenka_id = jj.jizdenka_id
WHERE ji.jizdenka_id = 16



SELECT * INTO v_cas_odjezdu FROM (
    SELECT TOP 1 cas
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
        JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
    WHERE jj.jizdenka_id = 16 AND p.stanice_id = 1 AND j.datum_start = '2020-03-27'
    ORDER BY cas
)
WHERE ROWNUM = 1;

SELECT *
    FROM Jizda j
        JOIN jizdenka_jizda jj ON j.jizda_id = jj.jizda_id
    WHERE jj.jizdenka_id = 16

