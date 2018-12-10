CREATE TABLE [dbo].[UserSolution] (
    [UserSolutionID] INT                IDENTITY (1, 1) NOT NULL,
    [UserID]         INT                NOT NULL,
    [UserListingID]  INT                NOT NULL,
    [SolutionID]     INT                NOT NULL,
    [LanguageID]     INT                NOT NULL,
    [CountryID]      INT                NOT NULL,
    [DisplayRank]    INT                NULL,
    [CreatedDate]    DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]    DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]     NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]         BIT                DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserSolution] PRIMARY KEY CLUSTERED ([UserSolutionID] ASC)
);

GO

ALTER TABLE [dbo].[UserSolution] ADD
    CONSTRAINT [FK_UserSolution_Solution] FOREIGN KEY ([SolutionID]) REFERENCES [dbo].[Solution] ([SolutionID]),
    CONSTRAINT [FK_UserSolution_userprofilepositions] FOREIGN KEY ([UserListingID]) REFERENCES [dbo].[userprofilepositions] ([UserListingID]),
    CONSTRAINT [FK_UserSolution_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])
