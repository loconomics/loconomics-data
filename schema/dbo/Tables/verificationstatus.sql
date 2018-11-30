CREATE TABLE [dbo].[verificationstatus] (
    [VerificationStatusID]                 INT           NOT NULL,
    [LanguageID]                           INT           NOT NULL,
    [CountryID]                            INT           NOT NULL,
    [VerificationStatusName]               VARCHAR (50)  NOT NULL,
    [VerificationStatusDisplayDescription] VARCHAR (300) NULL,
    [CreatedDate]                          DATETIME      NOT NULL,
    [UpdatedDate]                          DATETIME      NOT NULL,
    [ModifiedBy]                           VARCHAR (25)  NOT NULL,
    [Active]                               BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([VerificationStatusID] ASC, [LanguageID] ASC, [CountryID] ASC)
);

