CREATE TABLE [dbo].[providertaxform] (
    [ProviderUserID]     INT           NOT NULL,
    [FullName]           VARCHAR (200) NOT NULL,
    [BusinessName]       VARCHAR (200) NULL,
    [StreetApt]          VARCHAR (100) NOT NULL,
    [City]               VARCHAR (100) NOT NULL,
    [PostalCodeID]       INT           NULL,
    [StateProvinceID]    INT           NOT NULL,
    [CountryID]          INT           NOT NULL,
    [TaxEntityTypeID]    INT           NOT NULL,
    [ExemptPayee]        BIT           NOT NULL,
    [TINTypeID]          VARCHAR (25)  NOT NULL,
    [Signature]          VARCHAR (200) NOT NULL,
    [UserIPAddress]      VARCHAR (500) NOT NULL,
    [DateTimeSubmitted]  DATETIME      NOT NULL,
    [CreatedDate]        DATETIME      NOT NULL,
    [UpdatedDate]        DATETIME      NOT NULL,
    [ModifiedBy]         VARCHAR (25)  NULL,
    [Active]             BIT           NOT NULL,
    [LastThreeTINDigits] VARCHAR (64)  NULL,
    CONSTRAINT [PK_providertaxform] PRIMARY KEY CLUSTERED ([ProviderUserID] ASC)
);

