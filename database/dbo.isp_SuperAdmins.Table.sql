USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_SuperAdmins](
	[SuperAdminID] [int] IDENTITY(1,1) NOT NULL,
	[SuperAdminEmail] [nvarchar](255) NOT NULL,
	[Active] [bit] NOT NULL,
	[ContentManager] [bit] NOT NULL,
	[CentralSA] [bit] NOT NULL,
	[AdminGroupID] [int] NOT NULL,
 CONSTRAINT [PK_isp_SuperAdmins] PRIMARY KEY CLUSTERED 
(
	[SuperAdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_SuperAdmins] ADD  CONSTRAINT [DF_isp_SuperAdmins_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[isp_SuperAdmins] ADD  CONSTRAINT [DF_isp_SuperAdmins_ContentManager]  DEFAULT ((0)) FOR [ContentManager]
GO
ALTER TABLE [dbo].[isp_SuperAdmins] ADD  DEFAULT ((0)) FOR [CentralSA]
GO
ALTER TABLE [dbo].[isp_SuperAdmins] ADD  CONSTRAINT [DF_isp_SuperAdmins_AdminGroupID]  DEFAULT ((0)) FOR [AdminGroupID]
GO
