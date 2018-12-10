CREATE TABLE [dbo].[ServiceAttributeExperienceLevel] (
    [UserID]            INT          NOT NULL,
    [PositionID]        INT          NOT NULL,
    [ExperienceLevelID] INT          NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CreatedDate]       DATETIME     NOT NULL,
    [UpdatedDate]       DATETIME     NOT NULL,
    [ModifiedBy]        VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_ServiceAttributeExperienceLevel_1] PRIMARY KEY CLUSTERED ([UserID] ASC, [PositionID] ASC)
);

