CREATE TABLE [dbo].[authorizations] (
    [id]            INT                IDENTITY (1, 1) NOT NULL,
    [Token]         VARCHAR (216)      NOT NULL,
    [UserID]        INT                NOT NULL,
    [Scope]         VARCHAR (100)      NOT NULL,
    [CreatedDate]   DATETIMEOFFSET (0) NOT NULL,
    [DeletedDate]   DATETIMEOFFSET (0) NULL,
    [ClientAddress] VARCHAR (64)       NULL,
    [UserAgent]     TEXT               NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_authorizations_token]
    ON [dbo].[authorizations]([Token] ASC);

