CREATE TABLE [dbo].[Gender] (
    [GenderID]         INT           NOT NULL,
    [language]      NVARCHAR (42) DEFAULT ('en-US') NOT NULL,
    [GenderSingular]   NVARCHAR (16) NOT NULL,
    [GenderPlural]     NVARCHAR (16) NOT NULL,
    [SubjectPronoun]   VARCHAR (25)  NULL,
    [ObjectPronoun]    VARCHAR (25)  NULL,
    [PossesivePronoun] VARCHAR (25)  NULL,
    CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED ([GenderID] ASC)
);
