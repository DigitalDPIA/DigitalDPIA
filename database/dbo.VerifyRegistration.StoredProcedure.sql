USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 22/10/2014
-- Description:	Takes Hash ID and User ID parameters and uses them to verify a registration.
-- =============================================
CREATE PROCEDURE [dbo].[VerifyRegistration]
	-- Add the parameters for the stored procedure here
	@ConfirmationHash varchar(128),
	@UserID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_OrgUserID Int
	DECLARE @_Confirmed Bit
	DECLARE @_ReturnValue Int
	SET @_ReturnValue = 0
	DECLARE @UserEmail varchar(100)
	SELECT        @_OrgUserID = isp_OrganisationUsers.OrganisationUserID,@_Confirmed = isp_OrganisationUsers.Confirmed, @UserEmail=isp_OrganisationUsers.OrganisationUserEmail
FROM            isp_OrganisationUsers INNER JOIN
                         aspnet_Membership ON isp_OrganisationUsers.OrganisationUserEmail = aspnet_Membership.Email
WHERE        (aspnet_Membership.UserId = @UserId) AND (isp_OrganisationUsers.ConfirmationHash = @ConfirmationHash)
    
	IF (@_OrgUserID IS NULL)
	BEGIN
	-- There wasn't a match - sett return val to -20:
	SET @_ReturnValue = -20
	END
	ELSE IF (@_Confirmed = 1)
	BEGIN
	-- Already confirmed:
	SET @_ReturnValue = -21
	END
	ELSE
	BEGIN
	UPDATE isp_OrganisationUsers SET Confirmed = 1 WHERE OrganisationUserID = @_OrgUserID or OrganisationUserEmail=@UserEmail
	SET @_ReturnValue = 1
	IF (SELECT [dbo].[fncCheckEmailDomain] (@UserEmail)) = 0
	BEGIN
	UPDATE isp_OrganisationUsers SET Validated = 0 WHERE OrganisationUserID = @_OrgUserID or OrganisationUserEmail=@UserEmail
	SET @_ReturnValue = 2
	END
	END
	 SELECT @_ReturnValue
	 Return @_ReturnValue
END
GO
