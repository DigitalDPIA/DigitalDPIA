USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 30/04/2018
-- Description:	Inactivates organisation adding _INACTIVE to name and ICO number fields and updates the organisations involved count for flows the organisation is involved in.
-- =============================================
CREATE PROCEDURE [dbo].[Organisation_Inactivate]
	-- Add the parameters for the stored procedure here
	@OrganisationID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Inactivate the organisation and append _INACTIVE to name and ICO:

	UPDATE       isp_Organisations
SET                InactivatedDate = GETDATE(), OrganisationName = OrganisationName + '_INACTIVE', ICORegistrationNumber = ICORegistrationNumber + '_INACTIVE', AssuranceScore = -11
WHERE        (OrganisationID = @OrganisationID)

--Update the orgs involved count for dataflows involving this organisation:
if exists (SELECT DataFlowDetailID FROM isp_DFD_DFDOrganisations WHERE OrganisationID = @OrganisationID)
Begin
UPDATE       isp_DataFlowDetail
SET                OrgsInvolved =
                             (SELECT        COUNT(OrganisationID) AS Expr1
                               FROM            isp_DFD_DFDOrganisations AS dfdo
                               WHERE        (DataFlowDetailID = isp_DataFlowDetail.DataFlowDetailID) AND
                                                             ((SELECT        InactivatedDate
                                                                 FROM            isp_Organisations
                                                                 WHERE        (OrganisationID = dfdo.OrganisationID)) IS NULL))
WHERE        (DataFlowDetailID IN (SELECT DataFlowDetailID FROM isp_DFD_DFDOrganisations WHERE OrganisationID = @OrganisationID))
End
END
GO
