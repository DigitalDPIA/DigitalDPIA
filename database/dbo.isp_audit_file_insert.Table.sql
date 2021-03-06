USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_audit_file_insert](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](100) NULL,
	[FileType] [nvarchar](50) NULL,
	[FileSize] [bigint] NULL,
	[FileID] [int] NULL,
	[UserEmail] [nvarchar](255) NULL,
	[InsertedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_isp_audit_file_insert] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_audit_file_insert] ADD  CONSTRAINT [DF_isp_audit_file_insert_InsertedDate]  DEFAULT (getutcdate()) FOR [InsertedDate]
GO
