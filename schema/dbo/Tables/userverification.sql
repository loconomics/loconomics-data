CREATE TABLE [dbo].[userverification] (
    [UserID]               INT            NOT NULL,
    [VerificationID]       INT            NOT NULL,
    [PositionID]           INT            CONSTRAINT [DF_userverification_PositionID] DEFAULT ((0)) NOT NULL,
    [DateVerified]         DATETIME       NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [UpdatedDate]          DATETIME       NOT NULL,
    [VerifiedBy]           VARCHAR (25)   NOT NULL,
    [LastVerifiedDate]     DATETIME       NOT NULL,
    [Active]               BIT            NOT NULL,
    [VerificationStatusID] INT            NOT NULL,
    [Comments]             VARCHAR (2000) NULL,
    CONSTRAINT [PK_userverification] PRIMARY KEY CLUSTERED ([UserID] ASC, [VerificationID] ASC, [PositionID] ASC)
);

