CREATE TABLE [dbo].[servicecategory] (
    [ServiceCategoryID] INT           NOT NULL,
    [Name]              VARCHAR (45)  NULL,
    [Description]       VARCHAR (350) NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]       DATETIME      NULL,
    [UpdatedDate]       DATETIME      NULL,
    [ModifiedBy]        VARCHAR (2)   NULL,
    [Active]            BIT           NULL,
    [ImagePath]         VARCHAR (200) NULL,
    [headline]          VARCHAR (250) NULL,
    CONSTRAINT [PK_servicecategory] PRIMARY KEY CLUSTERED ([ServiceCategoryID] ASC)
);

