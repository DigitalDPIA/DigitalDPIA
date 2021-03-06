USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_SANotifications](
	[SANotificationID] [int] IDENTITY(1,1) NOT NULL,
	[SubjectLine] [nvarchar](100) NOT NULL,
	[BodyHTML] [nvarchar](max) NULL,
	[ExpiryDate] [datetime] NULL,
	[DateAdded] [datetime] NOT NULL,
 CONSTRAINT [PK_isp_SANotifications] PRIMARY KEY CLUSTERED 
(
	[SANotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_SANotifications] ADD  CONSTRAINT [DF_isp_SANotifications_DateAdded]  DEFAULT (getutcdate()) FOR [DateAdded]
GO
