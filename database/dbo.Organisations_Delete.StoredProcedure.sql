USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Organisations_Delete]
(
	@Original_OrganisationID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [isp_Organisations] WHERE (([OrganisationID] = @Original_OrganisationID))
GO
