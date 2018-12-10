CREATE TABLE [dbo].[userprofileserviceattributes] (
    [UserID]                     INT         NOT NULL,
    [PositionID]                 INT         NOT NULL,
    [ServiceAttributeCategoryID] INT         NOT NULL,
    [ServiceAttributeID]         INT         NOT NULL,
    [language]      NVARCHAR (42) NOT NULL,
    [CreateDate]                 DATETIME    NULL,
    [UpdatedDate]                DATETIME    NULL,
    [ModifiedBy]                 VARCHAR (3) NULL,
    [Active]                     BIT         NULL,
    CONSTRAINT [PK_userprofileserviceattributes_2] PRIMARY KEY CLUSTERED ([UserID] ASC, [PositionID] ASC, [ServiceAttributeCategoryID] ASC, [ServiceAttributeID] ASC)
);

