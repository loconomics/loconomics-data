CREATE TABLE [dbo].[postingTemplateQuestion] (
    [postingTemplateQuestionID] INT                IDENTITY (1, 1) NOT NULL,
    [postingTemplateID]         INT                NOT NULL,
    [questionID]                INT                NOT NULL,
    [legend]                    NVARCHAR (150)     NOT NULL,
    [branchLogic]               TEXT               NULL,
    [createdDate]               DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]               DATETIMEOFFSET (0) NOT NULL,
    [modifiedby]                NCHAR (5)          NOT NULL,
    [active]                    TINYINT            NOT NULL,
    CONSTRAINT [PK_postingTemplateQuestion] PRIMARY KEY CLUSTERED ([postingTemplateQuestionID] ASC),
    CONSTRAINT [FK_postingTemplateQuestion_postingTemplate] FOREIGN KEY ([postingTemplateID]) REFERENCES [dbo].[postingTemplate] ([postingTemplateID]),
    CONSTRAINT [FK_postingTemplateQuestion_question] FOREIGN KEY ([questionID]) REFERENCES [dbo].[question] ([questionID])
);

