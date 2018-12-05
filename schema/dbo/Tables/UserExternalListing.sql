CREATE TABLE [dbo].[UserExternalListing] (
    [UserExternalListingID] INT                IDENTITY (1, 1) NOT NULL,
    [UserID]                INT                NOT NULL,
    [PlatformID]            INT                NOT NULL,
    [Title]                 NVARCHAR (50)      NOT NULL,
    [JobTitles]             TEXT               NOT NULL,
    [Notes]                 TEXT               NOT NULL,
    [CreatedDate]           DATETIMEOFFSET (0) NOT NULL,
    [UpdatedDate]           DATETIMEOFFSET (0) NOT NULL,
    [ModifiedBy]            NVARCHAR (4)       NOT NULL,
    [Active]                BIT                CONSTRAINT [DF_UserExternalListing_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserExternalListing] PRIMARY KEY CLUSTERED ([UserExternalListingID] ASC)
);

GO

ALTER TABLE [dbo].[UserExternalListing] ADD
    CONSTRAINT [FK_UserExternalListing_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'JSON array with { jobTitleID: jobTitleSingularName }', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserExternalListing', @level2type = N'COLUMN', @level2name = N'JobTitles';

