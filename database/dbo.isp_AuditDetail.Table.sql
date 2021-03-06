USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_AuditDetail](
	[AuditDetailID] [int] IDENTITY(1,1) NOT NULL,
	[DFAuditID] [int] NOT NULL,
	[FieldName] [nvarchar](255) NULL,
	[OldValues] [nvarchar](max) NULL,
	[NewValues] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_AuditDetail]  WITH CHECK ADD  CONSTRAINT [FK_Isp_AuditDetail_isp_TableActivityAudit] FOREIGN KEY([DFAuditID])
REFERENCES [dbo].[isp_TableActivityAudit] ([DFAuditID])
GO
ALTER TABLE [dbo].[isp_AuditDetail] CHECK CONSTRAINT [FK_Isp_AuditDetail_isp_TableActivityAudit]
GO
