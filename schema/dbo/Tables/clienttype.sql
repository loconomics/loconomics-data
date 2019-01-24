CREATE TABLE [dbo].[clienttype] (
    [ClientTypeID]         INT           NOT NULL,
    [ClientTypeName]        VARCHAR (50)  NOT NULL,
    [ClientTypeDescription] VARCHAR (500) NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]           DATETIME      NOT NULL,
    [UpdatedDate]           DATETIME      NOT NULL,
    [ModifiedBy]            VARCHAR (25)  NULL,
    [Active]                BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([ClientTypeID] ASC)
);

GO
CREATE NONCLUSTERED INDEX [idx_clienttype]
    ON [dbo].[clienttype]([ClientTypeID] ASC);

