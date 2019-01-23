CREATE TABLE [dbo].[pricingtype] (
    [PricingTypeID] INT          NOT NULL,
    [Description]   VARCHAR (50) NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]   DATETIME     NOT NULL,
    [UpdatedDate]   DATETIME     NOT NULL,
    [ModifiedBy]    VARCHAR (50) NOT NULL,
    [Active]        BIT          CONSTRAINT [DF__pricingty__Activ__0A537D18] DEFAULT ((1)) NOT NULL,
    [DisplayRank]   INT          NOT NULL,
    CONSTRAINT [PK_pricingtype_PricingTypeID] PRIMARY KEY CLUSTERED ([PricingTypeID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [Pk_pricingtype] UNIQUE NONCLUSTERED ([PricingTypeID] ASC)
);

