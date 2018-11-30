CREATE TABLE [dbo].[OwnerStatusHistory] (
    [UserID]                 INT         NOT NULL,
    [OwnerStatusChangedDate] DATETIME    NOT NULL,
    [OwnerStatusID]          INT         NOT NULL,
    [OwnerStatusChangedBy]   VARCHAR (3) NOT NULL,
    CONSTRAINT [PK__OwnerSta__1788CCAC7F76C749] PRIMARY KEY CLUSTERED ([UserID] ASC, [OwnerStatusChangedDate] ASC)
);

