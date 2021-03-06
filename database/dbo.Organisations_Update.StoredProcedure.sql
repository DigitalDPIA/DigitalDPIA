USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Organisations_Update]
@OrganisationName NVARCHAR (255), 
@OrganisationTypeID INT, 
@SponsorOrganisationID INT, 
@OrganisationAddress NVARCHAR (500), 
@ISPFirstRegisteredBy UNIQUEIDENTIFIER, 
@ISPFirstRegisteredDate DATETIME, 
@ICORegistrationNumber VARCHAR (50), 
@RegEvidenceFileID INT, 
@Original_OrganisationID INT, 
@InactivatedDate DATETIME, 
@Longitude FLOAT,
@Latitude FLOAT, 
@OrgContactEmail NVARCHAR (255), 
@OrgContactPhone NVARCHAR (50), 
@OrgContactName NVARCHAR (50), 
@RequestClosureDate DATETIME, 
@RequestClosureReason NVARCHAR (500), 
@County NVARCHAR (100), 
@Aliases NVARCHAR (500), 
@AdminGroupID int,
@Identifiers NVARCHAR (255),
@OrganisationCategoryID int,
@OrganisationCategoryOther nvarchar(255),
@PrivacyNoticeURL nvarchar(255)

AS
BEGIN
    SET NOCOUNT OFF;
	DECLARE @ReturnVal Int
	Set @ReturnVal = 0 --Will be returned if the update call doesn't happen. Currently (19/08/2018) only if the organisation is being made a supported organisation but is also supporting organisations.
    IF @OrganisationTypeID < 2

        BEGIN
            SET @SponsorOrganisationID = 0;
            IF EXISTS (SELECT SponsorshipID
                       FROM   isp_Sponsorship
                       WHERE  SponsoredOrganisationID = @Original_OrganisationID
                              AND WithdrawnDate IS NULL
                              AND AuthorisedOn IS NOT NULL)
                BEGIN
                    UPDATE  [isp_Sponsorship]
                        SET WithdrawnDate   = getDate(),
                            WithdrawnReason = N'Sponsored organisation changed to lead organisation.'
                    WHERE   SponsoredOrganisationID = @Original_OrganisationID
                            AND WithdrawnDate IS NULL
                END
            /*Check if sponsorship record exists and delete if changing to a lead organisation */
            IF EXISTS (SELECT SponsorshipID
                       FROM   isp_Sponsorship
                       WHERE  SponsoredOrganisationID = @Original_OrganisationID
                              AND WithdrawnDate IS NULL)
                BEGIN
                    DELETE [isp_Sponsorship]
                    WHERE  SponsoredOrganisationID = @Original_OrganisationID
                           AND WithdrawnDate IS NULL;
                END
        END
		--Check if sponsor org has changed and remove old sponsorship and add new one:
		if @SponsorOrganisationID <> (SELECT SponsorOrganisationID FROM isp_Organisations WHERE OrganisationID = @Original_OrganisationID) AND @SponsorOrganisationID > 0
		begin
		IF EXISTS (SELECT SponsorshipID
                       FROM   isp_Sponsorship
                       WHERE  SponsoredOrganisationID = @Original_OrganisationID
                              AND WithdrawnDate IS NULL
                              AND AuthorisedOn IS NOT NULL)
                BEGIN
                    UPDATE  [isp_Sponsorship]
                        SET WithdrawnDate   = getDate(),
                            WithdrawnReason = N'Sponsored organisation changed to lead organisation.'
                    WHERE   SponsoredOrganisationID = @Original_OrganisationID
                            AND WithdrawnDate IS NULL

							INSERT INTO [isp_Sponsorship] (SponsoredOrganisationID, LeadOrganisationID, AuthorisedBy, AuthorisedOn, RequestedBy, RequestedOn) VALUES (@Original_OrganisationID, @SponsorOrganisationID, @ISPFirstRegisteredBy, GETUTCDATE(), @ISPFirstRegisteredBy, GETUTCDATE())
                END
				--Check if the organisation has been made sponsored but is itself sponsoring:
				IF (SELECT COUNT(OrganisationID) FROM isp_Organisations WHERE SponsorOrganisationID = @Original_OrganisationID) > 0
				BEGIN
				GoTo OnExit
				END
		end
		
		
		-- Now update the organisation record:

    UPDATE  isp_Organisations
        SET OrganisationName       = @OrganisationName,
            OrganisationTypeID     = @OrganisationTypeID,
            SponsorOrganisationID  = @SponsorOrganisationID,
            OrganisationAddress    = @OrganisationAddress,
            ISPFirstRegisteredDate = @ISPFirstRegisteredDate,
            InactivatedDate        = @InactivatedDate,
            ISPFirstRegisteredBy   = @ISPFirstRegisteredBy,
            ICORegistrationNumber  = @ICORegistrationNumber,
            RegEvidenceFileID      = @RegEvidenceFileID,
            Longitude              = @Longitude,
            Latitude               = @Latitude,
            OrgContactPhone        = @OrgContactPhone,
            OrgContactEmail        = @OrgContactEmail,
            OrgContactName         = @OrgContactName,
            RequestClosureDate     = @RequestClosureDate,
            RequestClosureReason   = @RequestClosureReason,
            County                 = @County,
            Aliases                = @Aliases,
            Identifiers            = @Identifiers,
			AdminGroupID = @AdminGroupID,
			OrganisationCategoryID = @OrganisationCategoryID,
			OrganisationCategoryOther = @OrganisationCategoryOther,
			PrivacyNoticeURL = @PrivacyNoticeURL

    WHERE   (OrganisationID = @Original_OrganisationID);
    /*Check if sponsorship record exists and create one if not */
    --IF @SponsorOrganisationID > 0
    --    BEGIN
    --        IF NOT EXISTS (SELECT TOP (1) SponsorshipID
    --                       FROM   isp_Sponsorship
    --                       WHERE  LeadOrganisationID = @SponsorOrganisationID
    --                              AND SponsoredOrganisationID = @Original_OrganisationID
    --                              AND WithdrawnDate IS NULL)
    --            BEGIN
    --                INSERT  INTO [isp_Sponsorship] (SponsoredOrganisationID, LeadOrganisationID)
    --                VALUES                        (@Original_OrganisationID, @SponsorOrganisationID);
    --            END
    --    END
    EXECUTE UpdateDataflowOrganisations @OrganisationID = @Original_OrganisationID;
	Set @ReturnVal = 1
	OnExit:
	SELECT @ReturnVal
	Return @ReturnVal
END  
GO
