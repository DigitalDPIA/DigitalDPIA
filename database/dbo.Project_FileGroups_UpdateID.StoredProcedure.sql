USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  	Michael Georgiades
-- Create date: 01/05/2019
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Project_FileGroups_UpdateID]
@ID int,
@FileGroupID int
	
AS
BEGIN
  SET NOCOUNT ON;
  Declare @_Result Int = 0
  Declare @trancount int;
  SET @trancount = @@trancount;

BEGIN
SET @_Result = -10
GoTo OnExit
END

BEGIN TRY
	IF @trancount = 0
      BEGIN TRANSACTION
      ELSE
        SAVE TRANSACTION Project_FileGroups_UpdateID;
	
		UPDATE isp_FileGroups
		SET ID = @ID
		WHERE (FileGroupID = @FileGroupID)
	
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
      ROLLBACK TRANSACTION Project_FileGroups_UpdateID;
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
