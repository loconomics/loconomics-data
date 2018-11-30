CREATE TABLE [dbo].[providerpackagedetail] (
    [ProviderPackageID]  INT          NOT NULL,
    [ServiceAttributeID] INT          NOT NULL,
    [CreatedDate]        DATETIME     DEFAULT ('sysdate') NOT NULL,
    [UpdatedDate]        DATETIME     DEFAULT ('sysdate') NOT NULL,
    [ModifiedBy]         VARCHAR (25) DEFAULT ('sys') NOT NULL,
    [Active]             BIT          DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_providerpackagedetail] PRIMARY KEY CLUSTERED ([ProviderPackageID] ASC, [ServiceAttributeID] ASC)
);

