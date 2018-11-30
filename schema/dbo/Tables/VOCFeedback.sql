CREATE TABLE [dbo].[VOCFeedback] (
    [VOCFeedbackID]           INT          IDENTITY (1, 1) NOT NULL,
    [VOCElementID]            INT          NOT NULL,
    [VOCExperienceCategoryID] INT          NOT NULL,
    [UserID]                  INT          NOT NULL,
    [Feedback]                TEXT         NOT NULL,
    [VOCFlag1]                VARCHAR (50) NULL,
    [VOCFlag2]                VARCHAR (50) NULL,
    [VOCFlag3]                VARCHAR (50) NULL,
    [VOCFlag4]                VARCHAR (50) NULL,
    [UserDevice]              TEXT         NULL,
    [ZenDeskTicketNumber]     INT          NULL,
    [ProviderUserID]          INT          NULL,
    [ProviderPositionID]      INT          NULL,
    [CreatedDate]             DATETIME     NOT NULL,
    [UpdatedDate]             DATETIME     NOT NULL,
    [ModifiedBy]              VARCHAR (3)  NOT NULL,
    CONSTRAINT [PK__VOCFeedb__B6FF22780B528E49] PRIMARY KEY CLUSTERED ([VOCFeedbackID] ASC)
);

