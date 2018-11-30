CREATE TABLE [dbo].[UserListingSpecialization] (
    [UserID]           INT                NOT NULL,
    [UserListingID]    INT                NOT NULL,
    [SpecializationID] INT                NOT NULL,
    [LanguageID]       INT                NOT NULL,
    [CountryID]        INT                NOT NULL,
    [DisplayRank]      INT                NULL,
    [CreatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]       NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]           BIT                DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC, [UserListingID] ASC, [SpecializationID] ASC, [LanguageID] ASC, [CountryID] ASC),
    CONSTRAINT [FK_UserListingSpecialization_Specialization] FOREIGN KEY ([SpecializationID], [LanguageID], [CountryID]) REFERENCES [dbo].[Specialization] ([SpecializationID], [LanguageID], [CountryID]),
    CONSTRAINT [FK_UserListingSpecialization_userprofilepositions] FOREIGN KEY ([UserListingID]) REFERENCES [dbo].[userprofilepositions] ([UserListingID]),
    CONSTRAINT [FK_UserListingSpecialization_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])
);

