USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 15/01/2018
-- Description:	Returns list of flows that involve two organisations
-- =============================================
CREATE FUNCTION [dbo].[GetSharedFlowsNew]
(	
	-- Add the parameters for the function here

	@OrganisationID int,
	@SharingOrganisationID int,
	@ExcludeArchived bit
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT       dfdo.DataFlowDetailID
FROM            isp_DFD_DFDOrganisations AS dfdo INNER JOIN
                         isp_DataFlowDetail AS dfd ON dfdo.DataFlowDetailID = dfd.DataFlowDetailID
WHERE        (dfd.ArchiveDate IS NULL OR @ExcludeArchived =0) AND (dfdo.OrganisationID =  @OrganisationID)
INTERSECT
	SELECT       dfdo.DataFlowDetailID
FROM            isp_DFD_DFDOrganisations AS dfdo INNER JOIN
                         isp_DataFlowDetail AS dfd ON dfdo.DataFlowDetailID = dfd.DataFlowDetailID
WHERE        (dfd.ArchiveDate IS NULL OR @ExcludeArchived =0) AND (dfdo.OrganisationID = @SharingOrganisationID )
)

GO
