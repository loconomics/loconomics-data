CREATE TABLE [dbo].[questionType] (
    [questionTypeID] INT                NOT NULL,
    [name]           NVARCHAR (50)      NOT NULL,
    [description]    NVARCHAR (500)     NOT NULL,
    [createdDate]    DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]    DATETIMEOFFSET (0) NOT NULL,
    [modifiedBy]     NVARCHAR (10)      NOT NULL,
    CONSTRAINT [PK_questionType] PRIMARY KEY CLUSTERED ([questionTypeID] ASC)
);

