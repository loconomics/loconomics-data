CREATE TABLE [dbo].[OwnerAcknowledgment] (
    [UserID]             INT                NOT NULL,
    [DateAcknowledged]   DATETIMEOFFSET (7) NOT NULL,
    [AcknowledgedFromIP] VARCHAR (25)       NOT NULL,
    [CreatedDate]        DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]        DATETIMEOFFSET (7) NOT NULL,
    [DetectedIPs]        VARCHAR (200)      NOT NULL,
    CONSTRAINT [PK_OwnerAcknowledgment] PRIMARY KEY CLUSTERED ([UserID] ASC),
    CONSTRAINT [FK_OwnerAcknowledgment_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])
);

