USE C_DB10_2018;

DROP TABLE Ex31Læge;
DROP TABLE Ex31Person;
DROP PROCEDURE IndsætLæge;
DROP PROCEDURE VisLæge;

/*
tip
DECLARE @LastValue AS INT;
SET @LastValue = (SELECT SCOPE_IDENTITY());
SCOPE_IDENTITY() tager den sidste INSERT
*/

CREATE TABLE Ex31Person 
(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Navn NVARCHAR(100) NOT NULL
);

CREATE TABLE Ex31Læge
(
	LægeID INT FOREIGN KEY REFERENCES Ex31Person (ID),
	Lønramme NVARCHAR(1) NOT NULL
);


GO
CREATE PROCEDURE IndsætLæge
	(@Navn NVARCHAR(50), @Lønramme NVARCHAR(1))
AS BEGIN
	INSERT INTO Ex31Person (Navn) VALUES (@Navn)
	INSERT INTO Ex31Læge (LægeID, Lønramme) VALUES (SCOPE_IDENTITY(), @Lønramme)
END

EXEC IndsætLæge 'Ib Larsson', 'D'

GO
CREATE PROCEDURE VisLæge
	(@ID INT)
AS BEGIN
	SELECT p.ID, p.Navn, l.Lønramme 
	FROM Ex31Person AS p
	JOIN Ex31Læge AS l 
		ON p.ID = l.LægeID
	WHERE p.ID = @ID
END

EXEC VisLæge 2