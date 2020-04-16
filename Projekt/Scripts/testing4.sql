
SELECT * FROM Uzivatel
GO


/*CREATE*/ ALTER PROCEDURE SelectByName(
	@p_input VARCHAR(20)
) AS
BEGIN
	SELECT *
	FROM Uzivatel
	WHERE jmeno LIKE '%' + @p_input + '%' OR
		prijmeni LIKE '%' + @p_input + '%';
END
GO

EXEC SelectByName 'Ma';
