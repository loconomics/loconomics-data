CREATE TABLE [dbo].[VOCExperienceCategory] (
    [VOCExperienceCategoryID]          INT           NOT NULL,
    [VOCExperienceCategoryName]        VARCHAR (50)  NULL,
    [VOCExperienceCategoryDescription] VARCHAR (200) NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreateDate]                       DATETIME      NOT NULL,
    [UpdatedDate]                      DATETIME      NOT NULL,
    [ModifiedBy]                       VARCHAR (3)   NOT NULL,
    [Active]                           BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([VOCExperienceCategoryID] ASC)
);

