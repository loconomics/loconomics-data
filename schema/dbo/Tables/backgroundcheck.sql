CREATE TABLE [dbo].[backgroundcheck] (
    [BackgroundCheckID]          INT            NOT NULL,
    [LanguageID]                 INT            NOT NULL,
    [CountryID]                  INT            NOT NULL,
    [BackgroundCheckName]        VARCHAR (100)  NOT NULL,
    [BackgroundCheckDescription] VARCHAR (1000) NULL,
    [CreatedDate]                DATETIME       NOT NULL,
    [UpdatedDate]                DATETIME       NOT NULL,
    [ModifiedBy]                 VARCHAR (25)   NOT NULL,
    [Active]                     BIT            NOT NULL,
    [BackGroundCheckPrice]       DECIMAL (5, 2) NULL,
    PRIMARY KEY CLUSTERED ([BackgroundCheckID] ASC)
);

