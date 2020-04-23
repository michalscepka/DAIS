
SELECT s.stanice_id, s.nazev, s.mesto_id, m.nazev, m.kraj
FROM Stanice s 
	JOIN Mesto m ON s.mesto_id = m.mesto_id
WHERE s.stanice_id = 2


SELECT s.stanice_id, s.nazev, s.mesto_id, m.nazev, m.kraj
FROM Stanice s 
	JOIN Mesto m ON s.mesto_id = m.mesto_id
WHERE s.nazev LIKE '%' + 'ost' + '%'


SELECT s.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.aktivni, s.spolecnost_id, sp.nazev, sp.web, sp.email
FROM Spoj s
	JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id
WHERE spoj_id=1

SELECT uzivatel_id, login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni FROM Uzivatel WHERE uzivatel_id = 1

SELECT * FROM Spoj s JOIN Prijezd p ON s.spoj_id = p.spoj_id WHERE p.stanice_id=1


SELECT s.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.aktivni, s.spolecnost_id, sp.nazev, sp.web, sp.email
FROM Spoj s
	JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id
	JOIN Prijezd p ON s.spoj_id = p.spoj_id
WHERE stanice_id =1




SELECT p.stanice_id, p.spoj_id, CAST(p.cas AS DATETIME), p.poradi, p.vzdalenost, st.stanice_id, st.nazev, st.mesto_id, 
	m.mesto_id, m.nazev, m.kraj, s.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny,
	sp.spolecnost_id, s.aktivni, sp.spolecnost_id, sp.nazev, sp.web, sp.email
FROM Prijezd p
	JOIN Stanice st ON p.stanice_id = st.stanice_id
	JOIN Mesto m ON st.mesto_id = m.mesto_id
	JOIN Spoj s ON p.spoj_id = s.spoj_id
	JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id
WHERE p.stanice_id=2 AND p.spoj_id=1


EXEC SeznamPrijezdu 'ost', '', '12:00', ''

GO

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

SELECT spolecnost_id, nazev, web, email FROM Spolecnost

SELECT j.jizda_id, j.datum_start, j.datum_cil, j.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.aktivni, s.spolecnost_id,
	sp.nazev, sp.web, sp.email
FROM Jizda j
	JOIN Spoj s ON j.spoj_id = s.spoj_id
	JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id
WHERE j.jizda_id = 1



--osetrit ze posledni navsteva muze byt null
SELECT jj.jizdenka_id, jj.jizda_id, jj.stanice_id_start, jj.stanice_id_cil, jj.poradi,
	ji.jizdenka_id, ji.uzivatel_id, ji.cena,
	u.uzivatel_id, u.login, u.jmeno, u.prijmeni, u.email, u.typ, u.aktivni, u.posledni_navsteva,
	j.jizda_id, j.datum_start, j.datum_cil, j.spoj_id,
	s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.spolecnost_id, s.aktivni,
	sp.spolecnost_id, sp.nazev, sp.web, sp.email,
	st.stanice_id, st.nazev, st.mesto_id,
	m.nazev, m.kraj,
	st2.stanice_id, st2.nazev, st2.mesto_id,
	m2.nazev, m2.kraj
FROM jizdenka_jizda jj
	JOIN Jizdenka ji ON jj.jizdenka_id = ji.jizdenka_id
	JOIN Uzivatel u ON ji.uzivatel_id = u.uzivatel_id
	JOIN Jizda j ON jj.jizda_id = j.jizda_id
	JOIN Spoj s ON j.spoj_id = s.spoj_id
	JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id
	JOIN Stanice st ON jj.stanice_id_start = st.stanice_id
	JOIN Mesto m ON st.mesto_id = m.mesto_id
	JOIN Stanice st2 ON jj.stanice_id_cil = st2.stanice_id
	JOIN Mesto m2 ON st2.mesto_id = m2.mesto_id
WHERE ji.jizdenka_id = 1


SELECT ji.jizdenka_id, ji.uzivatel_id, ji.cena,
	u.uzivatel_id, u.login, u.jmeno, u.prijmeni, u.email, u.typ, u.aktivni, u.posledni_navsteva,
	jj.jizdenka_id, jj.jizda_id, jj.stanice_id_start, jj.stanice_id_cil, jj.poradi/*,
	j.jizda_id, j.datum_start, j.datum_cil, j.spoj_id,
	s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.spolecnost_id, s.aktivni,
	sp.spolecnost_id, sp.nazev, sp.web, sp.email,
	st.stanice_id, st.nazev, st.mesto_id,
	m.nazev, m.kraj,
	st2.stanice_id, st2.nazev, st2.mesto_id,
	m2.nazev, m2.kraj*/
FROM Jizdenka ji
	JOIN Uzivatel u ON ji.uzivatel_id = u.uzivatel_id
	JOIN jizdenka_jizda jj ON ji.jizdenka_id = jj.jizdenka_id
	JOIN Jizda j ON jj.jizda_id = j.jizda_id
	JOIN Spoj s ON j.spoj_id = s.spoj_id
	JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id
	JOIN Stanice st ON jj.stanice_id_start = st.stanice_id
	JOIN Mesto m ON st.mesto_id = m.mesto_id
	JOIN Stanice st2 ON jj.stanice_id_cil = st2.stanice_id
	JOIN Mesto m2 ON st2.mesto_id = m2.mesto_id
WHERE ji.jizdenka_id = 1



