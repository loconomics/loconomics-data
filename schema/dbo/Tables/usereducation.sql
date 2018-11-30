CREATE TABLE [dbo].[usereducation] (
    [UserEducationID]   INT           IDENTITY (1, 1) NOT NULL,
    [UserID]            INT           NOT NULL,
    [InstitutionID]     INT           NOT NULL,
    [DegreeCertificate] VARCHAR (200) NOT NULL,
    [FieldOfStudy]      VARCHAR (200) NOT NULL,
    [FromYearAttended]  NUMERIC (4)   NULL,
    [ToYearAttended]    NUMERIC (4)   NULL,
    [CreatedDate]       DATETIME      NOT NULL,
    [ModifiedDate]      DATETIME      NOT NULL,
    [ModifiedBy]        VARCHAR (25)  NOT NULL,
    [VerifiedDate]      DATETIME      NULL,
    [VerifiedBy]        VARCHAR (25)  NULL,
    [Active]            BIT           NOT NULL,
    CONSTRAINT [PK__usereduc__A31C69552A363CC5] PRIMARY KEY CLUSTERED ([UserEducationID] ASC),
    CONSTRAINT [FK__usereduca__Insti__2D12A970] FOREIGN KEY ([InstitutionID]) REFERENCES [dbo].[institution] ([InstitutionID]),
    CONSTRAINT [FK__usereduca__UserI__2C1E8537] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])
);

