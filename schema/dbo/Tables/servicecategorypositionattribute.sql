CREATE TABLE [dbo].[servicecategorypositionattribute] (
    [PositionID]                 INT          NOT NULL,
    [ServiceAttributeCategoryID] INT          NOT NULL,
    [ServiceAttributeID]         INT          NOT NULL,
    [LanguageID]                 INT          NOT NULL,
    [CountryID]                  INT          NOT NULL,
    [CreateDate]                 DATETIME     NOT NULL,
    [UpdatedDate]                DATETIME     NOT NULL,
    [ModifiedBy]                 VARCHAR (20) NOT NULL,
    [Active]                     BIT          DEFAULT ((1)) NOT NULL,
    [EnteredByUserID]            INT          NULL,
    [Approved]                   BIT          NULL,
    PRIMARY KEY CLUSTERED ([PositionID] ASC, [ServiceAttributeCategoryID] ASC, [ServiceAttributeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);

