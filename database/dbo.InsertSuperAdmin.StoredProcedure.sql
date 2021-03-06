USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 09/05/2018
-- Description:	Adds a super admin and inserts the relevant admin groups into SuperAdminGroups
-- =============================================
CREATE PROCEDURE [dbo].[InsertSuperAdmin]
	-- Add the parameters for the stored procedure here
	@SAEmail nvarchar(255),
	@ContentManager bit,
	@CentralSA bit,
	@AdminGroupsCSV nvarchar (255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	begin
	Insert into isp_SuperAdmins (SuperAdminEmail,ContentManager,CentralSA) values (@SAEmail,@ContentManager,@CentralSA)

	DECLARE @_SuperAdminID as Int
	end
	SET @_SuperAdminID = SCOPE_IDENTITY()
	
	--INSERT ALL OF THE AdminGroups IN @AdminGroupsCSV:
if LEN(@AdminGroupsCSV) > 0
	BEGIN
INSERT INTO isp_SuperAdminGroups (SuperAdminID, AdminGroupID)
SELECT @_SuperAdminID AS SuperAdminID, ID AS AdminGroupID
	FROM [dbo].[tvfSplitCSV] (@AdminGroupsCSV)
	END



END
GO
