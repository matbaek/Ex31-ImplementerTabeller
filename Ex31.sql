USE C_DB10_2018;

DROP TABLE Ex31L�ge;
DROP TABLE Ex31Person;
DROP PROCEDURE Inds�tL�ge;
DROP PROCEDURE VisL�ge;

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

CREATE TABLE Ex31L�ge
(
	L�geID INT FOREIGN KEY REFERENCES Ex31Person (ID),
	L�nramme NVARCHAR(1) NOT NULL
);


GO
CREATE PROCEDURE Inds�tL�ge
	(@Navn NVARCHAR(50), @L�nramme NVARCHAR(1))
AS BEGIN
	INSERT INTO Ex31Person (Navn) VALUES (@Navn)
	INSERT INTO Ex31L�ge (L�geID, L�nramme) VALUES (SCOPE_IDENTITY(), @L�nramme)
END

EXEC Inds�tL�ge 'Ib Larsson', 'D'

GO
CREATE PROCEDURE VisL�ge
	(@ID INT)
AS BEGIN
	SELECT p.ID, p.Navn, l.L�nramme 
	FROM Ex31Person AS p
	JOIN Ex31L�ge AS l 
		ON p.ID = l.L�geID
	WHERE p.ID = @ID
END

EXEC VisL�ge 2