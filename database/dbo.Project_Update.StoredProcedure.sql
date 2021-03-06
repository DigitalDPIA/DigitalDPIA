USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  	Michael Georgiades
-- Create date: 06/03/2019
-- Description:	Updates a DPIA Project
-- =============================================
CREATE PROCEDURE [dbo].[Project_Update]
@ProjectID int,
@PName nvarchar(255),
@PDescription nvarchar(2500),
@PAssignedIGLeadID uniqueidentifier,
@PAssignedIGLeadDate datetime,
@PAssignedInfAssetOwnerID uniqueidentifier,
@PAssignedInfAssetOwnerDate datetime,
@PAssignedDPOID uniqueidentifier,
@PAssignedDPODate datetime,
@PAssignedICOID uniqueidentifier,
@PAssignedICODate datetime,
@PLastModifiedID uniqueidentifier
	
AS
BEGIN
  SET NOCOUNT ON;
  Declare @_Result Int = 0
  Declare @trancount int;
  SET @trancount = @@trancount;

  --Check that a project with the same PName (idenitifier) doesn't already exist:

If exists(SELECT ProjectID FROM dpia_Projects WHERE PName = @PName AND ProjectID <> @ProjectID)
BEGIN
SET @_Result = -10
GoTo OnExit
END

BEGIN TRY
	IF @trancount = 0
      BEGIN TRANSACTION
      ELSE
        SAVE TRANSACTION Project_Update;
	
		UPDATE dpia_Projects
		SET PName = @PName,
			PDescription = @PDescription, 
			PAssignedIGLeadID = @PAssignedIGLeadID, 
			PAssignedIGLeadDate = @PAssignedIGLeadDate,	
			PAssignedInfAssetOwnerID = @PAssignedInfAssetOwnerID, 
			PAssignedInfAssetOwnerDate = @PAssignedInfAssetOwnerDate,
			PAssignedDPOID = @PAssignedDPOID, 
			PAssignedDPODate = @PAssignedDPODate,
			PAssignedICOID = @PAssignedICOID, 
			PAssignedICODate = @PAssignedICODate,
			PLastModifiedID = @PLastModifiedID, 
			PLastModifiedDate = GETUTCDATE()
		WHERE ProjectID = @ProjectID		
		SET @_Result = 1

	lbexit:
      IF @trancount = 0
      COMMIT;
END TRY

BEGIN CATCH
    DECLARE @error int,
            @message varchar(4000),
            @xstate int;

    SELECT
      @error = ERROR_NUMBER(),
      @message = ERROR_MESSAGE(),
      @xstate = XACT_STATE();

    IF @xstate = -1
      ROLLBACK;
    IF @xstate = 1 AND @trancount = 0
      ROLLBACK
    IF @xstate = 1 AND @trancount > 0
      ROLLBACK TRANSACTION Project_Update;
	IF @@TRANCOUNT>0 
	BEGIN
		set @_Result = -1
		goto OnExit
	END

END CATCH

OnExit:

SELECT @_Result
Return @_Result
END
GO
