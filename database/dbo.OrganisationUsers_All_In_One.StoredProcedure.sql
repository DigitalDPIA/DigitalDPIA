USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 16/03/2015
-- Description:	Generic Organisation User insert / update / close procedure.
-- =============================================
CREATE PROCEDURE [dbo].[OrganisationUsers_All_In_One]
	-- Select parameters:
	@Email nvarchar(255),
	@OrganisationID int,
	-- Update parameters:
	@RoleID int,
	@OrganisationUserName nvarchar(50),
	@Active bit,
	@StatusActive bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_RetVal int
	SET @Email = LTRIM(RTRIM(@Email))
	SET @_RetVal = 0
    -- Find out whether any existing users exist:
	DECLARE @_CurrentCount Int
	SELECT @_CurrentCount = COUNT(OrganisationUserID) FROM isp_OrganisationUsers WHERE OrganisationID = @OrganisationID AND LOWER(OrganisationUserEmail) = LOWER(@Email)
	--If none and current role is inactive then nothing to do:
	IF @_CurrentCount = 0 and @Active = 0
	BEGIN
	GOTO OnExit
	END
	
	--If > 0 then let's update generic details of all org user records that match:
	IF @_CurrentCount > 0
	BEGIN
	if exists (SELECT * FROM isp_OrganisationUsers WHERE OrganisationUserName <> @OrganisationUserName AND LOWER(OrganisationUserEmail) = LOWER(@Email))
	BEGIN
		Update isp_OrganisationUsers SET OrganisationUserName = @OrganisationUserName WHERE LOWER(OrganisationUserEmail) = LOWER(@Email)
		SET @_RetVal = 1
		END
		END
	--If > 0 and current role active then need to check if current role exists and set inactive, or if role inactive and activating then set active:
	IF EXISTS(SELECT OrganisationUserID FROM isp_OrganisationUsers WHERE OrganisationID = @OrganisationID AND LOWER(OrganisationUserEmail) = LOWER(@Email) AND RoleID = @RoleID AND Active <> @Active)
	BEGIN 
	UPDATE isp_OrganisationUsers SET Active = @Active, ResignDate = CASE WHEN @Active = 1 THEN NULL ELSE ResignDate END WHERE  OrganisationID = @OrganisationID AND LOWER(OrganisationUserEmail) = LOWER(@Email) AND RoleID = @RoleID
--	 AND 
--	-- If activating we need to check that it isn't a reserved role (1,2 or 3) that already has an active user:
--	(@RoleID NOT IN (SELECT        RoleID
--FROM            isp_OrganisationUsers
--WHERE        (RoleID IN (1, 2, 3)) AND (OrganisationID = @OrganisationID) AND (Active = 1)) OR @Active=0)
	SET @_RetVal = 1
	GOTO OnExit
	END
	-- Inactivate all roles if StatusActive = 0
	If @StatusActive = 0 and @_CurrentCount > 0
	BEGIN
	UPDATE isp_OrganisationUsers SET Active = @StatusActive WHERE  OrganisationID = @OrganisationID AND LOWER(OrganisationUserEmail) = LOWER(@Email)
	SET @_RetVal = 1
	GOTO OnExit
	END
	-- Need to create role if it doesn't exist:
	IF @Active = 1 AND NOT EXISTS (SELECT OrganisationUserID FROM isp_OrganisationUsers WHERE OrganisationID = @OrganisationID AND LOWER(OrganisationUserEmail) = LOWER(@Email) AND RoleID = @RoleID)
	BEGIN
	DECLARE @RC int
EXECUTE @RC = [dbo].[OrganisationUsers_Add] 
   @OrganisationID
  ,@OrganisationUserName
  ,@Email
  ,@RoleID


	IF @RC > 0 
	BEGIN
	SET @_RetVal = 1
	END
	END

	OnExit:
	SELECT @_RetVal
	Return @_RetVal
END
GO
