CREATE TABLE [dbo].[UserFeePayments] (
    [UserFeePaymentID]     INT                IDENTITY (1, 1) NOT NULL,
    [UserID]               INT                NOT NULL,
    [PaymentTransactionID] VARCHAR (250)      NOT NULL,
    [SubscriptionID]       VARCHAR (250)      NOT NULL,
    [PaymentDate]          DATETIMEOFFSET (0) NOT NULL,
    [PaymentAmount]        MONEY              NOT NULL,
    [PaymentPlan]          VARCHAR (25)       NOT NULL,
    [PaymentMethod]        VARCHAR (50)       NOT NULL,
    [PaymentStatus]        VARCHAR (50)       NOT NULL,
    [CreatedDate]          DATETIMEOFFSET (0) NOT NULL,
    [ModifiedDate]         DATETIMEOFFSET (0) NOT NULL,
    CONSTRAINT [PK__UserFeeP__1788CCAC0347582D] PRIMARY KEY CLUSTERED ([UserFeePaymentID] ASC)
);

