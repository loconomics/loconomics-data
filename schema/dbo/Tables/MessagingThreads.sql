CREATE TABLE [dbo].[MessagingThreads] (
    [ThreadID]              INT            IDENTITY (1, 1) NOT NULL,
    [CustomerUserID]        INT            NOT NULL,
    [ProviderUserID]        INT            NOT NULL,
    [PositionID]            INT            NULL,
    [MessageThreadStatusID] INT            NOT NULL,
    [Subject]               NVARCHAR (100) NULL,
    [LastMessageID]         INT            NULL,
    [CreatedDate]           DATETIME       NOT NULL,
    [UpdatedDate]           DATETIME       NOT NULL,
    [ModifiedBy]            VARCHAR (50)   NOT NULL,
    CONSTRAINT [PK__Messagin__688356E41EC48A19] PRIMARY KEY CLUSTERED ([ThreadID] ASC)
);

GO

ALTER TABLE [dbo].[MessagingThreads] ADD
    CONSTRAINT [Fk_MessagingThreads_2] FOREIGN KEY ([CustomerUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK_MessagingThreads_Messages] FOREIGN KEY ([LastMessageID]) REFERENCES [dbo].[Messages] ([MessageID]),
    CONSTRAINT [FK_MessagingThreads_messagethreadstatus] FOREIGN KEY ([MessageThreadStatusID]) REFERENCES [dbo].[messagethreadstatus] ([MessageThreadStatusID]),
    CONSTRAINT [FK_MessagingThreads_users] FOREIGN KEY ([ProviderUserID]) REFERENCES [dbo].[users] ([UserID])
