CREATE TABLE [dbo].[languagelevel] (
    [LanguageLevelID]          INT            IDENTITY (1, 1) NOT NULL,
    [LanguageID]               INT            NOT NULL,
    [CountryID]                INT            NOT NULL,
    [LanguageLevelName]        VARCHAR (140)  NOT NULL,
    [LanguageLevelDescription] VARCHAR (2000) NULL,
    [CreatedDate]              DATETIME       NOT NULL,
    [UpdatedDate]              DATETIME       NOT NULL,
    [ModifiedBy]               VARCHAR (25)   NOT NULL,
    CONSTRAINT [PK__language__F5325F2353584DE9] PRIMARY KEY CLUSTERED ([LanguageLevelID] ASC, [LanguageID] ASC, [CountryID] ASC) WITH (FILLFACTOR = 100)
);

