
CREATE OR ALTER PROCEDURE NajdiPrimySpoj(
    @p_start_stanice_id INTEGER,
    @p_cil_stanice_id INTEGER,
    @p_datum DATE,
    @p_cas_od TIME,
    @p_i INTEGER,
	@v_nas_spoj INTEGER OUT)
AS
BEGIN

	SELECT @v_nas_spoj = nalezeny_spoj.spoj_id
	FROM (
		SELECT DISTINCT p.spoj_id, p.cas
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
	) nalezeny_spoj
END

GO

BEGIN
	DECLARE @cas_od TIME = '14:00'
	DECLARE @datum DATE = '2020-03-30'
	DECLARE @start_stanice_id INTEGER = 1
	DECLARE @cil_stanice_id INTEGER = 6
	DECLARE @nas_spoj INTEGER
	DECLARE @v_i INTEGER = 0

	EXEC NajdiPrimySpoj @start_stanice_id, @cil_stanice_id, @datum, @cas_od, @v_i, @nas_spoj OUT;
	PRINT(@nas_spoj)
END

GO

BEGIN
	DECLARE @cas_od TIME = '14:00'
	DECLARE @datum DATE = '2020-03-30'
	DECLARE @start_stanice_id INTEGER = 1
	DECLARE @cil_stanice_id INTEGER = 8
	DECLARE @nas_spoj INTEGER

	EXEC NajitJizdu @start_stanice_id, @cil_stanice_id, @datum, @cas_od;
END

GO

BEGIN
	DECLARE @p_cas_od TIME = '14:00'
	DECLARE @p_datum DATE = '2020-03-30'
	DECLARE @p_start_stanice_id INTEGER = 1
	DECLARE @p_cil_stanice_id INTEGER = 8
	DECLARE @p_nas_spoj INTEGER

	DECLARE @v_prvni_spoj INTEGER;
    DECLARE @v_tmp VARCHAR(2000);
    DECLARE @v_pocet INTEGER;
    DECLARE @v_i INTEGER = 0;
    DECLARE @v_pocet_stanic INTEGER;
    DECLARE @v_j INTEGER = 0;
    DECLARE @v_prestupni_stanice INTEGER;

	SELECT @v_prvni_spoj = spoj_id
    FROM (
		SELECT DISTINCT p.spoj_id, p.cas
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
	) prvni_spoj

	PRINT(@v_prvni_spoj)
END

GO


CREATE OR ALTER PROCEDURE NajitJizdu(
    @p_start_stanice_id INTEGER,
    @p_cil_stanice_id INTEGER,
    @p_datum DATE,
    @p_cas_od TIME)
AS
BEGIN
	DECLARE @v_prvni_spoj INTEGER;
	DECLARE @v_druhy_spoj INTEGER;
    DECLARE @v_tmp VARCHAR(2000) = '';
    DECLARE @v_pocet INTEGER;
    DECLARE @v_i INTEGER = 0;
    DECLARE @v_pocet_stanic INTEGER;
    DECLARE @v_j INTEGER = 0;
    DECLARE @v_prestupni_stanice INTEGER;

    SELECT @v_pocet = COUNT(DISTINCT p.spoj_id)
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p.stanice_id = @p_start_stanice_id AND 
        p.cas >= @p_cas_od AND 
        j.datum_start = @p_datum AND
        s.aktivni = 1;
	--PRINT('@v_pocet: ' + CAST(@v_pocet AS VARCHAR));

    WHILE @v_i < @v_pocet BEGIN

		SET @v_prvni_spoj = NULL;
		EXEC NajdiPrimySpoj @p_start_stanice_id, @p_cil_stanice_id, @p_datum, @p_cas_od, @v_i, @v_prvni_spoj OUT;
		--PRINT(CAST(@v_prvni_spoj AS VARCHAR));
		
		IF @v_prvni_spoj IS NOT NULL
			SET @v_tmp = @v_tmp + 'Spoj: ' + CAST(@v_prvni_spoj AS VARCHAR) + CHAR(13) + CHAR(10);
		ELSE BEGIN
			SELECT @v_prvni_spoj = spoj_id
			FROM (
				SELECT DISTINCT p.spoj_id, p.cas
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
			) prvni_spoj
			--PRINT('neprimy: ' + CAST(@v_prvni_spoj AS VARCHAR))

            SELECT @v_pocet_stanic = COUNT(stanice_id)
            FROM Prijezd WHERE spoj_id = @v_prvni_spoj;
			--PRINT('@v_pocet_stanic: ' + CAST(@v_pocet_stanic AS VARCHAR));
		END

		SET @v_j = 0;
		WHILE @v_j < @v_pocet_stanic BEGIN

            SELECT @v_prestupni_stanice = stanice_id
            FROM (
                SELECT stanice_id, cas
                FROM Prijezd
                WHERE spoj_id = @v_prvni_spoj
                ORDER BY cas
				OFFSET @v_j ROWS
				FETCH NEXT 1 ROWS ONLY
            ) prestupni_stanice
            --PRINT('@v_prestupni_stanice: ' + CAST(@v_prestupni_stanice AS VARCHAR));

			SET @v_druhy_spoj = NULL;
			EXEC NajdiPrimySpoj @v_prestupni_stanice, @p_cil_stanice_id, @p_datum, @p_cas_od, @v_i, @v_druhy_spoj OUT;
			--PRINT('mozny druhy spoj: ' + CAST(@v_druhy_spoj AS VARCHAR));

            IF @v_druhy_spoj IS NOT NULL
                SET @v_tmp = @v_tmp + 'Spoj: ' + CAST(@v_prvni_spoj AS VARCHAR) + '; prestupni stanice: ' + CAST(@v_prestupni_stanice AS VARCHAR) + 
					'; na spoj: ' + CAST(@v_druhy_spoj AS VARCHAR) + CHAR(13) + CHAR(10);
			SET @v_j = @v_j + 1;
		END
		SET @v_i = @v_i + 1;
	END
	PRINT(@v_tmp);
