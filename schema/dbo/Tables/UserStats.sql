CREATE TABLE [dbo].[UserStats] (
    [UserID]              INT             NOT NULL,
    [ResponseTimeMinutes] DECIMAL (18, 2) NULL,
    [LastLoginTime]       DATETIME        NULL,
    [LastActivityTime]    DATETIME        NULL,
    CONSTRAINT [PK_UserStats] PRIMARY KEY CLUSTERED ([UserID] ASC),
    CONSTRAINT [FK_UserStats_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])
);

