CREATE TABLE [dbo].[UserPostingQuestionResponse] (
    [userPostingID]  INT            NOT NULL,
    [questionID]     INT            NOT NULL,
    [questionTypeID] INT            NOT NULL,
    [question]       NVARCHAR (120) NOT NULL,
    [helpBlock]      NVARCHAR (300) NULL,
    [options]        TEXT           NOT NULL,
    [responses]      TEXT           NOT NULL,
    [legend]         NVARCHAR (60)  NOT NULL,
    [branchLogic]    TEXT           NULL,
    [label]          NVARCHAR (120) DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_UserPostingQuestionResponse_1] PRIMARY KEY CLUSTERED ([userPostingID] ASC, [questionID] ASC),
    CONSTRAINT [FK_UserPostingQuestionResponse_question] FOREIGN KEY ([questionID]) REFERENCES [dbo].[question] ([questionID]),
    CONSTRAINT [FK_UserPostingQuestionResponse_questionType] FOREIGN KEY ([questionTypeID]) REFERENCES [dbo].[questionType] ([questionTypeID]),
    CONSTRAINT [FK_UserPostingQuestionResponse_UserPosting] FOREIGN KEY ([userPostingID]) REFERENCES [dbo].[UserPosting] ([userPostingID])
);

