USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_OrganisationUsers](
	[OrganisationUserID] [int] IDENTITY(1,1) NOT NULL,
	[OrganisationID] [int] NOT NULL,
	[OrganisationUserName] [nvarchar](50) NOT NULL,
	[OrganisationUserEmail] [nvarchar](255) NOT NULL,
	[RoleID] [int] NOT NULL,
	[ConfirmationHash] [uniqueidentifier] NOT NULL,
	[Confirmed] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[DelegateRoleTo] [nvarchar](255) NULL,
	[ResignReason] [varchar](255) NULL,
	[ResignDate] [datetime] NULL,
	[Validated] [bit] NOT NULL,
	[AddedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_isp_OrganisationUsers] PRIMARY KEY CLUSTERED 
(
	[OrganisationUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_OrganisationUsers] ADD  CONSTRAINT [DF_isp_OrganisationUsers_ConfirmationHash]  DEFAULT (newid()) FOR [ConfirmationHash]
GO
ALTER TABLE [dbo].[isp_OrganisationUsers] ADD  CONSTRAINT [DF_isp_OrganisationUsers_Confirmed]  DEFAULT ((0)) FOR [Confirmed]
GO
ALTER TABLE [dbo].[isp_OrganisationUsers] ADD  CONSTRAINT [DF_isp_OrganisationUsers_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[isp_OrganisationUsers] ADD  CONSTRAINT [DF_isp_OrganisationUsers_Validated]  DEFAULT ((1)) FOR [Validated]
GO
ALTER TABLE [dbo].[isp_OrganisationUsers] ADD  CONSTRAINT [DF_isp_OrganisationUsers_AddedDate]  DEFAULT (getutcdate()) FOR [AddedDate]
GO
ALTER TABLE [dbo].[isp_OrganisationUsers]  WITH CHECK ADD  CONSTRAINT [FK_isp_OrganisationUsers_isp_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[isp_Roles] ([RoleID])
GO
ALTER TABLE [dbo].[isp_OrganisationUsers] CHECK CONSTRAINT [FK_isp_OrganisationUsers_isp_Roles]
GO
