CREATE TABLE [dbo].[CalendarAvailabilityType] (
    [CalendarAvailabilityTypeID]          INT            NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CountryID]                           INT            NOT NULL,
    [CalendarAvailabilityTypeName]        NVARCHAR (50)  NOT NULL,
    [CalendarAvailabilityTypeDescription] NVARCHAR (300) NOT NULL,
    [UserDescription]                     VARCHAR (500)  NULL,
    [AddAppointmentType]                  BIT            DEFAULT ((0)) NOT NULL,
    [SelectableAs]                        NVARCHAR (50)  NULL,
    CONSTRAINT [PK_CalendarAvailabilityType_1] PRIMARY KEY CLUSTERED ([CalendarAvailabilityTypeID] ASC)
);
