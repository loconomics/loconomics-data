CREATE TABLE [dbo].[CalendarReccurrenceFrequency] (
    [ID]                   INT IDENTITY (1, 1) NOT NULL,
    [CalendarReccursiveID] INT NULL,
    [ByDay]                BIT NULL,
    [ByHour]               BIT NULL,
    [ByMinute]             BIT NULL,
    [ByMonth]              BIT NULL,
    [ByMonthDay]           BIT NULL,
    [BySecond]             BIT NULL,
    [BySetPosition]        BIT NULL,
    [ByWeekNo]             BIT NULL,
    [ByYearDay]            BIT NULL,
    [ExtraValue]           INT NULL,
    [FrequencyDay]         INT NULL,
    [DayOfWeek]            INT NULL,
    CONSTRAINT [PK_CalendarRecurrence] PRIMARY KEY CLUSTERED ([ID] ASC)
);

GO

ALTER TABLE [dbo].[CalendarReccurrenceFrequency] ADD
    CONSTRAINT [FK_CalendarFrecuency_CalendarReccursive] FOREIGN KEY ([CalendarReccursiveID]) REFERENCES [dbo].[CalendarReccurrence] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
