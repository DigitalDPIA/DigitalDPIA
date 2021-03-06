USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 09/05/2018
-- Description:	Updates Super Admin record and updates associated super admin groups
-- =============================================
CREATE PROCEDURE [dbo].[UpdateSuperAdmin] 
	-- Add the parameters for the stored procedure here
	@SuperAdminID int,
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
	Update isp_SuperAdmins SET SuperAdminEmail=@SAEmail, ContentManager=@ContentManager, CentralSA=@CentralSA
	WHERE SuperAdminID = @SuperAdminID

	-- Now insert rows into isp_SuperAdminGroups for any admin group id in @@AdminGroupsCSV:
	if LEN(@AdminGroupsCSV) > 0
	BEGIN
	INSERT INTO isp_SuperAdminGroups (SuperAdminID, AdminGroupID)
SELECT @SuperAdminID AS SuperAdminID, ID AS AdminGroupID
	FROM [dbo].[tvfSplitCSV] (@AdminGroupsCSV)
	WHERE ID NOT IN (SELECT AdminGroupID FROM isp_SuperAdminGroups WHERE SuperAdminID = @SuperAdminID)
	END
	--...and delete any that exist that no longer should:
	DELETE FROM isp_SuperAdminGroups
	WHERE SuperAdminID = @SuperAdminID AND AdminGroupID NOT IN (SELECT * FROM [dbo].[tvfSplitCSV] (@AdminGroupsCSV))
END
GO
