CREATE TABLE [dbo].[backgroundcheck] (
    [BackgroundCheckID]          INT            NOT NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [BackgroundCheckName]        VARCHAR (100)  NOT NULL,
    [BackgroundCheckDescription] VARCHAR (1000) NULL,
    [CreatedDate]                DATETIME       NOT NULL,
    [UpdatedDate]                DATETIME       NOT NULL,
    [ModifiedBy]                 VARCHAR (25)   NOT NULL,
    [Active]                     BIT            NOT NULL,
    [BackGroundCheckPrice]       DECIMAL (5, 2) NULL,
    PRIMARY KEY CLUSTERED ([BackgroundCheckID] ASC)
);
