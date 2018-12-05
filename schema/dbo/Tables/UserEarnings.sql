CREATE TABLE [dbo].[UserEarnings] (
    [UserEarningsID] INT                IDENTITY (1, 1) NOT NULL,
    [UserID]         INT                NOT NULL,
    [PlatformID]     INT                NOT NULL,
    [ClientID]       INT                NOT NULL,
    [JobTitleID]     INT                NOT NULL,
    [Amount]         DECIMAL (10, 2)    NOT NULL,
    [Minutes]        INT                NOT NULL,
    [PaidDate]       DATETIMEOFFSET (0) NOT NULL,
    [Notes]          TEXT               NOT NULL,
    [CreatedDate]    DATETIMEOFFSET (0) NOT NULL,
    [UpdatedDate]    DATETIMEOFFSET (0) NOT NULL,
    [ModifiedBy]     NVARCHAR (4)       NOT NULL,
    [Active]         BIT                CONSTRAINT [DF_UserEarnings_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserEarnings] PRIMARY KEY CLUSTERED ([UserEarningsID] ASC)
);

GO

ALTER TABLE [dbo].[UserEarnings] ADD
    CONSTRAINT [FK_UserEarnings_UserEarnings] FOREIGN KEY ([UserEarningsID]) REFERENCES [dbo].[UserEarnings] ([UserEarningsID]),
    CONSTRAINT [FK_UserEarnings_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK_UserEarnings_users1] FOREIGN KEY ([ClientID]) REFERENCES [dbo].[users] ([UserID])
