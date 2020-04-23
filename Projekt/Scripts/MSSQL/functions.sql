
--------------------------------------------------------------------------------------------
-- 2.2 Aktualizovani jizdy
--------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE AktualizovatJizdu(
    @p_jizda_id INTEGER,
    @p_novy_datum_start DATE,
	@p_novy_datum_cil DATE,
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
        UPDATE Jizda SET datum_start = @p_novy_datum_start, datum_cil = @p_novy_datum_cil, spoj_id = @p_novy_spoj_id WHERE jizda_id = @p_jizda_id;
    ELSE
		RAISERROR('Jizda se jiz neda aktualizovat', 16, 1)
END

GO

--------------------------------------------------------------------------------------------
-- 2.4 Vyhledani jizdy
--------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE NajitJizdu(
    @p_start_stanice_id INTEGER,
    @p_cil_stanice_id INTEGER,
    @p_datum DATE,
    @p_cas_od TIME)
AS
BEGIN
	DECLARE @v_prvni_jizda INTEGER;
	DECLARE @v_druha_jizda INTEGER;
    DECLARE @v_tmp VARCHAR(2000) = '';
    DECLARE @v_pocet INTEGER;
    DECLARE @v_i INTEGER = 0;
    DECLARE @v_pocet_stanic INTEGER;
    DECLARE @v_j INTEGER = 0;
    DECLARE @v_prestupni_stanice INTEGER;
	DECLARE @pocet INTEGER = 0;

	CREATE TABLE #tempJizdy (
	prvni_jizda_id INTEGER,
	prestupni_stanice_id INTEGER,
	druha_jizda_id INTEGER)

    SELECT @v_pocet = COUNT(DISTINCT j.jizda_id)
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p.stanice_id = @p_start_stanice_id AND 
        p.cas >= @p_cas_od AND 
        j.datum_start = @p_datum AND
        s.aktivni = 1;
	--PRINT('@v_pocet: ' + CAST(@v_pocet AS VARCHAR));

    WHILE @v_i < @v_pocet
	BEGIN
		SET @v_prvni_jizda = NULL;
		EXEC NajdiPrimouJizdu @p_start_stanice_id, @p_cil_stanice_id, @p_datum, @p_cas_od, @v_i, @v_prvni_jizda OUT;
		--PRINT(CAST(@v_prvni_jizda AS VARCHAR));
		
		IF @v_prvni_jizda IS NOT NULL
		BEGIN
			--SET @v_tmp = @v_tmp + 'Jizda: ' + CAST(@v_prvni_jizda AS VARCHAR) + CHAR(13) + CHAR(10);
			INSERT INTO #tempJizdy(prvni_jizda_id) VALUES (@v_prvni_jizda);
		END
		ELSE
		BEGIN
			SELECT @v_prvni_jizda = jizda_id
			FROM (
				SELECT DISTINCT j.jizda_id, p.cas
				FROM Prijezd p
					JOIN Spoj s ON p.spoj_id = s.spoj_id
					JOIN Jizda j ON s.spoj_id = j.spoj_id
				WHERE p.stanice_id = @p_start_stanice_id AND
					p.cas >= @p_cas_od AND 
					j.datum_start = @p_datum AND
					s.aktivni = 1
				ORDER BY p.cas
				OFFSET @v_i ROWS
				FETCH NEXT 1 ROWS ONLY
			) prvni_jizda
			--PRINT('neprima: ' + CAST(@v_prvni_jizda AS VARCHAR))

            SELECT @v_pocet_stanic = COUNT(stanice_id)
            FROM Prijezd p JOIN Spoj s ON p.spoj_id = s.spoj_id
				JOIN Jizda j ON s.spoj_id = j.spoj_id
			WHERE jizda_id = @v_prvni_jizda
			--PRINT('@v_pocet_stanic: ' + CAST(@v_pocet_stanic AS VARCHAR));

			SET @v_j = 0;
			WHILE @v_j < @v_pocet_stanic
			BEGIN
				SELECT @v_prestupni_stanice = stanice_id
				FROM (
					SELECT stanice_id, cas
					FROM Prijezd p JOIN Spoj s ON p.spoj_id = s.spoj_id
						JOIN Jizda j ON s.spoj_id = j.spoj_id
					WHERE jizda_id = @v_prvni_jizda
					ORDER BY cas
					OFFSET @v_j ROWS
					FETCH NEXT 1 ROWS ONLY
				) prestupni_stanice
				--PRINT('@v_prestupni_stanice: ' + CAST(@v_prestupni_stanice AS VARCHAR));

				SET @v_druha_jizda = NULL;
				EXEC NajdiPrimouJizdu @v_prestupni_stanice, @p_cil_stanice_id, @p_datum, @p_cas_od, @v_i, @v_druha_jizda OUT;
				--PRINT('mozny druhy spoj: ' + CAST(@v_druha_jizda AS VARCHAR));

				IF @v_druha_jizda IS NOT NULL
				BEGIN
					/*SET @v_tmp = @v_tmp + 'Jizda: ' + CAST(@v_prvni_jizda AS VARCHAR) + '; prestupni stanice: ' + CAST(@v_prestupni_stanice AS VARCHAR) + 
						'; na jizdu: ' + CAST(@v_druha_jizda AS VARCHAR) + CHAR(13) + CHAR(10);*/
					INSERT INTO #tempJizdy(prvni_jizda_id, prestupni_stanice_id, druha_jizda_id) VALUES (@v_prvni_jizda, @v_prestupni_stanice, @v_druha_jizda);
				END
				SET @v_j = @v_j + 1;
			END
		END
		SET @v_i = @v_i + 1;
	END
	--PRINT(@v_tmp);
	SELECT * FROM #tempJizdy;
