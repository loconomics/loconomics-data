CREATE TABLE [dbo].[taxentitytype] (
    [TaxEntityTypeID]          INT           NOT NULL,
    [TaxEntityTypeName]        VARCHAR (75)  NULL,
    [TaxEntityTypeDescription] VARCHAR (300) NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CreatedDate]              DATETIME      NOT NULL,
    [UpdatedDate]              DATETIME      NOT NULL,
    [ModifiedBy]               VARCHAR (25)  NOT NULL,
    [Active]                   BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([TaxEntityTypeID] ASC)
);

