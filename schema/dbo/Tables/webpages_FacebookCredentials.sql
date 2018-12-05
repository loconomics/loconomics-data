CREATE TABLE [dbo].[webpages_FacebookCredentials] (
    [id]         INT    NOT NULL IDENTITY (1, 1),
    [UserId]     INT    NOT NULL,
    [FacebookId] BIGINT NOT NULL,
    CONSTRAINT [PK_webpages_FacebookCredentials] PRIMARY KEY CLUSTERED ([id] ASC)
);
