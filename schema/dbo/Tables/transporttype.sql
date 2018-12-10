CREATE TABLE [dbo].[transporttype] (
    [TransportTypeID]          INT           NOT NULL,
    [LanguageID]               INT           NOT NULL,
    [CountryID]                INT           NOT NULL,
    [TransportTypeName]        VARCHAR (50)  NOT NULL,
    [TransportTypeDescription] VARCHAR (300) NULL,
    [CreatedDate]              DATETIME      NOT NULL,
    [UpdatedDate]              DATETIME      NOT NULL,
    [ModifiedBy]               VARCHAR (25)  NOT NULL,
    [Active]                   BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([TransportTypeID] ASC)
);

