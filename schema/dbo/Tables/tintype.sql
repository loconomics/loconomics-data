CREATE TABLE [dbo].[tintype] (
    [TINTypeID]          INT            NOT NULL,
    [TINTypeAbbr]        NVARCHAR (10)  COLLATE Modern_Spanish_CI_AS NOT NULL,
    [TINTypeName]        NVARCHAR (70)  NOT NULL,
    [TINTypeDescription] NVARCHAR (200) NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]        DATETIME       NOT NULL,
    [UpdatedDate]        DATETIME       NOT NULL,
    [ModifiedBy]         VARCHAR (25)   NOT NULL,
    [Active]             BIT            NOT NULL,
    CONSTRAINT [PK__tintype__5B7925DB119F9925] PRIMARY KEY CLUSTERED ([TINTypeID] ASC)
);

