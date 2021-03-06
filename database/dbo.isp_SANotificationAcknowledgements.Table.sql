USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_SANotificationAcknowledgements](
	[AcknolwedgementID] [int] IDENTITY(1,1) NOT NULL,
	[SANotificationID] [int] NOT NULL,
	[UserEmail] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_isp_SANotificationAcknowledgements] PRIMARY KEY CLUSTERED 
(
	[AcknolwedgementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
