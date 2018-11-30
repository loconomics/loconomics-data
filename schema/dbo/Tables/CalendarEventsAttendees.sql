CREATE TABLE [dbo].[CalendarEventsAttendees] (
    [Id]       INT            IDENTITY (1, 1) NOT NULL,
    [IdEvent]  INT            NOT NULL,
    [Attendee] NVARCHAR (MAX) NULL,
    [Role]     NVARCHAR (50)  NULL,
    [Uri]      NVARCHAR (200) NULL,
    CONSTRAINT [PK_CalendarEventsAttendees] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_CalendarEventsAttendees_CalendarEvents] FOREIGN KEY ([IdEvent]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
);

