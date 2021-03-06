USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Michael Georgiades
-- Create date: 26/Nov/2018
-- Description:	Returns the list of organisations.
-- =============================================
CREATE PROCEDURE [dbo].[Organisations_GetData]
	-- Add the parameters for the stored procedure here
	@OnlyActive bit
AS
BEGIN
	SET NOCOUNT ON;

SELECT	OrganisationID AS ID, 
		OrganisationName, 
		Identifiers AS 'Identifiers_ODS', 
		ICORegistrationNumber AS ICONumber, 
		Aliases, 
		OrganisationAddress, 
		OrgContactPhone, 
		OrgContactEmail, 
		OrgContactName, 
        ISPFirstRegisteredDate AS ISGRegistered, 
		InactivatedDate, 
		Longitude, 
		Latitude, 
		County, 
		AdminGroupID,
        (SELECT        GroupName
         FROM            isp_AdminGroups
         WHERE        (AdminGroupID = o.AdminGroupID)) AS AdmingGroup, 
		OrganisationCategoryID,
        (SELECT        OrganisationCategory
         FROM            isp_OrganisationCategories
         WHERE        (OrganisationCategoryID = o.OrganisationCategoryID)) AS OrganisationCategory, 
		 OrganisationCategoryOther, 
		 CASE WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) IS NULL 
			THEN 'Not submitted' WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) = - 10 THEN 'Expired' WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) 
            = 0 THEN 'Significant' WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) = 1 THEN 'Limited' ELSE 'None' END AS Assurance,
		 (SELECT TOP (1) SignedDate
          FROM		isp_TierZeroSignatures
          WHERE     (OrganisationID = o.OrganisationID) AND (RemovedDate IS NULL)
          ORDER BY SignedDate DESC) AS MOUSigned
FROM isp_Organisations AS o
WHERE (@OnlyActive = 0) OR (InactivatedDate IS NULL)

END


GO
