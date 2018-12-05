CREATE TABLE [dbo].[municipality] (
    [MunicipalityID]   INT           NOT NULL,
    [CountyID]         INT           NOT NULL,
    [MunicipalityName] VARCHAR (100) NOT NULL,
    [CreatedDate]      DATETIME      NOT NULL,
    [UpdatedDate]      DATETIME      NOT NULL,
    [ModifiedBy]       VARCHAR (25)  NOT NULL,
    PRIMARY KEY CLUSTERED ([MunicipalityID] ASC)
);

GO

ALTER TABLE [dbo].[municipality] ADD
    FOREIGN KEY ([CountyID]) REFERENCES [dbo].[county] ([CountyID])
