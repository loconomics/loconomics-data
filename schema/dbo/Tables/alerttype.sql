CREATE TABLE [dbo].[alerttype] (
    [AlertTypeID]          INT           NOT NULL,
    [AlertTypeName]        VARCHAR (200) NOT NULL,
    [AlertTypeDescription] VARCHAR (200) NULL,
    [CreatedDate]          DATETIME      NOT NULL,
    [UpdatedDate]          DATETIME      NOT NULL,
    [ModifiedBy]           VARCHAR (25)  NOT NULL,
    [Active]               BIT           NOT NULL,
    [LanguageID]           INT           DEFAULT ((1)) NOT NULL,
    [CountryID]            INT           DEFAULT ((1)) NOT NULL,
    [DisplayRank]          INT           DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([AlertTypeID] ASC)
);

