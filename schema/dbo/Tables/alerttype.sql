CREATE TABLE [dbo].[alerttype] (
    [AlertTypeID]          INT           NOT NULL,
    [AlertTypeName]        VARCHAR (200) NOT NULL,
    [AlertTypeDescription] VARCHAR (200) NULL,
    [CreatedDate]          DATETIME      NOT NULL,
    [UpdatedDate]          DATETIME      NOT NULL,
    [ModifiedBy]           VARCHAR (25)  NOT NULL,
    [Active]               BIT           NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [DisplayRank]          INT           DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([AlertTypeID] ASC)
);
