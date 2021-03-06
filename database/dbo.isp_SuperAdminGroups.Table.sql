USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_SuperAdminGroups](
	[SuperAdminGroupID] [int] IDENTITY(1,1) NOT NULL,
	[SuperAdminID] [int] NOT NULL,
	[AdminGroupID] [int] NOT NULL,
 CONSTRAINT [PK_isp_SuperAdminGroups] PRIMARY KEY CLUSTERED 
(
	[SuperAdminGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_SuperAdminGroups]  WITH CHECK ADD  CONSTRAINT [FK_isp_SuperAdminGroups_isp_AdminGroups] FOREIGN KEY([AdminGroupID])
REFERENCES [dbo].[isp_AdminGroups] ([AdminGroupID])
GO
ALTER TABLE [dbo].[isp_SuperAdminGroups] CHECK CONSTRAINT [FK_isp_SuperAdminGroups_isp_AdminGroups]
GO
ALTER TABLE [dbo].[isp_SuperAdminGroups]  WITH CHECK ADD  CONSTRAINT [FK_isp_SuperAdminGroups_isp_SuperAdmins] FOREIGN KEY([SuperAdminID])
REFERENCES [dbo].[isp_SuperAdmins] ([SuperAdminID])
GO
ALTER TABLE [dbo].[isp_SuperAdminGroups] CHECK CONSTRAINT [FK_isp_SuperAdminGroups_isp_SuperAdmins]
GO
