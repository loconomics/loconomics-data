CREATE TABLE [dbo].[xJobTitleReviewRules] (
    [JobTitleID]                          INT         NOT NULL,
    [LanguageID]                          INT         NOT NULL,
    [CountryID]                           INT         NOT NULL,
    [SuppressReviewOfClient]              BIT         NOT NULL,
    [SuppressReviewOfServiceProfessional] BIT         NOT NULL,
    [RequestToReview]                     BIT         NOT NULL,
    [CreatedDate]                         DATETIME    NOT NULL,
    [UpdatedDate]                         DATETIME    NOT NULL,
    [ModifiedBy]                          VARCHAR (3) NOT NULL,
    [Active]                              BIT         NOT NULL,
    PRIMARY KEY CLUSTERED ([JobTitleID] ASC, [LanguageID] ASC, [CountryID] ASC)
);

