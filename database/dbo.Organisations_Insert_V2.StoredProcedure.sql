USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Organisations_Insert_V2]
(
	@OrganisationName nvarchar(255),
	@OrganisationTypeID int,
	@OrganisationCategoryID int,
	@OrganisationCategoryOther nvarchar(255),
	@SponsorOrganisationID int,
	@OrganisationAddress nvarchar(500),
	@ISPFirstRegisteredBy uniqueidentifier,
	@UserEmail nvarchar(256),
	@UserName nvarchar(256),
	@UserRoleID int,
	@ICORegNumber varchar(50),
	@FileID int,
	@Longitude float,
	@Latitude float,
	@ContactEmail varchar(255),
	@County nvarchar(100),
	@AdminGroupID int,
	@Aliases nvarchar(500),
	@Identifiers nvarchar(255),
	@RegisterByLead bit,
	@ConfirmDuplicateInsert bit
)
AS
BEGIN
	SET NOCOUNT OFF;

	DECLARE @_ReturnValue Int
	DECLARE @_OrganisationID Int
	SET @_ReturnValue = 0
	/*Set AdminGroupID to 1 if NULL*/
	if @AdminGroupID IS NULL
	begin
	set @AdminGroupID = 0
	end
	/*Need to check if OrganisationName exists:*/
	if exists(SELECT OrganisationID FROM isp_Organisations WHERE OrganisationName = @OrganisationName)
		BEGIN
			SET @_ReturnValue = -10
		END
		/*Need to check if ICONumber exists:*/
		else if not @ConfirmDuplicateInsert = 1 and exists(SELECT OrganisationID FROM isp_Organisations WHERE ([ICORegistrationNumber] = @ICORegNumber) AND (COALESCE([ICORegistrationNumber], '') <> '') AND (COALESCE(@ICORegNumber, '') <> ''))
		BEGIN
			SET @_ReturnValue = -11
		END
		/*And check the Identifier for existing records:*/
		else if not @ConfirmDuplicateInsert = 1 and exists(SELECT OrganisationID FROM            isp_Organisations
WHERE        (Identifiers LIKE '%' + @Identifiers + '%') AND (COALESCE (Identifiers, '') <> '') AND (COALESCE (@Identifiers, '') <> ''))
		BEGIN
			SET @_ReturnValue = -11
		END
/*Need to check if user is already assigned to a centre:*/
--if exists(SELECT OrganisationID from isp_OrganisationUsers WHERE OrganisationUserEmail =@UserEmail AND Active = 1)
--BEGIN
			--SET @_ReturnValue = -11
		--END
	IF @_ReturnValue = 0
		BEGIN
		BEGIN TRY
			Begin Transaction InsertOrg
			begin
	
			INSERT INTO [isp_Organisations] ([OrganisationName], [OrganisationTypeID], [SponsorOrganisationID], [OrganisationAddress], [ISPFirstRegisteredBy], [ISPFirstRegisteredDate], [ICORegistrationNumber], [RegEvidenceFileID], [Longitude], [Latitude], [OrgContactEmail], [County], [AdminGroupID], [Aliases], [Identifiers], [OrganisationCategoryID], [OrganisationCategoryOther]) 
			
			VALUES (@OrganisationName, @OrganisationTypeID, @SponsorOrganisationID, @OrganisationAddress, @ISPFirstRegisteredBy, getUTCDate(), @ICORegNumber, @FileID, @Longitude, @Latitude, @ContactEmail, @County, @AdminGroupID, @Aliases, @Identifiers, @OrganisationCategoryID, @OrganisationCategoryOther);

			SET @_OrganisationID =  SCOPE_IDENTITY()
			
			end
				if @UserRoleID <> 5 BEGIN		
				EXECUTE [dbo].[OrganisationUsers_Add_V2] @_OrganisationID, @UserName, @UserEmail, @UserRoleID, 0
			END
			EXECUTE [dbo].[OrganisationUsers_Add_V2] @_OrganisationID, @UserName, @UserEmail, 5, 0
			/* Now lets request sponsorship if it is a sponsored org */
			IF @SponsorOrganisationID > 0
			BEGIN
			if @RegisterByLead = 1
			BEGIN
			INSERT INTO [isp_Sponsorship] (SponsoredOrganisationID, LeadOrganisationID, AuthorisedBy, AuthorisedOn, RequestedBy, RequestedOn) VALUES (@_OrganisationID, @SponsorOrganisationID, @ISPFirstRegisteredBy, GETUTCDATE(), @ISPFirstRegisteredBy, GETUTCDATE())
			END
			ELSE
			BEGIN
			INSERT INTO [isp_Sponsorship] (SponsoredOrganisationID, LeadOrganisationID) VALUES (@_OrganisationID, @SponsorOrganisationID)
			END
			END
			
Commit Transaction InsertOrg
SET  @_ReturnValue =  @_OrganisationID
EXEC UpdateDataflowOrganisations @OrganisationID = @_OrganisationID
goto OnExit
			
END TRY
BEGIN CATCH
	IF @@TRANCOUNT>0 
	BEGIN

	ROLLBACK TRANSACTION InsertOrg
	INSERT INTO log_OrganisationInsertError 
	([OrganisationName]
           ,[OrganisationCategoryID]
           ,[OrganisationCategoryOther]
           ,[SponsorOrganisationID]
           ,[OrganisationAddress]
           ,[ISPFirstRegisteredBy]
           ,[UserEmail]
           ,[UserName]
           ,[UserRoleID]
           ,[ICORegNumber]
           ,[FileID]
           ,[Longitude]
           ,[Latitude]
           ,[ContactEmail]
           ,[County]
           ,[AdminGroupID]
           ,[Aliases]
           ,[Identifiers]
           ,[RegisterByLead]
           ,[ConfirmDuplicateInsert])
		   VALUES
		   (@OrganisationName
           ,@OrganisationCategoryID
           ,@OrganisationCategoryOther
           ,@SponsorOrganisationID
           ,@OrganisationAddress
           ,@ISPFirstRegisteredBy
           ,@UserEmail
           ,@UserName
           ,@UserRoleID
           ,@ICORegNumber
           ,@FileID
           ,@Longitude
           ,@Latitude
           ,@ContactEmail
           ,@County
           ,@AdminGroupID
           ,@Aliases
           ,@Identifiers
           ,@RegisterByLead
           ,@ConfirmDuplicateInsert)
	set @_ReturnValue = -1
	goto OnExit
	END
END CATCH
END

OnExit:

SELECT @_ReturnValue
Return @_ReturnValue
END
GO
