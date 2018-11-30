CREATE TABLE [dbo].[SearchCategory] (
    [SearchCategoryID] INT                NOT NULL,
    [LanguageID]       INT                NOT NULL,
    [CountryID]        INT                NOT NULL,
    [Name]             NVARCHAR (20)      NOT NULL,
    [ShortDescription] NVARCHAR (100)     NULL,
    [LongDescription]  NVARCHAR (300)     NULL,
    [SmallImage]       NVARCHAR (255)     NULL,
    [BannerImage]      NVARCHAR (255)     NULL,
    [DisplayRank]      INT                NULL,
    [CreatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]       NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]           BIT                DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([SearchCategoryID] ASC, [LanguageID] ASC, [CountryID] ASC),
    CONSTRAINT [FK_SearchCategory_language] FOREIGN KEY ([LanguageID], [CountryID]) REFERENCES [dbo].[language] ([LanguageID], [CountryID])
);

