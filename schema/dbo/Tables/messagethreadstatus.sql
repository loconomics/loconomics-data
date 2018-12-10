CREATE TABLE [dbo].[messagethreadstatus] (
    [MessageThreadStatusID]          INT           NOT NULL,
    [MessageThreadStatusName]        VARCHAR (25)  NOT NULL,
    [MessageThreadStatusDescription] VARCHAR (100) NULL,
    [CreatedDate]                    DATETIME      NOT NULL,
    [UpdatedDate]                    DATETIME      NOT NULL,
    [ModifiedBy]                     VARCHAR (25)  NOT NULL,
    [Active]                         BIT           NOT NULL,
    [MessageStatusColor]             VARCHAR (7)   NOT NULL,
    CONSTRAINT [Pk_messagethreadstatus] PRIMARY KEY CLUSTERED ([MessageThreadStatusID] ASC)
);

