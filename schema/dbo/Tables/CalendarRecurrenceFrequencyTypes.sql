CREATE TABLE [dbo].[CalendarRecurrenceFrequencyTypes] (
    [ID]            INT           NOT NULL,
    [FrequencyType] NVARCHAR (30) NULL,
    [UnitPlural]    NVARCHAR (30) NULL,
    CONSTRAINT [PK_CalendarRecurrenceFrequencyTypes] PRIMARY KEY CLUSTERED ([ID] ASC)
);

GO

