CREATE TABLE [dbo].[ServiceAttributeExperienceLevel] (
    [UserID]            INT          NOT NULL,
    [PositionID]        INT          NOT NULL,
    [LanguageID]        INT          NOT NULL,
    [CountryID]         INT          NOT NULL,
    [ExperienceLevelID] INT          NOT NULL,
    [CreatedDate]       DATETIME     NOT NULL,
    [UpdatedDate]       DATETIME     NOT NULL,
    [ModifiedBy]        VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_ServiceAttributeExperienceLevel_1] PRIMARY KEY CLUSTERED ([UserID] ASC, [PositionID] ASC)
);

