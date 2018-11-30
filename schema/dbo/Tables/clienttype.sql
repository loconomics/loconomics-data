CREATE TABLE [dbo].[clienttype] (
    [CllientTypeID]         INT           NOT NULL,
    [ClientTypeName]        VARCHAR (50)  NOT NULL,
    [ClientTypeDescription] VARCHAR (500) NULL,
    [LanguageID]            INT           NOT NULL,
    [CountryID]             INT           NOT NULL,
    [CreatedDate]           DATETIME      NOT NULL,
    [UpdatedDate]           DATETIME      NOT NULL,
    [ModifiedBy]            VARCHAR (25)  NULL,
    [Active]                BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([CllientTypeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_clienttype]
    ON [dbo].[clienttype]([CllientTypeID] ASC, [CountryID] ASC);

