USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fncCheckEmailDomain]
(
	@EmailAddress nvarchar(100)
)
RETURNS BIT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar bit
	SET @ResultVar = 0
	-- Add the T-SQL statements to compute the return value here
	DECLARE @Domains TABLE
	(
	id INT IDENTITY(1,1),
	Domain nvarchar(55)
	)
	INSERT INTO @Domains(Domain)
	SELECT Domain FROM isp_Domains
	WHERE Active = 1
	DECLARE @RowCount INT
SET @RowCount = (SELECT COUNT(id) FROM @Domains) 

	DECLARE @I int
	SET @I = 1
	WHILE (@I <= @RowCount)
	BEGIN
	DECLARE @RowDomain nvarchar(55)
	SELECT @RowDomain = Domain FROM @Domains where id = @I
	IF (SELECT CASE WHEN @EmailAddress LIKE N'%' + @RowDomain + '' THEN 1 ELSE 0 END AS True) = 1
	BEGIN
	SET @ResultVar = 1
	BREAK
	END
	SET @I = @I + 1
END

	-- Return the result of the function
	
	RETURN @ResultVar

END
GO
