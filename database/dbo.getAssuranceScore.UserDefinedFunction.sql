USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 10/12/14
-- Description:	Returns an assurance score for an assurance submission ID
-- =============================================
CREATE FUNCTION [dbo].[getAssuranceScore]
(
	@AssuranceSubmissionID int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int
	DECLARE @_Type As Int
	DECLARE @_Expires datetime
	DECLARE @_OrgID AS Int
	DECLARE @_DSPStandardsMet as bit
	--
	-- Count significant registration items
	-- ICO Registered; staff screened; IG Training
	--
	SELECT 
		@_OrgID = OrganisationID, 
		@_Type = IGComplianceTypeID, 
		@_Expires = ICORegReviewDate,  
		@_DSPStandardsMet = DSPStandardsMet,
		@Result = CAST(ICORegistered AS Int) + CAST(StaffScreened AS Int) + CAST(IGTraining As Int) 
	FROM 
		isp_AssuranceSubmissions 
	WHERE 
		AssuranceSubmissionID = @AssuranceSubmissionID
	--
	-- If the IG registration is expired then give back -10
	--
	if @_Expires < GETUTCDATE()
		BEGIN
		SET @Result = -10
		END
	ELSE
		BEGIN
		--
		-- Otherwise get a few more options
		-- Add another 1 for valid IG Compliance
		--
		DECLARE @_IGComplianceType varchar(255)

		SELECT @_IGComplianceType = IGComplianceType FROM isp_IGComplianceTypes WHERE IGComplianceTypeID = @_Type

		If @_IGComplianceType <> 'None'
			BEGIN
			--
			-- If using Digital Data Security, it only counts if the standards have been met
			--
			If @_IGComplianceType like '%NHS Digital Data Security%' 
				BEGIN
				if @_DSPStandardsMet = 1
					BEGIN
					Set @Result = @Result + 1
					END
				END
			ELSE
				BEGIN
				--
				-- All other valid methods count for the moment
				--
				Set @Result = @Result + 1
				END
			END
		--
		-- Check if they have a privacy URL or orgprivacy file uploaded
		--
		DECLARE @pURL as nvarchar(255)
		SELECT @pURL = COALESCE(PrivacyNoticeURL, '') FROM isp_Organisations WHERE OrganisationID = @_OrgID
		if LEN(@Purl) > 6
			Begin
			Set @Result = @Result+1
			End
		 else
		 if (SELECT COUNT(fgf.FileGroupFileID)
				FROM 
					isp_FileGroupFiles AS fgf INNER JOIN
					isp_FileGroups AS fg ON fgf.FileGroupID = fg.FileGroupID
				WHERE 
					(fg.GroupType = N'orgprivacy') 
					AND (fg.ID = @_OrgID)) > 0
			 Begin
			 Set @Result = @Result+1
			 End
		--
		-- Convert the count into 0 for best (max of 5 counted above)
		--
		Set @Result = 5 - @Result
		END
	
	RETURN @Result
END

GO
