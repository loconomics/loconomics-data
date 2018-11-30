CREATE TABLE [dbo].[PricingVariableValue] (
    [PricingVariableID]        INT            NOT NULL,
    [ProviderPackageID]        INT            NOT NULL,
    [UserID]                   INT            NOT NULL,
    [PricingEstimateID]        INT            NOT NULL,
    [PricingEstimateRevision]  INT            NOT NULL,
    [Value]                    VARCHAR (100)  NOT NULL,
    [ProviderNumberIncluded]   DECIMAL (7, 2) NULL,
    [ProviderMinNumberAllowed] DECIMAL (7, 2) NULL,
    [ProviderMaxNumberAllowed] DECIMAL (7, 2) NULL,
    [CreatedDate]              DATETIME       CONSTRAINT [DF_PricingVariableValue_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedDate]              DATETIME       CONSTRAINT [DF_PricingVariableValue_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]               VARCHAR (25)   CONSTRAINT [DF_PricingVariableValue_ModifiedBy] DEFAULT ('sys') NOT NULL,
    [Active]                   BIT            CONSTRAINT [DF_PricingVariableValue_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_PricingVariableValue] PRIMARY KEY CLUSTERED ([PricingVariableID] ASC, [ProviderPackageID] ASC, [UserID] ASC, [PricingEstimateID] ASC, [PricingEstimateRevision] ASC)
);

