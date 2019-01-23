CREATE TABLE [dbo].[cancellationpolicy] (
    [CancellationPolicyID]          INT            NOT NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CancellationPolicyName]        VARCHAR (50)   NOT NULL,
    [CancellationPolicyDescription] VARCHAR (1000) NULL,
    [HoursRequired]                 INT            NULL,
    [CancellationFeeAfter]          DECIMAL (5, 2) NULL,
    [CancellationFeeBefore]         DECIMAL (5, 2) NULL,
    [CreatedDate]                   DATETIME       NOT NULL,
    [UpdatedDate]                   DATETIME       NOT NULL,
    [ModifiedBy]                    VARCHAR (25)   NOT NULL,
    [Active]                        BIT            NOT NULL,
    CONSTRAINT [PK__cancella__4BAA8CCE7A0806B6] PRIMARY KEY CLUSTERED ([CancellationPolicyID] ASC)
);
