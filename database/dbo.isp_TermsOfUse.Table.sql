USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_TermsOfUse](
	[TOUID] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[TermsHTML] [nvarchar](max) NULL,
	[TermsSummary] [nvarchar](max) NULL,
	[NoticeType] [nvarchar](10) NULL,
 CONSTRAINT [PK_isp_TermsOfUse] PRIMARY KEY CLUSTERED 
(
	[TOUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_TermsOfUse] ADD  CONSTRAINT [DF_isp_TermsOfUse_StartDate]  DEFAULT (getutcdate()) FOR [StartDate]
GO
ALTER TABLE [dbo].[isp_TermsOfUse] ADD  CONSTRAINT [DF_isp_TermsOfUse_NoticeType]  DEFAULT (N'TOU') FOR [NoticeType]
GO
