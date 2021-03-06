USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 18/07/2017
-- Description:	Checks if licence limit has been reached for organisation admin group and assigns licence to organisation if not.
-- Return codes:	 1: licence successfully assigned / removed
--					-1: no admin group for organisation
--					-2: licence limit reached
--					-3: Admin group inactive
--					-4: Admin group end date passed
-- =============================================
CREATE PROCEDURE [dbo].[AssignAGLicence]
	-- Add the parameters for the stored procedure here
	@OrganisationID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @_ReturnVal as Integer
	Declare @_LicenceCount as Integer
	Declare @_LicenceLimit as Integer
	Declare @_AGActive as bit
	Declare @_AGEndDate as Datetime
	Declare @_AdminGroup as Integer
	Declare @_HasLicence as Bit
	Set @_ReturnVal = 0
	Select @_HasLicence = LicenceGranted from isp_Organisations WHERE OrganisationID = @OrganisationID
	if @_HasLicence = 1
	begin
	Update isp_Organisations SET LicenceGranted = 0 WHERE OrganisationID = @OrganisationID
	Set @_ReturnVal = 1
	Goto OnExit
	end
	SELECT @_AdminGroup = AdminGroupID FROM isp_Organisations WHERE OrganisationID = @OrganisationID
	IF @_AdminGroup < 1
	Begin
	Set @_ReturnVal = -1
	Goto OnExit
	end
	SELECT @_LicenceLimit = OrganisationLicences, @_AGActive= Active, @_AGEndDate = COALESCE(ContractEndDate, DateAdd(year, 1, getDate())) FROM isp_AdminGroups WHERE AdminGroupID = @_AdminGroup
	if @_AGActive = 0
	begin
	set @_ReturnVal = -3
	Goto OnExit
	end
	if @_AGEndDate <= getDate()
	begin
	set @_ReturnVal = -4
	Goto OnExit
	end
	SELECT @_LicenceCount = COUNT(OrganisationID) FROM isp_Organisations WHERE InactivatedDate IS NULL AND AdminGroupID = @_AdminGroup AND LicenceGranted = 1
	If @_LicenceCount >= @_LicenceLimit
	begin
	set @_ReturnVal = -2
	Goto OnExit
	end
	Update isp_Organisations SET LicenceGranted = 1 WHERE OrganisationID = @OrganisationID
	Set @_ReturnVal = 1

	OnExit:
	begin
	SELECT @_ReturnVal
	Return @_ReturnVal
	end

END
GO
