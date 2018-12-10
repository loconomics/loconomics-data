CREATE TABLE [dbo].[SearchSubCategory] (
    [SearchSubCategoryID] INT                NOT NULL,
    [LanguageID]          INT                NOT NULL,
    [CountryID]           INT                NOT NULL,
    [SearchCategoryID]    INT                NOT NULL,
    [Name]                NVARCHAR (40)      NOT NULL,
    [Description]         NVARCHAR (100)     NULL,
    [Image]               NVARCHAR (255)     NULL,
    [DisplayRank]         INT                NULL,
    [CreatedDate]         DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]         DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]          NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]              BIT                DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([SearchSubCategoryID] ASC)
);

GO

ALTER TABLE [dbo].[SearchSubCategory] ADD
    CONSTRAINT [FK_SearchSubCategory_SearchCategory] FOREIGN KEY ([SearchCategoryID]) REFERENCES [dbo].[SearchCategory] ([SearchCategoryID])
