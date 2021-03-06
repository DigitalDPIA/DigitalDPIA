USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Michael Georgiades
-- Create date: 01/03/2019
-- Description:	Returns a list of Information Asset Owners within an organisation.
-- =============================================
CREATE PROCEDURE [dbo].[Users_GetOrgIARoles]
	@OrganisationID Int
AS
BEGIN

SET NOCOUNT ON;

SELECT	DISTINCT 
		USERS.UserId, 
		ORGUSERS.OrganisationUserName
FROM    aspnet_Users AS USERS RIGHT OUTER JOIN isp_OrganisationUsers AS ORGUSERS ON USERS.UserName = ORGUSERS.OrganisationUserEmail
WHERE        (ORGUSERS.OrganisationID = @OrganisationID ) AND (ORGUSERS.RoleID = 7) AND (NOT (USERS.UserId IS NULL)) AND (ORGUSERS.Active = 1 )

END
GO
