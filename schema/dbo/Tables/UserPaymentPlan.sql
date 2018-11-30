CREATE TABLE [dbo].[UserPaymentPlan] (
    [UserPaymentPlanID]          INT                IDENTITY (1, 1) NOT NULL,
    [UserID]                     INT                NOT NULL,
    [SubscriptionID]             VARCHAR (250)      NOT NULL,
    [PaymentPlan]                VARCHAR (25)       NOT NULL,
    [PaymentMethod]              VARCHAR (50)       NOT NULL,
    [PaymentPlanLastChangedDate] DATETIMEOFFSET (0) NOT NULL,
    [NextPaymentDueDate]         DATETIMEOFFSET (0) NULL,
    [NextPaymentAmount]          MONEY              NULL,
    [FirstBillingDate]           DATETIMEOFFSET (0) NOT NULL,
    [SubscriptionEndDate]        DATETIMEOFFSET (0) NULL,
    [PaymentMethodToken]         VARCHAR (250)      NOT NULL,
    [PaymentExpiryDate]          DATETIMEOFFSET (0) NULL,
    [PlanStatus]                 VARCHAR (50)       NOT NULL,
    [DaysPastDue]                INT                CONSTRAINT [DF_UserPaymentPlan_DaysPastDue] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK__Owner__1788CCAC6A7BAA63] PRIMARY KEY CLUSTERED ([UserPaymentPlanID] ASC)
);

