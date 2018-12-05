CREATE TABLE [dbo].[CalendarProviderAttributes] (
    [UserID]                  INT             NOT NULL,
    [AdvanceTime]             DECIMAL (10, 2) NOT NULL,
    [MinTime]                 DECIMAL (10, 2) CONSTRAINT [DF_CalendarProviderAttributes_MinTime] DEFAULT ((0)) NOT NULL,
    [MaxTime]                 DECIMAL (10, 2) CONSTRAINT [DF_CalendarProviderAttributes_MaxTime] DEFAULT ((0)) NOT NULL,
    [BetweenTime]             DECIMAL (10, 2) NOT NULL,
    [UseCalendarProgram]      BIT             NOT NULL,
    [CalendarType]            VARCHAR (200)   NULL,
    [CalendarURL]             VARCHAR (500)   NULL,
    [PrivateCalendarToken]    VARCHAR (128)   NULL,
    [IncrementsSizeInMinutes] INT             CONSTRAINT [DF_CalendarProviderAttributes_IncrementsSizeInMinutes] DEFAULT ((15)) NOT NULL,
    [TimeZone]                VARCHAR (50)    NULL,
    CONSTRAINT [PK__Calendar__1788CCAC22B5168E] PRIMARY KEY CLUSTERED ([UserID] ASC) WITH (FILLFACTOR = 100)
);

GO

ALTER TABLE [dbo].[CalendarProviderAttributes] ADD
    CONSTRAINT [FK_CalendarProviderAttributes_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID]) ON DELETE CASCADE ON UPDATE CASCADE
