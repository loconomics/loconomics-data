CREATE TABLE [dbo].[pricingSummary] (
    [PricingSummaryID]               INT            NOT NULL,
    [PricingSummaryRevision]         INT            CONSTRAINT [DF__pricinges__Prici__04CFADEC] DEFAULT ((1)) NOT NULL,
    [ServiceDurationMinutes]         INT            NULL,
    [FirstSessionDurationMinutes]    INT            NULL,
    [SubtotalPrice]                  DECIMAL (7, 2) NULL,
    [ClientServiceFeePrice]          DECIMAL (7, 2) NULL,
    [TotalPrice]                     DECIMAL (7, 2) NULL,
    [ServiceFeeAmount]               DECIMAL (7, 2) CONSTRAINT [DF_pricingestimate_PFeePrice] DEFAULT ((0)) NULL,
    [CreatedDate]                    DATETIME       NOT NULL,
    [UpdatedDate]                    DATETIME       NOT NULL,
    [ModifiedBy]                     VARCHAR (25)   NOT NULL,
    [Active]                         BIT            NOT NULL,
    [CancellationDate]               DATETIME       NULL,
    [CancellationFeeCharged]         DECIMAL (7, 2) NULL,
    [FirstTimeServiceFeeFixed]       DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeeFixed] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeePercentage]  DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeePercentage] DEFAULT ((0)) NOT NULL,
    [PaymentProcessingFeePercentage] DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_PaymentProcessingFeePercentage] DEFAULT ((0)) NOT NULL,
    [PaymentProcessingFeeFixed]      DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_PaymentProcessingFeeFixed] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeeMaximum]     DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeeMaximum] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeeMinimum]     DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeeMinimum] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK__pricinge__7F7D375D21D600EE] PRIMARY KEY CLUSTERED ([PricingSummaryID] ASC, [PricingSummaryRevision] ASC) WITH (FILLFACTOR = 100)
);

GO

ALTER TABLE [dbo].[pricingSummary] ADD
    CONSTRAINT [FK_pricingestimate_pricingestimate] FOREIGN KEY ([PricingSummaryID], [PricingSummaryRevision]) REFERENCES [dbo].[pricingSummary] ([PricingSummaryID], [PricingSummaryRevision])

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Payment processing fees price', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'pricingSummary', @level2type = N'COLUMN', @level2name = N'ServiceFeeAmount';

