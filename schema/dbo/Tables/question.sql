CREATE TABLE [dbo].[question] (
    [questionID]     INT                NOT NULL,
    [questionTypeID] INT                NOT NULL,
    [question]       NVARCHAR (120)     NOT NULL,
    [helpBlock]      NVARCHAR (300)     NULL,
    [options]        TEXT               NOT NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [createdDate]    DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]    DATETIMEOFFSET (0) NOT NULL,
    [modifiedBy]     NVARCHAR (10)      NOT NULL,
    [label]          NVARCHAR (120)     DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_question] PRIMARY KEY CLUSTERED ([questionID] ASC)
);

GO

ALTER TABLE [dbo].[question] ADD
    CONSTRAINT [FK_question_questionType] FOREIGN KEY ([questionTypeID]) REFERENCES [dbo].[questionType] ([questionTypeID])
