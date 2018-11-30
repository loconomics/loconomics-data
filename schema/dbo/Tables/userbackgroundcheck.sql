CREATE TABLE [dbo].[userbackgroundcheck] (
    [UserID]            INT           NOT NULL,
    [BackgroundCheckID] INT           NOT NULL,
    [CreatedDate]       DATETIME      NOT NULL,
    [ModifiedDate]      DATETIME      NOT NULL,
    [ModifiedBy]        VARCHAR (25)  NOT NULL,
    [StatusID]          INT           NOT NULL,
    [Summary]           VARCHAR (200) NULL,
    [VerifiedBy]        VARCHAR (25)  NULL,
    [LastVerifiedDate]  DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([BackgroundCheckID] ASC, [UserID] ASC),
    CONSTRAINT [FK__userbackg__Provi__4BB72C21] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])
);

