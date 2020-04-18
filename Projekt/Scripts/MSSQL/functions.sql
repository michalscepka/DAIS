
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
