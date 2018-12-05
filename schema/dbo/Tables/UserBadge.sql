CREATE TABLE [dbo].[UserBadge] (
    [UserBadgeID] INT                IDENTITY (1, 1) NOT NULL,
    [UserID]      INT                NOT NULL,
    [SolutionID]  INT                NULL,
    [LanguageID]  INT                NOT NULL,
    [CountryID]   INT                NOT NULL,
    [BadgeURL]    NVARCHAR (255)     NOT NULL,
    [Type]        NVARCHAR (20)      NOT NULL,
    [Category]    NVARCHAR (50)      NOT NULL,
    [ExpiryDate]  DATETIMEOFFSET (0) NULL,
    [CreatedDate] DATETIMEOFFSET (0) NOT NULL,
    [UpdatedDate] DATETIMEOFFSET (0) NOT NULL,
    [CreatedBy]   NVARCHAR (4)       NOT NULL,
    [ModifiedBy]  NVARCHAR (4)       NOT NULL,
    [Active]      BIT                DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserBadge] PRIMARY KEY CLUSTERED ([UserBadgeID] ASC)
);

GO

ALTER TABLE [dbo].[UserBadge] ADD
    CONSTRAINT [FK_UserBadge_Solution] FOREIGN KEY ([SolutionID], [LanguageID], [CountryID]) REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID]),
    CONSTRAINT [FK_UserBadge_UserBadge] FOREIGN KEY ([UserBadgeID]) REFERENCES [dbo].[UserBadge] ([UserBadgeID]),
    CONSTRAINT [FK_UserBadge_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Special value ''user'' means createdy by the userID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserBadge', @level2type = N'COLUMN', @level2name = N'CreatedBy';

