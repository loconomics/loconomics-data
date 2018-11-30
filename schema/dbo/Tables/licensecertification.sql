CREATE TABLE [dbo].[licensecertification] (
    [LicenseCertificationID]              INT            NOT NULL,
    [LicenseCertificationType]            VARCHAR (100)  NOT NULL,
    [LicenseCertificationTypeDescription] VARCHAR (4000) NULL,
    [LicenseCertificationAuthority]       VARCHAR (500)  NULL,
    [VerificationWebsiteURL]              VARCHAR (2078) NULL,
    [HowToGetLicensedURL]                 VARCHAR (2078) NULL,
    [CreatedDate]                         DATETIME       NOT NULL,
    [UpdatedDate]                         DATETIME       NOT NULL,
    [ModifiedBy]                          VARCHAR (25)   NOT NULL,
    [Active]                              BIT            NOT NULL,
    [LanguageID]                          INT            CONSTRAINT [DF__licensece__Langu__5BF880E2] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK__licensec__65E993A46F0B5556] PRIMARY KEY CLUSTERED ([LicenseCertificationID] ASC, [LanguageID] ASC)
);