END

GO

--------------------------------------------------------------------------------------------
-- 2.6 Vypocitani ceny jizdy
--------------------------------------------------------------------------------------------

CREATE OR ALTER FUNCTION SpocitejCenuJizdy(
    @p_jizda_id INTEGER,
	@p_stanice_id_start INTEGER,
    @p_stanice_id_cil INTEGER)
RETURNS INTEGER
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

    RETURN (@v_cil_vzdalenost - @v_start_vzdalenost) * @v_cena_za_km;
END

GO

--------------------------------------------------------------------------------------------
-- 3.2 Zapsani jizdy do jizdenky
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
		
		UPDATE Jizdenka SET cena = cena + dbo.SpocitejCenuJizdy(@p_jizda_id, @p_stanice_id_start, @p_stanice_id_cil) WHERE jizdenka_id = @p_jizdenka_id;
	END
	ELSE
		RAISERROR('Spoj je vyprodany', 16, 1);
END

GO

--------------------------------------------------------------------------------------------
-- 3.3 Zruseni jizdenky
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

--------------------------------------------------------------------------------------------
-- POMOCNE FUNKCE
-- NajdiPrimouJizdu()
CREATE OR ALTER PROCEDURE NajdiPrimouJizdu(
    @p_start_stanice_id INTEGER,
    @p_cil_stanice_id INTEGER,
    @p_datum DATE,
    @p_cas_od TIME,
    @p_i INTEGER,
	@v_nase_jizda INTEGER OUT)
AS
BEGIN
	SELECT @v_nase_jizda = jizda_id
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

--------------------------------------------------------------------------------------------
-- ZBYTEK
-- 5.4. Seznam prijezdu
CREATE OR ALTER PROCEDURE SeznamPrijezdu(
	@p_stanice VARCHAR(30),
	@p_spoj VARCHAR(20),
	@p_cas TIME,
	@p_datum DATETIME)
AS
BEGIN
	SELECT p.stanice_id, p.spoj_id, CAST(p.cas AS DATETIME), p.poradi, p.vzdalenost, st.stanice_id, st.nazev, st.mesto_id, 
		m.mesto_id, m.nazev, m.kraj, s.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny,
		sp.spolecnost_id, s.aktivni, sp.spolecnost_id, sp.nazev, sp.web, sp.email
	FROM Prijezd p
		JOIN Stanice st ON p.stanice_id = st.stanice_id
		JOIN Mesto m ON st.mesto_id = m.mesto_id
		JOIN Spoj s ON p.spoj_id = s.spoj_id
		JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id
		JOIN Jizda j ON s.spoj_id = j.spoj_id
	WHERE st.nazev LIKE '%' + @p_stanice + '%' AND s.nazev LIKE '%' + @p_spoj + '%' AND p.cas >= @p_cas AND j.datum_start >= @p_datum
END

GO

-- 4.2. Aktualizovani spoje - zapsani puvodni ceny do tabulky Historie_ceny
CREATE OR ALTER TRIGGER trigHistorieCeny
ON Spoj
FOR INSERT, UPDATE
AS
BEGIN
	INSERT INTO Historie_ceny(cena, datum, spoj_id) VALUES((SELECT cena_za_km FROM inserted), GETDATE(), (SELECT spoj_id FROM inserted));
END

GO
