﻿CREATE TABLE [dbo].[CalendarEvents] (
    [Id]                         INT                IDENTITY (1, 1) NOT NULL,
    [UserId]                     INT                NOT NULL,
    [EventType]                  INT                CONSTRAINT [DF_CalendarEvents_EventType] DEFAULT ((1)) NOT NULL,
    [Summary]                    VARCHAR (500)      NULL,
    [StarTtime]                  DATETIMEOFFSET (0) NULL,
    [EndTime]                    DATETIMEOFFSET (0) NULL,
    [UID]                        VARCHAR (150)      NULL,
    [CalendarAvailabilityTypeID] INT                NOT NULL,
    [Transparency]               BIT                CONSTRAINT [DF_CalendarEvents_Transparency] DEFAULT ((0)) NOT NULL,
    [IsAllDay]                   BIT                CONSTRAINT [DF_CalendarEvents_IsAllDay] DEFAULT ((0)) NOT NULL,
    [StampTime]                  DATETIMEOFFSET (0) NULL,
    [TimeZone]                   NVARCHAR (100)     NULL,
    [Priority]                   INT                NULL,
    [Location]                   NVARCHAR (100)     NULL,
    [UpdatedDate]                DATETIMEOFFSET (0) NULL,
    [CreatedDate]                DATETIMEOFFSET (0) NULL,
    [ModifyBy]                   NVARCHAR (50)      NULL,
    [Class]                      NVARCHAR (50)      NULL,
    [Organizer]                  NVARCHAR (MAX)     NULL,
    [Sequence]                   INT                NULL,
    [Geo]                        NVARCHAR (100)     NULL,
    [RecurrenceId]               DATETIMEOFFSET (0) NULL,
    [TimeBlock]                  TIME (7)           NULL,
    [DayofWeek]                  INT                NULL,
    [Description]                NVARCHAR (MAX)     NULL,
    [Deleted]                    DATETIMEOFFSET (0) NULL,
    CONSTRAINT [PK_CalendarEvents] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO

ALTER TABLE [dbo].[CalendarEvents] ADD
    CONSTRAINT [FK_CalendarEvents_CalendarAvailabilityType] FOREIGN KEY ([CalendarAvailabilityTypeID]) REFERENCES [dbo].[CalendarAvailabilityType] ([CalendarAvailabilityTypeID]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_CalendarEvents_CalendarEventType] FOREIGN KEY ([EventType]) REFERENCES [dbo].[CalendarEventType] ([EventTypeId]) ON DELETE CASCADE ON UPDATE CASCADE
