USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Organisations_Select]
AS
	SET NOCOUNT ON;
SELECT        OrganisationID, OrganisationName, OrganisationTypeID, SponsorOrganisationID, OrganisationAddress, ISPFirstRegisteredBy, ISPFirstRegisteredDate, 
                         
                         InactivatedDate, Longitude, Latitude, OrgContactPhone, OrgContactEmail, OrgContactName
FROM            isp_Organisations
ORDER BY OrganisationName
GO
