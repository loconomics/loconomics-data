CREATE TABLE [dbo].[UserReviews] (
    [BookingID]          INT             NOT NULL,
    [CustomerUserID]     INT             NOT NULL,
    [ProviderUserID]     INT             NOT NULL,
    [PositionID]         INT             NOT NULL,
    [PrivateReview]      NVARCHAR (1000) NULL,
    [PublicReview]       NVARCHAR (500)  NULL,
    [Rating1]            TINYINT         NULL,
    [Rating2]            TINYINT         NULL,
    [Rating3]            TINYINT         NULL,
    [Rating4]            TINYINT         NULL,
    [Answer1]            BIT             NULL,
    [Answer2]            BIT             NULL,
    [Answer1Comment]     NVARCHAR (1000) NULL,
    [Answer2Comment]     NVARCHAR (1000) NULL,
    [ServiceHours]       DECIMAL (18, 5) CONSTRAINT [DF_UserReviews_ServiceHours] DEFAULT ((0)) NULL,
    [HelpfulReviewCount] BIGINT          CONSTRAINT [DF_UserReviews_HelpfulReviewCount] DEFAULT ((0)) NULL,
    [CreatedDate]        DATETIME        NOT NULL,
    [UpdatedDate]        DATETIME        NOT NULL,
    [ModifiedBy]         VARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_UserReviews] PRIMARY KEY CLUSTERED ([BookingID] ASC, [CustomerUserID] ASC, [ProviderUserID] ASC, [PositionID] ASC)
);

