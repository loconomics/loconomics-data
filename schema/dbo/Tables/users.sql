CREATE TABLE [dbo].[users] (
    [UserID]                           INT                NOT NULL,
    [FirstName]                        VARCHAR (50)       NOT NULL,
    [MiddleIn]                         VARCHAR (1)        NOT NULL,
    [LastName]                         VARCHAR (145)      NOT NULL,
    [SecondLastName]                   VARCHAR (145)      NOT NULL,
    [NickName]                         VARCHAR (50)       NULL,
    [PublicBio]                        VARCHAR (4000)     NULL,
    [GenderID]                         INT                CONSTRAINT [DF_users_GenderID] DEFAULT ((-1)) NOT NULL,
    [PreferredLanguageID]              INT                NOT NULL,
    [PreferredCountryID]               INT                NOT NULL,
    [IsProvider]                       BIT                CONSTRAINT [DF__users__IsProvide__3943762B] DEFAULT ((0)) NOT NULL,
    [IsCustomer]                       BIT                CONSTRAINT [DF__users__IsCustome__3A379A64] DEFAULT ((0)) NOT NULL,
    [IsAdmin]                          BIT                DEFAULT ((0)) NOT NULL,
    [IsCollaborator]                   BIT                DEFAULT ((0)) NOT NULL,
    [Photo]                            VARCHAR (150)      NULL,
    [MobilePhone]                      VARCHAR (20)       NULL,
    [AlternatePhone]                   VARCHAR (20)       NULL,
    [CanReceiveSms]                    BIT                DEFAULT ((0)) NOT NULL,
    [ProviderProfileURL]               VARCHAR (2078)     NULL,
    [ProviderWebsiteURL]               VARCHAR (2078)     NULL,
    [SMSBookingCommunication]          BIT                DEFAULT ((1)) NOT NULL,
    [PhoneBookingCommunication]        BIT                DEFAULT ((1)) NOT NULL,
    [LoconomicsMarketingCampaigns]     BIT                DEFAULT ((1)) NOT NULL,
    [ProfileSEOPermission]             BIT                DEFAULT ((1)) NOT NULL,
    [CreatedDate]                      DATETIME           NULL,
    [UpdatedDate]                      DATETIME           NULL,
    [ModifiedBy]                       VARCHAR (50)       NULL,
    [Active]                           BIT                NULL,
    [LoconomicsCommunityCommunication] BIT                DEFAULT ((1)) NOT NULL,
    [LoconomicsDBMCampaigns]           BIT                DEFAULT ((1)) NOT NULL,
    [AccountStatusID]                  INT                DEFAULT ((1)) NOT NULL,
    [CoBrandedPartnerPermissions]      BIT                DEFAULT ((1)) NOT NULL,
    [MarketingSource]                  VARCHAR (2055)     COLLATE Modern_Spanish_CI_AS NULL,
    [BookCode]                         VARCHAR (64)       NULL,
    [OnboardingStep]                   VARCHAR (60)       NULL,
    [BirthMonthDay]                    INT                NULL,
    [BirthMonth]                       INT                NULL,
    [BusinessName]                     NVARCHAR (145)     NULL,
    [AlternativeEmail]                 NVARCHAR (56)      NULL,
    [ReferredByUserID]                 INT                NULL,
    [SignupDevice]                     NVARCHAR (20)      NULL,
    [OwnerStatusID]                    INT                NULL,
    [OwnerAnniversaryDate]             DATETIME           NULL,
    [IsHipaaAdmin]                     BIT                DEFAULT ((0)) NOT NULL,
    [IsContributor]                    BIT                CONSTRAINT [users_IsContributor_default] DEFAULT (CONVERT([bit],(0),0)) NULL,
    [TrialEndDate]                     DATETIMEOFFSET (7) NULL,
    [BirthYear]                        INT                NULL,
    [IsOrganization]                   BIT                DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED ([UserID] ASC) WITH (FILLFACTOR = 100)
);

GO

ALTER TABLE [dbo].[users] ADD
    CONSTRAINT [FK_users_accountstatus] FOREIGN KEY ([AccountStatusID]) REFERENCES [dbo].[accountstatus] ([AccountStatusID]),
    CONSTRAINT [FK_users_OwnerStatus] FOREIGN KEY ([OwnerStatusID]) REFERENCES [dbo].[OwnerStatus] ([OwnserStatusID])

GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Execute all user tests on insert
--  to active all the alerts
-- =============================================
CREATE TRIGGER trigInitialUserAlertTest
   ON  dbo.users
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @UserID int

	SELECT @UserID = UserID FROM INSERTED

    EXEC TestAllUserAlerts @UserID

END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Optional field for customer users created by freelancers when adding them to their clients list. The referredByUserID is a freelancer that created, and can edit, the record (until the customer enables its marketplace account, this field value is preserved but status change)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'users', @level2type = N'COLUMN', @level2name = N'ReferredByUserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Choosen device from list on the signup form', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'users', @level2type = N'COLUMN', @level2name = N'SignupDevice';

