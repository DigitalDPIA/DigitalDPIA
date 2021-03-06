USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_Organisations](
	[OrganisationID] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationName] [nvarchar](255) NOT NULL,
	[OrganisationTypeID] [int] NOT NULL,
	[SponsorOrganisationID] [int] NULL,
	[OrganisationAddress] [nvarchar](500) NOT NULL,
	[ISPFirstRegisteredBy] [uniqueidentifier] NOT NULL,
	[ISPFirstRegisteredDate] [datetime] NOT NULL,
	[InactivatedDate] [datetime] NULL,
	[RegEvidenceFileID] [int] NULL,
	[ICORegistrationNumber] [varchar](50) NULL,
	[Longitude] [float] NULL,
	[Latitude] [float] NULL,
	[OrgContactPhone] [nvarchar](50) NULL,
	[OrgContactEmail] [nvarchar](255) NULL,
	[OrgContactName] [nvarchar](50) NULL,
	[RequestClosureReason] [nvarchar](500) NULL,
	[RequestClosureDate] [datetime] NULL,
	[County] [nvarchar](100) NULL,
	[AdminGroupID] [int] NOT NULL,
	[Aliases] [nvarchar](500) NULL,
	[Identifiers] [nvarchar](255) NULL,
	[OrganisationCategoryID] [int] NOT NULL,
	[OrganisationCategoryOther] [nvarchar](255) NULL,
	[LicenceGranted] [bit] NOT NULL,
	[SingleOrgLicence] [bit] NOT NULL,
	[SuperAdminID] [int] NOT NULL,
	[SingleOrgLicenceEnd] [datetime] NULL,
	[AssuranceScore] [int] NULL,
	[PrivacyNoticeURL] [nvarchar](255) NULL,
	[DPOExempt] [bit] NOT NULL,
 CONSTRAINT [PK_isp_Organisations] PRIMARY KEY CLUSTERED 
(
	[OrganisationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[OrganisationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_Organisations] ADD  CONSTRAINT [DF_isp_Organisations_ISPFirstRegisteredDate]  DEFAULT (getutcdate()) FOR [ISPFirstRegisteredDate]
GO
ALTER TABLE [dbo].[isp_Organisations] ADD  DEFAULT ((0)) FOR [AdminGroupID]
GO
ALTER TABLE [dbo].[isp_Organisations] ADD  CONSTRAINT [DF_isp_Organisations_OrganisationCategoryID]  DEFAULT ((0)) FOR [OrganisationCategoryID]
GO
ALTER TABLE [dbo].[isp_Organisations] ADD  CONSTRAINT [DF_isp_Organisations_LicenceGranted]  DEFAULT ((0)) FOR [LicenceGranted]
GO
ALTER TABLE [dbo].[isp_Organisations] ADD  CONSTRAINT [DF_isp_Organisations_SingleOrgLicence]  DEFAULT ((0)) FOR [SingleOrgLicence]
GO
ALTER TABLE [dbo].[isp_Organisations] ADD  CONSTRAINT [DF_isp_Organisations_SuperAdminID]  DEFAULT ((0)) FOR [SuperAdminID]
GO
ALTER TABLE [dbo].[isp_Organisations] ADD  DEFAULT ((0)) FOR [DPOExempt]
GO
