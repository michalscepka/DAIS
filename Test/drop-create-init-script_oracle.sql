--======================================================
--
-- Author: Radim Baca
-- Create date: 10.10.2016
-- Description: Create a tables database that are used in UDBS lectures
-- License: This code was writtend by Radim Baca and is the property of VSB-TUO 
--          This code MAY NOT BE USED without the expressed written consent of VSB-TUO.
-- Change history:
--
--======================================================

-- Drop table if they exists
DROP TABLE Complaint; 
DROP TABLE Purchase;
DROP TABLE Product;
DROP TABLE Customer; 
DROP TABLE Employee;

-- Create tables
CREATE TABLE Product 
(
	pID INTEGER NOT NULL PRIMARY KEY, 
	serialNr VARCHAR(20) NOT NULL, 
	trademark VARCHAR(30) NOT NULL, 
	lastProductionYear INTEGER
);

CREATE TABLE Customer 
(
	cID INTEGER NOT NULL PRIMARY KEY, 
	name VARCHAR(30) NOT NULL, 
	gender VARCHAR(4), 
	registrationYear INTEGER , 
	sendNews INTEGER, 
	email VARCHAR(50) NOT NULL
);

CREATE TABLE Employee	
(
    eID INTEGER PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	town VARCHAR(30) NOT NULL,
	birthyear INTEGER,
	country VARCHAR(30) NOT NULL,
	status INTEGER
);

CREATE TABLE Purchase
(
	nID INTEGER NOT NULL PRIMARY KEY,
	cID INTEGER NOT NULL REFERENCES Customer, 
	pID INTEGER NOT NULL REFERENCES Product, 
	eID INTEGER NOT NULL REFERENCES Employee,
	purchaseDay DATE NOT NULL,
	price INTEGER NOT NULL, 
	pieces INTEGER NOT NULL
);

CREATE TABLE Complaint 
(
	nID INTEGER NOT NULL REFERENCES Purchase,
	eID INTEGER NOT NULL REFERENCES Employee,
	complaintOrder INTEGER NOT NULL, 
	durationInDays INTEGER, 
	price INTEGER, 
	CONSTRAINT PK_Complaint PRIMARY KEY (nID, complaintOrder)
);

-- Init the database
INSERT INTO Customer(cID, name, gender, registrationYear, sendNews, email) VALUES (1, 'olda', 'muz', NULL, 0, 'old.setrhand@gmail.com');
INSERT INTO Customer(cID, name, gender, registrationYear, sendNews, email) VALUES (2, 'pepik', 'muz', 1999, 0, 'pepa.z.depa@gmail.com');
INSERT INTO Customer(cID, name, gender, registrationYear, sendNews, email) VALUES (3, 'vinetu', 'muz', 2005, 1, 'winer.netu@seznam.cz');
INSERT INTO Customer(cID, name, gender, registrationYear, sendNews, email) VALUES (4, 'sandokan', 'muz', 2006, 1, 'sandal.okanal@seznam.cz');
INSERT INTO Customer(cID, name, gender, registrationYear, sendNews, email) VALUES (5, 'amazonka', 'zena', 2005, 0, 'amazonka@seznam.cz');
INSERT INTO Customer(cID, name, gender, registrationYear, sendNews, email) VALUES (6, 'dryada', 'zena', 2006, 1, 'dr.ada@seznam.cz');
INSERT INTO Customer(cID, name, gender, registrationYear, sendNews, email) VALUES (7, 'fantomas', 'muz', NULL, NULL, 'fantom.as@gmail.com');
INSERT INTO Customer(cID, name, gender, registrationYear, sendNews, email) VALUES (8, 'kilia', 'muz', 2000, NULL, 'kilian.jornet@gmail.com');
INSERT INTO Customer(cID, name, gender, registrationYear, sendNews, email) VALUES (9, 'kipkoche', 'muz', 1995, NULL, 'kip@gmail.com');

INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (1, 'Bernoulli', 'Venice', 1654, 'Italy', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (2, 'Bernoulli', 'Venice', 1667, 'Italy', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (3, 'Bernoulli', 'Mila', 1695, 'Italy', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (4, 'Bernoulli', 'Roma', 1700, 'Italy', 2);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (5, 'Bernoulli', 'Madrid', 1710, 'Spai', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (6, 'Euler', 'Atlanta', 1707, 'America', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (7, 'Rousseau', 'Philadelphia', 1712, 'America', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (8, 'Laplace', 'Albany', 1749, 'America', 2);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (9, 'Leibniz', 'Berli', 1646, 'Germany', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (10, 'Descartes', 'Paris', 1596, 'France', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (11, 'Newto', 'Londo', 1642, 'Great Britai', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (12, 'Kepler', 'Prague', NULL, 'Austria-Hungary', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (13, 'Bayes', 'Londo', 1701, 'Great Britai', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (14, 'al-Kashi', ' Kasha', NULL, 'Ira', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (15, 'Lagrange', 'Paris', 1736, 'France', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (16, 'Chongzhi', ' Kunsha', NULL, 'China', 1);
INSERT INTO Employee(eID, name, town, birthyear, country, status) VALUES (17, 'Sangamagrama', ' Dehli', NULL, 'India', 1);

INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (1, 'OSKA-01-2', 'Whirpool', 2012);
INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (2, 'OSKA-01-4', 'Whirpool', 2012);
INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (3, 'GEL-0006-7G', 'Whirpool', 2010);
INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (4, 'WOS-50-K2', 'Electrolux', 2011);
INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (5, 'WOS-40-K', 'Electrolux', 2012);
INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (6, 'WOS-10-K80', 'Electrolux', NULL);
INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (7, 'Rup-15-6', 'Humbuk', 2010);
INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (8, 'HUP', 'Green line', 2012);
INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (9, 'WAP 26', 'Green line', NULL);
INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (10, 'Bongo Ultra 256', 'Green line', 2010);
INSERT INTO Product(pID, serialNr, trademark, lastProductionYear) VALUES (11, 'Bongo Light X2', 'Green line', 2011);

INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (1, 8, 1, 2, TO_DATE('2014-05-17 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), 1669, 8);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (2, 3, 2, 2, TO_DATE('2014-07-27 03:33:00', 'YYYY-MM-DD HH24:MI:SS'), 3389, 5);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (3, 3, 3, 7, TO_DATE('2012-12-17 11:12:00', 'YYYY-MM-DD HH24:MI:SS'), 3847, 4);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (4, 1, 4, 2, TO_DATE('2013-04-11 00:37:00', 'YYYY-MM-DD HH24:MI:SS'), 4954, 7);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (5, 5, 4, 12, TO_DATE('2014-06-03 18:37:00', 'YYYY-MM-DD HH24:MI:SS'), 1710, 8);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (6, 2, 4, 1, TO_DATE('2013-03-05 13:56:00', 'YYYY-MM-DD HH24:MI:SS'), 3348, 2);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (7, 1, 7, 4, TO_DATE('2012-12-05 08:09:00', 'YYYY-MM-DD HH24:MI:SS'), 309, 1);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (8, 1, 8, 12, TO_DATE('2012-12-11 04:08:00', 'YYYY-MM-DD HH24:MI:SS'), 241, 3);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (9, 4, 8, 16, TO_DATE('2014-06-18 10:09:00', 'YYYY-MM-DD HH24:MI:SS'), 1192, 5);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (10, 6, 8, 5, TO_DATE('2012-10-21 04:34:00', 'YYYY-MM-DD HH24:MI:SS'), 2516, 2);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (11, 3, 8, 15, TO_DATE('2012-09-21 21:52:00', 'YYYY-MM-DD HH24:MI:SS'), 4546, 2);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (12, 5, 8, 9, TO_DATE('2013-07-24 02:43:00', 'YYYY-MM-DD HH24:MI:SS'), 3055, 5);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (13, 5, 8, 1, TO_DATE('2014-05-24 19:39:00', 'YYYY-MM-DD HH24:MI:SS'), 2424, 5);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (14, 3, 8, 2, TO_DATE('2013-09-04 13:06:00', 'YYYY-MM-DD HH24:MI:SS'), 2536, 8);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (15, 1, 8, 12, TO_DATE('2014-01-17 13:37:00', 'YYYY-MM-DD HH24:MI:SS'), 4094, 4);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (16, 6, 9, 4, TO_DATE('2014-10-23 13:27:00', 'YYYY-MM-DD HH24:MI:SS'), 3752, 9);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (17, 7, 9, 3, TO_DATE('2013-08-16 02:18:00', 'YYYY-MM-DD HH24:MI:SS'), 3835, 1);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (18, 3, 9, 16, TO_DATE('2012-06-04 00:09:00', 'YYYY-MM-DD HH24:MI:SS'), 3302, 7);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (19, 2, 9, 1, TO_DATE('2012-08-22 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), 3859, 1);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (20, 7, 9, 11, TO_DATE('2013-09-26 08:34:00', 'YYYY-MM-DD HH24:MI:SS'), 3114, 4);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (21, 5, 9, 15, TO_DATE('2013-06-14 17:21:00', 'YYYY-MM-DD HH24:MI:SS'), 3911, 9);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (22, 6, 9, 12, TO_DATE('2014-07-10 13:25:00', 'YYYY-MM-DD HH24:MI:SS'), 1445, 9);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (23, 6, 9, 9, TO_DATE('2012-08-17 17:12:00', 'YYYY-MM-DD HH24:MI:SS'), 423, 7);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (24, 4, 10, 7, TO_DATE('2013-12-11 10:59:00', 'YYYY-MM-DD HH24:MI:SS'), 1527, 2);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (25, 1, 10, 4, TO_DATE('2012-03-19 15:58:00', 'YYYY-MM-DD HH24:MI:SS'), 3498, 2);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (26, 3, 10, 8, TO_DATE('2012-03-26 18:23:00', 'YYYY-MM-DD HH24:MI:SS'), 4533, 1);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (27, 5, 10, 6, TO_DATE('2013-06-28 04:33:00', 'YYYY-MM-DD HH24:MI:SS'), 3958, 9);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (28, 5, 10, 14, TO_DATE('2013-05-04 02:15:00', 'YYYY-MM-DD HH24:MI:SS'), 4461, 7);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (29, 1, 10, 2, TO_DATE('2012-11-01 20:50:00', 'YYYY-MM-DD HH24:MI:SS'), 4241, 5);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (30, 6, 10, 2, TO_DATE('2012-08-27 09:51:00', 'YYYY-MM-DD HH24:MI:SS'), 1794, 2);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (31, 8, 11, 2, TO_DATE('2013-02-19 21:11:00', 'YYYY-MM-DD HH24:MI:SS'), 309, 8);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (32, 5, 11, 13, TO_DATE('2012-02-15 21:57:00', 'YYYY-MM-DD HH24:MI:SS'), 4887, 5);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (33, 3, 11, 4, TO_DATE('2013-02-16 18:17:00', 'YYYY-MM-DD HH24:MI:SS'), 324, 1);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (34, 4, 11, 12, TO_DATE('2012-10-07 06:52:00', 'YYYY-MM-DD HH24:MI:SS'), 4546, 3);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (35, 5, 11, 2, TO_DATE('2012-09-01 09:51:00', 'YYYY-MM-DD HH24:MI:SS'), 1990, 6);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (36, 3, 11, 4, TO_DATE('2014-05-03 13:49:00', 'YYYY-MM-DD HH24:MI:SS'), 3589, 5);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (37, 1, 11, 2, TO_DATE('2013-06-29 01:36:00', 'YYYY-MM-DD HH24:MI:SS'), 4318, 7);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (38, 1, 1, 2, TO_DATE('2014-01-17 13:37:00', 'YYYY-MM-DD HH24:MI:SS'), 4094, 4);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (39, 6, 1, 2, TO_DATE('2014-10-23 13:27:00', 'YYYY-MM-DD HH24:MI:SS'), 3752, 9);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (40, 7, 2, 3, TO_DATE('2013-08-16 02:18:00', 'YYYY-MM-DD HH24:MI:SS'), 3835, 1);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (41, 3, 3, 16, TO_DATE('2012-06-04 00:09:00', 'YYYY-MM-DD HH24:MI:SS'), 3302, 7);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (42, 2, 3, 1, TO_DATE('2012-08-22 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), 3859, 1);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (43, 7, 4, 11, TO_DATE('2013-09-26 08:34:00', 'YYYY-MM-DD HH24:MI:SS'), 3114, 4);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (44, 5, 4, 15, TO_DATE('2014-06-14 17:21:00', 'YYYY-MM-DD HH24:MI:SS'), 3911, 9);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (45, 6, 6, 12, TO_DATE('2014-07-10 13:25:00', 'YYYY-MM-DD HH24:MI:SS'), 1445, 9);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (46, 6, 7, 9, TO_DATE('2012-08-17 17:12:00', 'YYYY-MM-DD HH24:MI:SS'), 423, 7);
INSERT INTO Purchase(nID, cID, pID, eID, purchaseDay, price, pieces) VALUES (47, 4, 7, 7, TO_DATE('2013-12-11 10:59:00', 'YYYY-MM-DD HH24:MI:SS'), 1527, 2);

INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (2, 10, 1, 9, 3192);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (3, 6, 1, 2, 2933);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (3, 7, 2, 3, 6734);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (5, 6, 1, 15, 1465);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (5, 6, 2, 7, 1291);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (7, 10, 1, 13, 260);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (7, 3, 2, 20, 203);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (8, 4, 1, 9, 230);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (9, 9, 1, 9, 1694);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (11, 2, 1, 13, 2840);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (11, 9, 2, 6, 7194);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (11, 7, 3, 18, 4178);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (13, 6, 1, 18, 2784);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (15, 6, 1, 16, 12327);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (16, 11, 1, 13, 198687);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (16, 16, 2, 20, 3215);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (16, 1, 3, 17, 3277);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (16, 10, 4, 16, 3959);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (17, 16, 1, 10, 3584);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (17, 13, 2, 7, 9577);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (18, 7, 1, 6, 6159);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (20, 5, 1, 12, 5250);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (20, 4, 2, 16, 4313);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (23, 4, 1, 7, 373);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (23, 13, 2, 19, 915);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (23, 12, 3, 9, 282);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (24, 2, 1, 4, 1329);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (24, 15, 2, 3, 1049);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (27, 9, 1, 19, 11241);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (27, 13, 2, 9, 3415);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (28, 5, 1, 4, 11157);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (28, 13, 2, 2, 5248);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (28, 8, 3, 7, 6141);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (32, 12, 1, 16, 9719);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (32, 16, 2, 14, 8582);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (32, 16, 3, 17, 2941);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (32, 12, 4, 7, 4733);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (33, 12, 1, 14, 276);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (33, 5, 2, 5, 520);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (33, 8, 3, 17, 69344);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (33, 16, 4, 17, 432);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (34, 8, 1, 15, 6173);
INSERT INTO Complaint(nID, eID, complaintOrder, durationInDays, price) VALUES (34, 14, 2, 5, 12877);

COMMIT;

-- Select the count of records
SELECT COUNT(*) FROM Product;
SELECT COUNT(*) FROM Customer;
SELECT COUNT(*) FROM Employee;	
SELECT COUNT(*) FROM Purchase;
SELECT COUNT(*) FROM Complaint;