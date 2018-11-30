CREATE TABLE [dbo].[ProviderPaymentAccount] (
    [ProviderUserID]    INT            NOT NULL,
    [MerchantAccountID] NVARCHAR (100) NOT NULL,
    [Status]            NVARCHAR (50)  NOT NULL,
    [Message]           NVARCHAR (400) NULL,
    [bt_signature]      NVARCHAR (MAX) NULL,
    [bt_payload]        NVARCHAR (MAX) NULL,
    [CreatedDate]       DATETIME       NOT NULL,
    [UpdatedDate]       DATETIME       NOT NULL,
    [ModifiedBy]        VARCHAR (25)   NOT NULL,
    CONSTRAINT [PK_ProviderPaymentAccount] PRIMARY KEY CLUSTERED ([ProviderUserID] ASC)
);

