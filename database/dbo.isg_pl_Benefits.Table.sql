USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isg_pl_Benefits](
	[BenefitID] [int] IDENTITY(1,1) NOT NULL,
	[AdminGroupID] [int] NOT NULL,
	[BenefitTitle] [nvarchar](255) NULL,
	[BenefitDesc] [nvarchar](max) NULL,
	[BenefitQuote] [nvarchar](1000) NULL,
	[BQuoteAttributedTo] [nvarchar](255) NULL,
	[AddedDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
	[AddedByEmail] [nvarchar](255) NULL,
	[OrderByNumber] [int] NOT NULL,
	[QuoteImageURL] [nvarchar](500) NULL,
	[ScreenImageURL] [nvarchar](500) NULL,
	[ScreenImageCaption] [nvarchar](255) NULL,
	[VideoLinkURL] [nvarchar](255) NULL,
 CONSTRAINT [PK_isg_pl_Benefits] PRIMARY KEY CLUSTERED 
(
	[BenefitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[isg_pl_Benefits] ADD  CONSTRAINT [DF_isg_pl_Benefits_AdminGroupID]  DEFAULT ((1)) FOR [AdminGroupID]
GO
ALTER TABLE [dbo].[isg_pl_Benefits] ADD  CONSTRAINT [DF_isg_pl_Benefits_AddedDate]  DEFAULT (getdate()) FOR [AddedDate]
GO
ALTER TABLE [dbo].[isg_pl_Benefits] ADD  CONSTRAINT [DF_isg_pl_Benefits_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[isg_pl_Benefits] ADD  CONSTRAINT [DF_isg_pl_Benefits_OrderByNumber]  DEFAULT ((0)) FOR [OrderByNumber]
GO
ALTER TABLE [dbo].[isg_pl_Benefits] ADD  CONSTRAINT [DF_isg_pl_Benefits_QuoteImageURL]  DEFAULT (N'images/anonuser.png') FOR [QuoteImageURL]
GO
