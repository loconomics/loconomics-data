CREATE TABLE [dbo].[accountstatus] (
    [AccountStatusID]          INT           NOT NULL,
    [AccountStatusName]        VARCHAR (25)  NOT NULL,
    [AccountStatusDescription] VARCHAR (200) NULL,
    [CreatedDate]              DATETIME      NOT NULL,
    [UpdatedDate]              DATETIME      NOT NULL,
    [ModifiedBy]               VARCHAR (25)  DEFAULT ('sys') NOT NULL,
    [Active]                   BIT           DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([AccountStatusID] ASC)
);

