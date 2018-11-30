CREATE TABLE [dbo].[ExperienceLevel] (
    [ExperienceLevelID]          INT           IDENTITY (1, 1) NOT NULL,
    [LanguageID]                 INT           NOT NULL,
    [CountryID]                  INT           NOT NULL,
    [ExperienceLevelName]        VARCHAR (140) NOT NULL,
    [ExperienceLevelDescription] VARCHAR (140) NULL,
    [CreatedDate]                DATETIME      NOT NULL,
    [UpdatedDate]                DATETIME      NOT NULL,
    [ModifiedBy]                 VARCHAR (25)  NOT NULL,
    CONSTRAINT [PK__Experien__2F4E34695728DECD] PRIMARY KEY CLUSTERED ([ExperienceLevelID] ASC, [LanguageID] ASC, [CountryID] ASC) WITH (FILLFACTOR = 100)
);

