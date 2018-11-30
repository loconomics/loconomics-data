CREATE TABLE [dbo].[bookingStatus] (
    [BookingStatusID]          INT           NOT NULL,
    [BookingStatusName]        VARCHAR (50)  NOT NULL,
    [BookingStatusDescription] VARCHAR (500) NULL,
    [CreatedDate]              DATETIME      NOT NULL,
    [UpdatedDate]              DATETIME      NOT NULL,
    [ModifiedBy]               VARCHAR (25)  NOT NULL,
    [Active]                   BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([BookingStatusID] ASC)
);

