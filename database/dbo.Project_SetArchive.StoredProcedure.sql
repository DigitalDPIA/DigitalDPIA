USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  	Michael Georgiades
-- Create date: 21/02/2019
-- Description:	Archives a DPIA Project
-- =============================================
CREATE PROCEDURE [dbo].[Project_SetArchive]
@SummaryID int,
@ArchivedByID uniqueidentifier
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
        SAVE TRANSACTION Project_SetArchive;
	
	
	UPDATE dpia_Projects

		SET  PLastModifiedID= @ArchivedByID,
		PLastModifiedDate = GETUTCDATE(),
		PArchivedByID = @ArchivedByID,
		PArchivedDate = GETUTCDATE()
		WHERE ProjectID = @SummaryID

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
      ROLLBACK TRANSACTION Project_SetArchive;
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
