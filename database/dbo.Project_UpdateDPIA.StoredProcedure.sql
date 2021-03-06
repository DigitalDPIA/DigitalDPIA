USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  	Michael Georgiades
-- Create date: 06/04/2019
-- Description:	Updates a Projects DPIA Details (Just the Legal section to start with.)
-- =============================================
CREATE PROCEDURE [dbo].[Project_UpdateDPIA]
@ProjectID int,
@PStatusID decimal(19,0),
@DPIALegalQ01 int,
@DPIALegalQ01a int,
@DPIALegalQ01aa int,
@DPIALegalQ01ab int,
@DPIALegalQ01ac int,
@DPIALegalQ01ad int,
@DPIALegalQ01ae int,
@DPIALegalQ01af int,
@DPIALegalQ01acleg nvarchar(500),
@DPIALegalQ01aeleg nvarchar(500),
@DPIALegalQ01aa2 int,
@DPIALegalQ01aa3 int,
@DPIALegalQ02 int,
@DPIALegalQ02aa int,
@DPIALegalQ02ab int,
@DPIALegalQ02ac int,
@DPIALegalQ02ad int,
@DPIALegalQ02ae int,
@DPIALegalQ02af int,
@DPIALegalQ02ag int,
@DPIALegalQ02ah int,
@DPIALegalQ02ai int,
@DPIALegalQ02aga int,
@DPIALegalQ02agb int,
@DPIALegalQ02agc int,
@DPIALegalQ02agd int,
@DPIALegalQ02age int,
@DPIALegalQ02agf int,
@DPIALegalQ02agg int,
@DPIALegalQ02agh int,
@DPIALegalQ02agi int,
@DPIALegalQ02agj int,
@DPIALegalQ02agk int,
@DPIALegalQ02agl int,
@DPIALegalQ02agm int,
@DPIALegalQ02agn int,
@DPIALegalQ02ago int,
@DPIALegalQ02agp int,
@DPIALegalQ02agq int,
@DPIALegalQ02agr int,
@DPIALegalQ02ags int,
@DPIALegalQ02agt int,
@DPIALegalQ02agu int,
@DPIALegalQ02agv int,
@DPIALegalQ02agw int,
@DPIALegalQ03 int,
@DPIALegalQ04 int,
@DPIALegalQ04b int,
@DPIALegalQ01aa1CSV varchar(400),
@DPIALegalQ03aCSV varchar(400),
@DPIALegalQ03bCSV varchar(400),
@DPIALegalQ04aCSV varchar(400),
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
        SAVE TRANSACTION Project_UpdateDPIA;
			BEGIN
				UPDATE dpia_Projects
				SET PStatusID = @PStatusID,
					DPIALegalQ01 = @DPIALegalQ01,
					DPIALegalQ01a = @DPIALegalQ01a,
					DPIALegalQ01aa = @DPIALegalQ01aa,
					DPIALegalQ01ab = @DPIALegalQ01ab,
					DPIALegalQ01ac = @DPIALegalQ01ac,
					DPIALegalQ01ad = @DPIALegalQ01ad,
					DPIALegalQ01ae = @DPIALegalQ01ae,
					DPIALegalQ01af = @DPIALegalQ01af,
					DPIALegalQ01acleg = @DPIALegalQ01acleg,
					DPIALegalQ01aeleg = @DPIALegalQ01aeleg,
					DPIALegalQ01aa2 = @DPIALegalQ01aa2,
					DPIALegalQ01aa3 = @DPIALegalQ01aa3,
					DPIALegalQ02 = @DPIALegalQ02,
					DPIALegalQ02aa = @DPIALegalQ02aa,
					DPIALegalQ02ab = @DPIALegalQ02ab,
					DPIALegalQ02ac = @DPIALegalQ02ac,
					DPIALegalQ02ad = @DPIALegalQ02ad,
					DPIALegalQ02ae = @DPIALegalQ02ae,
					DPIALegalQ02af = @DPIALegalQ02af,
					DPIALegalQ02ag = @DPIALegalQ02ag,
					DPIALegalQ02ah = @DPIALegalQ02ah,
					DPIALegalQ02ai = @DPIALegalQ02ai,
					DPIALegalQ02aga = @DPIALegalQ02aga,
					DPIALegalQ02agb = @DPIALegalQ02agb,
					DPIALegalQ02agc = @DPIALegalQ02agc,
					DPIALegalQ02agd = @DPIALegalQ02agd,
					DPIALegalQ02age = @DPIALegalQ02age,
					DPIALegalQ02agf = @DPIALegalQ02agf,
					DPIALegalQ02agg = @DPIALegalQ02agg,
					DPIALegalQ02agh = @DPIALegalQ02agh,
					DPIALegalQ02agi = @DPIALegalQ02agi,
					DPIALegalQ02agj = @DPIALegalQ02agj,
					DPIALegalQ02agk = @DPIALegalQ02agk,
					DPIALegalQ02agl = @DPIALegalQ02agl,
					DPIALegalQ02agm = @DPIALegalQ02agm,
					DPIALegalQ02agn = @DPIALegalQ02agn,
					DPIALegalQ02ago = @DPIALegalQ02ago,
					DPIALegalQ02agp = @DPIALegalQ02agp,
					DPIALegalQ02agq = @DPIALegalQ02agq,
					DPIALegalQ02agr = @DPIALegalQ02agr,
					DPIALegalQ02ags = @DPIALegalQ02ags,
					DPIALegalQ02agt = @DPIALegalQ02agt,
					DPIALegalQ02agu = @DPIALegalQ02agu,
					DPIALegalQ02agv = @DPIALegalQ02agv,
					DPIALegalQ02agw = @DPIALegalQ02agw,
					DPIALegalQ03 = @DPIALegalQ03,
					DPIALegalQ04 = @DPIALegalQ04,
					DPIALegalQ04b = @DPIALegalQ04b,
					PLastModifiedID = @PLastModifiedID, 
					PLastModifiedDate = GETUTCDATE()
				WHERE ProjectID = @ProjectID		
				SET @_Result = 1

				-- Now insert rows into dpia_InformConsent  for any id in @DPIALegalQ01aa1CSV:
				if LEN(@DPIALegalQ01aa1CSV) > 0
				BEGIN
					INSERT INTO dpia_InformConsent (ProjectID, InformationSharedID)
					SELECT @ProjectID AS ProjectID, ID AS DataAccessorID
					FROM [dbo].[tvfSplitCSV] (@DPIALegalQ01aa1CSV)
					WHERE ID NOT IN (SELECT InformationSharedID FROM dpia_InformConsent WHERE ProjectID = @ProjectID)
				END
				--...and delete any that exist that no longer should:
				DELETE FROM dpia_InformConsent
				WHERE ProjectID = @ProjectID AND InformationSharedID NOT IN (SELECT * FROM [dbo].[tvfSplitCSV] (@DPIALegalQ01aa1CSV))

				-- Now insert rows into dpia_HealthPurpose for any id in @DPIALegalQ03aCSV:
				if LEN(@DPIALegalQ03aCSV) > 0
				BEGIN
					INSERT INTO dpia_HealthPurpose (ProjectID, InformationSharedID)
					SELECT @ProjectID AS ProjectID, ID AS DataAccessorID
					FROM [dbo].[tvfSplitCSV] (@DPIALegalQ03aCSV)
					WHERE ID NOT IN (SELECT InformationSharedID FROM dpia_HealthPurpose WHERE ProjectID = @ProjectID)
				END
				--...and delete any that exist that no longer should:
				DELETE FROM dpia_HealthPurpose
				WHERE ProjectID = @ProjectID AND InformationSharedID NOT IN (SELECT * FROM [dbo].[tvfSplitCSV] (@DPIALegalQ03aCSV))

				-- Now insert rows into dpia_HealthConfResp for any id in @DPIALegalQ03bCSV:
				if LEN(@DPIALegalQ03bCSV) > 0
				BEGIN
					INSERT INTO dpia_HealthConfResp (ProjectID, InformationSharedID)
					SELECT @ProjectID AS ProjectID, ID AS DataAccessorID
					FROM [dbo].[tvfSplitCSV] (@DPIALegalQ03bCSV)
					WHERE ID NOT IN (SELECT InformationSharedID FROM dpia_HealthConfResp WHERE ProjectID = @ProjectID)
				END
				--...and delete any that exist that no longer should:
				DELETE FROM dpia_HealthConfResp
				WHERE ProjectID = @ProjectID AND InformationSharedID NOT IN (SELECT * FROM [dbo].[tvfSplitCSV] (@DPIALegalQ03bCSV))

				-- Now insert rows into dpia_DCDPResposibility for any id in @DPIALegalQ04aCSV:
				if LEN(@DPIALegalQ04aCSV) > 0
				BEGIN
					INSERT INTO dpia_DCDPResposibility (ProjectID, InformationSharedID)
					SELECT @ProjectID AS ProjectID, ID AS DataAccessorID
					FROM [dbo].[tvfSplitCSV] (@DPIALegalQ04aCSV)
					WHERE ID NOT IN (SELECT InformationSharedID FROM dpia_DCDPResposibility WHERE ProjectID = @ProjectID)
				END
				--...and delete any that exist that no longer should:
				DELETE FROM dpia_DCDPResposibility
				WHERE ProjectID = @ProjectID AND InformationSharedID NOT IN (SELECT * FROM [dbo].[tvfSplitCSV] (@DPIALegalQ04aCSV))

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
      ROLLBACK TRANSACTION Project_UpdateDPIA;
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
