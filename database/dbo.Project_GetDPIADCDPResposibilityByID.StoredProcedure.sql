USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 05/04/2019
-- Description:	Returns a Projects DCDPResposibility selections with a specific ID.

-- =============================================
CREATE PROCEDURE [dbo].[Project_GetDPIADCDPResposibilityByID]
	@ProjectID as int
AS
BEGIN
SET NOCOUNT ON;

	SELECT
		DPIADCDPResposibilityID, 
		ProjectID,
		InformationSharedID
	FROM	dpia_DCDPResposibility            
	WHERE	(ProjectID = @ProjectID)

END
GO
