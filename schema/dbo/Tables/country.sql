CREATE TABLE [dbo].[country] (
    [CountryID]          INT           NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CountryName]        VARCHAR (100) NOT NULL,
    [CountryCode]        VARCHAR (3)   NOT NULL,
    [CountryCodeAlpha2]  CHAR (2)      NULL,
    [CountryCallingCode] VARCHAR (3)   NULL,
    [CreatedDate]        DATETIME      NULL,
    [UpdatedDate]        DATETIME      NULL,
    [ModifiedBy]         VARCHAR (25)  NULL,
    [Active]             BIT           NOT NULL,
    [numcode]            INT           NULL,
    CONSTRAINT [PK__country__BB42E5E768D28DBC] PRIMARY KEY CLUSTERED ([CountryID] ASC) WITH (FILLFACTOR = 100)
);
