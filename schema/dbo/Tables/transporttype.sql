CREATE TABLE [dbo].[transporttype] (
    [TransportTypeID]          INT           NOT NULL,
    [TransportTypeName]        VARCHAR (50)  NOT NULL,
    [TransportTypeDescription] VARCHAR (300) NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]              DATETIME      NOT NULL,
    [UpdatedDate]              DATETIME      NOT NULL,
    [ModifiedBy]               VARCHAR (25)  NOT NULL,
    [Active]                   BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([TransportTypeID] ASC)
);

