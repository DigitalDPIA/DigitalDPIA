USE [dpiasandpit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dpia_Projects](
	[ProjectID] [decimal](19, 0) IDENTITY(1,1) NOT NULL,
	[PName] [nvarchar](255) NOT NULL,
	[PDescription] [nvarchar](max) NULL,
	[PStatusID] [decimal](19, 0) NOT NULL,
	[PStatusDate] [datetime] NOT NULL,
	[POrganisationID] [int] NOT NULL,
	[PAssignedToID] [uniqueidentifier] NULL,
	[PAssignedToDate] [datetime] NULL,
	[PAssignedIGLeadID] [uniqueidentifier] NULL,
	[PAssignedIGLeadDate] [datetime] NULL,
	[PAssignedIGLeadSignOffDate] [datetime] NULL,
	[PAssignedInfAssetOwnerID] [uniqueidentifier] NULL,
	[PAssignedInfAssetOwnerDate] [datetime] NULL,
	[PAssignedInfAssetOwnerSignOffDate] [datetime] NULL,
	[PAssignedDPOID] [uniqueidentifier] NULL,
	[PAssignedDPODate] [datetime] NULL,
	[PAssignedDPOSignOffDate] [datetime] NULL,
	[PAssignedICOID] [uniqueidentifier] NULL,
	[PAssignedICODate] [datetime] NULL,
	[PAssignedICOSignOffDate] [datetime] NULL,
	[PCreatedByID] [uniqueidentifier] NOT NULL,
	[PCreatedDate] [datetime] NOT NULL,
	[PLastModifiedID] [uniqueidentifier] NULL,
	[PLastModifiedDate] [datetime] NULL,
	[PArchivedByID] [uniqueidentifier] NULL,
	[PArchivedDate] [datetime] NULL,
	[PSQV201a] [int] NULL,
	[PSQV201b] [int] NULL,
	[PSQV201c] [int] NULL,
	[PSQV201d] [int] NULL,
	[PSQV201e] [int] NULL,
	[PSQV201f] [int] NULL,
	[PSQV201g] [int] NULL,
	[PSQV202a] [int] NULL,
	[PSQV202b] [int] NULL,
	[PSQV202c] [int] NULL,
	[PSQV202d] [int] NULL,
	[PSQV202e] [int] NULL,
	[PSQV202f] [int] NULL,
	[PSQV203a] [int] NULL,
	[PSQV203b] [int] NULL,
	[PSQV203c] [int] NULL,
	[PSQV203d] [int] NULL,
	[PSQV203e] [int] NULL,
	[PSQV203f] [int] NULL,
	[PSQV203g] [int] NULL,
	[PSQV203h] [int] NULL,
	[PSQV204a] [int] NULL,
	[PSQV204b] [int] NULL,
	[PSQV204c] [int] NULL,
	[PSQV204d] [int] NULL,
	[PSQV204e] [int] NULL,
	[PSQV204f] [int] NULL,
	[PSQV204g] [int] NULL,
	[PSQV204h] [int] NULL,
	[PSQ01] [int] NULL,
	[PSQ02] [int] NULL,
	[PSQ03] [int] NULL,
	[PSQ04] [int] NULL,
	[PSQ05] [int] NULL,
	[PSQ06] [int] NULL,
	[PSQ07] [int] NULL,
	[PSQ08] [int] NULL,
	[PSQ09] [int] NULL,
	[PSQ10] [int] NULL,
	[PSQ11] [int] NULL,
	[PSQ12] [int] NULL,
	[PSQ13] [int] NULL,
	[PSQ14] [int] NULL,
	[PSQ15] [int] NULL,
	[PSQ16] [int] NULL,
	[PSQ17] [int] NULL,
	[PSQ18] [int] NULL,
	[DPIALegalQ01] [int] NULL,
	[DPIALegalQ01a] [int] NULL,
	[DPIALegalQ01aa] [int] NOT NULL,
	[DPIALegalQ01ab] [int] NOT NULL,
	[DPIALegalQ01ac] [int] NOT NULL,
	[DPIALegalQ01ad] [int] NOT NULL,
	[DPIALegalQ01ae] [int] NOT NULL,
	[DPIALegalQ01af] [int] NOT NULL,
	[DPIALegalQ01acleg] [nvarchar](500) NULL,
	[DPIALegalQ01aeleg] [nvarchar](500) NULL,
	[DPIALegalQ01aa2] [int] NULL,
	[DPIALegalQ01aa3] [int] NULL,
	[DPIALegalQ02] [int] NULL,
	[DPIALegalQ02aa] [int] NOT NULL,
	[DPIALegalQ02ab] [int] NOT NULL,
	[DPIALegalQ02ac] [int] NOT NULL,
	[DPIALegalQ02ad] [int] NOT NULL,
	[DPIALegalQ02ae] [int] NOT NULL,
	[DPIALegalQ02af] [int] NOT NULL,
	[DPIALegalQ02ag] [int] NOT NULL,
	[DPIALegalQ02ah] [int] NOT NULL,
	[DPIALegalQ02ai] [int] NOT NULL,
	[DPIALegalQ02aga] [int] NOT NULL,
	[DPIALegalQ02agb] [int] NOT NULL,
	[DPIALegalQ02agc] [int] NOT NULL,
	[DPIALegalQ02agd] [int] NOT NULL,
	[DPIALegalQ02age] [int] NOT NULL,
	[DPIALegalQ02agf] [int] NOT NULL,
	[DPIALegalQ02agg] [int] NOT NULL,
	[DPIALegalQ02agh] [int] NOT NULL,
	[DPIALegalQ02agi] [int] NOT NULL,
	[DPIALegalQ02agj] [int] NOT NULL,
	[DPIALegalQ02agk] [int] NOT NULL,
	[DPIALegalQ02agl] [int] NOT NULL,
	[DPIALegalQ02agm] [int] NOT NULL,
	[DPIALegalQ02agn] [int] NOT NULL,
	[DPIALegalQ02ago] [int] NOT NULL,
	[DPIALegalQ02agp] [int] NOT NULL,
	[DPIALegalQ02agq] [int] NOT NULL,
	[DPIALegalQ02agr] [int] NOT NULL,
	[DPIALegalQ02ags] [int] NOT NULL,
	[DPIALegalQ02agt] [int] NOT NULL,
	[DPIALegalQ02agu] [int] NOT NULL,
	[DPIALegalQ02agv] [int] NOT NULL,
	[DPIALegalQ02agw] [int] NOT NULL,
	[DPIALegalQ03] [int] NULL,
	[DPIALegalQ04] [int] NULL,
	[DPIALegalQ04b] [int] NULL,
 CONSTRAINT [PK_dpia_Projects] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[dpia_Projects]  WITH CHECK ADD  CONSTRAINT [FK_dpia_Projects_dpia_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[dpia_Projects] ([ProjectID])
GO
ALTER TABLE [dbo].[dpia_Projects] CHECK CONSTRAINT [FK_dpia_Projects_dpia_Projects]
GO
