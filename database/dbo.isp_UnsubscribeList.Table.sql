USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_UnsubscribeList](
	[UnsubscribeID] [int] IDENTITY(1,1) NOT NULL,
	[UnsubscribeEmail] [nvarchar](252) NOT NULL
) ON [PRIMARY]
GO
