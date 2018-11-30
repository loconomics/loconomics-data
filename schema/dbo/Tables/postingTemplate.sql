CREATE TABLE [dbo].[postingTemplate] (
    [postingTemplateID] INT                NOT NULL,
    [name]              NVARCHAR (200)     NOT NULL,
    [languageID]        INT                NOT NULL,
    [countryID]         INT                NOT NULL,
    [createdDate]       DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]       DATETIMEOFFSET (0) NOT NULL,
    [modifiedBy]        NCHAR (5)          NOT NULL,
    CONSTRAINT [PK_postingTemplate] PRIMARY KEY CLUSTERED ([postingTemplateID] ASC)
);

