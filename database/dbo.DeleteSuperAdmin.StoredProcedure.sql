USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 09/05/2018
-- Description:	Deletes all SuperAdminGroup records associated with a super admin id and then deletes the Super Admin
-- =============================================
CREATE PROCEDURE [dbo].[DeleteSuperAdmin]
	-- Add the parameters for the stored procedure here
	@SuperAdminID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM isp_SuperAdminGroups WHERE SuperAdminID = @SuperAdminID
	DELETE FROM isp_SuperAdmins WHERE SuperAdminID = @SuperAdminID
	END
GO
