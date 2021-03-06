USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_EmailServers](
	[ServerID] [int] IDENTITY(1,1) NOT NULL,
	[IPAddress] [nvarchar](50) NOT NULL,
	[FromAddress] [nvarchar](100) NOT NULL,
	[Uname] [nvarchar](50) NOT NULL,
	[PW] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_EmailServers] ADD  CONSTRAINT [DF_isp_EmailServers_Active]  DEFAULT ((1)) FOR [Active]
GO
