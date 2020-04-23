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

--SELECT * FROM mesto;

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

--SELECT * FROM stanice;

INSERT INTO spolecnost (nazev, web, email) VALUES ('Ceske Drahy', 'www.cd.cz', 'info@cd.cz');
INSERT INTO spolecnost (nazev, web, email) VALUES ('RegioJet', 'www.regiojet.cz', 'info@regiojet.cz');
INSERT INTO spolecnost (nazev, web, email) VALUES ('LeoExpress', 'www.leoexpress.com', 'info@le.cz');

--SELECT * FROM spolecnost;

INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('honza1', 'Jan', 'Novak', 'jannovak@gmail.com', 'zakaznik', '2019-12-3 12:30:50', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('janaN', 'Jana', 'Novakova', 'jananovakova@gmail.com', 'zakaznik', '2019-12-2 10:36:52', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('modrp', 'Petr', 'Modry', 'modrp@gmail.com', 'zakaznik', '2019-12-1 22:30:54', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('noobmaster', 'Thor', 'Odinson', 'noobmaster@gmail.com', 'zakaznik', '2019-11-30 23:23:50', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('StarLord', 'Martin', 'Maly', 'malymartin@gmail.com', 'zakaznik', '2019-11-29 11:30:40', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('kral', 'Marek', 'Novak', 'marnov@seznam.cz', 'spravce drah', '2019-12-3 05:30:50', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('Leo', 'Martin', 'Velky', 'leokral@seznam.cz', 'vlakova spolecnost', '2019-12-2 06:30:50', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('regio', 'Martina', 'Velka', 'regio@bing.com', 'vlakova spolecnost', '2019-12-4 08:35:59', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('cesd', 'Jakub', 'Motany', 'mot@gmail.com', 'vlakova spolecnost', '2019-12-5 12:30:58', 1);
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva, aktivni)
    VALUES ('pepa', 'Pepa', 'Jan', 'pepajan@gmail.com', 'zakaznik', NULL, 1);

--SELECT * FROM uzivatel;

INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('LE 400', 3, 200, 1, 3, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('RJ 106', 2, 150, 1, 2, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('SC 512 Pendolino', 4, 170, 1, 1, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('RJ 1006', 5, 100, 0, 2, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('LE 401', 2, 180, 1, 3, 1);
---------- testovaci spoje ------------
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('LE 900', 2, 180, 1, 3, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('RJ 800', 2, 200, 1, 2, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('RJ 801', 2, 200, 1, 2, 1);

INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('LE 901', 2, 180, 1, 3, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('RJ 802', 2, 200, 1, 2, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('RJ 803', 2, 200, 1, 2, 1);
---------------------------------------
--SELECT * FROM spoj;

---------- testovaci prijezdy ------------
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 6, '14:00', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 6, '14:10', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 6, '14:20', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 6, '14:30', 4, 30);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 6, '14:40', 5, 40);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (4, 7, '14:35', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 7, '14:45', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (7, 7, '14:55', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 7, '15:05', 4, 30);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 8, '15:10', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 8, '15:20', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 8, '15:30', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (11, 8, '15:40', 4, 30);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 9, '15:00', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 9, '15:10', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 9, '15:20', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 9, '15:30', 4, 30);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 9, '15:40', 5, 40);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (4, 10, '15:35', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 10, '15:45', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (7, 10, '15:55', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 10, '16:05', 4, 30);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 11, '16:10', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 11, '16:20', 2, 10);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 11, '16:30', 3, 20);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (11, 11, '16:40', 4, 30);
---------------------------------------
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 1, '13:56', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 1, '14:04', 2, 8);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 1, '14:12', 3, 13);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (4, 1, '14:21', 4, 30);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 1, '14:28', 5, 42);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 1, '14:40', 6, 63);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (7, 1, '15:01', 7, 92);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 1, '15:17', 8, 114);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 1, '15:39', 9, 160);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 1, '16:29', 10, 260);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (11, 1, '16:48', 11, 302);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (12, 1, '17:16', 12, 359);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (13, 1, '17:23', 13, 364);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 2, '14:56', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 2, '15:04', 2, 8);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 2, '15:12', 3, 13);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (4, 2, '15:21', 4, 30);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 2, '15:28', 5, 42);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 2, '15:40', 6, 63);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (7, 2, '16:01', 7, 92);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 2, '16:17', 8, 114);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 2, '16:39', 9, 160);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 2, '17:29', 10, 260);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (11, 2, '17:48', 11, 302);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (12, 2, '18:16', 12, 359);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (13, 2, '18:23', 13, 364);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 3, '7:07', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 3, '7:15', 2, 8);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 3, '7:23', 3, 13);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 3, '8:14', 4, 114);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 3, '9:23', 5, 260);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (12, 3, '10:12', 6, 359);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (13, 3, '10:45', 7, 364);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (14, 3, '10:53', 8, 368);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (15, 3, '12:05', 9, 471);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (16, 3, '12:08', 10, 472);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (17, 3, '12:31', 11, 504);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (18, 3, '12:52', 12, 535);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (13, 4, '13:47', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 4, '14:41', 2, 104);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (19, 4, '15:16', 3, 164);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 4, '15:38', 4, 204);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 4, '16:02', 5, 250);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 4, '16:35', 6, 301);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 4, '17:02', 7, 351);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 4, '17:10', 8, 356);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (20, 4, '17:29', 9, 374);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (13, 5, '16:09', 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (12, 5, '16:16', 2, 5);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (11, 5, '16:46', 3, 62);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 5, '17:05', 4, 104);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 5, '17:58', 5, 204);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 5, '18:20', 6, 250);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (7, 5, '18:38', 7, 272);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 5, '18:57', 8, 301);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 5, '19:09', 9, 322);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (4, 5, '19:16', 10, 334);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 5, '19:27', 11, 351);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 5, '19:35', 12, 356);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 5, '19:49', 13, 364);

