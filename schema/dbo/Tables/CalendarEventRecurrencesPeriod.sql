CREATE TABLE [dbo].[CalendarEventRecurrencesPeriod] (
    [IdRecurrence] INT                NOT NULL,
    [DateStart]    DATETIMEOFFSET (0) NOT NULL,
    [DateEnd]      DATETIMEOFFSET (0) NULL,
    CONSTRAINT [PK_CalendarEventRecurrencesPeriod_1] PRIMARY KEY CLUSTERED ([IdRecurrence] ASC, [DateStart] ASC),
    CONSTRAINT [FK_CalendarEventRecurrencesPeriod_CalendarEventRecurrencesPeriodList] FOREIGN KEY ([IdRecurrence]) REFERENCES [dbo].[CalendarEventRecurrencesPeriodList] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
);

