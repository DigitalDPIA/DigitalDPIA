USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 01/05/2019
-- Description:	Add file to file table and return ID
-- =============================================
CREATE PROCEDURE [dbo].[Project_InsertFile]
	@FileName varchar(100),
	@FileType varchar(50),
	@FileSize bigint,
	@FileData varbinary(MAX),
	@OrganisationID int,
	@UserEmail nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @_FileID Int
	IF LEN(@FileName) = 0
	BEGIN
	SET @_FileID = -1
	END
	ELSE
	BEGIN
	INSERT INTO isp_Files
                         (FileName, FileType, FileSize, FileData, OrganisationID, UserEmail)
VALUES        (@FileName,@FileType,@FileSize,@FileData, @OrganisationID, @UserEmail)
SET @_FileID = SCOPE_IDENTITY()
END
insert into isp_audit_file_insert(FileName, FileType, FileSize, FileID, UserEmail)
values (@FileName,@FileType,@FileSize, @_FileID, @UserEmail)
SELECT @_FileID
Return @_FileID
END
GO
