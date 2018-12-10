CREATE TABLE [dbo].[VOCElement] (
    [VOCElementID]    INT           NOT NULL,
    [VOCElementName]  VARCHAR (100) NULL,
    [ScoreStartValue] INT           NULL,
    [ScoreMidValue]   INT           NULL,
    [ScoreEndValue]   INT           NULL,
    [ScoreStartLabel] VARCHAR (25)  NULL,
    [ScoreMidLabel]   VARCHAR (25)  NULL,
    [ScoreEndLabel]   VARCHAR (25)  NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CreateDate]      DATETIME      NOT NULL,
    [UpdatedDate]     DATETIME      NOT NULL,
    [ModifiedBy]      VARCHAR (3)   NOT NULL,
    [Active]          BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([VOCElementID] ASC)
);

