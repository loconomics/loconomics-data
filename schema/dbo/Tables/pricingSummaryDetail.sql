CREATE TABLE [dbo].[pricingSummaryDetail] (
    [PricingSummaryID]             INT            NOT NULL,
    [PricingSummaryRevision]       INT            NOT NULL,
    [ServiceProfessionalServiceID] INT            NOT NULL,
    [ServiceProfessionalDataInput] VARCHAR (100)  NULL,
    [ClientDataInput]              VARCHAR (500)  NULL,
    [HourlyPrice]                  DECIMAL (5, 2) NULL,
    [Price]                        DECIMAL (7, 2) NULL,
    [ServiceDurationMinutes]       INT            NULL,
    [FirstSessionDurationMinutes]  INT            NULL,
    [ServiceName]                  VARCHAR (50)   NOT NULL,
    [ServiceDescription]           VARCHAR (1000) NULL,
    [NumberOfSessions]             INT            NOT NULL,
    [CreatedDate]                  DATETIME       NOT NULL,
    [UpdatedDate]                  DATETIME       NOT NULL,
    [ModifiedBy]                   VARCHAR (25)   NOT NULL,
    [IsRemoteService]              BIT            CONSTRAINT [DF_pricingSummaryDetail_IsRemoteService] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_pricingestimatedetail_1] PRIMARY KEY CLUSTERED ([PricingSummaryID] ASC, [PricingSummaryRevision] ASC, [ServiceProfessionalServiceID] ASC)
);

