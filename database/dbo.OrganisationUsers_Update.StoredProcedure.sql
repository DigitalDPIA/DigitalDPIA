USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 04/12/2014
-- Description:	Update Organisation Users catching error.
-- =============================================
CREATE PROCEDURE [dbo].[OrganisationUsers_Update]
	@OrganisationID Int,
	@OrganisationUserName nvarchar(50),
	@OrganisationUserEmail nvarchar(255),
	@RoleID int,
	@Confirmed bit,
	@Active bit,
	@Original_OrganisationUserID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @_Result Int = 0
	SET @OrganisationUserEmail = LTRIM(RTRIM(@OrganisationUserEmail))
	--Check if another OrganisationUserID has the same role and e-mail address:
	if exists(SELECT OrganisationUserID FROM isp_OrganisationUsers WHERE OrganisationUserEmail = @OrganisationUserEmail AND RoleID = @RoleID AND OrganisationID = @OrganisationID AND OrganisationUserID<> @Original_OrganisationUserID)
	BEGIN
	Set @_Result = -30
	GoTo OnExit
	END

	-- Check if another current, active user exists in exclusive role:

	IF @RoleID IN (1,2,3) 
	BEGIN
	if exists(SELECT OrganisationUserID FROM isp_OrganisationUsers WHERE RoleID = @RoleID AND OrganisationID = @OrganisationID AND Active=1 AND OrganisationUserID<> @Original_OrganisationUserID)
	BEGIN
	Set @_Result = -31
	GoTo OnExit
	END
	END

	BEGIN TRY
	Begin transaction UpdateUser
    UPDATE [isp_OrganisationUsers] 
	SET [OrganisationID] = @OrganisationID, [OrganisationUserName] = @OrganisationUserName, [OrganisationUserEmail] = @OrganisationUserEmail, [RoleID] = @RoleID, [Confirmed] = @Confirmed, [Active] = @Active 
	WHERE (([OrganisationUserID] = @Original_OrganisationUserID))
	set @_Result =1
	Commit Transaction UpdateUser
	--Now, let's make sure all usernames are the same:
	UPDATE isp_OrganisationUsers
	SET OrganisationUserName = @OrganisationUserName WHERE OrganisationUserEmail = @OrganisationUserEmail
			
END TRY

BEGIN CATCH
	IF @@TRANCOUNT>0 
	BEGIN
	ROLLBACK TRANSACTION UpdateUser
	set @_Result = -1
	goto OnExit
	END
END CATCH
OnExit:

SELECT @_Result
Return @_Result
END
GO
