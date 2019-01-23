CREATE TABLE [dbo].[xJobTitleReviewRules] (
    [JobTitleID]                          INT         NOT NULL,
    [SuppressReviewOfClient]              BIT         NOT NULL,
    [SuppressReviewOfServiceProfessional] BIT         NOT NULL,
    [RequestToReview]                     BIT         NOT NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]                         DATETIME    NOT NULL,
    [UpdatedDate]                         DATETIME    NOT NULL,
    [ModifiedBy]                          VARCHAR (3) NOT NULL,
    [Active]                              BIT         NOT NULL,
    PRIMARY KEY CLUSTERED ([JobTitleID] ASC)
);

