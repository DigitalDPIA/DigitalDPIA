USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 19/01/2019
-- Description:	Returns a list of Projects filtered by optional parameters.
-- Modified date: 02/05/2019 - SQL Restructured to provide performance improvements
-- =============================================
CREATE PROCEDURE [dbo].[Projects_GetFiltered]
	@OrganisationID as int,
	@UserId as uniqueidentifier,
	@IncludeArchived as bit
AS
BEGIN
SET NOCOUNT ON;
SELECT PROJECTS.ProjectID AS ID
	,PROJECTS.PName AS Name
	,PROJECTS.PDescription AS Description
	,PSTATUS.PStatusText AS STATUS
	,PROJECTS.PStatusDate AS [Status Date]
	,PROJECTS.POrganisationID AS [Organisation ID]

	,PROJECTS.PAssignedToID AS [Assigned To ID]
	,ou1.OrganisationUserName AS [Assigned Name]
	,ou1.OrganisationUserEmail AS [Assigned Email]
	,PROJECTS.PAssignedToDate AS [Assigned Date]

	,PROJECTS.PAssignedIGLeadID AS [IG Lead ID]
	,ou2.OrganisationUserName AS [IG Lead Name]
	,ou2.OrganisationUserEmail AS [IG Lead Email]
	,PROJECTS.PAssignedIGLeadDate AS [IG Lead Date]

	,PROJECTS.PAssignedIGLeadSignOffDate AS [IG Lead Sign Off Date]
	,PROJECTS.PAssignedInfAssetOwnerID AS [Asset Owner ID]
	,ou3.OrganisationUserName AS [Asset Owner Name]
	,ou3.OrganisationUserEmail AS [Asset Owner Email]

	,PROJECTS.PAssignedInfAssetOwnerDate AS [Asset Owner Date]
	,PROJECTS.PAssignedInfAssetOwnerSignOffDate AS [Asset Owner Sign Off Date]
	,PROJECTS.PAssignedDPOID AS [DPO ID]
	,ou4.OrganisationUserName AS [DPO Name]

	,ou4.OrganisationUserEmail AS [DPO Email]
	,PROJECTS.PAssignedDPODate AS [DPO Date]
	,PROJECTS.PAssignedDPOSignOffDate AS [DPO Sign Off Date]
	,PROJECTS.PAssignedICOID AS [ICO ID]

	,ou5.OrganisationUserName AS [ICO Name]
	,ou5.OrganisationUserEmail AS [ICO Email]
	,PROJECTS.PAssignedICODate AS [ICO Date]
	,PROJECTS.PAssignedICOSignOffDate AS [ICO Sign Off Date]

	,PROJECTS.PCreatedByID AS [Created ID]
	,ou6.OrganisationUserName AS [Created Name]
	,ou6.OrganisationUserEmail AS [Created Email]
	,PROJECTS.PCreatedDate AS [Created Date]

	,PROJECTS.PLastModifiedID AS [Modified ID]
	,ou7.OrganisationUserName AS [Modified Name]
	,ou7.OrganisationUserEmail AS [Modified Email]
	,PROJECTS.PLastModifiedDate AS [Modified Date]

	,PROJECTS.PArchivedByID AS [Archived ID]
	,ou8.OrganisationUserName AS [Archived Name]
	,ou8.OrganisationUserEmail AS [Archived Email]
	,PROJECTS.PArchivedDate AS [Archived Date]
FROM dpia_Projects AS PROJECTS
INNER JOIN dpia_PStatus AS PSTATUS ON PROJECTS.PStatusID = PSTATUS.PStatusID
OUTER APPLY (
	SELECT TOP 1 OrganisationUserName
		,OrganisationUserEmail
	FROM aspnet_Users
	JOIN isp_OrganisationUsers ON aspnet_Users.UserName = isp_OrganisationUsers.OrganisationUserEmail
	WHERE aspnet_Users.UserId = PROJECTS.PAssignedToID
	) ou1
OUTER APPLY (
	SELECT TOP 1 OrganisationUserName
		,OrganisationUserEmail
	FROM aspnet_Users
	JOIN isp_OrganisationUsers ON aspnet_Users.UserName = isp_OrganisationUsers.OrganisationUserEmail
	WHERE aspnet_Users.UserId = PROJECTS.PAssignedIGLeadID
	) ou2
OUTER APPLY (
	SELECT TOP 1 OrganisationUserName
		,OrganisationUserEmail
	FROM aspnet_Users
	JOIN isp_OrganisationUsers ON aspnet_Users.UserName = isp_OrganisationUsers.OrganisationUserEmail
	WHERE aspnet_Users.UserId = PROJECTS.PAssignedInfAssetOwnerID
	) ou3
OUTER APPLY (
	SELECT TOP 1 OrganisationUserName
		,OrganisationUserEmail
	FROM aspnet_Users
	JOIN isp_OrganisationUsers ON aspnet_Users.UserName = isp_OrganisationUsers.OrganisationUserEmail
	WHERE aspnet_Users.UserId = PROJECTS.PAssignedDPOID
	) ou4
OUTER APPLY (
	SELECT TOP 1 OrganisationUserName
		,OrganisationUserEmail
	FROM aspnet_Users
	JOIN isp_OrganisationUsers ON aspnet_Users.UserName = isp_OrganisationUsers.OrganisationUserEmail
	WHERE aspnet_Users.UserId = PROJECTS.PAssignedICOID
	) ou5
OUTER APPLY (
	SELECT TOP 1 OrganisationUserName
		,OrganisationUserEmail
	FROM aspnet_Users
	JOIN isp_OrganisationUsers ON aspnet_Users.UserName = isp_OrganisationUsers.OrganisationUserEmail
	WHERE aspnet_Users.UserId = PROJECTS.PCreatedByID
	) ou6
OUTER APPLY (
	SELECT TOP 1 OrganisationUserName
		,OrganisationUserEmail
	FROM aspnet_Users
	JOIN isp_OrganisationUsers ON aspnet_Users.UserName = isp_OrganisationUsers.OrganisationUserEmail
	WHERE aspnet_Users.UserId = PROJECTS.PLastModifiedID
	) ou7
OUTER APPLY (
	SELECT TOP 1 OrganisationUserName
		,OrganisationUserEmail
	FROM aspnet_Users
	JOIN isp_OrganisationUsers ON aspnet_Users.UserName = isp_OrganisationUsers.OrganisationUserEmail
	WHERE aspnet_Users.UserId = PROJECTS.PArchivedByID
	) ou8
WHERE (PROJECTS.POrganisationID = @OrganisationID)
	AND (
		PROJECTS.PAssignedToID = @UserId
		OR PROJECTS.PAssignedIGLeadID = @UserId
		OR PROJECTS.PAssignedInfAssetOwnerID = @UserId
		OR PROJECTS.PAssignedDPOID = @UserId
		OR PROJECTS.PAssignedICOID = @UserId
		OR PROJECTS.PCreatedByID = @UserId
		OR PROJECTS.PLastModifiedID = @UserId
		OR PROJECTS.PArchivedByID = @UserId
		)
	AND (
		PROJECTS.PArchivedDate IS NULL
		OR @IncludeArchived = 1
		)
END
GO
