CREATE TABLE [dbo].[OwnerStatus] (
    [OwnserStatusID]         INT           NOT NULL,
    [OwnerStatusName]        VARCHAR (50)  NOT NULL,
    [OwnerStatusDescription] VARCHAR (200) NULL,
    [CreatedDate]            DATETIME      NOT NULL,
    [UpdatedDate]            DATETIME      NOT NULL,
    [Active]                 BIT           NOT NULL,
    [UpdatedBy]              VARCHAR (3)   NULL,
    CONSTRAINT [PK_OwnerStatus] PRIMARY KEY CLUSTERED ([OwnserStatusID] ASC)
);

