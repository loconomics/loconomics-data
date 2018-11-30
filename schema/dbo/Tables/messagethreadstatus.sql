CREATE TABLE [dbo].[messagethreadstatus] (
    [MessageThreadStatusID]          INT           NOT NULL,
    [MessageThreadStatusName]        VARCHAR (25)  NOT NULL,
    [MessageThreadStatusDescription] VARCHAR (100) NULL,
    [CreatedDate]                    DATETIME      NOT NULL,
    [UpdatedDate]                    DATETIME      NOT NULL,
    [ModifiedBy]                     VARCHAR (25)  NOT NULL,
    [Active]                         BIT           NOT NULL,
    [MessageStatusColor]             VARCHAR (7)   NOT NULL,
    CONSTRAINT [Pk_messagethreadstatus_0] PRIMARY KEY CLUSTERED ([MessageThreadStatusID] ASC),
    CONSTRAINT [Pk_messagethreadstatus] UNIQUE NONCLUSTERED ([MessageThreadStatusID] ASC)
);

