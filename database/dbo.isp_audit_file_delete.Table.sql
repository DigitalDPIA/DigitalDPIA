USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_audit_file_delete](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FileID] [int] NOT NULL,
	[DeletedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_isp_audit_file_delete] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_audit_file_delete] ADD  CONSTRAINT [DF_isp_audit_file_delete_DeletedDate]  DEFAULT (getutcdate()) FOR [DeletedDate]
GO
