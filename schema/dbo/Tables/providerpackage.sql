﻿CREATE TABLE [dbo].[providerpackage] (
    [ProviderPackageID]              INT            IDENTITY (1, 1) NOT NULL,
    [PricingTypeID]                  INT            NOT NULL,
    [ProviderUserID]                 INT            NOT NULL,
    [PositionID]                     INT            NOT NULL,
    [ProviderPackageName]            VARCHAR (50)   NOT NULL,
    [ProviderPackageDescription]     VARCHAR (1000) NULL,
    [ProviderPackagePrice]           DECIMAL (7, 2) NULL,
    [ProviderPackageServiceDuration] INT            NOT NULL,
    [FirstTimeClientsOnly]           BIT            CONSTRAINT [DF__providerp__First__1BD30ED5] DEFAULT ((0)) NOT NULL,
    [NumberOfSessions]               INT            CONSTRAINT [DF__providerp__Numbe__1CC7330E] DEFAULT ((1)) NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CreatedDate]                    DATETIME       NOT NULL,
    [UpdatedDate]                    DATETIME       NOT NULL,
    [ModifiedBy]                     VARCHAR (25)   NOT NULL,
    [Active]                         BIT            NOT NULL,
    [IsAddOn]                        BIT            CONSTRAINT [DF__providerp__IsAdd__1F398B65] DEFAULT ((0)) NOT NULL,
    [PriceRate]                      DECIMAL (7, 2) NULL,
    [PriceRateUnit]                  NVARCHAR (30)  COLLATE Modern_Spanish_CI_AS NULL,
    [IsPhone]                        BIT            CONSTRAINT [DF_providerpackage_IsPhone] DEFAULT ((0)) NOT NULL,
    [VisibleToClientID]              INT            DEFAULT ((0)) NOT NULL,
    [SolutionID]                     INT            CONSTRAINT [DF_providerpackage_SolutionID] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_providerpackage] PRIMARY KEY CLUSTERED ([ProviderPackageID] ASC)
);

