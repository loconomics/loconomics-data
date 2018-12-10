CREATE TABLE [dbo].[positions] (
    [PositionID]                 INT            NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [PositionSingular]           VARCHAR (250)  NULL,
    [PositionPlural]             VARCHAR (250)  NULL,
    [Aliases]                    VARCHAR (200)  NULL,
    [PositionDescription]        VARCHAR (2000) NULL,
    [CreatedDate]                DATETIME       NULL,
    [UpdatedDate]                DATETIME       NULL,
    [ModifiedBy]                 VARCHAR (2)    NULL,
    [GovID]                      VARCHAR (20)   NULL,
    [GovPosition]                VARCHAR (200)  NULL,
    [GovPositionDescription]     VARCHAR (2000) NULL,
    [Active]                     BIT            NULL,
    [DisplayRank]                INT            NULL,
    [PositionSearchDescription]  VARCHAR (1000) NULL,
    [AttributesComplete]         BIT            CONSTRAINT [DF_positions_AttributesComplete] DEFAULT ((0)) NOT NULL,
    [StarRatingsComplete]        BIT            CONSTRAINT [DF_positions_StarRatingsComplete] DEFAULT ((0)) NOT NULL,
    [PricingTypeComplete]        BIT            CONSTRAINT [DF_positions_PricingTypeComplete] DEFAULT ((0)) NOT NULL,
    [EnteredByUserID]            INT            NULL,
    [Approved]                   BIT            NULL,
    [AddGratuity]                INT            DEFAULT ((0)) NOT NULL,
    [HIPAA]                      BIT            DEFAULT ((0)) NOT NULL,
    [SendReviewReminderToClient] BIT            DEFAULT ((1)) NOT NULL,
    [CanBeRemote]                BIT            DEFAULT ((0)) NOT NULL,
    [SuppressReviewOfClient]     BIT            DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_positions_1] PRIMARY KEY CLUSTERED ([PositionID] ASC)
);

GO

CREATE NONCLUSTERED INDEX [idx_positions]
    ON [dbo].[positions]([PositionID] ASC);
