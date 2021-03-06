USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Michael Georgiades
-- Create date: 26/Nov/2018
-- Description:	Returns the organisation details for a particular OrganisationID  
-- =============================================
CREATE PROCEDURE [dbo].[Organisations_GetByOrgID]
		@OrganisationID int
AS
BEGIN
	SET NOCOUNT ON;
SELECT	AdminGroupID, 
		(SELECT GroupName FROM isp_AdminGroups WHERE (AdminGroupID = o.AdminGroupID)) AS AdmingGroup, 
		Aliases, 
		CASE WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) IS NULL THEN 'Not submitted' WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) = - 10 THEN 'Expired' WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) = 0 THEN 'Significant' WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) = 1 THEN 'Limited' ELSE 'None' END AS Assurance,
		County, 
		ICORegistrationNumber AS ICONumber, 
		ISPFirstRegisteredDate AS ISGRegistered, 
		Identifiers AS Identifiers_ODS, 
		InactivatedDate, 
		Latitude, 
		Longitude, 
		OrgContactEmail, 
		OrgContactName, 
		OrgContactPhone, 
		OrganisationAddress, 
		(SELECT OrganisationCategory FROM isp_OrganisationCategories WHERE (OrganisationCategoryID = o.OrganisationCategoryID)) AS OrganisationCategory, 
		OrganisationCategoryID, 
		OrganisationCategoryOther, 
		OrganisationID AS ID, 
		OrganisationName,  
		(SELECT TOP       (1) SignedDate
                FROM      isp_TierZeroSignatures
                WHERE     (OrganisationID = o.OrganisationID) AND (RemovedDate IS NULL)
                ORDER BY  SignedDate DESC) AS MOUSigned
FROM isp_Organisations AS o 
WHERE (OrganisationID = @OrganisationID)
END


GO
