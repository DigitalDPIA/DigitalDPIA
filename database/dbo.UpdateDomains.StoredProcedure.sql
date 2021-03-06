USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Georgiades
-- Create date: 22/11/2018
-- Description:	Updates Domain record
-- =============================================
CREATE PROCEDURE [dbo].[UpdateDomains] 
	@DomainID int,
	@Domain nvarchar(255),
	@Active bit,
	@ShowInList bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	Update isp_Domains SET Domain=@Domain, Active=@Active, ShowInList=@ShowInList
	WHERE DomainID = @DomainID
END
GO
