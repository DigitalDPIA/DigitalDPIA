USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isg_pl_NewsItems](
	[NewsItemID] [int] IDENTITY(1,1) NOT NULL,
	[AdminGroupID] [int] NOT NULL,
	[PostedByUsername] [nvarchar](100) NOT NULL,
	[PostedDate] [datetime] NOT NULL,
	[NewsTitle] [nvarchar](500) NOT NULL,
	[NewsSubtitle] [nvarchar](500) NULL,
	[NewsContent] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_isg_pl_NewsItems] PRIMARY KEY CLUSTERED 
(
	[NewsItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[isg_pl_NewsItems] ADD  CONSTRAINT [DF_isg_pl_NewsItems_AdminGroupID]  DEFAULT ((0)) FOR [AdminGroupID]
GO
ALTER TABLE [dbo].[isg_pl_NewsItems] ADD  CONSTRAINT [DF_isg_pl_NewsItems_PostedDate]  DEFAULT (getdate()) FOR [PostedDate]
GO
ALTER TABLE [dbo].[isg_pl_NewsItems] ADD  CONSTRAINT [DF_isg_pl_NewsItems_Active]  DEFAULT ((1)) FOR [Active]
GO
