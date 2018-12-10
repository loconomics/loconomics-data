CREATE TABLE [dbo].[JobTitlePlatform] (
    [JobTitleID]  INT                NOT NULL,
    [PlatformID]  INT                NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CreatedDate] DATETIMEOFFSET (0) NOT NULL,
    [UpdatedDate] DATETIMEOFFSET (0) NOT NULL,
    [ModifiedBy]  NVARCHAR (4)       NOT NULL,
    [Active]      BIT                CONSTRAINT [DF_JobTitlePlatform_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_JobTitlePlatform] PRIMARY KEY CLUSTERED ([JobTitleID] ASC, [PlatformID] ASC)
);

GO

ALTER TABLE [dbo].[JobTitlePlatform] ADD
    CONSTRAINT [FK_JobTitlePlatform_Platform] FOREIGN KEY ([PlatformID]) REFERENCES [dbo].[Platform] ([PlatformID])
