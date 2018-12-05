CREATE TABLE [dbo].[CalendarEventExceptionsPeriodsList] (
    [Id]      INT IDENTITY (1, 1) NOT NULL,
    [IdEvent] INT NOT NULL,
    CONSTRAINT [PK_CalendarEventExceptions] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO

ALTER TABLE [dbo].[CalendarEventExceptionsPeriodsList] ADD
    CONSTRAINT [FK_CalendarEventExceptions_CalendarEvents] FOREIGN KEY ([IdEvent]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
