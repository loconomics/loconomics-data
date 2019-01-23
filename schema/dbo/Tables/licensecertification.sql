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
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    CONSTRAINT [PK__licensec__65E993A46F0B5556] PRIMARY KEY CLUSTERED ([LicenseCertificationID] ASC)
);
