USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  	Michael Georgiades
-- Create date: 13/03/2019
-- Description:	Updates a DPIA Projects screening questions
-- Create date: 27/03/2019 Changed to updated selected IG Lead, and set Assigned User When StatusID=5(IG Review)
-- =============================================
CREATE PROCEDURE [dbo].[Project_UpdateScreening]
@ProjectID int,
@PStatusID decimal(19,0),
@PAssignedIGLeadID uniqueidentifier,
@PAssignedIGLeadDate datetime,
@PSQ01 int,
@PSQ02 int,
@PSQ03 int,
@PSQ04 int,
@PSQ05 int,
@PSQ06 int,
@PSQ07 int,
@PSQ08 int,
@PSQ09 int,
@PSQ10 int,
@PSQ11 int,
@PSQ12 int,
@PSQ13 int,
@PSQ14 int,
@PSQ15 int,
@PSQ16 int,
@PSQ17 int,
@PSQ18 int,
@PLastModifiedID uniqueidentifier
	
AS
BEGIN
  SET NOCOUNT ON;
  Declare @_Result Int = 0
  Declare @trancount int;
  SET @trancount = @@trancount;

BEGIN TRY
	IF @trancount = 0
      BEGIN TRANSACTION
      ELSE
        SAVE TRANSACTION Project_UpdateScreening;
		IF @PStatusID = 5
			BEGIN
				UPDATE dpia_Projects
				SET PStatusID = @PStatusID,
					PAssignedToID= @PAssignedIGLeadID, 
					PAssignedToDate= @PAssignedIGLeadDate,	
					PAssignedIGLeadID = @PAssignedIGLeadID, 
					PAssignedIGLeadDate = @PAssignedIGLeadDate,	
					PSQ01 = @PSQ01,
					PSQ02 = @PSQ02,
					PSQ03 = @PSQ03,
					PSQ04 = @PSQ04,
					PSQ05 = @PSQ05,
					PSQ06 = @PSQ06,
					PSQ07 = @PSQ07,
					PSQ08 = @PSQ08,
					PSQ09 = @PSQ09,
					PSQ10 = @PSQ10,
					PSQ11 = @PSQ11,
					PSQ12 = @PSQ12,
					PSQ13 = @PSQ13,
					PSQ14 = @PSQ14,
					PSQ15 = @PSQ14,
					PSQ16 = @PSQ16,
					PSQ17 = @PSQ17,
					PSQ18 = @PSQ18,
					PLastModifiedID = @PLastModifiedID, 
					PLastModifiedDate = GETUTCDATE()
				WHERE ProjectID = @ProjectID		
				SET @_Result = 1
			END
		ELSE
			BEGIN
				UPDATE dpia_Projects
				SET PStatusID = @PStatusID,
					PSQ01 = @PSQ01,
					PSQ02 = @PSQ02,
					PSQ03 = @PSQ03,
					PSQ04 = @PSQ04,
					PSQ05 = @PSQ05,
					PSQ06 = @PSQ06,
					PSQ07 = @PSQ07,
					PSQ08 = @PSQ08,
					PSQ09 = @PSQ09,
					PSQ10 = @PSQ10,
					PSQ11 = @PSQ11,
					PSQ12 = @PSQ12,
					PSQ13 = @PSQ13,
					PSQ14 = @PSQ14,
					PSQ15 = @PSQ14,
					PSQ16 = @PSQ16,
					PSQ17 = @PSQ17,
					PSQ18 = @PSQ18,
					PLastModifiedID = @PLastModifiedID, 
					PLastModifiedDate = GETUTCDATE()
				WHERE ProjectID = @ProjectID		
				SET @_Result = 1
			END

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
      ROLLBACK TRANSACTION Project_UpdateScreening;
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
