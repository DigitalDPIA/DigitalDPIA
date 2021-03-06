USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 21/09/2015
-- Description:	Generates a CSV list of e-mail addresses for senior users and delegates at a given organisation.
-- =============================================
CREATE FUNCTION [dbo].[AdminsAtOrgCSV]
(
	-- Add the parameters for the function here
	@OrganisationID int
)
RETURNS varchar(8000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar varchar(8000)

	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultVar = COALESCE(STUFF((SELECT ', ' + Q1.Email 
FROM            (SELECT DISTINCT Email
FROM            (SELECT        OrganisationUserEmail AS Email
                          FROM            isp_OrganisationUsers AS Orgs
                          WHERE        (OrganisationID = @OrganisationID) AND (RoleID = 5) AND (Active = 1)
                          ) AS Q2) AS Q1
FOR XML PATH('')),1, 2, ''), '')

	-- Return the result of the function
	RETURN @ResultVar

END
GO
