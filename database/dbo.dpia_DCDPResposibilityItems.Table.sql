USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dpia_DCDPResposibilityItems](
	[DataTypeID] [int] IDENTITY(1,1) NOT NULL,
	[DataType] [nvarchar](100) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_dpia_DCDPResposibilityItems] PRIMARY KEY CLUSTERED 
(
	[DataTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dpia_DCDPResposibilityItems] ADD  CONSTRAINT [DF_dpia_DCDPResposibilityItems]  DEFAULT ((1)) FOR [Active]
GO
