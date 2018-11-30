CREATE TABLE [dbo].[PricingGroups] (
    [PricingGroupID]      INT           NOT NULL,
    [InternalGroupName]   VARCHAR (50)  NOT NULL,
    [SelectionTitle]      VARCHAR (100) NOT NULL,
    [SummaryTitle]        VARCHAR (100) NOT NULL,
    [DynamicSummaryTitle] VARCHAR (100) NOT NULL,
    [LanguageID]          INT           NULL,
    [CountryID]           INT           NULL,
    CONSTRAINT [PK_PricingGroups] PRIMARY KEY CLUSTERED ([PricingGroupID] ASC)
);

