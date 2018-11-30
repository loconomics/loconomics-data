CREATE TABLE [dbo].[stateprovince] (
    [StateProvinceID]   INT           NOT NULL,
    [StateProvinceName] VARCHAR (100) NULL,
    [StateProvinceCode] VARCHAR (25)  NULL,
    [CountryID]         INT           NOT NULL,
    [RegionCode]        VARCHAR (25)  NULL,
    [PostalCodePrefix]  VARCHAR (25)  NULL,
    PRIMARY KEY CLUSTERED ([StateProvinceID] ASC)
);

