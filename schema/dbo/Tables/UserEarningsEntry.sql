CREATE TABLE [dbo].[UserEarningsEntry] (
    [UserID]                INT                NOT NULL,
    [EarningsEntryID]       INT                NOT NULL,
    [Amount]                DECIMAL (10, 2)    CONSTRAINT [DF_UserEarningsEntry_Amount] DEFAULT ((0)) NOT NULL,
    [PaidDate]              DATETIMEOFFSET (0) NOT NULL,
    [DurationMinutes]       INT                NOT NULL,
    [UserExternalListingID] INT                NOT NULL,
    [JobTitleID]            INT                NOT NULL,
    [ClientUserID]          INT                NULL,
    [CreatedDate]           DATETIMEOFFSET (0) NOT NULL,
    [UpdatedDate]           DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]            NVARCHAR (4)       NOT NULL,
    [Active]                BIT                CONSTRAINT [DF_UserEarningsEntry_Active] DEFAULT ((1)) NOT NULL,
    [Notes]                 TEXT               NULL,
    CONSTRAINT [PK_UserEarningsEntry] PRIMARY KEY CLUSTERED ([UserID] ASC, [EarningsEntryID] ASC)
);

GO

ALTER TABLE [dbo].[UserEarningsEntry] ADD
    CONSTRAINT [FK_UserEarningsEntry_ServiceProfessionalClient] FOREIGN KEY ([UserID], [ClientUserID]) REFERENCES [dbo].[ServiceProfessionalClient] ([ServiceProfessionalUserID], [ClientUserID]),
    CONSTRAINT [FK_UserEarningsEntry_UserExternalListing] FOREIGN KEY ([UserExternalListingID]) REFERENCES [dbo].[UserExternalListing] ([UserExternalListingID]),
    CONSTRAINT [FK_UserEarningsEntry_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])
