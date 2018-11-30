CREATE TABLE [dbo].[positionpricingtype] (
    [PositionID]    INT          NOT NULL,
    [PricingTypeID] INT          NOT NULL,
    [ClientTypeID]  INT          NOT NULL,
    [LanguageID]    INT          NOT NULL,
    [CountryID]     INT          NOT NULL,
    [CreatedDate]   DATETIME     NOT NULL,
    [UpdatedDate]   DATETIME     NOT NULL,
    [ModifiedBy]    VARCHAR (25) NOT NULL,
    [Active]        BIT          NOT NULL,
    PRIMARY KEY CLUSTERED ([PositionID] ASC, [PricingTypeID] ASC, [ClientTypeID] ASC, [LanguageID] ASC, [CountryID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [Fk_positionpricingtype] FOREIGN KEY ([PricingTypeID], [LanguageID], [CountryID]) REFERENCES [dbo].[pricingtype] ([PricingTypeID], [LanguageID], [CountryID]),
    CONSTRAINT [Fk_positionpricingtype_0] FOREIGN KEY ([PositionID], [LanguageID], [CountryID]) REFERENCES [dbo].[positions] ([PositionID], [LanguageID], [CountryID]),
    CONSTRAINT [Fk_positionpricingtype_1] FOREIGN KEY ([ClientTypeID], [LanguageID], [CountryID]) REFERENCES [dbo].[clienttype] ([CllientTypeID], [LanguageID], [CountryID])
);

