USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  	Michael Georgiades
-- Create date: 17/04/2019
-- Description:	Updates a DPIA Projects screening questions (Version 2 of the screening questions)
-- =============================================
CREATE PROCEDURE [dbo].[Project_UpdateScreeningV2]
@ProjectID int,
@PStatusID decimal(19,0),
@PAssignedIGLeadID uniqueidentifier,
@PAssignedIGLeadDate datetime,
@PSQV201a int,
@PSQV201b int,
@PSQV201c int,
@PSQV201d int,
@PSQV201e int,
@PSQV201f int,
@PSQV201g int,
@PSQV202a int,
@PSQV202b int,
@PSQV202c int,
@PSQV202d int,
@PSQV202e int,
@PSQV202f int,
@PSQV203a int,
@PSQV203b int,
@PSQV203c int,
@PSQV203d int,
@PSQV203e int,
@PSQV203f int,
@PSQV203g int,
@PSQV203h int,
@PSQV204a int,
@PSQV204b int,
@PSQV204c int,
@PSQV204d int,
@PSQV204e int,
@PSQV204f int,
@PSQV204g int,
@PSQV204h int,
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
        SAVE TRANSACTION Project_UpdateScreeningV2;
		IF @PStatusID = 5
			BEGIN
				UPDATE dpia_Projects
				SET PStatusID = @PStatusID,
					PAssignedToID= @PAssignedIGLeadID, 
					PAssignedToDate= @PAssignedIGLeadDate,	
					PAssignedIGLeadID = @PAssignedIGLeadID, 
					PAssignedIGLeadDate = @PAssignedIGLeadDate,	
					PSQV201a = @PSQV201a,
					PSQV201b = @PSQV201b,
					PSQV201c = @PSQV201c,
					PSQV201d = @PSQV201d,
					PSQV201e = @PSQV201e,
					PSQV201f = @PSQV201f,
					PSQV201g = @PSQV201g,
					PSQV202a = @PSQV202a,
					PSQV202b = @PSQV202b,
					PSQV202c = @PSQV202c,
					PSQV202d = @PSQV202d,
					PSQV202e = @PSQV202e,
					PSQV202f = @PSQV202f,
					PSQV203a = @PSQV203a,
					PSQV203b = @PSQV203b,
					PSQV203c = @PSQV203c,
					PSQV203d = @PSQV203d,
					PSQV203e = @PSQV203e,
					PSQV203f = @PSQV203f,
					PSQV203g = @PSQV203g,
					PSQV203h = @PSQV203h,
					PSQV204a = @PSQV204a,
					PSQV204b = @PSQV204b,
					PSQV204c = @PSQV204c,
					PSQV204d = @PSQV204d,
					PSQV204e = @PSQV204e,
					PSQV204f = @PSQV204f,
					PSQV204g = @PSQV204g,
					PSQV204h = @PSQV204h,
					PLastModifiedID = @PLastModifiedID, 
					PLastModifiedDate = GETUTCDATE()
				WHERE ProjectID = @ProjectID		
				SET @_Result = 1
			END
		ELSE
			BEGIN
				UPDATE dpia_Projects
				SET PStatusID = @PStatusID,
					PSQV201a = @PSQV201a,
					PSQV201b = @PSQV201b,
					PSQV201c = @PSQV201c,
					PSQV201d = @PSQV201d,
					PSQV201e = @PSQV201e,
					PSQV201f = @PSQV201f,
					PSQV201g = @PSQV201g,
					PSQV202a = @PSQV202a,
					PSQV202b = @PSQV202b,
					PSQV202c = @PSQV202c,
					PSQV202d = @PSQV202d,
					PSQV202e = @PSQV202e,
					PSQV202f = @PSQV202f,
					PSQV203a = @PSQV203a,
					PSQV203b = @PSQV203b,
					PSQV203c = @PSQV203c,
					PSQV203d = @PSQV203d,
					PSQV203e = @PSQV203e,
					PSQV203f = @PSQV203f,
					PSQV203g = @PSQV203g,
					PSQV203h = @PSQV203h,
					PSQV204a = @PSQV204a,
					PSQV204b = @PSQV204b,
					PSQV204c = @PSQV204c,
					PSQV204d = @PSQV204d,
					PSQV204e = @PSQV204e,
					PSQV204f = @PSQV204f,
					PSQV204g = @PSQV204g,
					PSQV204h = @PSQV204h,
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
      ROLLBACK TRANSACTION Project_UpdateScreeningV2;
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
