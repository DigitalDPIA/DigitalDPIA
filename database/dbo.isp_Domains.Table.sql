USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_Domains](
	[DomainID] [int] IDENTITY(1,1) NOT NULL,
	[Domain] [nvarchar](55) NULL,
	[Active] [bit] NOT NULL,
	[ShowInList] [bit] NOT NULL,
 CONSTRAINT [PK_isp_Domains] PRIMARY KEY CLUSTERED 
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_Domains] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[isp_Domains] ADD  CONSTRAINT [DF_isp_Domains_ShowInList]  DEFAULT ((1)) FOR [ShowInList]
GO
