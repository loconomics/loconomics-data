CREATE TABLE [dbo].[UserReviewScores] (
    [UserID]         INT             NOT NULL,
    [PositionID]     INT             NOT NULL,
    [TotalRatings]   BIGINT          NULL,
    [Rating1]        DECIMAL (18, 2) NULL,
    [Rating2]        DECIMAL (18, 2) NULL,
    [Rating3]        DECIMAL (18, 2) NULL,
    [Rating4]        DECIMAL (18, 2) NULL,
    [Answer1]        BIGINT          NULL,
    [Answer2]        BIGINT          NULL,
    [ServiceHours]   DECIMAL (18, 2) NULL,
    [LastRatingDate] DATETIME        NULL,
    [CreatedDate]    DATETIME        NOT NULL,
    [UpdatedDate]    DATETIME        NOT NULL,
    [ModifiedBy]     VARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_ReviewScores_positionID_userID] PRIMARY KEY CLUSTERED ([PositionID] ASC, [UserID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Average of total ratings for Rating1 value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Rating1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Average of total ratings for Rating1 value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Rating2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Average of total ratings for Rating1 value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Rating3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Average of total ratings for Rating1 value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Rating4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Number of ratings with a positive answer in Answer1 (value 1, true, yes)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Answer1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Number of ratings with a positive answer in Answer2 (value 1, true, yes)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Answer2';

