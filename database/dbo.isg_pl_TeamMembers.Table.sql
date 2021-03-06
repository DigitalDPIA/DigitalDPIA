USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isg_pl_TeamMembers](
	[TeamMemberID] [int] IDENTITY(1,1) NOT NULL,
	[AdminGroupID] [int] NOT NULL,
	[TMName] [nvarchar](100) NULL,
	[JobTitle] [nvarchar](100) NULL,
	[LinkedInURL] [nvarchar](255) NULL,
	[TwitterURL] [nvarchar](255) NULL,
	[Active] [bit] NOT NULL,
	[OrderByNumber] [int] NOT NULL,
	[PortraitURL] [nvarchar](255) NULL,
 CONSTRAINT [PK_isg_pl_TeamMembers] PRIMARY KEY CLUSTERED 
(
	[TeamMemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isg_pl_TeamMembers] ADD  CONSTRAINT [DF_isg_pl_TeamMembers_AdminGroupID]  DEFAULT ((0)) FOR [AdminGroupID]
GO
ALTER TABLE [dbo].[isg_pl_TeamMembers] ADD  CONSTRAINT [DF_isg_pl_TeamMembers_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[isg_pl_TeamMembers] ADD  CONSTRAINT [DF_isg_pl_TeamMembers_SortOrderNumber]  DEFAULT ((0)) FOR [OrderByNumber]
GO
