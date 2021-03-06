USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_ScheduleThrees](
	[ScheduleThreeID] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleThreeText] [nvarchar](100) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_isp_ScheduleThrees] PRIMARY KEY CLUSTERED 
(
	[ScheduleThreeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_ScheduleThrees] ADD  DEFAULT ((1)) FOR [Active]
GO
