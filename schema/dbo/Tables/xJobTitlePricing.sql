﻿CREATE TABLE [dbo].[xJobTitlePricing] (
    [JobTitlePricingID]                INT           NOT NULL,
    [JobTitleID]                       INT           NOT NULL,
    [PricingTypeID]                    INT           NOT NULL,
    [PricingTypeLabel]                 VARCHAR (100) NOT NULL,
    [PricingNameDefaultValue]          VARCHAR (100) NOT NULL,
    [PricingDescriptionPlaceholder]    VARCHAR (200) NOT NULL,
    [PricingRateUnitDefaultValue]      VARCHAR (100) NOT NULL,
    [PricingHelperLanguagePlaceholder] VARCHAR (500) DEFAULT ('en-US') NOT NULL,
    [IncludeTaskListOption]            BIT           NOT NULL,
    [RecurringEligible]                BIT           NOT NULL,
    [ShowFirstTimeClientsOnlyOption]   BIT           NOT NULL,
    [ShowExisitingClientsOnlyOption]   BIT           NOT NULL,
    [ShowSpecificClientOnlyOption]     BIT           NOT NULL,
    [ShowSlidingScaleOption]           BIT           NOT NULL,
    [ShowTradeOption]                  BIT           NOT NULL,
    [ShowServiceAreaOption]            BIT           NOT NULL,
    [ShowServiceLocationOption]        BIT           NOT NULL,
    [ShowRemoteLocationOption]         BIT           NOT NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [CreatedDate]                      DATETIME      NOT NULL,
    [UpdatedDate]                      DATETIME      NOT NULL,
    [ModifiedBy]                       VARCHAR (25)  NOT NULL,
    [Active]                           BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([JobTitlePricingID] ASC)
);

