USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[isp_TableActivityAudit](
	[DFAuditID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[TransactionTableName] [nvarchar](50) NOT NULL,
	[TransactionType] [nvarchar](25) NOT NULL,
	[ProcedureName] [nchar](50) NULL,
	[RecordID] [int] NULL,
	[Details] [nvarchar](500) NULL,
 CONSTRAINT [PK_isp_TableActivityAudit] PRIMARY KEY CLUSTERED 
(
	[DFAuditID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[isp_TableActivityAudit] ADD  CONSTRAINT [DF_isp_TableActivityAudit_TransactionDate]  DEFAULT (getutcdate()) FOR [TransactionDate]
GO
