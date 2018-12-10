CREATE TABLE [dbo].[Specialization] (
    [SpecializationID] INT                NOT NULL,
    [LanguageID]       INT                NOT NULL,
    [CountryID]        INT                NOT NULL,
    [SolutionID]       INT                NOT NULL,
    [Name]             NVARCHAR (100)     NOT NULL,
    [DisplayRank]      INT                NULL,
    [CreatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [CreatedBy]        NVARCHAR (12)      CONSTRAINT [DF__Specializ__Creat__23D42350] DEFAULT ('staff') NOT NULL,
    [Approved]         BIT                CONSTRAINT [DF__Specializ__Appro__24C84789] DEFAULT ((0)) NULL,
    [Active]           BIT                CONSTRAINT [DF__Specializ__Activ__25BC6BC2] DEFAULT ((1)) NOT NULL,
    [EnteredByUserID]  INT                NULL,
    CONSTRAINT [PK_Specialization] PRIMARY KEY CLUSTERED ([SpecializationID] ASC)
);

GO

ALTER TABLE [dbo].[Specialization] ADD
    CONSTRAINT [FK_Specialization_Solution] FOREIGN KEY ([SolutionID]) REFERENCES [dbo].[Solution] ([SolutionID])
