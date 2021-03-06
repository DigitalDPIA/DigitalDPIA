USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 05/04/2019
-- Description:	Returns a Projects HealthPurpose selections with a specific ID.

-- =============================================
CREATE PROCEDURE [dbo].[Project_GetDPIAHealthPurposeByID]
	@ProjectID as int
AS
BEGIN
SET NOCOUNT ON;

	SELECT
		DPIAHealthPurposeID, 
		ProjectID,
		InformationSharedID
	FROM	dpia_HealthPurpose             
	WHERE	(ProjectID = @ProjectID)

END
GO
