CREATE TABLE [dbo].[addresstype] (
    [AddressTypeID] INT          NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [AddressType]   VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     NOT NULL,
    [UpdatedDate]   DATETIME     NOT NULL,
    [ModifiedBy]    VARCHAR (25) NOT NULL,
    [Active]        BIT          NOT NULL,
    [UniquePerUser] BIT          NOT NULL,
    [Selectable]    BIT          CONSTRAINT [DF_addresstype_Selectable] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK__addresst__9E7638F92C88998B] PRIMARY KEY CLUSTERED ([AddressTypeID] ASC)
);
