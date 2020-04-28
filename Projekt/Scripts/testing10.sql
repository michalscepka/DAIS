
SELECT s.spoj_id, s.nazev, s.cena_za_km, s.kapacita_mist, s.pravidelny, s.aktivni, s.spolecnost_id, sp.nazev, sp.web, sp.email, j.jizda_id, j.datum_start, j.datum_cil
FROM Spoj s
	LEFT JOIN Spolecnost sp ON s.spolecnost_id = sp.spolecnost_id
	LEFT JOIN Jizda j ON s.spoj_id = j.spoj_id
WHERE s.spoj_id = 6

