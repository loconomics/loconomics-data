CREATE TABLE [dbo].[PricingGroups] (
    [PricingGroupID]      INT           NOT NULL,
    [InternalGroupName]   VARCHAR (50)  NOT NULL,
    [SelectionTitle]      VARCHAR (100) NOT NULL,
    [SummaryTitle]        VARCHAR (100) NOT NULL,
    [DynamicSummaryTitle] VARCHAR (100) NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    CONSTRAINT [PK_PricingGroups] PRIMARY KEY CLUSTERED ([PricingGroupID] ASC)
);

