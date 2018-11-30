CREATE TABLE [dbo].[usersignup] (
    [UserId] INT           IDENTITY (1, 1) NOT NULL,
    [Email]  NVARCHAR (56) NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC)
);

