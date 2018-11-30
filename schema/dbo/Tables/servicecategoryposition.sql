CREATE TABLE [dbo].[servicecategoryposition] (
    [ServiceCategoryID] INT          NOT NULL,
    [PositionID]        INT          NOT NULL,
    [LanguageID]        INT          NOT NULL,
    [CountryID]         INT          NOT NULL,
    [Rank]              INT          DEFAULT ((1)) NOT NULL,
    [CreateDate]        DATETIME     NOT NULL,
    [UpdatedDate]       DATETIME     NOT NULL,
    [ModifiedBy]        VARCHAR (25) NOT NULL,
    [Active]            INT          DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ServiceCategoryID] ASC, [PositionID] ASC, [LanguageID] ASC, [CountryID] ASC)
);

