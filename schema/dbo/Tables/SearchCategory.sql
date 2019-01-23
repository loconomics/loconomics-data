CREATE TABLE [dbo].[SearchCategory] (
    [SearchCategoryID] INT                NOT NULL,
    [Name]             NVARCHAR (20)      NOT NULL,
    [ShortDescription] NVARCHAR (100)     NULL,
    [LongDescription]  NVARCHAR (300)     NULL,
    [SmallImage]       NVARCHAR (255)     NULL,
    [BannerImage]      NVARCHAR (255)     NULL,
    [DisplayRank]      INT                NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]       NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]           BIT                DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([SearchCategoryID] ASC)
);

