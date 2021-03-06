USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 12/11/14
-- Description:	Adds a user to isp_OrganisationUsers checking for duplicates and previous e-mail confirmation
-- =============================================
CREATE PROCEDURE [dbo].[OrganisationUsers_Add_V2]
	@OrganisationID Int,
	@UserName nvarchar(50),
	@Email nvarchar(255),
	@RoleID int,
	@Scalar bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @_Result Int = 0
	SET @Email = LTRIM(RTRIM(@Email))

	-- Check if existing email, role, organisation match already exists:

	if exists(SELECT OrganisationUserID FROM isp_OrganisationUsers WHERE OrganisationUserEmail = @Email AND RoleID = @RoleID AND OrganisationID = @OrganisationID)
	BEGIN
	Set @_Result = -30
	GoTo OnExit
	END

	-- Check if current, active user exists in exclusive role:

	IF @RoleID = 1 
	BEGIN
	Declare @RCount Int
	 SELECT @RCount = COUNT(OrganisationUserID) FROM isp_OrganisationUsers WHERE RoleID = @RoleID AND OrganisationID = @OrganisationID AND Active=1
	if (@RCount >= 5)
	BEGIN
	Set @_Result = -31
	GoTo OnExit
	END
	END
	-- Check if user email is already confirmed in current organisation:
	DECLARE @_GUID as uniqueidentifier
	DECLARE @_IsConfirmed as bit
	SELECT TOP(1) @_GUID = ConfirmationHash, @_IsConfirmed = Confirmed FROM isp_OrganisationUsers WHERE OrganisationUserEmail = @Email ORDER BY Confirmed DESC
	-- If none exists, let's generate a new one:
	IF @_GUID IS NULL
	BEGIN
	SET @_GUID = NEWID()
	SET @_IsConfirmed = 0
	END

	-- Let's go ahead and insert
	BEGIN TRY
	Begin transaction InsertUser
    INSERT INTO isp_OrganisationUsers
                         (OrganisationID, OrganisationUserName, OrganisationUserEmail, RoleID, ConfirmationHash, Confirmed)
VALUES        (@OrganisationID,@UserName,@Email,@RoleID, @_GUID, @_IsConfirmed)
SET @_Result = SCOPE_IDENTITY()
	
	
Commit Transaction InsertUser
--Now, let's make sure all usernames are the same:
	UPDATE isp_OrganisationUsers
	SET OrganisationUserName = @UserName WHERE OrganisationUserEmail = @Email
	-- Let's insert notification sign up entries for user for all available notifications for role:
	INSERT INTO isp_NotificationUsers
	(NotificationID, UserEmail)
	SELECT DISTINCT NotificationID, @Email AS UserEmail
	FROM isp_NotificationRoles WHERE RoleID = @RoleID
END TRY

BEGIN CATCH
	IF @@TRANCOUNT>0 
	BEGIN
	ROLLBACK TRANSACTION InsertUser
	set @_Result = -1
	goto OnExit
	END
END CATCH
OnExit:
if @Scalar = 1
Begin
SELECT @_Result
Return @_Result
End
END
GO
