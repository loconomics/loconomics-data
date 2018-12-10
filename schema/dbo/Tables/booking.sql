CREATE TABLE [dbo].[booking] (
    [BookingID]                        INT             IDENTITY (1, 1) NOT NULL,
    [ClientUserID]                     INT             NULL,
    [ServiceProfessionalUserID]        INT             NULL,
    [JobTitleID]                       INT             NOT NULL,
    [LanguageID]                       INT             NOT NULL,
    [CountryID]                        INT             NOT NULL,
    [BookingStatusID]                  INT             NOT NULL,
    [BookingTypeID]                    INT             NOT NULL,
    [CancellationPolicyID]             INT             NOT NULL,
    [ParentBookingID]                  INT             NULL,
    [ServiceAddressID]                 INT             NULL,
    [ServiceDateID]                    INT             NULL,
    [AlternativeDate1ID]               INT             NULL,
    [AlternativeDate2ID]               INT             NULL,
    [PricingSummaryID]                 INT             NOT NULL,
    [PricingSummaryRevision]           INT             NOT NULL,
    [PaymentTransactionID]             VARCHAR (250)   NULL,
    [PaymentLastFourCardNumberDigits]  VARCHAR (64)    NULL,
    [paymentMethodID]                  VARCHAR (250)   NULL,
    [cancellationPaymentTransactionID] VARCHAR (250)   NULL,
    [ClientPayment]                    DECIMAL (25, 2) NULL,
    [ServiceProfessionalPaid]          DECIMAL (25, 2) NULL,
    [ServiceProfessionalPPFeePaid]     DECIMAL (25, 2) NULL,
    [LoconomicsPaid]                   DECIMAL (25, 2) NULL,
    [LoconomicsPPFeePaid]              DECIMAL (25, 2) NULL,
    [InstantBooking]                   BIT             CONSTRAINT [Contraint_booking_InstantBooking] DEFAULT ((0)) NOT NULL,
    [FirstTimeBooking]                 BIT             NOT NULL,
    [SendReminder]                     BIT             CONSTRAINT [Contraint_booking_SendReminder] DEFAULT ((0)) NOT NULL,
    [SendPromotional]                  BIT             CONSTRAINT [Contraint_booking_SendPromotional] DEFAULT ((0)) NOT NULL,
    [Recurrent]                        BIT             CONSTRAINT [Contraint_booking_Recurrent] DEFAULT ((0)) NOT NULL,
    [MultiSession]                     BIT             CONSTRAINT [Contraint_booking_MultiSession] DEFAULT ((0)) NOT NULL,
    [PricingAdjustmentApplied]         BIT             CONSTRAINT [Contraint__booking__PricingAdjustmentApplied] DEFAULT ((0)) NOT NULL,
    [PaymentEnabled]                   BIT             CONSTRAINT [DF_booking_PaymentEnabled] DEFAULT ((0)) NOT NULL,
    [PaymentCollected]                 BIT             CONSTRAINT [Contraint_booking_PaymentCollected] DEFAULT ((0)) NOT NULL,
    [PaymentAuthorized]                BIT             CONSTRAINT [Contraint_booking_PaymentAuthorized] DEFAULT ((0)) NOT NULL,
    [AwaitingResponseFromUserID]       INT             NULL,
    [PricingAdjustmentRequested]       BIT             CONSTRAINT [Contraint_booking_PricingAdjustmentRequested] DEFAULT ((0)) NOT NULL,
    [SupportTicketNumber]              VARCHAR (200)   NULL,
    [MessagingLog]                     NVARCHAR (400)  CONSTRAINT [Contraint_booking_MessagingLog] DEFAULT ('') NOT NULL,
    [CreatedDate]                      DATETIME        NOT NULL,
    [UpdatedDate]                      DATETIME        NOT NULL,
    [ModifiedBy]                       VARCHAR (25)    NOT NULL,
    [SpecialRequests]                  TEXT            NULL,
    [PreNotesToClient]                 TEXT            NULL,
    [PostNotesToClient]                TEXT            NULL,
    [PreNotesToSelf]                   TEXT            NULL,
    [PostNotesToSelf]                  TEXT            NULL,
    CONSTRAINT [PK__booking__bookingIDKey] PRIMARY KEY CLUSTERED ([BookingID] ASC)
);

GO

ALTER TABLE [dbo].[booking] ADD
    CONSTRAINT [FK__booking__alternativeDate1] FOREIGN KEY ([AlternativeDate1ID]) REFERENCES [dbo].[CalendarEvents] ([Id]),
    CONSTRAINT [FK__booking__alternativeDate2] FOREIGN KEY ([AlternativeDate2ID]) REFERENCES [dbo].[CalendarEvents] ([Id]),
    CONSTRAINT [FK__booking__AwaitingResponseFromUserID] FOREIGN KEY ([AwaitingResponseFromUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK__booking__cancellationPolicy] FOREIGN KEY ([CancellationPolicyID]) REFERENCES [dbo].[cancellationpolicy] ([CancellationPolicyID]),
    CONSTRAINT [FK__booking__client] FOREIGN KEY ([ClientUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK__booking__jobtitle] FOREIGN KEY ([JobTitleID]) REFERENCES [dbo].[positions] ([PositionID]),
    CONSTRAINT [FK__booking__parentbooking] FOREIGN KEY ([ParentBookingID]) REFERENCES [dbo].[booking] ([BookingID]),
    CONSTRAINT [FK__booking__pricingSummary] FOREIGN KEY ([PricingSummaryID]) REFERENCES [dbo].[pricingSummary] ([PricingSummaryID]),
    CONSTRAINT [FK__booking__serviceAddress] FOREIGN KEY ([ServiceAddressID]) REFERENCES [dbo].[address] ([AddressID]),
    CONSTRAINT [FK__booking__serviceDate] FOREIGN KEY ([ServiceDateID]) REFERENCES [dbo].[CalendarEvents] ([Id]),
    CONSTRAINT [FK__booking__serviceProfessional] FOREIGN KEY ([ServiceProfessionalUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK__booking__status] FOREIGN KEY ([BookingStatusID]) REFERENCES [dbo].[bookingStatus] ([BookingStatusID]),
    CONSTRAINT [FK__booking__type] FOREIGN KEY ([BookingTypeID]) REFERENCES [dbo].[bookingType] ([BookingTypeID])


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The languageID related to the jobTitleID, and the one used on the API call by the creator of the booking', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'booking', @level2type = N'COLUMN', @level2name = N'LanguageID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The countryID related to the jobTitleID, and the one used on the API call by the creator of the booking', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'booking', @level2type = N'COLUMN', @level2name = N'CountryID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'It''s an initial setup flag, set on creation and no updated later. It lets know that payment processing is enabled on this booking, and later payment MUST be collected and performed. Payment must be enabled on the service professional account and optionally enable/disable for bookNow bookings depending on jobTitle and user setup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'booking', @level2type = N'COLUMN', @level2name = N'PaymentEnabled';

