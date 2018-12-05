CREATE TABLE [dbo].[Solution] (
    [SolutionID]              INT                NOT NULL,
    [LanguageID]              INT                NOT NULL,
    [CountryID]               INT                NOT NULL,
    [Name]                    NVARCHAR (100)     NOT NULL,
    [CredentialCheckRequired] BIT                DEFAULT ((0)) NOT NULL,
    [BackgroundCheckRequired] BIT                DEFAULT ((0)) NOT NULL,
    [IsHIPAA]                 BIT                DEFAULT ((0)) NOT NULL,
    [TaxActivityID]           INT                NULL,
    [PostingTemplateID]       INT                NULL,
    [Image]                   NVARCHAR (255)     NULL,
    [CreatedDate]             DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]             DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]              NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]                  BIT                DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([SolutionID] ASC, [LanguageID] ASC, [CountryID] ASC)
);

GO

ALTER TABLE [dbo].[Solution] ADD
    CONSTRAINT [FK_Solution_language] FOREIGN KEY ([LanguageID], [CountryID]) REFERENCES [dbo].[language] ([LanguageID], [CountryID])