END

GO


BEGIN
	DECLARE @input VARCHAR = 'a'
	SELECT * FROM Uzivatel WHERE jmeno LIKE '%' + @input + '%' OR prijmeni LIKE '%' + @input + '%';
END

SELECT * FROM Jizda

INSERT INTO Jizda VALUES ('2020-04-30', '2020-04-30', 1)


EXEC AktualizovatJizdu 20, '2020-04-04', '2020-04-04', 2



BEGIN
	DECLARE @cas_od TIME = '14:00'
	DECLARE @datum DATE = '2020-03-30'
	DECLARE @start_stanice_id INTEGER = 1
	DECLARE @cil_stanice_id INTEGER = 8
	DECLARE @nas_spoj INTEGER

	EXEC NajitJizdu @start_stanice_id, @cil_stanice_id, @datum, @cas_od;
END

BEGIN
	DECLARE @v_cislo INTEGER;
	EXEC SpocitejCenuJizdy 2, 3, 13, @v_cislo OUT;
	PRINT @v_cislo;
END


SELECT * FROM Jizdenka
SELECT * FROM jizdenka_jizda
SELECT * FROM Jizda

SELECT * FROM Jizdenka ji
	JOIN jizdenka_jizda jj ON ji.jizdenka_id = jj.jizdenka_id
WHERE ji.jizdenka_id = 2


EXEC PridatJizduDoJizdenky 4, 5, 1, 5

SELECT * FROM Jizdenka ji
	LEFT JOIN jizdenka_jizda jj ON ji.jizdenka_id = jj.jizdenka_id
WHERE ji.jizdenka_id = 4

DELETE FROM jizdenka_jizda WHERE jizdenka_id = 2

SELECT * FROM Jizdenka
SELECT * FROM jizdenka_jizda
SELECT * FROM Jizda

SELECT * FROM JIZDA WHERE jizda_id = 1


SELECT * FROM Spoj s
	JOIN Prijezd p ON s.spoj_id = p.spoj_id
WHERE p.stanice_id = 1



BEGIN
	DECLARE @cislo INT = dbo.SpocitejCenuJizdyF(5, 1, 5)
	PRINT(@cislo)
END

GO






















GO

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






BEGIN
	DECLARE @cislo INT = dbo.SpocitejCenuJizdy(2, 3, 13)
	PRINT(@cislo)
END

GO

SELECT dbo.SpocitejCenuJizdy(2, 3, 13) AS cena

GO

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
		
		-- mozna upravit v analyze
		UPDATE Jizdenka SET cena = cena + dbo.SpocitejCenuJizdy(@p_jizda_id, @p_stanice_id_start, @p_stanice_id_cil) WHERE jizdenka_id = @p_jizdenka_id;
	END
	ELSE
		RAISERROR('Spoj je vyprodany', 16, 1);
END







GO

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

    WHILE @v_i < @v_pocet BEGIN

		SET @v_prvni_jizda = NULL;
		EXEC NajdiPrimouJizdu @p_start_stanice_id, @p_cil_stanice_id, @p_datum, @p_cas_od, @v_i, @v_prvni_jizda OUT;
		--PRINT(CAST(@v_prvni_spoj AS VARCHAR));
		
		IF @v_prvni_jizda IS NOT NULL BEGIN
			--SET @v_tmp = @v_tmp + 'Jizda: ' + CAST(@v_prvni_jizda AS VARCHAR) + CHAR(13) + CHAR(10);
			INSERT INTO #tempJizdy(druha_jizda_id) VALUES (@v_prvni_jizda);
		END
		ELSE BEGIN
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
		END

		SET @v_j = 0;
		WHILE @v_j < @v_pocet_stanic BEGIN

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

            IF @v_druha_jizda IS NOT NULL BEGIN
                /*SET @v_tmp = @v_tmp + 'Jizda: ' + CAST(@v_prvni_jizda AS VARCHAR) + '; prestupni stanice: ' + CAST(@v_prestupni_stanice AS VARCHAR) + 
					'; na jizdu: ' + CAST(@v_druha_jizda AS VARCHAR) + CHAR(13) + CHAR(10);*/
				INSERT INTO #tempJizdy(prvni_jizda_id, prestupni_stanice_id, druha_jizda_id) VALUES (@v_prvni_jizda, @v_prestupni_stanice, @v_druha_jizda);
			END
			SET @v_j = @v_j + 1;
		END
		SET @v_i = @v_i + 1;
	END
	--PRINT(@v_tmp);
	SELECT * FROM #tempJizdy;
END


GO

BEGIN
	DECLARE @cas_od TIME = '14:00'
	DECLARE @datum DATE = '2020-03-30'
	DECLARE @start_stanice_id INTEGER = 1
	DECLARE @cil_stanice_id INTEGER = 8
	DECLARE @nas_spoj INTEGER

	EXEC NajitJizdu @start_stanice_id, @cil_stanice_id, @datum, @cas_od;
END

GO

BEGIN
	DECLARE @p_cas_od TIME = '14:00'
	DECLARE @p_datum DATE = '2020-03-30'
	DECLARE @p_start_stanice_id INTEGER = 1
	DECLARE @p_cil_stanice_id INTEGER = 8
	DECLARE @p_nas_spoj INTEGER

	SELECT DISTINCT j.jizda_id
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p.stanice_id = @p_start_stanice_id AND 
        p.cas >= @p_cas_od AND 
        j.datum_start = @p_datum AND
        s.aktivni = 1;
END


GO

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

