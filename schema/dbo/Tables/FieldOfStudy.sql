CREATE TABLE [dbo].[FieldOfStudy] (
    [FieldOfStudyID]   INT          IDENTITY (1, 1) NOT NULL,
    [FieldOfStudyName] VARCHAR (50) NOT NULL,
    [CCCTOPCode]       INT          NULL,
    [LanguageID]       INT          NULL,
    [CountryID]        INT          NULL,
    [CreatedDate]      DATETIME     NULL,
    [UpdatedDate]      DATETIME     NULL,
    [ModifiedBy]       VARCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([FieldOfStudyID] ASC)
);

