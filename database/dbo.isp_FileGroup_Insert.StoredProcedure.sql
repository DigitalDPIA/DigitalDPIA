USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 28/05/2015
-- Description:	Creates a file group of the specified type and returns it's ID.
-- =============================================
CREATE PROCEDURE [dbo].[isp_FileGroup_Insert]
	@GroupType nvarchar(20),
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_FileGroupID AS Int
	if exists (SELECT * FROM isp_FileGroups WHERE GroupType=@GroupType AND ID=@ID AND @ID > 0)
	begin
	SELECT @_FileGroupID = FileGroupID  FROM isp_FileGroups WHERE GroupType=@GroupType AND ID=@ID
	end
	else
	begin 
	INSERT INTO isp_FileGroups (GroupType, ID) Values (@GroupType, @ID)
    SET @_FileGroupID = SCOPE_IDENTITY()
	end
	SELECT @_FileGroupID
	Return @_FileGroupID
END

GO
