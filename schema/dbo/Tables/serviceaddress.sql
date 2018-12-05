CREATE TABLE [dbo].[serviceaddress] (
    [AddressID]                   INT          NOT NULL,
    [UserID]                      INT          NOT NULL,
    [PositionID]                  INT          NOT NULL,
    [ServicesPerformedAtLocation] BIT          CONSTRAINT [DF__servicead__Servi__532343BF] DEFAULT ((0)) NOT NULL,
    [TravelFromLocation]          BIT          CONSTRAINT [DF__servicead__Trave__541767F8] DEFAULT ((0)) NOT NULL,
    [ServiceRadiusFromLocation]   VARCHAR (25) NULL,
    [TransportType]               INT          CONSTRAINT [DF__servicead__Trans__550B8C31] DEFAULT ((1)) NULL,
    [PreferredAddress]            BIT          CONSTRAINT [DF__servicead__Prefe__55FFB06A] DEFAULT ((0)) NOT NULL,
    [CreatedDate]                 DATETIME     NOT NULL,
    [UpdatedDate]                 DATETIME     NOT NULL,
    [ModifiedBy]                  VARCHAR (25) NOT NULL,
    [Active]                      BIT          NOT NULL,
    CONSTRAINT [PK__servicea__8F1793BE58DC1D15] PRIMARY KEY CLUSTERED ([AddressID] ASC, [UserID] ASC, [PositionID] ASC)
);

GO

ALTER TABLE [dbo].[serviceaddress] ADD
    CONSTRAINT [FK__servicead__UserI__56F3D4A3] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])
