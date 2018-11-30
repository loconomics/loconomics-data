CREATE TABLE [dbo].[jobTitleLicense] (
    [PositionID]             INT           NOT NULL,
    [LicenseCertificationID] INT           NOT NULL,
    [StateProvinceID]        INT           NOT NULL,
    [CountryID]              INT           NOT NULL,
    [Required]               BIT           NOT NULL,
    [CreatedDate]            DATETIME      NOT NULL,
    [UpdatedDate]            DATETIME      NOT NULL,
    [ModifiedBy]             VARCHAR (25)  NOT NULL,
    [Active]                 BIT           NOT NULL,
    [MunicipalityID]         INT           DEFAULT ((0)) NOT NULL,
    [CountyID]               INT           DEFAULT ((0)) NOT NULL,
    [OptionGroup]            VARCHAR (100) NULL,
    CONSTRAINT [PK__jobTitle__5E077F7A5FC911C6] PRIMARY KEY CLUSTERED ([PositionID] ASC, [LicenseCertificationID] ASC, [StateProvinceID] ASC, [CountryID] ASC, [MunicipalityID] ASC, [CountyID] ASC)
);

