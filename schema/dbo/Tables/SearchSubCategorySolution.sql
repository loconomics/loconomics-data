CREATE TABLE [dbo].[SearchSubCategorySolution] (
    [SearchSubCategoryID] INT                NOT NULL,
    [SolutionID]          INT                NOT NULL,
    [DisplayRank]         INT                NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]         DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]         DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]          NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    PRIMARY KEY CLUSTERED ([SearchSubCategoryID] ASC, [SolutionID] ASC)
);

GO

ALTER TABLE [dbo].[SearchSubCategorySolution] ADD
    CONSTRAINT [FK_SearchSubCategorySolution_SearchSubCategory] FOREIGN KEY ([SearchSubCategoryID]) REFERENCES [dbo].[SearchSubCategory] ([SearchSubCategoryID]),
    CONSTRAINT [FK_SearchSubCategorySolution_Solution] FOREIGN KEY ([SolutionID]) REFERENCES [dbo].[Solution] ([SolutionID])
