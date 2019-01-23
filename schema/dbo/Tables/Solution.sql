CREATE TABLE [dbo].[Solution] (
    [SolutionID]              INT                NOT NULL,
    [Name]                    NVARCHAR (100)     NOT NULL,
    [CredentialCheckRequired] BIT                DEFAULT ((0)) NOT NULL,
    [BackgroundCheckRequired] BIT                DEFAULT ((0)) NOT NULL,
    [IsHIPAA]                 BIT                DEFAULT ((0)) NOT NULL,
    [TaxActivityID]           INT                NULL,
    [PostingTemplateID]       INT                NULL,
    [Image]                   NVARCHAR (255)     NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]             DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]             DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]              NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]                  BIT                DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([SolutionID] ASC)
);

GO

