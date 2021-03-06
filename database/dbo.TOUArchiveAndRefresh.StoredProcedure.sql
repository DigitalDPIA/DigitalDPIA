USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kevin Whittaker
-- Create date: 04/01/2017
-- Description:	Closes any open TOU records and creates a new one.
-- =============================================
CREATE PROCEDURE [dbo].[TOUArchiveAndRefresh]
	-- Add the parameters for the stored procedure here
	@TOUDetail nvarchar(MAX),
	@TOUSummary nvarchar(MAX),
	@NoticeType nvarchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [isp_TermsOfUse] SET [EndDate] = getUTCDate() WHERE (([EndDate] IS NULL) AND (NoticeType = @NoticeType))

	INSERT INTO [isp_TermsOfUse](TermsHTML, TermsSummary, NoticeType)
	VALUES(@TOUDetail, @TOUSummary, @NoticeType)

END

GO
