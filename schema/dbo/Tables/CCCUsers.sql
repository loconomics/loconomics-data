CREATE TABLE [dbo].[CCCUsers] (
    [UserID]             INT          NOT NULL,
    [InstitutionID]      INT          NULL,
    [FieldOfStudyID]     INT          NULL,
    [PlanExpirationDate] DATETIME     NULL,
    [UserType]           VARCHAR (25) NULL,
    [StudentID]          INT          NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC),
    FOREIGN KEY ([FieldOfStudyID]) REFERENCES [dbo].[FieldOfStudy] ([FieldOfStudyID]),
    FOREIGN KEY ([InstitutionID]) REFERENCES [dbo].[institution] ([InstitutionID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK__CCCUsers__UserID__6EA14102] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])
);

