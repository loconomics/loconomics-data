CREATE TABLE [dbo].[ServiceProfessionalClient] (
    [ServiceProfessionalUserID]    INT      NOT NULL,
    [ClientUserID]                 INT      NOT NULL,
    [NotesAboutClient]             NTEXT    CONSTRAINT [DF_ProviderCustomer_NotesAboutCustomer] DEFAULT ('') NOT NULL,
    [ReferralSourceID]             INT      NOT NULL,
    [CreatedDate]                  DATETIME NOT NULL,
    [UpdatedDate]                  DATETIME NOT NULL,
    [Active]                       BIT      NOT NULL,
    [CreatedByBookingID]           INT      NULL,
    [DeletedByServiceProfessional] BIT      CONSTRAINT [DF_ServiceProfessionalClient_DeletedByServiceProfessional] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ProviderCustomer] PRIMARY KEY CLUSTERED ([ServiceProfessionalUserID] ASC, [ClientUserID] ASC),
    CONSTRAINT [FK_ProviderCustomer_ReferralSource] FOREIGN KEY ([ReferralSourceID]) REFERENCES [dbo].[ReferralSource] ([ReferralSourceID]),
    CONSTRAINT [FK_ProviderCustomer_users] FOREIGN KEY ([ServiceProfessionalUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK_ProviderCustomer_users1] FOREIGN KEY ([ClientUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK_ServiceProfessionalClient_booking] FOREIGN KEY ([CreatedByBookingID]) REFERENCES [dbo].[booking] ([BookingID])
);

