CREATE TABLE [dbo].[ReferralSource] (
    [ReferralSourceID] INT           NOT NULL,
    [Name]             NVARCHAR (80) NOT NULL,
    CONSTRAINT [PK_ReferralSource] PRIMARY KEY CLUSTERED ([ReferralSourceID] ASC)
);

