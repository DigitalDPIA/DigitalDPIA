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
CREATE PROCEDURE [dbo].[GetFilteredOrganisations]
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
	set @_OrgFilter = dbo.svfAnd(@_OrgFilter) + '(o.AdminGroupID = @AdminGroupID)'
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
	SELECT        OrganisationID, OrganisationName, ICORegistrationNumber, '''' AS OrganisationAddress, OrgContactEmail, Identifiers, 
	(SELECT        OrganisationCategory
                               FROM            isp_OrganisationCategories AS so
                               WHERE        (OrganisationCategoryID = o.OrganisationCategoryID)) AS [Category],
                             (SELECT        OrganisationName
                               FROM            isp_Organisations AS so
                               WHERE        (OrganisationID = o.SponsorOrganisationID)) AS [SponsoredBy], County, OrgContactEmail AS Contact,
                             (SELECT        UserName
                               FROM            aspnet_Users
                               WHERE        (UserId = o.ISPFirstRegisteredBy)) AS [RegisteredBy], ISPFirstRegisteredDate, RequestClosureDate, 
                         InactivatedDate, 
                             (SELECT        TOP (1) SubmittedDate
                               FROM            isp_AssuranceSubmissions
                               WHERE        (OrganisationID = o.OrganisationID)
                               ORDER BY SubmittedDate DESC) AS [AssuranceSubmitted],
                             (SELECT        TOP (1) SignedDate
                               FROM            isp_TierZeroSignatures
                               WHERE        (OrganisationID = o.OrganisationID) AND (RemovedDate IS NULL)
                               ORDER BY SignedDate DESC) AS [MOUSigned], COALESCE((SELECT GroupName FROM isp_AdminGroups WHERE AdminGroupID = o.AdminGroupID), ''None'') AS [AdminGroup],
(SELECT       COUNT(OrganisationUserID)  AS Admins
FROM            isp_OrganisationUsers AS ou
WHERE        (OrganisationID = o.OrganisationID) AND (Active=1) AND (RoleID = 5) AND (Confirmed = 1)) AS [AdminsVerified],
(SELECT        COUNT(OrganisationUserID) AS Admins
FROM            isp_OrganisationUsers AS ou
WHERE        (OrganisationID = OrganisationID) AND (Active=1) AND (RoleID IN (1,2,3)) AND (Confirmed = 1)) AS [SeniorUsersVerified], CAST(CASE WHEN COALESCE (Longitude, '''') 
                         <> '''' THEN 1 ELSE 0 END AS Bit) AS OnMap, [dbo].[GetOrgSetupPercentage](OrganisationID) AS OrganisationSetupPercent, (SELECT        COUNT(DataFlowDetailID) AS DataFlows
FROM            isp_DataFlowDetail
WHERE        (ArchiveDate IS NULL) AND (DataFlowDetailID IN
                             (SELECT        do.DataFlowDetailID
                               FROM            isp_DFD_DFDOrganisations AS do INNER JOIN
                                                         isp_DF_Organisations AS o2 ON do.DF_OrgID = o2.DF_OrgID
                               WHERE        (o2.OrganisationID = o.OrganisationID)))) 
                         AS DataFlows, LicenceGranted, SingleOrgLicence, SuperAdminID, COALESCE(COALESCE(COALESCE((SELECT SuperAdminEmail FROM isp_SuperAdmins WHERE SuperAdminID = o.SuperAdminID AND ACTIVE = 1), (SELECT EmailAddress FROM isp_AdminGroups WHERE AdminGroupID = o.AdminGroupID)),(SELECT EmailAddress FROM isp_AdminGroups WHERE AdminGroupID = 1 AND o.SingleOrgLicenceEnd >= getDate())), ''None'') AS SuperAdmin, SingleOrgLicenceEnd
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
