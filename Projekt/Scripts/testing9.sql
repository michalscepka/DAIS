

insert into mesto values('bla', 'blaa')

SELECT * FROM Mesto

SELECT * FROM Uzivatel

SELECT * FROM Jizda

SELECT * FROM Spoj

SELECT * FROM jizdenka_jizda

SELECT * FROM Jizdenka

SELECT * FROM Prijezd



BEGIN
	DECLARE @p_cas_od TIME = '13:00'
	DECLARE @p_datum DATE = '2020-06-05'
	DECLARE @p_start_stanice_id INTEGER = 1
	DECLARE @p_cil_stanice_id INTEGER = 8
	DECLARE @p_nas_spoj INTEGER

	/*SELECT  j.jizda_id
    FROM Prijezd p
        JOIN Spoj s ON p.spoj_id = s.spoj_id
        JOIN Jizda j ON s.spoj_id = j.spoj_id
    WHERE p.stanice_id = @p_start_stanice_id AND 
        p.cas >= @p_cas_od AND 
        j.datum_start = @p_datum AND
        s.aktivni = 1;*/

	EXEC NajitJizdu @p_start_stanice_id, @p_cil_stanice_id, @p_datum, @p_cas_od
END

