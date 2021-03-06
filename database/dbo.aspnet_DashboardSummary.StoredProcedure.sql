USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Michael Georgiades
-- Create date: 09/November/2018
-- Description:	Obtains Summary from Dashboard. 
-- This SQL has been moved from the application into a sp in order to address issue #1099. 
-- The AdminGroupID's DataFlows subquery used within the nested SQL was not working (not sure why) and this was highlighted in the execution plan. 
-- By querying the AdminGroupID's at the outset of the sp into a temp table and placing the temp table query within the nested sql the DataFlows column is now calculated correctly.
-- =============================================
CREATE PROCEDURE [dbo].[aspnet_DashboardSummary]
    @SuperAdminID int, @IsCentralSA As Bit
AS
BEGIN

CREATE TABLE #TempTable
(
   [AdminGroupID] [int] NOT NULL,
)
       INSERT INTO #TempTable 
	   SELECT        AdminGroupID
					 FROM            isp_SuperAdminGroups
					 WHERE        (SuperAdminID = @SuperAdminID)	

	   SELECT        (SELECT        COUNT(OrganisationID) AS Expr1
                          FROM            isp_Organisations
                          WHERE        (InactivatedDate IS NULL) AND (AdminGroupID IN
                                                        (SELECT        AdminGroupID
                                                          FROM            isp_SuperAdminGroups
                                                          WHERE        (SuperAdminID = @SuperAdminID))) OR
                                                    (InactivatedDate IS NULL) AND (CAST(@IsCentralSA AS Bit) = 1)) AS TotalOrgs,
                             (SELECT        COUNT(OrganisationID) AS Expr1
                               FROM            isp_Organisations AS o2
                               WHERE        (InactivatedDate IS NULL) AND (OrganisationTypeID = 1) AND (AdminGroupID IN
                                                             (SELECT        AdminGroupID
                                                               FROM            isp_SuperAdminGroups AS isp_SuperAdminGroups_4
                                                               WHERE        (SuperAdminID = @SuperAdminID))) OR
                                                         (InactivatedDate IS NULL) AND (OrganisationTypeID = 1) AND (CAST(@IsCentralSA AS Bit) = 1)) AS LeadOrgs,
                             (SELECT        COUNT(OrganisationID) AS Expr1
                               FROM            isp_Organisations AS o1
                               WHERE        (InactivatedDate IS NULL) AND (OrganisationTypeID = 2) AND (AdminGroupID IN
                                                             (SELECT        AdminGroupID
                                                               FROM            isp_SuperAdminGroups AS isp_SuperAdminGroups_3
                                                               WHERE        (SuperAdminID = @SuperAdminID))) OR
                                                         (InactivatedDate IS NULL) AND (OrganisationTypeID = 2) AND (CAST(@IsCentralSA AS Bit) = 1)) AS SponsoredOrgs,
                             (SELECT        COUNT(DISTINCT ou.OrganisationUserEmail) AS Users
                               FROM            isp_OrganisationUsers AS ou INNER JOIN
                                                         isp_Organisations AS o4 ON ou.OrganisationID = o4.OrganisationID
                               WHERE        (ou.Active = 1) AND (o4.InactivatedDate IS NULL) AND (o4.AdminGroupID IN
                                                             (SELECT        AdminGroupID
                                                               FROM            isp_SuperAdminGroups AS isp_SuperAdminGroups_2
                                                               WHERE        (SuperAdminID = @SuperAdminID))) OR
                                                         (ou.Active = 1) AND (o4.InactivatedDate IS NULL) AND (CAST(@IsCentralSA AS Bit) = 1)) AS ActiveUsers,
                             (SELECT        COUNT(DataFlowDetailID) AS DataFlows
                               FROM            isp_DataFlowDetail
                               WHERE        (DataSummaryID IN
                                                             (SELECT        og.DataFlowID AS DataSharingSummaries
                                                               FROM            isp_DF_OrganisationGroups AS og INNER JOIN
                                                                                         isp_DF_Organisations AS o ON og.DF_OrgGroupID = o.DF_OrgGroupID INNER JOIN
                                                                                         isp_DataFlowSummaries AS dfs ON og.DataFlowID = dfs.DataFlowID INNER JOIN
                                                                                         isp_Organisations AS o3 ON o.OrganisationID = o3.OrganisationID
                                                               WHERE        (og.DataFlowID > 0) AND (dfs.DFArchivedDate IS NULL) AND (o3.AdminGroupID IN
                                                                                             (Select AdminGroupID from #TempTable)) AND (isp_DataFlowDetail.ArchiveDate IS NULL) OR
                                                                                         (og.DataFlowID > 0) AND (dfs.DFArchivedDate IS NULL) AND (isp_DataFlowDetail.ArchiveDate IS NULL) AND (CAST(@IsCentralSA AS Bit) = 1)))) AS DataFlows


END
GO
