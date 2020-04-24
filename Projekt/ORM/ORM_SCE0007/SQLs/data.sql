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

INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('LE 400', 3, 200, 1, 3, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('RJ 106', 2, 150, 1, 2, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('SC 512', 4, 170, 1, 1, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('RJ 1006', 5, 100, 0, 2, 1);
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id, aktivni) VALUES ('LE 401', 2, 180, 1, 3, 1);

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
