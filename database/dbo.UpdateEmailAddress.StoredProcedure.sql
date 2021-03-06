USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 22/03/2017
-- Description:	Updates a users e-mail address in all relevant tables
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEmailAddress]
	-- Add the parameters for the stored procedure here
	@OldEmail nvarchar(255),
	@NewEmail nvarchar(255)
AS
BEGIN


	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_Return Int
	SET @_Return = 2
    -- Insert statements for procedure here
	-- Check if new e-mail address already exists:
	if exists (SELECT * FROM aspnet_Membership WHERE LoweredEmail = LOWER(@NewEmail)) AND exists (SELECT * FROM isp_OrganisationUsers WHERE OrganisationUserEmail = @NewEmail)
	begin
	SET @_Return = 3
	Goto OnExit
	end

	-- Update the aspnet_Membership table:
	if exists (SELECT * FROM aspnet_Membership WHERE LoweredEmail = LOWER(@OldEmail)) AND not exists (SELECT * FROM aspnet_Membership WHERE LoweredEmail = LOWER(@NewEmail))
	begin
	UPDATE aspnet_Membership SET LoweredEmail = LOWER(@NewEmail), Email = @NewEmail WHERE LoweredEmail = LOWER(@OldEmail)
	UPDATE aspnet_Users SET LoweredUserName = LOWER(@NewEmail), UserName = @NewEmail WHERE LoweredUserName = LOWER(@OldEmail)
	SET @_Return = 1
	end

	-- Update the isp_AdminGroups table:
	if exists (SELECT * FROM isp_AdminGroups WHERE EmailAddress = @OldEmail)
	begin
	UPDATE isp_AdminGroups SET EmailAddress = @NewEmail WHERE EmailAddress = @OldEmail
	end

	-- Update the isp_DataAssetContacts table:
	if exists (SELECT * FROM isp_DataAssetContacts WHERE ContactEmail = @OldEmail)
	begin
	UPDATE isp_DataAssetContacts SET ContactEmail = @NewEmail WHERE ContactEmail = @OldEmail
	end

	-- Update the isp_DataAssetInventory table:
	if exists (SELECT * FROM isp_DataAssetInventory WHERE InformationAssetOwnerEmail = @OldEmail)
	begin
	UPDATE isp_DataAssetInventory SET InformationAssetOwnerEmail = @NewEmail WHERE InformationAssetOwnerEmail = @OldEmail
	end

	-- Update the isp_DataAssetInventory table:
	if exists (SELECT * FROM isp_DataAssetInventory WHERE InformationAssetOwnerEmail = @OldEmail)
	begin
	UPDATE isp_DataAssetInventory SET InformationAssetOwnerEmail = @NewEmail WHERE InformationAssetOwnerEmail = @OldEmail
	end

	-- Update the isp_DataFlowContacts table:
	if exists (SELECT * FROM isp_DataFlowContacts WHERE ContactEmail = @OldEmail)
	begin
	UPDATE isp_DataFlowContacts SET ContactEmail = @NewEmail WHERE ContactEmail = @OldEmail
	end

	-- Update the isp_DataFlowSignOffRequests table:
	if exists (SELECT * FROM isp_DataFlowSignOffRequests WHERE RequestedBy = @OldEmail)
	begin
	UPDATE isp_DataFlowSignOffRequests SET RequestedBy = @NewEmail WHERE RequestedBy = @OldEmail
	end

	-- Update the isp_Files table:
	if exists (SELECT * FROM isp_Files WHERE UserEmail = @OldEmail)
	begin
	UPDATE isp_Files SET UserEmail = @NewEmail WHERE UserEmail = @OldEmail
	end

    -- Update the isp_NotificationUsers table:
	if exists (SELECT * FROM isp_NotificationUsers WHERE UserEmail = @OldEmail)
	begin
	UPDATE isp_NotificationUsers SET UserEmail = @NewEmail WHERE UserEmail = @OldEmail
	end

	 -- Update the isp_Organisations table:
	if exists (SELECT * FROM isp_Organisations WHERE OrgContactEmail = @OldEmail)
	begin
	UPDATE isp_Organisations SET OrgContactEmail = @NewEmail WHERE OrgContactEmail = @OldEmail
	end

	-- Update the isp_OrganisationUsers table:
	if exists (SELECT * FROM isp_OrganisationUsers WHERE OrganisationUserEmail = @OldEmail)
	begin
	UPDATE isp_OrganisationUsers SET OrganisationUserEmail = @NewEmail WHERE OrganisationUserEmail = @OldEmail
	end

	-- Update the isp_SuperAdmins table:
	if exists (SELECT * FROM isp_SuperAdmins WHERE SuperAdminEmail = @OldEmail)
	begin
	UPDATE isp_SuperAdmins SET SuperAdminEmail = @NewEmail WHERE SuperAdminEmail = @OldEmail
	end

	-- Update the isp_SupportTicketComments table:
	if exists (SELECT * FROM isp_SupportTicketComments WHERE TCUserEmail = @OldEmail)
	begin
	UPDATE isp_SupportTicketComments SET TCUserEmail = @NewEmail WHERE TCUserEmail = @OldEmail
	end

	-- Update the isp_SupportTickets table:
	if exists (SELECT * FROM isp_SupportTickets WHERE ReporterEmail = @OldEmail)
	begin
	UPDATE isp_SupportTickets SET ReporterEmail = @NewEmail WHERE ReporterEmail = @OldEmail
	end

	-- Update the isp_TermsOfUseUserSigned table:
	if exists (SELECT * FROM isp_TermsOfUseUserSigned WHERE Email = @OldEmail)
	begin
	UPDATE isp_TermsOfUseUserSigned SET Email = @NewEmail WHERE Email = @OldEmail
	end

    -- Update the isp_UnsubscribeList table:
	if exists (SELECT * FROM isp_UnsubscribeList WHERE UnsubscribeEmail = @OldEmail)
	begin
	UPDATE isp_UnsubscribeList SET UnsubscribeEmail = @NewEmail WHERE UnsubscribeEmail = @OldEmail
	end

	-- Update the isp_UserNotifications table:
	if exists (SELECT * FROM isp_UserNotifications WHERE UserEmail = @OldEmail)
	begin
	UPDATE isp_UserNotifications SET UserEmail = @NewEmail WHERE UserEmail = @OldEmail
	end
	OnExit:
	Select @_Return
	Return @_Return
END
GO
