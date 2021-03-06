USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dpia_PStatus](
	[PStatusID] [decimal](19, 0) IDENTITY(1,1) NOT NULL,
	[PStatusText] [nvarchar](50) NULL,
 CONSTRAINT [PK_dpia_PStatus_1] PRIMARY KEY CLUSTERED 
(
	[PStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dpia_PStatus]  WITH CHECK ADD  CONSTRAINT [FK_dpia_PStatus_dpia_PStatus1] FOREIGN KEY([PStatusID])
REFERENCES [dbo].[dpia_PStatus] ([PStatusID])
GO
ALTER TABLE [dbo].[dpia_PStatus] CHECK CONSTRAINT [FK_dpia_PStatus_dpia_PStatus1]
GO
