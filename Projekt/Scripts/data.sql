INSERT INTO mesto (nazev) VALUES ('Bohumin');
INSERT INTO mesto (nazev) VALUES ('Ostrava');
INSERT INTO mesto (nazev) VALUES ('Studenka');
INSERT INTO mesto (nazev) VALUES ('Suchodol nad Odrou');
INSERT INTO mesto (nazev) VALUES ('Hranice na Morave');
INSERT INTO mesto (nazev) VALUES ('Prerov');
INSERT INTO mesto (nazev) VALUES ('Olomouc');
INSERT INTO mesto (nazev) VALUES ('Zabreh na Morave');
INSERT INTO mesto (nazev) VALUES ('Pardubice');
INSERT INTO mesto (nazev) VALUES ('Kolin');
INSERT INTO mesto (nazev) VALUES ('Praha');
INSERT INTO mesto (nazev) VALUES ('Plzen');
INSERT INTO mesto (nazev) VALUES ('Stribro');
INSERT INTO mesto (nazev) VALUES ('Plana');
INSERT INTO mesto (nazev) VALUES ('Ceska Trebova');
INSERT INTO mesto (nazev) VALUES ('Havirov');

SELECT * FROM mesto;

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

SELECT * FROM stanice;

INSERT INTO spolecnost (nazev) VALUES ('Ceske Drahy');
INSERT INTO spolecnost (nazev) VALUES ('RegioJet');
INSERT INTO spolecnost (nazev) VALUES ('LeoExpress');

SELECT * FROM spolecnost;

INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
    VALUES ('honza1', 'Jan', 'Novak', 'jannovak@gmail.com', 'zakaznik', to_timestamp('2019-12-3 12:30:50', 'YYYY-MM-DD:HH24:MI:SS'));
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
    VALUES ('janaN', 'Jana', 'Novakova', 'jananovakova@gmail.com', 'zakaznik', to_timestamp('2019-12-2 10:36:52', 'YYYY-MM-DD:HH24:MI:SS'));
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
    VALUES ('modrp', 'Petr', 'Modry', 'modrp@gmail.com', 'zakaznik', to_timestamp('2019-12-1 22:30:54', 'YYYY-MM-DD:HH24:MI:SS'));
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
    VALUES ('noobmaster', 'Thor', 'Odinson', 'noobmaster@gmail.com', 'zakaznik', to_timestamp('2019-11-30 23:23:50', 'YYYY-MM-DD:HH24:MI:SS'));
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
    VALUES ('StarLord', 'Martin', 'Maly', 'malymartin@gmail.com', 'zakaznik', to_timestamp('2019-11-29 11:30:40', 'YYYY-MM-DD:HH24:MI:SS'));
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
    VALUES ('kral', 'Marek', 'Novak', 'marnov@seznam.cz', 'spravce drah', to_timestamp('2019-12-3 05:30:50', 'YYYY-MM-DD:HH24:MI:SS'));
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
    VALUES ('Leo', 'Martin', 'Velky', 'leokral@seznam.cz', 'vlakova spolecnost', to_timestamp('2019-12-2 06:30:50', 'YYYY-MM-DD:HH24:MI:SS'));
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
    VALUES ('regio', 'Martina', 'Velka', 'regio@bing.com', 'vlakova spolecnost', to_timestamp('2019-12-4 08:35:59', 'YYYY-MM-DD:HH24:MI:SS'));
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
    VALUES ('cesd', 'Jakub', 'Motany', 'mot@gmail.com', 'vlakova spolecnost', to_timestamp('2019-12-5 12:30:58', 'YYYY-MM-DD:HH24:MI:SS'));
INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
    VALUES ('pepa', 'Pepa', 'Jan', 'pepajan@gmail.com', 'zakaznik', NULL);

SELECT * FROM uzivatel;

INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id) VALUES ('LE 400', 3, 200, 1, 3);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id) VALUES ('RJ 106', 2, 150, 1, 2);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id) VALUES ('SC 512 Pendolino', 4, 170, 1, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id) VALUES ('RJ 1006', 5, 100, 0, 2);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id) VALUES ('LE 401', 2, 180, 1, 3);

