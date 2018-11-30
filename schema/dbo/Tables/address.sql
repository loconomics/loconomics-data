CREATE TABLE [dbo].[address] (
    [AddressID]           INT            IDENTITY (1, 1) NOT NULL,
    [UserID]              INT            NOT NULL,
    [AddressTypeID]       INT            NOT NULL,
    [AddressName]         VARCHAR (50)   NOT NULL,
    [AddressLine1]        VARCHAR (100)  NOT NULL,
    [AddressLine2]        VARCHAR (100)  NULL,
    [City]                VARCHAR (100)  NOT NULL,
    [StateProvinceID]     INT            NOT NULL,
    [PostalCodeID]        INT            NOT NULL,
    [CountryID]           INT            NOT NULL,
    [Latitude]            FLOAT (53)     NULL,
    [Longitude]           FLOAT (53)     NULL,
    [GoogleMapsURL]       VARCHAR (2073) NULL,
    [SpecialInstructions] VARCHAR (1000) NULL,
    [CreatedDate]         DATETIME       NOT NULL,
    [UpdatedDate]         DATETIME       NOT NULL,
    [ModifiedBy]          VARCHAR (25)   NOT NULL,
    [Active]              BIT            NULL,
    [CreatedBy]           INT            NOT NULL,
    CONSTRAINT [PK_address_1] PRIMARY KEY CLUSTERED ([AddressID] ASC)
);

