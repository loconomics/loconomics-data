CREATE TABLE [dbo].[UserLicenseCertifications] (
    [userLicenseCertificationID] INT            IDENTITY (1, 1) NOT NULL,
    [ProviderUserID]             INT            NOT NULL,
    [PositionID]                 INT            NOT NULL,
    [LicenseCertificationID]     INT            NOT NULL,
    [VerificationStatusID]       INT            NOT NULL,
    [LicenseCertificationURL]    VARCHAR (2073) NULL,
    [LastName]                   VARCHAR (100)  NOT NULL,
    [FirstName]                  VARCHAR (100)  NOT NULL,
    [MiddleInitial]              VARCHAR (1)    NULL,
    [SecondLastName]             VARCHAR (100)  NULL,
    [BusinessName]               VARCHAR (200)  NULL,
    [LicenseCertificationNumber] VARCHAR (100)  NULL,
    [CreatedDate]                DATETIME       NOT NULL,
    [ExpirationDate]             DATETIME       NULL,
    [IssueDate]                  DATETIME       NULL,
    [Comments]                   VARCHAR (500)  NULL,
    [VerifiedBy]                 VARCHAR (25)   NULL,
    [LastVerifiedDate]           DATETIME       NULL,
    [SubmittedBy]                VARCHAR (25)   NULL,
    [SubmittedImageLocalURL]     VARCHAR (255)  NULL,
    PRIMARY KEY CLUSTERED ([userLicenseCertificationID] ASC)
);

GO

ALTER TABLE [dbo].[UserLicenseCertifications] ADD
    CONSTRAINT [FK_userlicen__ProviderUserID] FOREIGN KEY ([ProviderUserID]) REFERENCES [dbo].[users] ([UserID])
