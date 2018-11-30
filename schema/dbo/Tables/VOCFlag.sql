CREATE TABLE [dbo].[VOCFlag] (
    [VOCFlagID]           INT           NOT NULL,
    [LanguageID]          INT           NOT NULL,
    [CountryID]           INT           NOT NULL,
    [VOCFlagName]         VARCHAR (50)  NOT NULL,
    [VOCFlagNDescription] VARCHAR (500) NULL,
    [CreateDate]          DATETIME      NOT NULL,
    [UpdatedDate]         DATETIME      NOT NULL,
    [ModifiedBy]          VARCHAR (3)   NOT NULL,
    [Active]              BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([VOCFlagID] ASC, [LanguageID] ASC, [CountryID] ASC)
);

