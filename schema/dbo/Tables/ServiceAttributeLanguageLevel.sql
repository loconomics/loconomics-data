CREATE TABLE [dbo].[ServiceAttributeLanguageLevel] (
    [UserID]             INT          NOT NULL,
    [PositionID]         INT          NOT NULL,
    [LanguageID]         INT          NOT NULL,
    [CountryID]          INT          NOT NULL,
    [ServiceAttributeID] INT          NOT NULL,
    [LanguageLevelID]    INT          NOT NULL,
    [CreatedDate]        DATETIME     NOT NULL,
    [UpdatedDate]        DATETIME     NOT NULL,
    [ModifiedBy]         VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_ServiceAttributeLanguageLevel] PRIMARY KEY CLUSTERED ([UserID] ASC, [PositionID] ASC, [ServiceAttributeID] ASC)
);

