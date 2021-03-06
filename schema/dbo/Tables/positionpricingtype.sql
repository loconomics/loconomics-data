﻿CREATE TABLE [dbo].[positionpricingtype] (
    [PositionID]    INT          NOT NULL,
    [PricingTypeID] INT          NOT NULL,
    [ClientTypeID]  INT          NOT NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]   DATETIME     NOT NULL,
    [UpdatedDate]   DATETIME     NOT NULL,
    [ModifiedBy]    VARCHAR (25) NOT NULL,
    [Active]        BIT          NOT NULL,
    PRIMARY KEY CLUSTERED ([PositionID] ASC, [PricingTypeID] ASC, [ClientTypeID] ASC) WITH (FILLFACTOR = 100)
);

GO

ALTER TABLE [dbo].[positionpricingtype] ADD
    CONSTRAINT [Fk_positionpricingtype_pricingtype] FOREIGN KEY ([PricingTypeID]) REFERENCES [dbo].[pricingtype] ([PricingTypeID]),
    CONSTRAINT [Fk_positionpricingtype_positions] FOREIGN KEY ([PositionID]) REFERENCES [dbo].[positions] ([PositionID]),
    CONSTRAINT [Fk_positionpricingtype_clienttype] FOREIGN KEY ([ClientTypeID]) REFERENCES [dbo].[clienttype] ([ClientTypeID])
