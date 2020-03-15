--1. task

CREATE TABLE PurchaseImport (
    serialNr VARCHAR2(30) NOT NULL,
    trademark VARCHAR2(30) NOT NULL,
    cID INTEGER NOT NULL,
    eID INTEGER NOT NULL,
    price INTEGER NOT NULL,
    pieces INTEGER NOT NULL
);

INSERT INTO PurchaseImport VALUES('OSKA-01-2', 'Whirpool', 1, 1, 200, 60);
INSERT INTO PurchaseImport VALUES('GEL-0006-7G', 'Whirpool', 1, 1, 200, 60);

SELECT * FROM PurchaseImport;
SELECT * FROM Purchase;
SELECT * FROM Product;

EXEC InsertPurchases;

SELECT product.lastproductionyear from Product;

create or replace PROCEDURE InsertPurchases
AS
    v_pID INT;
BEGIN     
    FOR radek IN (SELECT *  FROM PurchaseImport) LOOP
    
        SELECT pID INTO v_pID FROM Product
        WHERE radek.serialNr = Product.serialNr AND radek.trademark = Product.trademark
            AND Product.lastproductionyear = (
                SELECT MAX(lastproductionyear) FROM Product
                WHERE radek.serialNr = Product.serialNr AND radek.trademark = Product.trademark);
            
        INSERT INTO Purchase(nID, cID, pID, eID, purchaseday, price, pieces)
            VALUES((SELECT MAX(nID) FROM Purchase) + 1, 
                radek.cID, v_pID, radek.eID, (SELECT CURRENT_DATE FROM dual), radek.price, radek.pieces);
    END LOOP;
END;

--2. task

CREATE TABLE Pair (
    cID1 INTEGER NOT NULL,
    cID2 INTEGER NOT NULL
);

CREATE TABLE Offer (
    pID INTEGER NOT NULL,
    cID INTEGER NOT NULL
);

SELECT * FROM Pair;
SELECT * FROM Offer;
SELECT * FROM Customer;

INSERT INTO Pair VALUES(1, 2);
INSERT INTO Pair VALUES(1, 3);
INSERT INTO Pair VALUES(1, 4);
INSERT INTO Pair VALUES(2, 5);

DELETE FROM Offer;

create or replace TRIGGER PurchaseTrigger
BEFORE INSERT ON Purchase
FOR EACH ROW
DECLARE
BEGIN
    IF inserting THEN
        FOR one_pair IN (SELECT * FROM Pair WHERE cID1 = :NEW.cID) LOOP
            INSERT INTO Offer(pID, cID) VALUES(:NEW.pID, one_pair.cID2);
        END LOOP;
    END IF;
END;

INSERT INTO Purchase
    VALUES((SELECT MAX(nID) FROM Purchase) + 1, 1, 1, 1, (SELECT CURRENT_DATE FROM dual), 100, 1);












