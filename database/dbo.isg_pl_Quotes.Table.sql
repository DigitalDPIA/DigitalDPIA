USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isg_pl_Quotes](
	[QuoteID] [int] IDENTITY(1,1) NOT NULL,
	[QuoteText] [nvarchar](1000) NULL,
	[QuoteAttribution] [nvarchar](255) NULL,
	[QuoteFaceURL] [nvarchar](500) NULL,
	[QuoteSourceURL] [nvarchar](500) NULL,
	[AdminGroupID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[OrderByNumber] [int] NOT NULL,
 CONSTRAINT [PK_isg_pl_Quotes] PRIMARY KEY CLUSTERED 
(
	[QuoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isg_pl_Quotes] ADD  CONSTRAINT [DF_isg_pl_Quotes_AdminGroupID]  DEFAULT ((1)) FOR [AdminGroupID]
GO
ALTER TABLE [dbo].[isg_pl_Quotes] ADD  CONSTRAINT [DF_isg_pl_Quotes_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[isg_pl_Quotes] ADD  CONSTRAINT [DF_isg_pl_Quotes_QuoteOrderNumber]  DEFAULT ((0)) FOR [OrderByNumber]
GO
