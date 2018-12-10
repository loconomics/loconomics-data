CREATE TABLE [dbo].[UserPosting] (
    [userPostingID]            INT                IDENTITY (1, 1) NOT NULL,
    [userID]                   INT                NOT NULL,
    [solutionID]               INT                NOT NULL,
    [postingTemplateID]        INT                NULL,
    [title]                    NVARCHAR (50)      NOT NULL,
    [statusID]                 INT                NOT NULL,
    [neededSpecializationIDs]  VARCHAR (300)      NULL,
    [desiredSpecializationIDs] VARCHAR (300)      NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [createdDate]              DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]              DATETIMEOFFSET (0) NOT NULL,
    [modifiedBy]               NVARCHAR (10)      NOT NULL,
    CONSTRAINT [PK_UserPosting] PRIMARY KEY CLUSTERED ([userPostingID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Comma separated list of integers (JSON like but don''t need to be surrounded by square brackets)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserPosting', @level2type = N'COLUMN', @level2name = N'neededSpecializationIDs';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Comma separated list of integers (JSON like but don''t need to be surrounded by square brackets)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserPosting', @level2type = N'COLUMN', @level2name = N'desiredSpecializationIDs';

