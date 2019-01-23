CREATE TABLE [dbo].[verification] (
    [VerificationID]          INT            NOT NULL,
    [VerificationType]        VARCHAR (100)  NOT NULL,
    [VerificationDescription] VARCHAR (1000) NOT NULL,
    [VerificationProcess]     VARCHAR (500)  NULL,
    [Icon]                    VARCHAR (15)   NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]             DATETIME       NOT NULL,
    [ModifiedDate]            DATETIME       NOT NULL,
    [ModifiedBy]              VARCHAR (25)   NULL,
    [Active]                  BIT            NOT NULL,
    [VerificationCategoryID]  INT            NOT NULL,
    [RankPosition]            INT            NULL,
    [SummaryGroup]            VARCHAR (20)   NULL,
    CONSTRAINT [PK__verficat__25EE1D1F0C1BC9F9] PRIMARY KEY CLUSTERED ([VerificationID] ASC)
);