SELECT * FROM spoj;

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 1, to_timestamp('13:56', 'HH24:MI'), 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 1, to_timestamp('14:04', 'HH24:MI'), 2, 8);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 1, to_timestamp('14:12', 'HH24:MI'), 3, 13);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (4, 1, to_timestamp('14:21', 'HH24:MI'), 4, 30);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 1, to_timestamp('14:28', 'HH24:MI'), 5, 42);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 1, to_timestamp('14:40', 'HH24:MI'), 6, 63);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (7, 1, to_timestamp('15:01', 'HH24:MI'), 7, 92);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 1, to_timestamp('15:17', 'HH24:MI'), 8, 114);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 1, to_timestamp('15:39', 'HH24:MI'), 9, 160);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 1, to_timestamp('16:29', 'HH24:MI'), 10, 260);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (11, 1, to_timestamp('16:48', 'HH24:MI'), 11, 302);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (12, 1, to_timestamp('17:16', 'HH24:MI'), 12, 359);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (13, 1, to_timestamp('17:23', 'HH24:MI'), 13, 364);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 2, to_timestamp('14:56', 'HH24:MI'), 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 2, to_timestamp('15:04', 'HH24:MI'), 2, 8);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 2, to_timestamp('15:12', 'HH24:MI'), 3, 13);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (4, 2, to_timestamp('15:21', 'HH24:MI'), 4, 30);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 2, to_timestamp('15:28', 'HH24:MI'), 5, 42);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 2, to_timestamp('15:40', 'HH24:MI'), 6, 63);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (7, 2, to_timestamp('16:01', 'HH24:MI'), 7, 92);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 2, to_timestamp('16:17', 'HH24:MI'), 8, 114);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 2, to_timestamp('16:39', 'HH24:MI'), 9, 160);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 2, to_timestamp('17:29', 'HH24:MI'), 10, 260);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (11, 2, to_timestamp('17:48', 'HH24:MI'), 11, 302);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (12, 2, to_timestamp('18:16', 'HH24:MI'), 12, 359);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (13, 2, to_timestamp('18:23', 'HH24:MI'), 13, 364);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 3, to_timestamp('7:07', 'HH24:MI'), 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 3, to_timestamp('7:15', 'HH24:MI'), 2, 8);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 3, to_timestamp('7:23', 'HH24:MI'), 3, 13);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 3, to_timestamp('8:14', 'HH24:MI'), 4, 114);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 3, to_timestamp('9:23', 'HH24:MI'), 5, 260);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (12, 3, to_timestamp('10:12', 'HH24:MI'), 6, 359);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (13, 3, to_timestamp('10:45', 'HH24:MI'), 7, 364);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (14, 3, to_timestamp('10:53', 'HH24:MI'), 8, 368);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (15, 3, to_timestamp('12:05', 'HH24:MI'), 9, 471);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (16, 3, to_timestamp('12:08', 'HH24:MI'), 10, 472);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (17, 3, to_timestamp('12:31', 'HH24:MI'), 11, 504);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (18, 3, to_timestamp('12:52', 'HH24:MI'), 12, 535);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (13, 4, to_timestamp('13:47', 'HH24:MI'), 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 4, to_timestamp('14:41', 'HH24:MI'), 2, 104);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (19, 4, to_timestamp('15:16', 'HH24:MI'), 3, 164);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 4, to_timestamp('15:38', 'HH24:MI'), 4, 204);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 4, to_timestamp('16:02', 'HH24:MI'), 5, 250);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 4, to_timestamp('16:35', 'HH24:MI'), 6, 301);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 4, to_timestamp('17:02', 'HH24:MI'), 7, 351);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 4, to_timestamp('17:10', 'HH24:MI'), 8, 356);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (20, 4, to_timestamp('17:29', 'HH24:MI'), 9, 374);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (13, 5, to_timestamp('16:09', 'HH24:MI'), 1, 0);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (12, 5, to_timestamp('16:16', 'HH24:MI'), 2, 5);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (11, 5, to_timestamp('16:46', 'HH24:MI'), 3, 62);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (10, 5, to_timestamp('17:05', 'HH24:MI'), 4, 104);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (9, 5, to_timestamp('17:58', 'HH24:MI'), 5, 204);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (8, 5, to_timestamp('18:20', 'HH24:MI'), 6, 250);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (7, 5, to_timestamp('18:38', 'HH24:MI'), 7, 272);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (6, 5, to_timestamp('18:57', 'HH24:MI'), 8, 301);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (5, 5, to_timestamp('19:09', 'HH24:MI'), 9, 322);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (4, 5, to_timestamp('19:16', 'HH24:MI'), 10, 334);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (3, 5, to_timestamp('19:27', 'HH24:MI'), 11, 351);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (2, 5, to_timestamp('19:35', 'HH24:MI'), 12, 356);
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost) VALUES (1, 5, to_timestamp('19:49', 'HH24:MI'), 13, 364);

SELECT * FROM prijezd;

INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-05', 'YYYY-MM-DD'), 1);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-05', 'YYYY-MM-DD'), 2);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-05', 'YYYY-MM-DD'), 3);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-05', 'YYYY-MM-DD'), 5);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-06', 'YYYY-MM-DD'), 1);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-06', 'YYYY-MM-DD'), 2);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-06', 'YYYY-MM-DD'), 3);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-06', 'YYYY-MM-DD'), 5);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-07', 'YYYY-MM-DD'), 1);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-07', 'YYYY-MM-DD'), 2);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-07', 'YYYY-MM-DD'), 3);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-07', 'YYYY-MM-DD'), 4);
INSERT INTO jizda (datum, spoj_id) VALUES (to_timestamp('2019-12-07', 'YYYY-MM-DD'), 5);

SELECT * FROM jizda;

INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (10, to_timestamp('20191201', 'YYYY-MM-DD'), 1);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (9, to_timestamp('20191201', 'YYYY-MM-DD'), 2);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (5, to_timestamp('20191202', 'YYYY-MM-DD'), 3);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (9, to_timestamp('20191203', 'YYYY-MM-DD'), 4);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (5, to_timestamp('20191204', 'YYYY-MM-DD'), 5);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (7, to_timestamp('20191202', 'YYYY-MM-DD'), 1);
INSERT INTO historie_ceny(cena, datum, spoj_id) VALUES (1, to_timestamp('20191201', 'YYYY-MM-DD'), 2);

SELECT * FROM historie_ceny;

INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (1, 1, 3, 13, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (1, 2, 3, 13, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (2, 1, 5, 11, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (2, 4, 13, 6, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (3, 5, 2, 5, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (3, 12, 13, 20, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (4, 7, 14, 17, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (4, 9, 3, 6, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (4, 13, 13, 6, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (5, 6, 4, 10, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (5, 5, 2, 12, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (5, 3, 10, 13, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (5, 8, 10, 5, 0);
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena) VALUES (5, 11, 12, 15, 0);

SELECT * FROM jizdenka;
