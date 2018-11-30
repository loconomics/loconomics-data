CREATE TABLE [dbo].[providerpaymentpreference] (
    [ProviderUserID]                  INT           NOT NULL,
    [ProviderPaymentPreferenceTypeID] INT           NOT NULL,
    [CreatedDate]                     DATETIME      NOT NULL,
    [UpdatedDate]                     DATETIME      NOT NULL,
    [Modifiedby]                      VARCHAR (25)  NOT NULL,
    [Verified]                        BIT           CONSTRAINT [DF__providerp__Verif__08D548FA] DEFAULT ((0)) NOT NULL,
    [AccountName]                     VARCHAR (100) NULL,
    [ABANumber]                       NUMERIC (9)   NULL,
    [LastThreeAccountDigits]          VARCHAR (64)  NULL,
    CONSTRAINT [PK_providerpaymentpreference] PRIMARY KEY CLUSTERED ([ProviderUserID] ASC)
);

