CREATE TABLE [dbo].[JobTitleSolution] (
    [JobTitleID]      INT                NOT NULL,
    [SolutionID]      INT                NOT NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [DefaultSelected] BIT                NULL,
    [DisplayRank]     INT                NULL,
    [CreatedDate]     DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]     DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]      NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    PRIMARY KEY CLUSTERED ([JobTitleID] ASC, [SolutionID] ASC)
);

GO

ALTER TABLE [dbo].[JobTitleSolution] ADD
    CONSTRAINT [FK_JobTitleSolution_positions] FOREIGN KEY ([JobTitleID]) REFERENCES [dbo].[positions] ([PositionID]),
    CONSTRAINT [FK_JobTitleSolution_Solution] FOREIGN KEY ([SolutionID]) REFERENCES [dbo].[Solution] ([SolutionID])
