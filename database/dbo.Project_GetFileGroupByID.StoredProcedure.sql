USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Michael Georgiades
-- Create date: 01/05/2019
-- Description:	Creates a file group of the specified type and returns it's ID.
-- =============================================
CREATE PROCEDURE [dbo].[Project_GetFileGroupByID]
	@GroupType nvarchar(20),
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT COALESCE((
			SELECT TOP (1) FileGroupID
			FROM isp_FileGroups
			WHERE (GroupType = @GroupType)
				AND (ID = @ID)
			), 0) AS FileGroupID
END

GO
