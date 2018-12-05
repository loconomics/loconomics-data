CREATE TABLE [dbo].[postalcode] (
    [PostalCodeID]    INT           NOT NULL,
    [PostalCode]      VARCHAR (25)  NULL,
    [City]            VARCHAR (250) NULL,
    [StateProvinceID] INT           NOT NULL,
    [CountryID]       INT           NOT NULL,
    [Latitude]        FLOAT (53)    NULL,
    [Longitude]       FLOAT (53)    NULL,
    [StandardOffset]  DECIMAL (18)  NULL,
    [DST]             BIT           NULL,
    [Location]        VARCHAR (250) NULL,
    [PostalCodeType]  VARCHAR (50)  NULL,
    [CreatedDate]     DATETIME      NULL,
    [UpdatedDate]     DATETIME      NULL,
    [ModifiedBy]      VARCHAR (25)  NULL,
    [MunicipalityID]  INT           DEFAULT ((0)) NOT NULL,
    [CountyID]        INT           DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([PostalCodeID] ASC)
);

GO

ALTER TABLE [dbo].[postalcode] ADD
    CONSTRAINT [FK__postalcode__CountyID] FOREIGN KEY ([CountyID]) REFERENCES [dbo].[county] ([CountyID]),
    CONSTRAINT [FK__postalcode__MunicipalityID] FOREIGN KEY ([MunicipalityID]) REFERENCES [dbo].[municipality] ([MunicipalityID]),
    CONSTRAINT [FK__postalcode__StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [dbo].[stateprovince] ([StateProvinceID])
