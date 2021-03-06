USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 01/05/2019 
-- Description:	Returns a list of files with an associate FileGroupId.
-- =============================================
CREATE PROCEDURE [dbo].[Projects_GetFilesByGroup]
	@FileGroupId as int
AS
BEGIN
SET NOCOUNT ON;

	SELECT f.FileID
		,f.FileName
		,f.FileType
		,f.FileSize
		,f.FileData
		,COALESCE(f.OrganisationID, 0) AS OrganisationID
		,f.UserEmail
		,CASE 
			WHEN f.FileName LIKE N'%.doc%'
				THEN 'icon-file-word'
			WHEN f.FileName LIKE N'%.zip%'
				THEN 'icon-file-zip'
			WHEN f.FileName LIKE N'%.dot%'
				THEN 'icon-file-word'
			WHEN f.FileName LIKE N'%.xls%'
				THEN 'icon-file-excel'
			WHEN f.FileName LIKE N'%.pdf%'
				THEN 'icon-file-pdf'
			WHEN f.FileName LIKE N'%.jpg%'
				THEN 'icon-image'
			WHEN f.FileName LIKE N'%.png%'
				THEN 'icon-image'
			WHEN f.FileName LIKE N'%.bmp%'
				THEN 'icon-image'
			WHEN f.FileName LIKE N'%.gif%'
				THEN 'icon-image'
			WHEN f.FileName LIKE N'%.ppt%'
				THEN 'icon-file-powerpoint'
			ELSE 'icon-file2'
			END AS Type
	FROM isp_FileGroupFiles AS fgf
	INNER JOIN isp_Files AS f ON fgf.FileID = f.FileID
	WHERE (fgf.FileGroupID = @FileGroupID)
	ORDER BY f.FileName,f.FileSize

END
GO
