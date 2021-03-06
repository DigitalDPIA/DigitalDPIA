USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 05/04/2019
-- Description:	Returns a Projects Screening questions with a specific ID.

-- =============================================
CREATE PROCEDURE [dbo].[Project_GetDPIAByID]
	@ProjectID as int
AS
BEGIN
SET NOCOUNT ON;
	SELECT	DISTINCT
			PROJECTS.ProjectID AS ID,
			PROJECTS.PStatusID AS StatusID,
			PROJECTS.DPIALegalQ01,
			PROJECTS.DPIALegalQ01a,
			PROJECTS.DPIALegalQ01aa,
			PROJECTS.DPIALegalQ01ab,
			PROJECTS.DPIALegalQ01ac,
			PROJECTS.DPIALegalQ01ad,
			PROJECTS.DPIALegalQ01ae,
			PROJECTS.DPIALegalQ01af,
			PROJECTS.DPIALegalQ01acleg,
			PROJECTS.DPIALegalQ01aeleg,
			PROJECTS.DPIALegalQ01aa2,
			PROJECTS.DPIALegalQ01aa3,
			PROJECTS.DPIALegalQ02,
			PROJECTS.DPIALegalQ02aa,
			PROJECTS.DPIALegalQ02ab,
			PROJECTS.DPIALegalQ02ac,
			PROJECTS.DPIALegalQ02ad,
			PROJECTS.DPIALegalQ02ae,
			PROJECTS.DPIALegalQ02af,
			PROJECTS.DPIALegalQ02ag,
			PROJECTS.DPIALegalQ02ah,
			PROJECTS.DPIALegalQ02ai,
			PROJECTS.DPIALegalQ02aga,
			PROJECTS.DPIALegalQ02agb,
			PROJECTS.DPIALegalQ02agc,
			PROJECTS.DPIALegalQ02agd,
			PROJECTS.DPIALegalQ02age,
			PROJECTS.DPIALegalQ02agf,
			PROJECTS.DPIALegalQ02agg,
			PROJECTS.DPIALegalQ02agh,
			PROJECTS.DPIALegalQ02agi,
			PROJECTS.DPIALegalQ02agj,
			PROJECTS.DPIALegalQ02agk,
			PROJECTS.DPIALegalQ02agl,
			PROJECTS.DPIALegalQ02agm,
			PROJECTS.DPIALegalQ02agn,
			PROJECTS.DPIALegalQ02ago,
			PROJECTS.DPIALegalQ02agp,
			PROJECTS.DPIALegalQ02agq,
			PROJECTS.DPIALegalQ02agr,
			PROJECTS.DPIALegalQ02ags,
			PROJECTS.DPIALegalQ02agt,
			PROJECTS.DPIALegalQ02agu,
			PROJECTS.DPIALegalQ02agv,
			PROJECTS.DPIALegalQ02agw,
			PROJECTS.DPIALegalQ03,
			PROJECTS.DPIALegalQ04,
			PROJECTS.DPIALegalQ04b
	FROM	dpia_Projects AS PROJECTS                 
	WHERE	(PROJECTS.ProjectID = @ProjectID)
END
GO
