USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 09/06/2016
-- Description: (Created for http://trac/InformationSharingPortal/ticket/480
--				Looks at key organisation setup requirements and returns a completeness percentage.
-- =============================================
CREATE FUNCTION [dbo].[GetOrgSetupPercentage]
(
	-- Add the parameters for the function here
	@OrgID Int
)
RETURNS INTEGER
AS
BEGIN
	-- Declare the return variable here
	DECLARE @_ProcessDone DECIMAL(5,2)
	DECLARE @_SponsoredOrgID Int
	DECLARE @_DPOExempt bit
	DECLARE @_OutOf decimal(5,2)
	SELECT @_DPOExempt = DPOExempt FROM isp_Organisations WHERE OrganisationID = @OrgID

	SET @_OutOf = 14.0


	SELECT @_ProcessDone = (OrgRegistered + Administrators + SeniorUsers + Assurance + ContactEmail + MOU + DPOs)/@_OutOf
FROM
(SELECT
2 AS OrgRegistered,
(SELECT        CASE WHEN COUNT(OrganisationUserID)> 0 THEN 2 ELSE 0 END AS Admins
FROM            isp_OrganisationUsers AS ou
WHERE        (Active = 1) AND (OrganisationID = @OrgID) AND (RoleID = 5) AND (Active =1) AND (Confirmed = 1)) AS Administrators,
(SELECT        CASE WHEN COUNT(OrganisationUserID) > 0 THEN 1 ELSE 0 END AS Admins
FROM            isp_OrganisationUsers AS ou
WHERE        (Active = 1) AND (OrganisationID = @OrgID) AND (RoleID IN (1,2,3)))+(SELECT        CASE WHEN COUNT(OrganisationUserID) > 0 THEN 1 ELSE 0 END AS Admins
FROM            isp_OrganisationUsers AS ou
WHERE        (Active = 1) AND (OrganisationID = @OrgID) AND (RoleID IN (1,2,3)) AND (Confirmed = 1)) AS SeniorUsers,
(SELECT        CASE WHEN @_DPOExempt = 1 THEN 2 WHEN COUNT(OrganisationUserID) > 0 THEN 1 ELSE 0 END AS Admins
FROM            isp_OrganisationUsers AS ou
WHERE        (Active = 1) AND (OrganisationID = @OrgID) AND (RoleID = 10))+(SELECT        CASE WHEN @_DPOExempt = 1 THEN 0 WHEN COUNT(OrganisationUserID) > 0 THEN 1 ELSE 0 END AS Admins
FROM            isp_OrganisationUsers AS ou
WHERE        (Active = 1) AND (OrganisationID = @OrgID) AND (RoleID = 10) AND (Confirmed = 1)) AS DPOs,
 (SELECT        CASE WHEN COUNT(AssuranceSubmissionID) > 0 THEN 1 ELSE 0 END AS Assurance
                               FROM            isp_AssuranceSubmissions
                               WHERE        (OrganisationID = @OrgID) AND (SubmissionClosedDate IS NULL) AND (ICORegReviewDate > getUTCDate())) +
                             (SELECT        CASE WHEN COUNT(AssuranceSubmissionID) > 0 THEN 1 ELSE 0 END AS Assurance
                               FROM            isp_AssuranceSubmissions AS isp_AssuranceSubmissions_1
                               WHERE        (OrganisationID = @OrgID) AND (SubmissionClosedDate IS NULL)) AS Assurance,
(SELECT        CASE WHEN LEN(OrgContactEmail) > 0 THEN 2 ELSE 0 END AS ContactEmail
FROM            isp_Organisations
WHERE        (OrganisationID = @OrgID)) AS ContactEmail,
(SELECT        CASE WHEN COUNT(TierZeroID) > 0 THEN 2 ELSE 0 END AS MoU
FROM            isp_TierZeroSignatures
WHERE        (OrganisationID = @OrgID) AND (RemovedDate IS NULL)) AS MOU) AS Q1

	-- Return the result of the function
	RETURN CAST(@_ProcessDone*100.0 AS Int)

END


GO
