CREATE TABLE [dbo].[userprofilepositions] (
    [UserListingID]                INT            IDENTITY (1, 1) NOT NULL,
    [UserID]                       INT            NOT NULL,
    [PositionID]                   INT            NOT NULL,
    [LanguageID]                   INT            NOT NULL,
    [CountryID]                    INT            NOT NULL,
    [CreateDate]                   DATETIME       NULL,
    [UpdatedDate]                  DATETIME       NULL,
    [ModifiedBy]                   VARCHAR (3)    NULL,
    [Active]                       BIT            NULL,
    [PositionIntro]                VARCHAR (2000) NULL,
    [StatusID]                     INT            CONSTRAINT [DF_userprofilepositions_StatusID] DEFAULT ((1)) NOT NULL,
    [CancellationPolicyID]         INT            NULL,
    [InstantBooking]               BIT            CONSTRAINT [DF_userprofilepositions_InstantBooking] DEFAULT ((0)) NOT NULL,
    [bookMeButtonReady]            BIT            CONSTRAINT [DF_userprofilepositions_bookMeButtonReady] DEFAULT ((0)) NOT NULL,
    [collectPaymentAtBookMeButton] BIT            CONSTRAINT [DF_userprofilepositions_collectPaymentAtBookMeButton] DEFAULT ((1)) NOT NULL,
    [Title]                        NVARCHAR (50)  NULL,
    CONSTRAINT [PK_userprofilepositions] PRIMARY KEY CLUSTERED ([UserListingID] ASC),
    CONSTRAINT [FK_userprofilepositions_accountstatus] FOREIGN KEY ([StatusID]) REFERENCES [dbo].[accountstatus] ([AccountStatusID]),
    CONSTRAINT [FK_userprofilepositions_positions] FOREIGN KEY ([PositionID], [LanguageID], [CountryID]) REFERENCES [dbo].[positions] ([PositionID], [LanguageID], [CountryID]),
    CONSTRAINT [FK_userprofilepositions_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_userprofilepositions]
    ON [dbo].[userprofilepositions]([UserID] ASC, [PositionID] ASC, [LanguageID] ASC, [CountryID] ASC);


GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Execute all user tests on insert
--  to active all the alerts
-- =============================================
CREATE TRIGGER trigInitialProviderPositionAlertTest
   ON  dbo.userprofilepositions
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @UserID int, @PositionID int
	
	SELECT @UserID = UserID, @PositionID = PositionID FROM INSERTED

    EXEC TestAllUserAlerts @UserID, @PositionID

END
