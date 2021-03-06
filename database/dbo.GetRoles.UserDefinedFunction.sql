USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 16/03/2015
-- Description:	Returns active roles for user
-- =============================================
CREATE FUNCTION [dbo].[GetRoles]
(	
	-- Add the parameters for the function here
	@Email nvarchar(255),
	@OrganisationID int
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT        Role, RoleID, CASE WHEN
                             (SELECT        COUNT(OrganisationUserID)
                               FROM            isp_OrganisationUsers
                               WHERE        (OrganisationUserEmail = @Email) AND (OrganisationID = @OrganisationID) AND (Active = 1) AND (RoleID = isp_Roles.RoleID)) 
                         > 0 THEN 1 ELSE 0 END AS IsSelected
FROM            isp_Roles
)

GO
