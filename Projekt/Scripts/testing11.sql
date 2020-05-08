


INSERT INTO Jizdenka (uzivatel_id, cena) VALUES (1, 100)
SELECT SCOPE_IDENTITY()

SELECT * FROM Jizdenka

GO

CREATE OR ALTER PROCEDURE ZjistiData(
	@p_jizda_1_id INTEGER,
    @p_prestup_id INTEGER,
	@p_jizda_2_id INTEGER,
    @p_start_stanice_id INTEGER,
	@p_cil_stanice_id INTEGER)
AS
BEGIN
	CREATE TABLE #tempData (
		spoj_1_nazev VARCHAR(20),
		prestup_nazev VARCHAR(30),
		spoj_2_nazev VARCHAR(20),
		cas_odjezdu TIME,
		cas_prijezdu TIME)

	DECLARE @v_spoj_1_nazev VARCHAR(20)
	DECLARE @v_prestup_nazev VARCHAR(30) = '-'
	DECLARE @v_spoj_2_nazev VARCHAR(20) = '-'
    DECLARE @v_cas_odjezdu TIME
	DECLARE @v_cas_prijezdu TIME

	IF @p_prestup_id != 0 BEGIN
		SELECT @v_prestup_nazev = st.nazev
		FROM Stanice st
		WHERE st.stanice_id = @p_prestup_id

		SELECT @v_spoj_1_nazev = s.nazev, @v_cas_odjezdu = p.cas
		FROM Jizda j
			JOIN Spoj s ON j.spoj_id = s.spoj_id
			JOIN Prijezd p ON s.spoj_id = p.spoj_id
		WHERE j.jizda_id = @p_jizda_1_id AND p.stanice_id = @p_start_stanice_id

		SELECT @v_spoj_2_nazev = s.nazev, @v_cas_prijezdu = p.cas
		FROM Jizda j
			JOIN Spoj s ON j.spoj_id = s.spoj_id
			JOIN Prijezd p ON s.spoj_id = p.spoj_id
		WHERE j.jizda_id = @p_jizda_2_id AND p.stanice_id = @p_cil_stanice_id

		INSERT INTO #tempData(spoj_1_nazev, prestup_nazev, spoj_2_nazev, cas_odjezdu, cas_prijezdu)
			VALUES (@v_spoj_1_nazev, @v_prestup_nazev, @v_spoj_2_nazev, @v_cas_odjezdu, @v_cas_prijezdu)
	END

	ELSE BEGIN
		SELECT @v_spoj_1_nazev = s.nazev, @v_cas_odjezdu = p.cas
		FROM Jizda j
			JOIN Spoj s ON j.spoj_id = s.spoj_id
			JOIN Prijezd p ON s.spoj_id = p.spoj_id
		WHERE (j.jizda_id = @p_jizda_1_id AND p.stanice_id = @p_start_stanice_id)

		SELECT @v_cas_prijezdu = p.cas
		FROM Jizda j
			JOIN Spoj s ON j.spoj_id = s.spoj_id
			JOIN Prijezd p ON s.spoj_id = p.spoj_id
		WHERE j.jizda_id = @p_jizda_1_id AND p.stanice_id = @p_cil_stanice_id

		INSERT INTO #tempData(spoj_1_nazev, prestup_nazev, spoj_2_nazev, cas_odjezdu, cas_prijezdu)
			VALUES (@v_spoj_1_nazev, @v_prestup_nazev, @v_spoj_2_nazev, @v_cas_odjezdu, @v_cas_prijezdu)
	END

	SELECT * FROM #tempData;
END

GO


BEGIN
	DECLARE @p_jizda_1_id INTEGER = 1
	DECLARE @p_prestup_id INTEGER = 5
	DECLARE @p_jizda_2_id INTEGER = 2
    DECLARE @p_start_stanice_id INTEGER = 1
	DECLARE @p_cil_stanice_id INTEGER = 8

	EXEC ZjistiData @p_jizda_1_id, @p_prestup_id, @p_jizda_2_id, @p_start_stanice_id, @p_cil_stanice_id
END


