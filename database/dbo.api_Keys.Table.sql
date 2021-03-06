USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[api_Keys](
	[APIKeyID] [int] IDENTITY(1,1) NOT NULL,
	[APIKeyGUID] [uniqueidentifier] NOT NULL,
	[Active] [bit] NOT NULL,
	[OrganisationName] [nvarchar](255) NULL,
	[ContactEmail] [nvarchar](255) NULL,
	[IPApproved] [nvarchar](16) NULL,
	[DFDTransferSystemPlatformID] [int] NOT NULL,
 CONSTRAINT [PK_api_Keys] PRIMARY KEY CLUSTERED 
(
	[APIKeyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[api_Keys] ADD  CONSTRAINT [DF_api_Keys_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[api_Keys] ADD  CONSTRAINT [DF_api_Keys_DFDTransferSystemPlatformID]  DEFAULT ((0)) FOR [DFDTransferSystemPlatformID]
GO
