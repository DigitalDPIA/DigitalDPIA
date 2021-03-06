USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log_OrganisationInsertError](
	[OrgInsertErrorID] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationName] [nvarchar](255) NULL,
	[OrganisationCategoryID] [int] NULL,
	[OrganisationCategoryOther] [nvarchar](255) NULL,
	[SponsorOrganisationID] [int] NULL,
	[OrganisationAddress] [nvarchar](500) NULL,
	[ISPFirstRegisteredBy] [uniqueidentifier] NULL,
	[UserEmail] [nvarchar](256) NULL,
	[UserName] [nvarchar](256) NULL,
	[UserRoleID] [int] NULL,
	[ICORegNumber] [varchar](50) NULL,
	[FileID] [int] NULL,
	[Longitude] [float] NULL,
	[Latitude] [float] NULL,
	[ContactEmail] [nvarchar](255) NULL,
	[County] [nvarchar](100) NULL,
	[AdminGroupID] [int] NULL,
	[Aliases] [nvarchar](500) NULL,
	[Identifiers] [nvarchar](255) NULL,
	[RegisterByLead] [bit] NULL,
	[ConfirmDuplicateInsert] [bit] NULL,
	[TransactionDate] [datetime] NOT NULL,
 CONSTRAINT [PK_log_OrganisationInsertError] PRIMARY KEY CLUSTERED 
(
	[OrgInsertErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[log_OrganisationInsertError] ADD  CONSTRAINT [DF_log_OrganisationInsertError_TransactionDate]  DEFAULT (getutcdate()) FOR [TransactionDate]
GO
