CREATE TABLE [dbo].[CalendarEventType] (
    [EventTypeId] INT            NOT NULL,
    [EventType]   NVARCHAR (100) NULL,
    [Description] NVARCHAR (MAX) NULL,
    [DisplayName] NVARCHAR (100) NULL,
    CONSTRAINT [PK_EventType] PRIMARY KEY CLUSTERED ([EventTypeId] ASC)
);

