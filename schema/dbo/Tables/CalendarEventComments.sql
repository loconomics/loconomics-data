CREATE TABLE [dbo].[CalendarEventComments] (
    [Id]      INT            IDENTITY (1, 1) NOT NULL,
    [IdEvent] INT            NOT NULL,
    [Comment] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
ALTER TABLE [dbo].[CalendarEventComments] ADD
    CONSTRAINT [FK_Comments_CalendarEvents] FOREIGN KEY ([IdEvent]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
