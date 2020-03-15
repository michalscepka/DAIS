--1. Pridejte tabulce Product atribut dostupny_pocet_kusu.
--Napiste ulozenou proceduru PridejNakup(pID, cID, eID, pieces, price), ktera
--ulozi do tabulky Purchase nakup jen pokud je dostatecny pocet dotupnych
--kusu u daneho produktu. V opacnem pripade vyvola vyjimku. Po vlozeni do tabulky
--Purchase aktualizujte take pocet_dostupnych_kusu.

ALTER TABLE Product ADD dostupny_pocet_kusu INT;

SELECT * FROM Product;

create or replace PROCEDURE PridejNakup(
    productID IN Purchase.pID%TYPE,
    cID IN Purchase.cID%TYPE,
    eID IN Purchase.eID%TYPE,
    pieces IN Purchase.pieces%TYPE,
    price IN Purchase.price%TYPE)
AS
    v_pocet_kusu INT;
    not_enough_pieces EXCEPTION;
BEGIN
    SELECT Product.dostupny_pocet_kusu INTO v_pocet_kusu
        FROM Product WHERE Product.pID = productID;
        
    IF v_pocet_kusu >= pieces THEN
        INSERT INTO Purchase
            VALUES((SELECT MAX(nID) FROM Purchase) + 1, cID, productID, eID, (SELECT CURRENT_DATE FROM dual), price, pieces);
        UPDATE Product SET dostupny_pocet_kusu = dostupny_pocet_kusu - pieces
            WHERE Product.pID = productID;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nedostatek kusu!');
        RAISE not_enough_pieces;
    END IF;
END;

SELECT * FROM Product;
SELECT * FROM Purchase;

UPDATE Product SET dostupny_pocet_kusu = 5;

EXEC PridejNakup(1, 1, 1, 1, 100);

DELETE FROM Purchase WHERE nID = 48;

--2. Pridejte tabulce Employee atribut pocet_nakupu. Pri kazdem
--vlozeni nakupu hodnotu tohoto atributu u prislusneho zamestnance
--inkrementujte. Pri smazani nakupu hodnotu dekrementujte.

ALTER TABLE Employee ADD pocet_nakupu INT;

UPDATE Employee SET pocet_nakupu = 0;

SELECT * FROM Employee;

CREATE OR REPLACE
TRIGGER PocetNakupuCount
BEFORE DELETE OR INSERT ON Purchase
FOR EACH ROW
DECLARE
BEGIN
    IF inserting THEN
        UPDATE Employee SET pocet_nakupu = pocet_nakupu + 1
        WHERE eID = :NEW.eID;
    END IF;
    IF deleting THEN
        UPDATE Employee SET pocet_nakupu = pocet_nakupu - 1
        WHERE eID = :OLD.eID;
    END IF;
END;

EXEC PridejNakup(1, 1, 1, 1, 100);

DELETE FROM Purchase WHERE nID = 48;

--3. Vytvorte tabulku ComplaintImport, ktera bude mit parametry nID a eID.
--Vytvorte proceduru InsertComplaints, ktera presune vsechny radky z tabulky
--ComplaintImport do tabulky Complaint. Pri vkladani bude nastavovat hodnotu
--complaintOrder na nejnizsi dostupnou kladnou hodnotu. Zbyvajici atributy budou
--null. Procedura bude kontrolovat, zda existuje eID i nID v prislusnych tabulkach
--a pokud tam nebudou, tak zaznamy pri importu zustanou v tabulce ComplaintImport.

CREATE TABLE ComplaintImport (
    nID INTEGER NOT NULL,
    eID INTEGER NOT NULL
);

create or replace PROCEDURE InsertComplaints
AS
v_nejmensi_co INT;
v_eids INT;
v_nids INT;
BEGIN     
    FOR radek IN (SELECT *  FROM ComplaintImport) LOOP
    
        SELECT count(eid) into v_eids
        FROM Employee
        WHERE Employee.eid = radek.eid;
        
        SELECT count(nid) into v_nids
        FROM Purchase
        WHERE Purchase.nid = radek.nid;
    
        IF v_nids > 0 and v_eids > 0 THEN
            
            SELECT COALESCE(MAX(Complaint.complaintorder),0) INTO v_nejmensi_co
            FROM Complaint
            WHERE radek.nid = Complaint.nid;
            
            INSERT INTO Complaint(nid,eid,complaintOrder,price,finished) VALUES(radek.nid,radek.eid,v_nejmensi_co + 1,null,null);
            
            DELETE FROM ComplaintImport WHERE eid = radek.eid and nid = radek.nid;
        END IF;
    END LOOP;
END;

INSERT INTO ComplaintImport VALUES(1, 1);
INSERT INTO ComplaintImport VALUES(2, 1);
INSERT INTO ComplaintImport VALUES(3, 1);
INSERT INTO ComplaintImport VALUES(4, 1);
INSERT INTO ComplaintImport VALUES(1, 2);
INSERT INTO ComplaintImport VALUES(2, 2);

SELECT * FROM ComplaintImport;
SELECT * FROM Complaint;

DELETE FROM Complaint;
DELETE FROM ComplaintImport;

EXEC InsertComplaints;

SELECT COUNT(nID) FROM Complaint WHERE nID = 1;

SET SERVEROUTPUT ON;

--4. Pridejte do tabulky Complaint nepovinny atribut finished, ktery bude moci
--nabyvat pouze hodnot nula nebo jedna. Hodnota jedna bude znamenat, ze je
--reklamace vyrizena a hodnota nula nebo null bude znamenat, ze reklamace jeste
--bezi. Pri vkladani do tabulky Complaint vyvolejte vyjimku, pokud by mel
--zamestnanec po vlozeni vice nez tri reklamace.

ALTER TABLE Complaint ADD finished INT CHECK(finished IN (0, 1));

SELECT * FROM Complaint;

create or replace TRIGGER PocetAktivnichReklamaci
BEFORE INSERT ON Complaint
FOR EACH ROW
DECLARE
    v_complaints_count INT;
    more_than_three EXCEPTION;
BEGIN
    IF inserting THEN
        SELECT COUNT(eID) INTO v_complaints_count FROM Complaint
            WHERE eID = :NEW.eID AND (finished = 0 OR finished IS NULL);
        --DBMS_OUTPUT.PUT_LINE(v_complaints_count);
        IF v_complaints_count >= 3 THEN
            RAISE more_than_three;
        END IF;
    END IF;
END;

INSERT INTO Complaint VALUES(1, 1, 0, null, null, null);
INSERT INTO Complaint VALUES(2, 1, 0, null, null, null);
INSERT INTO Complaint VALUES(3, 1, 0, null, null, null);
INSERT INTO Complaint VALUES(4, 1, 0, null, null, null);























