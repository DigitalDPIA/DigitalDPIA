USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 28/05/2015
-- Description:	Deletes a file from the file table and references to it from the FileGroupFiles tables
-- =============================================
CREATE PROCEDURE [dbo].[File_Delete]
	-- Add the parameters for the stored procedure here
	@FileID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM isp_FileGroupFiles WHERE FileID = @FileID
DELETE FROM isp_Files WHERE FileID = @FileID
insert into isp_audit_file_delete(FileID) Values(@FileID)
END


/****** Object:  StoredProcedure [dbo].[InsertFile]    Script Date: 06/11/2017 14:41:03 ******/
SET ANSI_NULLS ON
GO
