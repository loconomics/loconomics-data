CREATE TABLE [dbo].[verificationcategory] (
    [VerificationCategoryID]          INT            NOT NULL,
    [LanguageID]                      INT            NOT NULL,
    [CountryID]                       INT            NOT NULL,
    [VerificationCategoryName]        VARCHAR (100)  NOT NULL,
    [VerificationCategoryDescription] VARCHAR (1000) NULL,
    [CreatedDate]                     DATETIME       NOT NULL,
    [UpdatedDate]                     DATETIME       NOT NULL,
    [ModifiedBy]                      VARCHAR (25)   NOT NULL,
    [Active]                          BIT            NOT NULL,
    [RankPosition]                    INT            NULL,
    PRIMARY KEY CLUSTERED ([VerificationCategoryID] ASC, [LanguageID] ASC, [CountryID] ASC)
);

