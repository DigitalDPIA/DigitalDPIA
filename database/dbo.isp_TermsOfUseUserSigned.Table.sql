USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_TermsOfUseUserSigned](
	[TOUSignedID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[LastSigned] [datetime] NOT NULL,
 CONSTRAINT [PK_isp_TermsOfUseUserSigned] PRIMARY KEY CLUSTERED 
(
	[TOUSignedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_TermsOfUseUserSigned] ADD  CONSTRAINT [DF_isp_TermsOfUseUserSigned_LastSigned]  DEFAULT (getutcdate()) FOR [LastSigned]
GO
