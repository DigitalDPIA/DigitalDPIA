USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 01/05/2019 
-- Description:	Returns a list of files with an associate FileGroupType and ID.
-- =============================================
CREATE PROCEDURE [dbo].[Projects_GetFilesByGroupTypeAndID]
	@GroupType as nvarchar(20),
	@ID as int
AS
BEGIN
SET NOCOUNT ON;

	SELECT CASE 
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
		,f.FileData
		,f.FileID
		,f.FileName
		,f.FileSize
		,f.FileType
		,f.UserEmail
		,COALESCE(f.OrganisationID, 0) AS OrganisationID
	FROM isp_FileGroupFiles AS fgf
	INNER JOIN isp_Files AS f ON fgf.FileID = f.FileID
	INNER JOIN isp_FileGroups ON fgf.FileGroupID = isp_FileGroups.FileGroupID
	WHERE (isp_FileGroups.GroupType = @GroupType)
		AND (isp_FileGroups.ID = @ID)
	ORDER BY f.FileName ,f.FileSize

END
GO
