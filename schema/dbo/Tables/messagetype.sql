CREATE TABLE [dbo].[messagetype] (
    [MessageTypeID]          INT           NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [MessageTypeName]        VARCHAR (50)  NULL,
    [MessageTypeDescription] VARCHAR (200) NULL,
    [CreatedDate]            DATETIME      NOT NULL,
    [UpdatedDate]            DATETIME      NOT NULL,
    [ModifiedBy]             VARCHAR (25)  NOT NULL,
    [Active]                 BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([MessageTypeID] ASC),
    CONSTRAINT [Pk_messagetype] UNIQUE NONCLUSTERED ([MessageTypeID] ASC)
);
