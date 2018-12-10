CREATE TABLE [dbo].[servicesubcategory] (
    [ServiceSubCategoryID] INT           NOT NULL,
    [LanguageID]           INT           NOT NULL,
    [CountryID]            INT           NOT NULL,
    [Name]                 VARCHAR (45)  NULL,
    [Description]          VARCHAR (250) NULL,
    [CreatedDate]          DATETIME      NULL,
    [UpdatedDate]          DATETIME      NULL,
    [ModifiedBy]           VARCHAR (2)   NULL,
    [Active]               BIT           NULL,
    [ServiceCategoryID]    INT           NULL,
    [Rank]                 INT           NULL,
    [RankQuery]            VARCHAR (200) NULL,
    CONSTRAINT [PK_servicesubcategory] PRIMARY KEY CLUSTERED ([ServiceSubCategoryID] ASC)
);

GO

ALTER TABLE [dbo].[servicesubcategory] ADD
    CONSTRAINT [FK_servicesubcategory_servicecategory] FOREIGN KEY ([ServiceCategoryID]) REFERENCES [dbo].[servicecategory] ([ServiceCategoryID])
