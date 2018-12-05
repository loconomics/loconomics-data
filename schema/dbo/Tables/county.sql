CREATE TABLE [dbo].[county] (
    [CountyID]        INT           NOT NULL,
    [CountyName]      VARCHAR (100) NULL,
    [FIPSCode]        INT           NULL,
    [StateProvinceID] INT           NOT NULL,
    [CreatedDate]     DATETIME      NOT NULL,
    [UpdatedDate]     DATETIME      NOT NULL,
    [ModifiedBy]      VARCHAR (25)  NOT NULL,
    [Active]          BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([CountyID] ASC)
);

GO

ALTER TABLE [dbo].[county] ADD
    CONSTRAINT [FK__county__StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [dbo].[stateprovince] ([StateProvinceID])