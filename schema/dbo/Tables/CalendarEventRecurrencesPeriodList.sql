CREATE TABLE [dbo].[CalendarEventRecurrencesPeriodList] (
    [Id]      INT IDENTITY (1, 1) NOT NULL,
    [IdEvent] INT NOT NULL,
    CONSTRAINT [PK_CalendarEventRecurrenceDates] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_CalendarEventRecurrencesPeriodList_CalendarEvents] FOREIGN KEY ([IdEvent]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
);

