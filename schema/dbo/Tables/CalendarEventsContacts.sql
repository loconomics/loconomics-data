CREATE TABLE [dbo].[CalendarEventsContacts] (
    [Id]      INT            IDENTITY (1, 1) NOT NULL,
    [IdEvent] INT            NOT NULL,
    [Contact] NVARCHAR (500) NULL,
    CONSTRAINT [PK_CalendarEventsContacts] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_CalendarEventsContacts_CalendarEvents] FOREIGN KEY ([IdEvent]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
);

