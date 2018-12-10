CREATE TABLE [dbo].[serviceattributecategory] (
    [ServiceAttributeCategoryID]          INT           NOT NULL,
    [ServiceAttributeCategory]            VARCHAR (200) NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CreateDate]                          DATETIME      NULL,
    [UpdatedDate]                         DATETIME      NULL,
    [ModifiedBy]                          VARCHAR (20)  NULL,
    [Active]                              BIT           NULL,
    [SourceID]                            INT           NULL,
    [PricingOptionCategory]               BIT           NULL,
    [ServiceAttributeCategoryDescription] VARCHAR (500) NULL,
    [RequiredInput]                       BIT           NOT NULL,
    [SideBarCategory]                     BIT           CONSTRAINT [DF_serviceattributecategory_SideBarCategory] DEFAULT ((0)) NOT NULL,
    [EligibleForPackages]                 BIT           CONSTRAINT [DF_serviceattributecategory_EligibleForPackages] DEFAULT ((0)) NOT NULL,
    [DisplayRank]                         INT           CONSTRAINT [DF__serviceat__Displ__3C0AD43D] DEFAULT ((1)) NOT NULL,
    [PositionReference]                   INT           NULL,
    [BookingPathSelection]                BIT           DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_serviceattributecategory] PRIMARY KEY CLUSTERED ([ServiceAttributeCategoryID] ASC)
);

