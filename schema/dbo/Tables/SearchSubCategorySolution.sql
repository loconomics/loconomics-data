CREATE TABLE [dbo].[SearchSubCategorySolution] (
    [SearchSubCategoryID] INT                NOT NULL,
    [SolutionID]          INT                NOT NULL,
    [LanguageID]          INT                NOT NULL,
    [CountryID]           INT                NOT NULL,
    [DisplayRank]         INT                NULL,
    [CreatedDate]         DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]         DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]          NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    PRIMARY KEY CLUSTERED ([SearchSubCategoryID] ASC, [SolutionID] ASC, [LanguageID] ASC, [CountryID] ASC)
);

GO

ALTER TABLE [dbo].[SearchSubCategorySolution] ADD
    CONSTRAINT [FK_SearchSubCategorySolution_language] FOREIGN KEY ([LanguageID], [CountryID]) REFERENCES [dbo].[language] ([LanguageID], [CountryID]),
    CONSTRAINT [FK_SearchSubCategorySolution_SearchSubCategory] FOREIGN KEY ([SearchSubCategoryID], [LanguageID], [CountryID]) REFERENCES [dbo].[SearchSubCategory] ([SearchSubCategoryID], [LanguageID], [CountryID]),
    CONSTRAINT [FK_SearchSubCategorySolution_Solution] FOREIGN KEY ([SolutionID], [LanguageID], [CountryID]) REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID])
