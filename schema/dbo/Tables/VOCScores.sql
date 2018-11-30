CREATE TABLE [dbo].[VOCScores] (
    [VOCScoresID]             INT           NOT NULL,
    [UserID]                  INT           NOT NULL,
    [VOCElementID]            INT           NOT NULL,
    [Score]                   INT           NOT NULL,
    [Date]                    DATETIME      NOT NULL,
    [ProviderUserID]          INT           NULL,
    [ProviderPositionID]      INT           NULL,
    [UserDevice]              VARCHAR (100) NULL,
    [VOCExperienceCategoryID] INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([VOCScoresID] ASC, [UserID] ASC, [VOCElementID] ASC, [Score] ASC, [Date] ASC)
);

