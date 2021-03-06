USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 06/03/2019
-- Description:	Returns a Project with a specific ID.
-- =============================================
CREATE PROCEDURE [dbo].[Project_GetByID]
	@ProjectID as int
AS
BEGIN
SET NOCOUNT ON;
SELECT DISTINCT 
                         PROJECTS.ProjectID AS ID, PROJECTS.PName AS Name, PROJECTS.PDescription AS Description, PSTATUS.PStatusText AS Status, PROJECTS.PStatusDate AS [Status Date], PROJECTS.POrganisationID AS [Organisation ID], 
                         PROJECTS.PAssignedToID AS [Assigned To ID], ORGUSERS1.OrganisationUserName AS [Assigned Name], ORGUSERS1.OrganisationUserEmail AS [Assigned Email], PROJECTS.PAssignedToDate AS [Assigned Date], 
                         PROJECTS.PAssignedIGLeadID AS [IG Lead ID], ORGUSERS2.OrganisationUserName AS [IG Lead Name], ORGUSERS2.OrganisationUserEmail AS [IG Lead Email], PROJECTS.PAssignedIGLeadDate AS [IG Lead Date], 
                         PROJECTS.PAssignedIGLeadSignOffDate AS [IG Lead Sign Off Date], PROJECTS.PAssignedInfAssetOwnerID AS [Asset Owner ID], ORGUSERS3.OrganisationUserName AS [Asset Owner Name], 
                         ORGUSERS3.OrganisationUserEmail AS [Asset Owner Email], PROJECTS.PAssignedInfAssetOwnerDate AS [Asset Owner Date], PROJECTS.PAssignedInfAssetOwnerSignOffDate AS [Asset Owner Sign Off Date], 
                         PROJECTS.PAssignedDPOID AS [DPO ID], ORGUSERS4.OrganisationUserName AS [DPO Name], ORGUSERS4.OrganisationUserEmail AS [DPO Email], PROJECTS.PAssignedDPODate AS [DPO Date], 
                         PROJECTS.PAssignedDPOSignOffDate AS [DPO Sign Off Date], PROJECTS.PAssignedICOID AS [ICO ID], ORGUSERS5.OrganisationUserName AS [ICO Name], ORGUSERS5.OrganisationUserEmail AS [ICO Email], 
                         PROJECTS.PAssignedICODate AS [ICO Date], PROJECTS.PAssignedICOSignOffDate AS [ICO Sign Off Date], PROJECTS.PCreatedByID AS [Created ID], ORGUSERS6.OrganisationUserName AS [Created Name], 
                         ORGUSERS6.OrganisationUserEmail AS [Created Email], PROJECTS.PCreatedDate AS [Created Date], PROJECTS.PLastModifiedID AS [Modified ID], ORGUSERS7.OrganisationUserName AS [Modified Name], 
                         ORGUSERS7.OrganisationUserEmail AS [Modified Email], PROJECTS.PLastModifiedDate AS [Modified Date], PROJECTS.PArchivedByID AS [Archived ID], ORGUSERS8.OrganisationUserName AS [Archived Name], 
                         ORGUSERS8.OrganisationUserEmail AS [Archived Email], PROJECTS.PArchivedDate AS [Archived Date]
FROM            aspnet_Users AS USERS8 INNER JOIN
                         isp_OrganisationUsers AS ORGUSERS8 ON USERS8.UserName = ORGUSERS8.OrganisationUserEmail RIGHT OUTER JOIN
                         dpia_Projects AS PROJECTS INNER JOIN
                         dpia_PStatus AS PSTATUS ON PROJECTS.PStatusID = PSTATUS.PStatusID ON USERS8.UserId = PROJECTS.PArchivedByID LEFT OUTER JOIN
                         aspnet_Users AS USERS7 INNER JOIN
                         isp_OrganisationUsers AS ORGUSERS7 ON USERS7.UserName = ORGUSERS7.OrganisationUserEmail ON PROJECTS.PLastModifiedID = USERS7.UserId LEFT OUTER JOIN
                         isp_OrganisationUsers AS ORGUSERS6 INNER JOIN
                         aspnet_Users AS USERS6 ON ORGUSERS6.OrganisationUserEmail = USERS6.UserName ON PROJECTS.PCreatedByID = USERS6.UserId LEFT OUTER JOIN
                         aspnet_Users AS USERS5 INNER JOIN
                         isp_OrganisationUsers AS ORGUSERS5 ON USERS5.UserName = ORGUSERS5.OrganisationUserEmail ON PROJECTS.PAssignedICOID = USERS5.UserId LEFT OUTER JOIN
                         aspnet_Users AS USERS4 INNER JOIN
                         isp_OrganisationUsers AS ORGUSERS4 ON USERS4.UserName = ORGUSERS4.OrganisationUserEmail ON PROJECTS.PAssignedDPOID = USERS4.UserId LEFT OUTER JOIN
                         aspnet_Users AS USERS2 INNER JOIN
                         isp_OrganisationUsers AS ORGUSERS2 ON USERS2.UserName = ORGUSERS2.OrganisationUserEmail ON PROJECTS.PAssignedIGLeadID = USERS2.UserId LEFT OUTER JOIN
                         isp_OrganisationUsers AS ORGUSERS1 INNER JOIN
                         aspnet_Users AS USERS1 ON ORGUSERS1.OrganisationUserEmail = USERS1.UserName ON PROJECTS.PAssignedToID = USERS1.UserId LEFT OUTER JOIN
                         isp_OrganisationUsers AS ORGUSERS3 INNER JOIN
                         aspnet_Users AS USERS3 ON ORGUSERS3.OrganisationUserEmail = USERS3.UserName ON PROJECTS.PAssignedInfAssetOwnerID = USERS3.UserId
WHERE (PROJECTS.ProjectID = @ProjectID)
END
GO
