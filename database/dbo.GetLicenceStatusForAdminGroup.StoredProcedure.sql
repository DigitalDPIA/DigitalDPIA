USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 21/08/2017
-- Description:	Returns total licences, licences used and licences remaining for Admin Group.
-- =============================================
CREATE PROCEDURE [dbo].[GetLicenceStatusForAdminGroup]
	-- Add the parameters for the stored procedure here
	@AdminGroupID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_Total int
	DECLARE @_Used int
	DECLARE @_Active bit
    -- Insert statements for procedure here
	SELECT @_Active = CASE WHEN Active = 1 and ContractEndDate >= getDate() Then 1 ELSE 0 END, @_Total = OrganisationLicences FROM isp_AdminGroups WHERE AdminGroupID = @AdminGroupID
	SELECT @_Used = COUNT(OrganisationID) FROM isp_Organisations WHERE InactivatedDate IS NULL AND LicenceGranted = 1 AND AdminGroupID = @AdminGroupID AND SingleOrgLicence = 0
	SELECT @_Total as LicTotal, @_Used AS LicUsed, @_Total-@_Used AS LicRemaining, COALESCE(@_Active, 0) as Active
END
GO
