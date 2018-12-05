CREATE TABLE [dbo].[UserPostingReaction] (
    [userPostingID]             INT                NOT NULL,
    [serviceProfessionalUserID] INT                NOT NULL,
    [reactionTypeID]            INT                NOT NULL,
    [createdDate]               DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]               DATETIMEOFFSET (0) NOT NULL,
    [message]                   TEXT               NULL,
    CONSTRAINT [PK_UserPostingReaction] PRIMARY KEY CLUSTERED ([userPostingID] ASC, [serviceProfessionalUserID] ASC)
);

GO

ALTER TABLE [dbo].[UserPostingReaction] ADD
    CONSTRAINT [FK_UserPostingReaction_UserPosting] FOREIGN KEY ([userPostingID]) REFERENCES [dbo].[UserPosting] ([userPostingID]),
    CONSTRAINT [FK_UserPostingReaction_users] FOREIGN KEY ([serviceProfessionalUserID]) REFERENCES [dbo].[users] ([UserID])
