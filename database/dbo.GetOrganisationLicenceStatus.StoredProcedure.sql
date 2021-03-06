USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 18/07/2017
-- Description:	Return most relevant licence information for an organisation
-- =============================================
CREATE PROCEDURE [dbo].[GetOrganisationLicenceStatus]
	-- Add the parameters for the stored procedure here
	@OrganisationID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @_EndDate as DateTime
	Declare @_LicenceType as nvarchar(255)
	SET @_LicenceType = 'Free, limited licence'
	if exists (SELECT OrganisationID FROM isp_Organisations WHERE OrganisationID = @OrganisationID AND SingleOrgLicence = 1 and SingleOrgLicenceEnd >= getDate())
	Begin
	SET @_LicenceType = 'Single organisation licence'
	SELECT @_EndDate = SingleOrgLicenceEnd FROM isp_Organisations WHERE OrganisationID = @OrganisationID AND SingleOrgLicence = 1 and SingleOrgLicenceEnd >= getDate()
	GOTO OnExit
	End 
	if exists (SELECT OrganisationID FROM isp_Organisations AS o WHERE OrganisationID = @OrganisationID AND LicenceGranted = 1 AND (SELECT Active FROM isp_AdminGroups WHERE AdminGroupID = o.AdminGroupID) = 1 and COALESCE((SELECT ContractEndDate FROM isp_AdminGroups WHERE AdminGroupID = o.AdminGroupID), DATEADD(year,1,getDate())) >= getDate())
	Begin
	SET @_LicenceType = 'Group franchise licence'
	SELECT @_EndDate = ContractEndDate FROM isp_AdminGroups WHERE AdminGroupID = (SELECT AdminGroupID FROM isp_Organisations WHERE OrganisationID = @OrganisationID)

	End
	OnExit:
	SELECT OrganisationID, @_LicenceType AS LicenceType, @_EndDate AS EndDate, COALESCE(COALESCE(COALESCE((SELECT SuperAdminEmail FROM isp_SuperAdmins WHERE SuperAdminID = o.SuperAdminID AND ACTIVE = 1), (SELECT EmailAddress FROM isp_AdminGroups WHERE AdminGroupID = o.AdminGroupID)),(SELECT EmailAddress FROM isp_AdminGroups WHERE AdminGroupID = 1 AND o.SingleOrgLicenceEnd >= getDate())), 'None') AS SuperAdmin	FROM isp_Organisations as o	WHERE OrganisationID = @OrganisationID
END
GO
