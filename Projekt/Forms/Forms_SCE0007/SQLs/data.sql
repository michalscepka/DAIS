INSERT INTO mesto (nazev, kraj) VALUES ('Bohumin', 'Moravskoslezsky');
INSERT INTO mesto (nazev, kraj) VALUES ('Ostrava', 'Moravskoslezsky');
INSERT INTO mesto (nazev, kraj) VALUES ('Studenka', 'Moravskoslezsky');
INSERT INTO mesto (nazev, kraj) VALUES ('Suchodol nad Odrou', 'Moravskoslezsky');
INSERT INTO mesto (nazev, kraj) VALUES ('Hranice na Morave', 'Olomoucky');
INSERT INTO mesto (nazev, kraj) VALUES ('Prerov', 'Olomoucky');
INSERT INTO mesto (nazev, kraj) VALUES ('Olomouc', 'Olomoucky');
INSERT INTO mesto (nazev, kraj) VALUES ('Zabreh na Morave', 'Olomoucky');
INSERT INTO mesto (nazev, kraj) VALUES ('Pardubice', 'Pardubicky');
INSERT INTO mesto (nazev, kraj) VALUES ('Kolin', 'Stredocesky');
INSERT INTO mesto (nazev, kraj) VALUES ('Praha', 'Hlavni mesto Praha');
INSERT INTO mesto (nazev, kraj) VALUES ('Plzen', 'Plzensky');
INSERT INTO mesto (nazev, kraj) VALUES ('Stribro', 'Plzensky');
INSERT INTO mesto (nazev, kraj) VALUES ('Plana', 'Plzensky');
INSERT INTO mesto (nazev, kraj) VALUES ('Ceska Trebova', 'Pardubicky');
INSERT INTO mesto (nazev, kraj) VALUES ('Havirov', 'Moravskoslezsky');

INSERT INTO stanice (nazev, mesto_id) VALUES ('Bohumin', 1);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Ostrava hl.n.', 2);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Ostrava-Svinov', 2);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Studenka', 3);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Suchodol n. Odrou', 4);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Hranice na Morave', 5);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Prerov', 6);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Olomouc hl.n.', 7);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Zabreh na Morave', 8);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Pardubice hl.n.', 9);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Kolin', 10);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Praha-Liben', 11);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Praha hl.n.', 11);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Praha-Smichov', 11);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Plzen hl.n.', 12);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Plzen-Jizni Predmesti', 12);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Stribro', 13);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Plana u Mar.Lazni', 14);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Ceska Trebova', 15);
INSERT INTO stanice (nazev, mesto_id) VALUES ('Havirov', 16);

INSERT INTO spolecnost (nazev, web, email) VALUES ('Ceske Drahy', 'www.cd.cz', 'info@cd.cz');
INSERT INTO spolecnost (nazev, web, email) VALUES ('RegioJet', 'www.regiojet.cz', 'info@regiojet.cz');
INSERT INTO spolecnost (nazev, web, email) VALUES ('LeoExpress', 'www.leoexpress.com', 'info@le.cz');

INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('LE 400', 3, 3, 1, 3, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('RJ 106', 2, 3, 1, 2, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('SC 512', 4, 3, 1, 1, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('RJ 1006', 5, 3, 0, 2, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('LE 401', 2, 3, 1, 3, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('LE 500', 1, 3, 1, 3, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('F', 1, 3, 1, 3, 1);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 1, '14:00', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 1, '14:10', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 1, '14:20', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 1, '14:30', 4, 30);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 1, '14:40', 5, 40);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (4, 2, '14:35', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 2, '14:45', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (7, 2, '14:55', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 2, '15:05', 4, 30);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 3, '15:10', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 3, '15:20', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 3, '15:30', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (11, 3, '15:40', 4, 30);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 4, '16:00', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 4, '16:10', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 4, '16:20', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 4, '16:30', 4, 30);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 4, '16:40', 5, 40);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (4, 5, '16:35', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 5, '16:45', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (7, 5, '16:55', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 5, '17:05', 4, 30);

INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('pepa13', 'Pepa', 'Zamotany', 'pepa.zamotany@gmail.com', 'zakaznik', '2019-04-24 12:30:50', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('noobmaster', 'Pavel', 'Maly', 'pavel.maly@gmail.com', 'zakaznik', '2019-04-25 10:36:52', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('rebarbora', 'Barbora', 'Velka', 'bara.velka@gmail.com', 'zakaznik', '2019-12-1 22:30:54', 1);

INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-06-05', '2020-06-05', 1);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-06-05', '2020-06-05', 2);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-06-05', '2020-06-05', 3);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-06-05', '2020-06-05', 4);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-06-05', '2020-06-05', 5);

INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-06-06', '2020-06-06', 1);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-06-06', '2020-06-06', 2);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-06-06', '2020-06-06', 3);

INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-06-07', '2020-06-07', 1);

INSERT INTO jizdenka (uzivatel_id, cena) VALUES (1, 130);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (1, 80);

INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (1, 1, 1, 5, 1)
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi)	VALUES (1, 2, 5, 8, 2)
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi)	VALUES (2, 1, 2, 5, 1)

-- jizdenka, ktera se jiz neda zrusit
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2019-01-01', '2019-01-01', 1);

INSERT INTO jizdenka (uzivatel_id, cena) VALUES (1, 200);

INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi)	VALUES (3, 10, 1, 3, 1)
