CREATE TABLE [dbo].[institution] (
    [InstitutionID]          INT            IDENTITY (1, 1) NOT NULL,
    [DeptOfEdInstitutionID]  VARCHAR (25)   NULL,
    [InstitutionName]        VARCHAR (200)  NOT NULL,
    [InstitutionAddress]     VARCHAR (200)  NULL,
    [InstitutionCity]        VARCHAR (100)  NULL,
    [InstitutionState]       VARCHAR (25)   NULL,
    [StateProvinceID]        INT            NULL,
    [InstitutionZip]         VARCHAR (25)   NULL,
    [InstitutionPhone]       VARCHAR (25)   NULL,
    [InstitutionOPEID]       VARCHAR (25)   NULL,
    [InstitutionIPEDSUnitID] VARCHAR (25)   NULL,
    [InstitutionURL]         VARCHAR (2083) NULL,
    [CountryID]              INT            NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [UpdatedDate]            DATETIME       NOT NULL,
    [ModifiedBy]             VARCHAR (25)   NOT NULL,
    [SchoolID]               VARCHAR (3)    NULL,
    [DistrictName]           VARCHAR (50)   NULL,
    [DistrictID]             VARCHAR (3)    NULL,
    CONSTRAINT [PK__institut__8DF6B94D047AA831] PRIMARY KEY CLUSTERED ([InstitutionID] ASC)
);

GO

ALTER TABLE [dbo].[institution] ADD
    CONSTRAINT [FK__instituti__State__153B1FDF] FOREIGN KEY ([StateProvinceID]) REFERENCES [dbo].[stateprovince] ([StateProvinceID])
