CREATE TABLE [dbo].[Platform] (
    [PlatformID]       INT                NOT NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [Name]             NVARCHAR (20)      NOT NULL,
    [ShortDescription] NVARCHAR (50)      NOT NULL,
    [LongDescription]  TEXT               NOT NULL,
    [FeesDescription]  TEXT               NOT NULL,
    [PositiveAspects]  TEXT               NOT NULL,
    [NegativeAspects]  TEXT               NOT NULL,
    [Advice]           TEXT               NOT NULL,
    [SignUpURL]        NVARCHAR (255)     NOT NULL,
    [SignInURL]        NVARCHAR (255)     NOT NULL,
    [CreatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]      DATETIMEOFFSET (0) NOT NULL,
    [ModifiedBy]       NVARCHAR (4)       NOT NULL,
    [Active]           BIT                CONSTRAINT [DF_Platform_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Platform] PRIMARY KEY CLUSTERED ([PlatformID] ASC)
);

