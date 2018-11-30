CREATE TABLE [dbo].[positionratings] (
    [PositionID]                INT            NOT NULL,
    [LanguageID]                INT            NOT NULL,
    [CountryID]                 INT            NOT NULL,
    [Rating1]                   VARCHAR (25)   NOT NULL,
    [Rating2]                   VARCHAR (25)   NOT NULL,
    [Rating3]                   VARCHAR (25)   NOT NULL,
    [Rating4]                   VARCHAR (25)   NULL,
    [Rating1FormDescription]    VARCHAR (1000) NULL,
    [Rating2FormDescription]    VARCHAR (1000) NULL,
    [Rating3FormDescription]    VARCHAR (1000) NULL,
    [Rating4FormDescription]    VARCHAR (1000) NULL,
    [Rating1ProfileDescription] VARCHAR (1000) NULL,
    [Rating2ProfileDescription] VARCHAR (1000) NULL,
    [Rating3ProfileDescription] VARCHAR (1000) NULL,
    [Rating4ProfileDescription] VARCHAR (1000) NULL,
    [CreatedDate]               DATETIME       NOT NULL,
    [UpdatedDate]               DATETIME       NOT NULL,
    [ModifiedBy]                VARCHAR (25)   NOT NULL,
    CONSTRAINT [PK__position__E3225E7D52EE3995] PRIMARY KEY CLUSTERED ([CountryID] ASC, [LanguageID] ASC, [PositionID] ASC)
);

