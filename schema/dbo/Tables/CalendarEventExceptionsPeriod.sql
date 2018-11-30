CREATE TABLE [dbo].[CalendarEventExceptionsPeriod] (
    [IdException] INT                NOT NULL,
    [DateStart]   DATETIMEOFFSET (0) NOT NULL,
    [DateEnd]     DATETIMEOFFSET (0) NULL,
    CONSTRAINT [PK_CalendarEventExceptionsPeriod] PRIMARY KEY CLUSTERED ([IdException] ASC, [DateStart] ASC),
    CONSTRAINT [FK_CalendarEventExceptionsPeriods_CalendarEventExceptionsDates] FOREIGN KEY ([IdException]) REFERENCES [dbo].[CalendarEventExceptionsPeriodsList] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
);

