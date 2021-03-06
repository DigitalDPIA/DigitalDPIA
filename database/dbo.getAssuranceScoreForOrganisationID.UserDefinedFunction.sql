USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 10/12/14
-- Description:	Returns an assurance score for an Organisation ID
--				Note that return value is -11 if the organisation is inactive
-- =============================================
CREATE FUNCTION [dbo].[getAssuranceScoreForOrganisationID]
(
	@OrganisationID int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @_AssuranceSubmissionID int
	DECLARE @_Result int

	SELECT @_AssuranceSubmissionID = AssuranceSubmissionID from isp_AssuranceSubmissions WHERE OrganisationID = @OrganisationID AND SubmissionClosedDate Is Null  

	if not @_AssuranceSubmissionID is NULL
		begin
		set @_Result = dbo.getAssuranceScore(@_AssuranceSubmissionID)

		if NOT (SELECT InactivatedDate FROM isp_Organisations WHERE OrganisationID = @OrganisationID) IS NULL
			begin
			SET @_Result = -11
			end
		end

	RETURN @_Result
END

GO
