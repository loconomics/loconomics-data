CREATE TABLE [dbo].[providerpaymentpreferencetype] (
    [ProviderPaymentPreferenceTypeID]          INT           NOT NULL,
    [ProviderPaymentPreferenceTypeName]        VARCHAR (50)  NOT NULL,
    [ProviderPaymentPreferenceTypeDescription] VARCHAR (300) NULL,
    [DependsOnID]                              INT           NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CreatedDate]                              DATETIME      NOT NULL,
    [UpdatedDate]                              DATETIME      NOT NULL,
    [ModifiedBy]                               VARCHAR (25)  NOT NULL,
    [Active]                                   BIT           NOT NULL,
    CONSTRAINT [PK__provider__A7C3000A031C6FA4] PRIMARY KEY CLUSTERED ([ProviderPaymentPreferenceTypeID] ASC)
);

