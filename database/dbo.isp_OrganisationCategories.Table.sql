USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_OrganisationCategories](
	[OrganisationCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationCategory] [nvarchar](255) NOT NULL,
	[Active] [bit] NOT NULL,
	[ODSIdentified] [bit] NOT NULL,
 CONSTRAINT [PK_isp_OrganisationCategories] PRIMARY KEY CLUSTERED 
(
	[OrganisationCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_OrganisationCategories] ADD  CONSTRAINT [DF_isp_OrganisationCategories_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[isp_OrganisationCategories] ADD  CONSTRAINT [DF_isp_OrganisationCategories_ODSIdentified]  DEFAULT ((0)) FOR [ODSIdentified]
GO
