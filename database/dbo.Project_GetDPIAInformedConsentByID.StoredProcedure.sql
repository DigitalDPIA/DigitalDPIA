USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 05/04/2019
-- Description:	Returns a Projects InformedConsent selections with a specific ID.

-- =============================================
CREATE PROCEDURE [dbo].[Project_GetDPIAInformedConsentByID]
	@ProjectID as int
AS
BEGIN
SET NOCOUNT ON;

	SELECT
		DPIAInformedConsentID, 
		ProjectID,
		InformationSharedID
	FROM	dpia_InformConsent               
	WHERE	(ProjectID = @ProjectID)

END
GO
