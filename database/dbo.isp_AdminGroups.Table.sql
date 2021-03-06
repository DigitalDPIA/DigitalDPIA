USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_AdminGroups](
	[AdminGroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](255) NULL,
	[GroupContact] [nvarchar](1000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ContractEndDate] [datetime] NULL,
	[EmailAddress] [nvarchar](255) NULL,
	[Address] [nvarchar](1000) NULL,
	[Telephone] [nvarchar](50) NULL,
	[RegionID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[OrganisationLicences] [int] NOT NULL,
 CONSTRAINT [PK_isp_AdminGroups] PRIMARY KEY CLUSTERED 
(
	[AdminGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_AdminGroups] ADD  CONSTRAINT [DF_isp_AdminGroups_CreatedDate]  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[isp_AdminGroups] ADD  CONSTRAINT [DF_isp_AdminGroups_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[isp_AdminGroups] ADD  CONSTRAINT [DF_isp_AdminGroups_OrganisationLicences]  DEFAULT ((1000)) FOR [OrganisationLicences]
GO
