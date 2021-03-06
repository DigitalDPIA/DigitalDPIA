USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_Sponsorship](
	[SponsorshipID] [int] IDENTITY(1,1) NOT NULL,
	[LeadOrganisationID] [int] NOT NULL,
	[SponsoredOrganisationID] [int] NOT NULL,
	[RequestedBy] [uniqueidentifier] NULL,
	[RequestedOn] [datetime] NULL,
	[AuthorisedBy] [uniqueidentifier] NULL,
	[AuthorisedOn] [datetime] NULL,
	[WithdrawnDate] [datetime] NULL,
	[WithdrawnReason] [nvarchar](max) NULL,
 CONSTRAINT [PK_isp_Sponsorship] PRIMARY KEY CLUSTERED 
(
	[SponsorshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
