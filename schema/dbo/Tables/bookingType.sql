CREATE TABLE [dbo].[bookingType] (
    [BookingTypeID]                  INT            NOT NULL,
    [BookingTypeName]                VARCHAR (50)   NOT NULL,
    [BookingTypeDescription]         VARCHAR (500)  NULL,
    [CreatedDate]                    DATETIME       NOT NULL,
    [UpdatedDate]                    DATETIME       NOT NULL,
    [ModifiedBy]                     VARCHAR (25)   NOT NULL,
    [Active]                         BIT            NOT NULL,
    [FirstTimeServiceFeeFixed]       DECIMAL (5, 2) CONSTRAINT [DF__bookingty__Servi__2215F810] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeePercentage]  DECIMAL (5, 2) CONSTRAINT [DF__bookingty__Servi__230A1C49] DEFAULT ((0)) NOT NULL,
    [PaymentProcessingFeePercentage] DECIMAL (5, 2) CONSTRAINT [DF__bookingty__Payme__23FE4082] DEFAULT ((0)) NOT NULL,
    [PaymentProcessingFeeFixed]      DECIMAL (5, 2) CONSTRAINT [DF_bookingtype_PaymentProcessingFeeFixed] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeeMaximum]     DECIMAL (5, 2) CONSTRAINT [DF_bookingtype_FirstTimeServiceFeeMaximum] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeeMinimum]     DECIMAL (5, 2) CONSTRAINT [DF_bookingtype_FirstTimeServiceFeeMinimum] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK__bookingt__649EC4B15090EFD7] PRIMARY KEY CLUSTERED ([BookingTypeID] ASC)
);

