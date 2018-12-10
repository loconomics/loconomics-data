CREATE TABLE [dbo].[pricingtype] (
    [PricingTypeID] INT          NOT NULL,
    [LanguageID]    INT          CONSTRAINT [DF__pricingty__Langu__086B34A6] DEFAULT ((1)) NOT NULL,
    [CountryID]     INT          CONSTRAINT [DF__pricingty__Count__095F58DF] DEFAULT ((1)) NOT NULL,
    [Description]   VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     NOT NULL,
    [UpdatedDate]   DATETIME     NOT NULL,
    [ModifiedBy]    VARCHAR (50) NOT NULL,
    [Active]        BIT          CONSTRAINT [DF__pricingty__Activ__0A537D18] DEFAULT ((1)) NOT NULL,
    [DisplayRank]   INT          NOT NULL,
    CONSTRAINT [PK_pricingtype_PricingTypeID] PRIMARY KEY CLUSTERED ([PricingTypeID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [Pk_pricingtype] UNIQUE NONCLUSTERED ([PricingTypeID] ASC)
);

