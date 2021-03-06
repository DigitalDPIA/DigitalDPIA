USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 05/07/2018
-- Description:	Updates Resources
-- =============================================
CREATE PROCEDURE [dbo].[isp_Resources_Update]
	-- Add the parameters for the stored procedure here
	@ResourceName nvarchar(100),
	@URL nvarchar(255),
	@Type nvarchar(20),
	@ResourceDescription nvarchar(MAX),
	@PreLogin bit,
	@AdminGroupID int,
	@RequiresFullLicence bit,
	@Category nvarchar(100),
	@Original_ResourceID int
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @Updated as DateTime
	SELECT @Updated = Updated  FROM isp_Resources WHERE ResourceID = @Original_ResourceID
	If ((Select [URL] FROM isp_Resources WHERE ResourceID = @Original_ResourceID) <> @URL)
	Begin
	SET @Updated = getDate()
	End
    -- Insert statements for procedure here
	UPDATE       isp_Resources
SET                ResourceName = @ResourceName, Updated = @Updated, URL = @URL, Type = @Type, ResourceDescription = @ResourceDescription, ReportedBroken = 0, PreLogin = @PreLogin, AdminGroupID = @AdminGroupID, 
                         RequiresFullLicence = @RequiresFullLicence, Category = @Category
WHERE        (ResourceID = @Original_ResourceID)
END
GO