--SELECT * FROM prijezd;

INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-27', '2020-03-27', 1);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-27', '2020-03-27', 2);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-27', '2020-03-27', 3);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-27', '2020-03-27', 5);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-28', '2020-03-28', 1);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-28', '2020-03-28', 2);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-28', '2020-03-28', 3);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-28', '2020-03-28', 5);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-29', '2020-03-29', 1);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-29', '2020-03-29', 2);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-29', '2020-03-29', 3);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-29', '2020-03-29', 4);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-29', '2020-03-29', 5);
---------- testovaci jizdy ------------
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-30', '2020-03-30', 6);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-30', '2020-03-30', 7);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-30', '2020-03-30', 8);

INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-30', '2020-03-30', 9);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-30', '2020-03-30', 10);
INSERT INTO jizda (datum_start, datum_cil, spoj_id) VALUES ('2020-03-30', '2020-03-30', 11);
---------------------------------------
--SELECT * FROM jizda;

INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (10, '2019-12-01', 1);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (9, '2019-12-01', 2);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (5, '2019-12-02', 3);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (9, '2019-12-03', 4);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (5, '2019-12-04', 5);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (7, '2019-12-02', 1);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (1, '2019-12-01', 2);

--SELECT * FROM historie_ceny;

INSERT INTO jizdenka (uzivatel_id, cena) VALUES (1, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (1, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (2, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (2, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (3, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (3, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (4, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (4, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (4, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (5, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (5, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (5, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (5, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (5, 0);

INSERT INTO jizdenka (uzivatel_id, cena) VALUES (1, 0);
INSERT INTO jizdenka (uzivatel_id, cena) VALUES (2, 0);

--SELECT * FROM jizdenka;

INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (1, 1, 3, 13, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (2, 2, 3, 13, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (3, 1, 5, 11, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (4, 4, 13, 6, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (5, 5, 2, 5, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (6, 12, 13, 20, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (7, 7, 14, 17, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (8, 9, 3, 6, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (9, 13, 13, 6, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (10, 6, 4, 10, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (11, 5, 2, 12, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (12, 3, 10, 13, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (13, 8, 10, 5, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (14, 11, 12, 15, 1);

INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (15, 1, 1, 5, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (15, 2, 5, 8, 2);

INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (16, 1, 1, 5, 1);
INSERT INTO jizdenka_jizda(jizdenka_id, jizda_id, stanice_id_start, stanice_id_cil, poradi) VALUES (16, 2, 5, 8, 2);

--SELECT * FROM jizdenka_jizda;
