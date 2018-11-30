CREATE TABLE [dbo].[positionbackgroundcheck] (
    [PositionID]        INT          NOT NULL,
    [BackgroundCheckID] VARCHAR (25) NOT NULL,
    [StateProvinceID]   VARCHAR (25) NOT NULL,
    [CountryID]         VARCHAR (25) NOT NULL,
    [Required]          BIT          NOT NULL,
    [CreatedDate]       DATETIME     NOT NULL,
    [UpdatedDate]       DATETIME     NOT NULL,
    [ModifiedBy]        VARCHAR (25) NOT NULL,
    [Active]            BIT          NOT NULL,
    PRIMARY KEY CLUSTERED ([CountryID] ASC, [BackgroundCheckID] ASC, [PositionID] ASC, [StateProvinceID] ASC)
);

