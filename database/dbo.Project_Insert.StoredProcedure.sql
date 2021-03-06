USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  	Michael Georgiades
-- Create date: 27/02/2019
-- Description:	Inserts a DPIA Project
-- Modified date: 04/04/2019 Set appropriate non-nullable DPIA Legal fields to 0
-- Modified date: 05/04/2019 Set DPIALegalQ01acleg and DPIALegalQ01aeleg to non Null
-- =============================================
CREATE PROCEDURE [dbo].[Project_Insert]
@PName nvarchar(255),
@PDescription nvarchar(2500),
@PStatusID decimal (19,0),
@POrganisationID int,
@PAssignedIGLeadID uniqueidentifier,
@PAssignedIGLeadDate datetime,
@PAssignedInfAssetOwnerID uniqueidentifier,
@PAssignedInfAssetOwnerDate datetime,
@PAssignedDPOID uniqueidentifier,
@PAssignedDPODate datetime,
@PAssignedICOID uniqueidentifier,
@PAssignedICODate datetime,
@PCreatedByID uniqueidentifier
	
AS
BEGIN
  SET NOCOUNT ON;
  Declare @_Result Int = 0
  Declare @trancount int;
  SET @trancount = @@trancount;

  --Check that a flow with the same DFName (idenitifier) doesn't already exist:

If exists(SELECT ProjectID FROM dpia_Projects WHERE PName = @PName AND POrganisationID = @POrganisationID AND PCreatedByID = @PCreatedByID)
BEGIN
SET @_Result = -10
GoTo OnExit
END

BEGIN TRY
	IF @trancount = 0
      BEGIN TRANSACTION
      ELSE
        SAVE TRANSACTION Project_Insert;
	
	
	INSERT INTO dpia_Projects (PName, PDescription, PStatusID, PStatusDate, POrganisationID, PAssignedToID, PAssignedToDate, PAssignedIGLeadID, PAssignedIGLeadDate,
		PAssignedInfAssetOwnerID, PAssignedInfAssetOwnerDate, PAssignedDPOID, PAssignedDPODate, PAssignedICOID, PAssignedICODate,
		PCreatedByID, PCreatedDate,
		DPIALegalQ01aa, DPIALegalQ01ab, DPIALegalQ01ac, DPIALegalQ01ad, DPIALegalQ01ae, DPIALegalQ01af,
		DPIALegalQ01acleg, DPIALegalQ01aeleg,
		DPIALegalQ02aa, DPIALegalQ02ab, DPIALegalQ02ac, DPIALegalQ02ad, DPIALegalQ02ae, DPIALegalQ02af, DPIALegalQ02ag, DPIALegalQ02ah, DPIALegalQ02ai,
		DPIALegalQ02aga, DPIALegalQ02agb, DPIALegalQ02agc, DPIALegalQ02agd, DPIALegalQ02age, DPIALegalQ02agf, DPIALegalQ02agg, DPIALegalQ02agh, DPIALegalQ02agi, DPIALegalQ02agj, 
		DPIALegalQ02agk, DPIALegalQ02agl, DPIALegalQ02agm, DPIALegalQ02agn, DPIALegalQ02ago, DPIALegalQ02agp, DPIALegalQ02agq, DPIALegalQ02agr, DPIALegalQ02ags, DPIALegalQ02agt, 
		DPIALegalQ02agu, DPIALegalQ02agv, DPIALegalQ02agw)
	VALUES (@PName, @PDescription, @PStatusID, GETUTCDATE(), @POrganisationID, @PCreatedByID, GETUTCDATE(), @PAssignedIGLeadID, @PAssignedIGLeadDate,
		@PAssignedInfAssetOwnerID, @PAssignedInfAssetOwnerDate, @PAssignedDPOID, @PAssignedDPODate, @PAssignedICOID, @PAssignedICODate,
		@PCreatedByID, GETUTCDATE(),
		0,0,0,0,0,0,
		'','',
		0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0)
	SET @_Result = SCOPE_IDENTITY() 

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
      ROLLBACK TRANSACTION Project_Insert;
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
