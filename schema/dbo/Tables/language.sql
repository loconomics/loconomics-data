CREATE TABLE [dbo].[language] (
    [LanguageID]   INT          NOT NULL,
    [CountryID]    INT          NOT NULL,
    [LanguageName] VARCHAR (50) NOT NULL,
    [Active]       BIT          NULL,
    [LanguageCode] VARCHAR (2)  NULL,
    [CreatedDate]  DATETIME     NULL,
    [UpdatedDate]  DATETIME     NULL,
    [ModifiedBy]   VARCHAR (25) NULL,
    PRIMARY KEY CLUSTERED ([LanguageID] ASC, [CountryID] ASC)
);

