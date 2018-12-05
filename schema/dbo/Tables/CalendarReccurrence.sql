CREATE TABLE [dbo].[CalendarReccurrence] (
    [ID]              INT                IDENTITY (1, 1) NOT NULL,
    [EventID]         INT                NULL,
    [Count]           INT                NULL,
    [EvaluationMode]  NVARCHAR (50)      NULL,
    [Frequency]       INT                NULL,
    [Interval]        INT                NULL,
    [RestristionType] INT                NULL,
    [Until]           DATETIMEOFFSET (0) NULL,
    [FirstDayOfWeek]  INT                NULL,
    CONSTRAINT [PK_CalendarReccursive] PRIMARY KEY CLUSTERED ([ID] ASC)
);

GO

ALTER TABLE [dbo].[CalendarReccurrence] ADD
    CONSTRAINT [FK_CalendarReccurrence_CalendarRecurrenceFrequencyTypes] FOREIGN KEY ([Frequency]) REFERENCES [dbo].[CalendarRecurrenceFrequencyTypes] ([ID]),
    CONSTRAINT [FK_CalendarReccursive_CalendarEvents] FOREIGN KEY ([EventID]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
