USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 16/06/2016
-- Description:	Returns a table of organisations based on a range of filter parameters by constructing dynamic SQL query.
-- =============================================
CREATE PROCEDURE [dbo].[GetFilteredOrganisationsForExport]
	-- Add the parameters for the stored procedure here
	@Closed Bit,
	@County nvarchar(100),
	@AdminGroupID int,
	@Search nvarchar(255),
	@ShowInactive bit,
	@LeadOrganisationID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @_SQL nvarchar(max)
	DECLARE @_OrgFilter nvarchar(max)
	
	--Filter by LeadOrganisationID:
	if @LeadOrganisationID > 0 
	begin
	set @_OrgFilter = dbo.svfAnd(@_OrgFilter) + '(SponsorOrganisationID = @LeadOrganisationID)'
	end
	--Filter by Admin Group if supplied:
	If @AdminGroupID > -1
	begin
	set @_OrgFilter = dbo.svfAnd(@_OrgFilter) + '(AdminGroupID = @AdminGroupID)'
	end
	-- Filter by County:
	if @County <> ''
	begin
	set @_OrgFilter = dbo.svfAnd(@_OrgFilter) + '(County = @County)'
	end
	--Filter by include show inactive:
	if @ShowInactive = 0
	begin
	set @_OrgFilter = dbo.svfAnd(@_OrgFilter) + '(InactivatedDate IS NULL)'
	end
	--Filter by closed requests:
	if @closed = 1
	begin
	set @_OrgFilter = dbo.svfAnd(@_OrgFilter) + '(RequestClosureDate IS NOT NULL)'
	end
	--Filter by @Search:
	if @Search <> ''
	begin
	set @_OrgFilter = dbo.svfAnd(@_OrgFilter) + '((OrganisationName LIKE N''%'' + REPLACE(@Search, '' '', ''%'') + ''%'') OR (CAST(OrganisationID AS VarChar) LIKE N''%'' + REPLACE(@Search, '' '', ''%'') + ''%'') OR (ICORegistrationNumber LIKE N''%'' + REPLACE(@Search, '' '', ''%'') + ''%'') OR (Aliases LIKE N''%'' + REPLACE(@Search, '' '', ''%'') + ''%'') OR (Identifiers LIKE N''%'' + REPLACE(@Search, '' '', ''%'') + ''%''))'
	end
	SET @_SQL = '
	SELECT        OrganisationName AS Organisation, ICORegistrationNumber AS [ICO Num], 
	                             (SELECT        OrganisationName
                               FROM            isp_Organisations AS so
                               WHERE        (OrganisationID = o.SponsorOrganisationID)) AS [Sponsored By], County, OrgContactEmail AS Contact, Identifiers, 
	(SELECT        OrganisationCategory
                               FROM            isp_OrganisationCategories AS so
                               WHERE        (OrganisationCategoryID = o.OrganisationCategoryID)) AS [Category],
                             (SELECT        UserName
                               FROM            aspnet_Users
                               WHERE        (UserId = o.ISPFirstRegisteredBy)) AS [Registered By], ISPFirstRegisteredDate AS [Registered], RequestClosureDate AS [Closure Requested], 
                         InactivatedDate AS Inactivated, 
                             (SELECT        TOP (1) SubmittedDate
                               FROM            isp_AssuranceSubmissions
                               WHERE        (OrganisationID = o.OrganisationID)
                               ORDER BY SubmittedDate DESC) AS [Assurance Submitted], CASE WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) IS NULL THEN ''Not submitted'' WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) = -10 Then ''Expired'' WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) = 0 THEN ''Significant'' WHEN dbo.getAssuranceScoreForOrganisationID(o.OrganisationID) = 1 THEN ''Limited'' ELSE ''None'' END AS Assurance,
                             (SELECT        TOP (1) SignedDate
                               FROM            isp_TierZeroSignatures
                               WHERE        (OrganisationID = o.OrganisationID) AND (RemovedDate IS NULL)
                               ORDER BY SignedDate DESC) AS [MOU Signed], COALESCE((SELECT GroupName FROM isp_AdminGroups WHERE AdminGroupID = o.AdminGroupID), ''None'') AS [Admin Group],
(SELECT       COUNT(OrganisationUserID)  AS Admins
FROM            isp_OrganisationUsers AS ou
WHERE        (OrganisationID = o.OrganisationID) AND (Active=1) AND (RoleID = 5) AND (Confirmed = 1)) AS [Administrators Verified], dbo.AdminsAtOrgCSV(OrganisationID) AS Administrators,
(SELECT        COUNT(OrganisationUserID) AS Admins
FROM            isp_OrganisationUsers AS ou
WHERE        (OrganisationID = o.OrganisationID) AND (Active=1) AND (RoleID IN (1,2,3)) AND (Confirmed = 1)) AS [Senior Users Verified], dbo.SeniorUsersAtOrgCSV(OrganisationID) AS [Senior Users],
 [dbo].[GetOrgSetupPercentage](OrganisationID) AS [Setup %], (SELECT        COUNT(DataFlowDetailID) AS DataFlows
FROM            isp_DataFlowDetail
WHERE        (ArchiveDate IS NULL) AND (DataFlowDetailID IN
                             (SELECT        do.DataFlowDetailID
                               FROM            isp_DFD_DFDOrganisations AS do INNER JOIN
                                                         isp_DF_Organisations AS o2 ON do.DF_OrgID = o2.DF_OrgID
                               WHERE        (o2.OrganisationID = o.OrganisationID)))) 
                         AS DataFlows, LicenceGranted, SingleOrgLicence, SuperAdminID, COALESCE(COALESCE((SELECT SuperAdminEmail FROM isp_SuperAdmins WHERE SuperAdminID = o.SuperAdminID AND ACTIVE = 1), (SELECT EmailAddress FROM isp_AdminGroups WHERE AdminGroupID = o.AdminGroupID)), ''None'') AS SuperAdmin, SingleOrgLicenceEnd
FROM            isp_Organisations AS o' 
SET @_SQL = @_SQL + @_OrgFilter + ' ORDER BY OrganisationName'
PRINT @_SQL
EXEC sp_executesql @_SQL, 	N'
@Closed Bit,
	@County nvarchar(100),
	@AdminGroupID int,
	@Search nvarchar(255),
	@ShowInactive bit,
	@LeadOrganisationID int',
	@Closed,
	@County,
	@AdminGroupID,
	@Search,
	@ShowInactive,
	@LeadOrganisationID
END

GO
