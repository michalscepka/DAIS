ALTER TABLE stanice DROP CONSTRAINT stanice_mesto_fk;
ALTER TABLE spoj DROP CONSTRAINT spoj_spolecnost_fk;
ALTER TABLE prijezd DROP CONSTRAINT prijezd_stanice_fk;
ALTER TABLE prijezd DROP CONSTRAINT prijezd_spoj_fk;
ALTER TABLE jizdenka DROP CONSTRAINT jizdenka_uzivatel_fk;
ALTER TABLE jizdenka_jizda DROP CONSTRAINT jizdenka_jizda_stanice_fkv2;
ALTER TABLE jizdenka_jizda DROP CONSTRAINT jizdenka_jizda_stanice_fk;
ALTER TABLE jizdenka_jizda DROP CONSTRAINT jizdenka_jizda_jizdenka_fk;
ALTER TABLE jizdenka_jizda DROP CONSTRAINT jizdenka_jizda_jizda_fk;
ALTER TABLE jizda DROP CONSTRAINT jizda_spoj_fk;
ALTER TABLE historie_ceny DROP CONSTRAINT historie_ceny_spoj_fk;

DROP TABLE uzivatel;
DROP TABLE stanice;
DROP TABLE spolecnost;
DROP TABLE spoj;
DROP TABLE prijezd;
DROP TABLE mesto;
DROP TABLE jizdenka;
DROP TABLE jizdenka_jizda;
DROP TABLE jizda;
DROP TABLE historie_ceny;
