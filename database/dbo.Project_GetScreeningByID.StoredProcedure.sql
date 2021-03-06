USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 13/03/2019
-- Description:	Returns a Projects Screening questions with a specific ID.
-- Modified Date: 27/03/2019 Addition of IG Lead details
-- =============================================
CREATE PROCEDURE [dbo].[Project_GetScreeningByID]
	@ProjectID as int
AS
BEGIN
SET NOCOUNT ON;
	SELECT	DISTINCT
			PROJECTS.ProjectID AS ID,
			PROJECTS.PStatusID AS StatusID,
			PROJECTS.PAssignedIGLeadID AS [IG Lead ID],
			ORGUSERS2.OrganisationUserName AS [IG Lead Name], 
			ORGUSERS2.OrganisationUserEmail AS [IG Lead Email], 
			PROJECTS.PAssignedIGLeadDate AS [IG Lead Date], 
			PROJECTS.PSQ01,
			PROJECTS.PSQ02,
			PROJECTS.PSQ03,
			PROJECTS.PSQ04,
			PROJECTS.PSQ05,
			PROJECTS.PSQ06,
			PROJECTS.PSQ07,
			PROJECTS.PSQ08,
			PROJECTS.PSQ09,
			PROJECTS.PSQ10,
			PROJECTS.PSQ11,
			PROJECTS.PSQ12,
			PROJECTS.PSQ13,
			PROJECTS.PSQ14,
			PROJECTS.PSQ15,
			PROJECTS.PSQ16,
			PROJECTS.PSQ17,
			PROJECTS.PSQ18
	FROM	aspnet_Users AS USERS8 INNER JOIN
			isp_OrganisationUsers AS ORGUSERS8 ON USERS8.UserName = ORGUSERS8.OrganisationUserEmail RIGHT OUTER JOIN
			dpia_Projects AS PROJECTS INNER JOIN
            dpia_PStatus AS PSTATUS ON PROJECTS.PStatusID = PSTATUS.PStatusID ON USERS8.UserId = PROJECTS.PArchivedByID LEFT OUTER JOIN
	        aspnet_Users AS USERS2 INNER JOIN
            isp_OrganisationUsers AS ORGUSERS2 ON USERS2.UserName = ORGUSERS2.OrganisationUserEmail ON PROJECTS.PAssignedIGLeadID = USERS2.UserId      
	WHERE	(PROJECTS.ProjectID = @ProjectID)
END
GO
