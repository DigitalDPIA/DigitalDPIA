USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 17/04/2019
-- Description:	Returns a Projects Screening questions with a specific ID. (Version 2 of the screening questions)
-- =============================================
CREATE PROCEDURE [dbo].[Project_GetScreeningV2ByID]
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
			PROJECTS.PSQV201a,
			PROJECTS.PSQV201b,
			PROJECTS.PSQV201c,
			PROJECTS.PSQV201d,
			PROJECTS.PSQV201e,
			PROJECTS.PSQV201f,
			PROJECTS.PSQV201g,
			PROJECTS.PSQV202a,
			PROJECTS.PSQV202b,
			PROJECTS.PSQV202c,
			PROJECTS.PSQV202d,
			PROJECTS.PSQV202e,
			PROJECTS.PSQV202f,
			PROJECTS.PSQV203a,
			PROJECTS.PSQV203b ,
			PROJECTS.PSQV203c,
			PROJECTS.PSQV203d ,
			PROJECTS.PSQV203e,
			PROJECTS.PSQV203f,
			PROJECTS.PSQV203g,
			PROJECTS.PSQV203h,
			PROJECTS.PSQV204a,
			PROJECTS.PSQV204b,
			PROJECTS.PSQV204c,
			PROJECTS.PSQV204d,
			PROJECTS.PSQV204e,
			PROJECTS.PSQV204f,
			PROJECTS.PSQV204g,
			PROJECTS.PSQV204h
	FROM	aspnet_Users AS USERS8 INNER JOIN
			isp_OrganisationUsers AS ORGUSERS8 ON USERS8.UserName = ORGUSERS8.OrganisationUserEmail RIGHT OUTER JOIN
			dpia_Projects AS PROJECTS INNER JOIN
            dpia_PStatus AS PSTATUS ON PROJECTS.PStatusID = PSTATUS.PStatusID ON USERS8.UserId = PROJECTS.PArchivedByID LEFT OUTER JOIN
	        aspnet_Users AS USERS2 INNER JOIN
            isp_OrganisationUsers AS ORGUSERS2 ON USERS2.UserName = ORGUSERS2.OrganisationUserEmail ON PROJECTS.PAssignedIGLeadID = USERS2.UserId      
	WHERE	(PROJECTS.ProjectID = @ProjectID)
END
GO
