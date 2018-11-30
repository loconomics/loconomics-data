CREATE TABLE [dbo].[userOrganization] (
    [userID]         INT                NOT NULL,
    [orgName]        NVARCHAR (200)     NOT NULL,
    [orgDescription] NVARCHAR (400)     NULL,
    [orgWebsite]     NVARCHAR (255)     NULL,
    [updatedDate]    DATETIMEOFFSET (0) NULL,
    CONSTRAINT [PK_userOrganization] PRIMARY KEY CLUSTERED ([userID] ASC),
    CONSTRAINT [FK_userOrganization_users] FOREIGN KEY ([userID]) REFERENCES [dbo].[users] ([UserID]) ON DELETE CASCADE ON UPDATE CASCADE
);

