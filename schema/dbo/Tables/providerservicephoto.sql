CREATE TABLE [dbo].[providerservicephoto] (
    [ProviderServicePhotoID] INT            IDENTITY (1, 1) NOT NULL,
    [UserID]                 INT            NOT NULL,
    [PositionID]             INT            NOT NULL,
    [PhotoCaption]           VARCHAR (150)  NULL,
    [PhotoAddress]           VARCHAR (2073) NOT NULL,
    [RankPosition]           INT            NOT NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [UpdatedDate]            DATETIME       NOT NULL,
    [ModifiedBy]             VARCHAR (25)   NOT NULL,
    [Active]                 BIT            NOT NULL,
    [IsPrimaryPhoto]         BIT            NOT NULL,
    CONSTRAINT [PK__servicep__D5090DBE39E294A9] PRIMARY KEY CLUSTERED ([ProviderServicePhotoID] ASC)
);

