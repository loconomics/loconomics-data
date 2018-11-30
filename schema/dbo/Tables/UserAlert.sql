CREATE TABLE [dbo].[UserAlert] (
    [UserID]        INT            NOT NULL,
    [PositionID]    INT            NOT NULL,
    [AlertID]       INT            NOT NULL,
    [CreatedDate]   DATETIME       NOT NULL,
    [UpdatedDate]   DATETIME       NOT NULL,
    [ModifiedBy]    VARCHAR (25)   NOT NULL,
    [CompletedDate] DATETIME       NULL,
    [Active]        BIT            NOT NULL,
    [AlertQuery]    VARCHAR (1000) NULL,
    [Dismissed]     BIT            CONSTRAINT [DF_UserAlert_Dismissed] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK__provider__D933DA027BB05806] PRIMARY KEY CLUSTERED ([UserID] ASC, [PositionID] ASC, [AlertID] ASC)
);

