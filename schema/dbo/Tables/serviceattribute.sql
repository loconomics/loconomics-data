CREATE TABLE [dbo].[serviceattribute] (
    [ServiceAttributeID]          INT            NOT NULL,
    [SourceID]                    INT            DEFAULT (NULL) NULL,
    [Name]                        VARCHAR (100)  NULL,
    [ServiceAttributeDescription] VARCHAR (2000) NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CreateDate]                  DATETIME       NULL,
    [UpdatedDate]                 DATETIME       NULL,
    [ModifiedBy]                  VARCHAR (45)   NULL,
    [Active]                      BIT            NULL,
    [DisplayRank]                 INT            DEFAULT ((1)) NOT NULL,
    [PositionReference]           INT            NULL,
    [EnteredByUserID]             INT            NULL,
    [Approved]                    BIT            NULL,
    CONSTRAINT [PK_serviceattribute] PRIMARY KEY CLUSTERED ([ServiceAttributeID] ASC)
);

