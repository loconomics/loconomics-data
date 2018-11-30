CREATE TABLE [dbo].[Tmp_users] (
    [UserID]                           INT            NOT NULL,
    [FirstName]                        VARCHAR (50)   NOT NULL,
    [MiddleIn]                         VARCHAR (1)    NOT NULL,
    [LastName]                         VARCHAR (145)  NOT NULL,
    [SecondLastName]                   VARCHAR (145)  NOT NULL,
    [NickName]                         VARCHAR (50)   NULL,
    [PublicBio]                        VARCHAR (4000) NULL,
    [GenderID]                         INT            NOT NULL,
    [PreferredLanguageID]              INT            NULL,
    [PreferredCountryID]               INT            NULL,
    [IsProvider]                       BIT            NOT NULL,
    [IsCustomer]                       BIT            NOT NULL,
    [IsMember]                         BIT            CONSTRAINT [DF_users_IsMember] DEFAULT ((0)) NOT NULL,
    [IsAdmin]                          BIT            CONSTRAINT [DF_users_IsAdmin] DEFAULT ((0)) NOT NULL,
    [IsContributor]                    BIT            CONSTRAINT [DF_users_IsContributor] DEFAULT ((0)) NOT NULL,
    [IsCollaborator]                   BIT            CONSTRAINT [DF__users__Collabora__5E7FE7D2] DEFAULT ((0)) NOT NULL,
    [Photo]                            VARCHAR (150)  NULL,
    [MobilePhone]                      VARCHAR (20)   NULL,
    [AlternatePhone]                   VARCHAR (20)   NULL,
    [CanReceiveSms]                    BIT            CONSTRAINT [DF_users_CanReceiveSms] DEFAULT ((0)) NOT NULL,
    [ProviderProfileURL]               VARCHAR (2078) NULL,
    [ProviderWebsiteURL]               VARCHAR (2078) NULL,
    [SMSBookingCommunication]          BIT            CONSTRAINT [DF__users__SMSBookin__3B2BBE9D] DEFAULT ((1)) NOT NULL,
    [PhoneBookingCommunication]        BIT            CONSTRAINT [DF__users__PhoneBook__3C1FE2D6] DEFAULT ((1)) NOT NULL,
    [LoconomicsMarketingCampaigns]     BIT            CONSTRAINT [DF__users__Loconomic__3D14070F] DEFAULT ((1)) NOT NULL,
    [ProfileSEOPermission]             BIT            CONSTRAINT [DF__users__ProviderP__3E082B48] DEFAULT ((1)) NOT NULL,
    [CreatedDate]                      DATETIME       NULL,
    [UpdatedDate]                      DATETIME       NULL,
    [ModifiedBy]                       VARCHAR (50)   NULL,
    [Active]                           BIT            NULL,
    [LoconomicsCommunityCommunication] BIT            CONSTRAINT [DF__users__Loconomic__3EFC4F81] DEFAULT ((1)) NOT NULL,
    [IAuthZumigoVerification]          BIT            NULL,
    [IAuthZumigoLocation]              BIT            NULL,
    [LoconomicsDBMCampaigns]           BIT            CONSTRAINT [DF__users__Loconomic__45FE52CB] DEFAULT ((1)) NOT NULL,
    [AccountStatusID]                  INT            CONSTRAINT [DF__users__AccountSt__6265874F] DEFAULT ((1)) NOT NULL,
    [CoBrandedPartnerPermissions]      BIT            CONSTRAINT [DF__users__CoBranded__691284DE] DEFAULT ((1)) NOT NULL,
    [MarketingSource]                  VARCHAR (2055) NULL,
    [BookCode]                         VARCHAR (64)   NULL,
    [OnboardingStep]                   VARCHAR (60)   NULL,
    [BirthMonthDay]                    INT            NULL,
    [BirthMonth]                       INT            NULL,
    [BusinessName]                     NVARCHAR (145) NULL,
    [AlternativeEmail]                 NVARCHAR (56)  NULL,
    [ReferredByUserID]                 INT            NULL,
    [SignupDevice]                     NVARCHAR (20)  NULL,
    [OwnerStatusID]                    INT            NULL,
    [OwnerAnniversaryDate]             DATETIME       NULL,
    [IsHipaaAdmin]                     BIT            CONSTRAINT [DF__users__IsHipaaAd__70F39DC8] DEFAULT ((0)) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is a contributor developer with access to some parts before only for admins like ''test'' pages', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Tmp_users', @level2type = N'COLUMN', @level2name = N'IsContributor';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Optional field for customer users created by freelancers when adding them to their clients list. The referredByUserID is a freelancer that created, and can edit, the record (until the customer enables its marketplace account, this field value is preserved but status change)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Tmp_users', @level2type = N'COLUMN', @level2name = N'ReferredByUserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Choosen device from list on the signup form', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Tmp_users', @level2type = N'COLUMN', @level2name = N'SignupDevice';

