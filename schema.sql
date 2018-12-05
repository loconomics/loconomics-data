
PRINT N'Creating database [loconomics]...';
GO
/** Create empty database, first script before any other object DDL **/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;
SET NUMERIC_ROUNDABORT OFF;
GO

CREATE DATABASE [loconomics]
GO
ALTER DATABASE [loconomics] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [loconomics].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [loconomics] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [loconomics] SET ANSI_NULLS OFF
GO
ALTER DATABASE [loconomics] SET ANSI_PADDING OFF
GO
ALTER DATABASE [loconomics] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [loconomics] SET ARITHABORT OFF
GO
ALTER DATABASE [loconomics] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [loconomics] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [loconomics] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [loconomics] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [loconomics] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [loconomics] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [loconomics] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [loconomics] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [loconomics] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [loconomics] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [loconomics] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [loconomics] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [loconomics] SET READ_COMMITTED_SNAPSHOT ON
GO
ALTER DATABASE [loconomics] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [loconomics] SET  MULTI_USER
GO
ALTER DATABASE [loconomics] SET DB_CHAINING OFF
GO
USE [loconomics]
GO

GO
        

PRINT N'Creating [dbo].[accountstatus]...';
GO
CREATE TABLE [dbo].[accountstatus] (
    [AccountStatusID]          INT           NOT NULL,
    [AccountStatusName]        VARCHAR (25)  NOT NULL,
    [AccountStatusDescription] VARCHAR (200) NULL,
    [CreatedDate]              DATETIME      NOT NULL,
    [UpdatedDate]              DATETIME      NOT NULL,
    [ModifiedBy]               VARCHAR (25)  DEFAULT ('sys') NOT NULL,
    [Active]                   BIT           DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([AccountStatusID] ASC)
);


GO
    
PRINT N'Creating [dbo].[address]...';
GO
CREATE TABLE [dbo].[address] (
    [AddressID]           INT            IDENTITY (1, 1) NOT NULL,
    [UserID]              INT            NOT NULL,
    [AddressTypeID]       INT            NOT NULL,
    [AddressName]         VARCHAR (50)   NOT NULL,
    [AddressLine1]        VARCHAR (100)  NOT NULL,
    [AddressLine2]        VARCHAR (100)  NULL,
    [City]                VARCHAR (100)  NOT NULL,
    [StateProvinceID]     INT            NOT NULL,
    [PostalCodeID]        INT            NOT NULL,
    [CountryID]           INT            NOT NULL,
    [Latitude]            FLOAT (53)     NULL,
    [Longitude]           FLOAT (53)     NULL,
    [GoogleMapsURL]       VARCHAR (2073) NULL,
    [SpecialInstructions] VARCHAR (1000) NULL,
    [CreatedDate]         DATETIME       NOT NULL,
    [UpdatedDate]         DATETIME       NOT NULL,
    [ModifiedBy]          VARCHAR (25)   NOT NULL,
    [Active]              BIT            NULL,
    [CreatedBy]           INT            NOT NULL,
    CONSTRAINT [PK_address_1] PRIMARY KEY CLUSTERED ([AddressID] ASC)
);


GO
    
PRINT N'Creating [dbo].[addresstype]...';
GO
CREATE TABLE [dbo].[addresstype] (
    [AddressTypeID] INT          NOT NULL,
    [LanguageID]    INT          NOT NULL,
    [CountryID]     INT          NOT NULL,
    [AddressType]   VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     NOT NULL,
    [UpdatedDate]   DATETIME     NOT NULL,
    [ModifiedBy]    VARCHAR (25) NOT NULL,
    [Active]        BIT          NOT NULL,
    [UniquePerUser] BIT          NOT NULL,
    [Selectable]    BIT          CONSTRAINT [DF_addresstype_Selectable] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK__addresst__9E7638F92C88998B] PRIMARY KEY CLUSTERED ([AddressTypeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[alert]...';
GO
CREATE TABLE [dbo].[alert] (
    [AlertID]                       INT            NOT NULL,
    [AlertTypeID]                   INT            NOT NULL,
    [LanguageID]                    INT            NOT NULL,
    [CountryID]                     INT            NOT NULL,
    [AlertName]                     VARCHAR (30)   NOT NULL,
    [AlertHeadlineDisplay]          VARCHAR (100)  NULL,
    [AlertTextDisplay]              VARCHAR (300)  NOT NULL,
    [AlertDescription]              VARCHAR (500)  NULL,
    [AlertEmailText]                VARCHAR (25)   NULL,
    [ProviderProfileCompletePoints] INT            NOT NULL,
    [CustomerProfileCompletePoints] INT            NOT NULL,
    [CreatedDate]                   DATETIME       NOT NULL,
    [UpdatedDate]                   DATETIME       NOT NULL,
    [ModifiedBy]                    VARCHAR (25)   NOT NULL,
    [Active]                        BIT            NOT NULL,
    [AlertPageURL]                  VARCHAR (2000) NULL,
    [Required]                      BIT            NOT NULL,
    [PositionSpecific]              BIT            CONSTRAINT [DF__alert__PositionS__5E94F66B] DEFAULT ((0)) NOT NULL,
    [DisplayRank]                   INT            CONSTRAINT [DF__alert__DisplayRa__3CFEF876] DEFAULT ((1)) NOT NULL,
    [ProviderAlert]                 BIT            DEFAULT ((1)) NOT NULL,
    [CustomerAlert]                 BIT            DEFAULT ((0)) NOT NULL,
    [bookMeButtonRequired]          BIT            CONSTRAINT [DF_alert_bookMeButtonRequired] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK__alert__AAFF8BB7025D5595] PRIMARY KEY CLUSTERED ([AlertID] ASC, [AlertTypeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[alerttype]...';
GO
CREATE TABLE [dbo].[alerttype] (
    [AlertTypeID]          INT           NOT NULL,
    [AlertTypeName]        VARCHAR (200) NOT NULL,
    [AlertTypeDescription] VARCHAR (200) NULL,
    [CreatedDate]          DATETIME      NOT NULL,
    [UpdatedDate]          DATETIME      NOT NULL,
    [ModifiedBy]           VARCHAR (25)  NOT NULL,
    [Active]               BIT           NOT NULL,
    [LanguageID]           INT           DEFAULT ((1)) NOT NULL,
    [CountryID]            INT           DEFAULT ((1)) NOT NULL,
    [DisplayRank]          INT           DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([AlertTypeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[authorizations]...';
GO
CREATE TABLE [dbo].[authorizations] (
    [id]            INT                IDENTITY (1, 1) NOT NULL,
    [Token]         VARCHAR (216)      NOT NULL,
    [UserID]        INT                NOT NULL,
    [Scope]         VARCHAR (100)      NOT NULL,
    [CreatedDate]   DATETIMEOFFSET (0) NOT NULL,
    [DeletedDate]   DATETIMEOFFSET (0) NULL,
    [ClientAddress] VARCHAR (64)       NULL,
    [UserAgent]     TEXT               NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);



GO
    
PRINT N'Creating [dbo].[backgroundcheck]...';
GO
CREATE TABLE [dbo].[backgroundcheck] (
    [BackgroundCheckID]          INT            NOT NULL,
    [LanguageID]                 INT            NOT NULL,
    [CountryID]                  INT            NOT NULL,
    [BackgroundCheckName]        VARCHAR (100)  NOT NULL,
    [BackgroundCheckDescription] VARCHAR (1000) NULL,
    [CreatedDate]                DATETIME       NOT NULL,
    [UpdatedDate]                DATETIME       NOT NULL,
    [ModifiedBy]                 VARCHAR (25)   NOT NULL,
    [Active]                     BIT            NOT NULL,
    [BackGroundCheckPrice]       DECIMAL (5, 2) NULL,
    PRIMARY KEY CLUSTERED ([BackgroundCheckID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[booking]...';
GO
CREATE TABLE [dbo].[booking] (
    [BookingID]                        INT             IDENTITY (1, 1) NOT NULL,
    [ClientUserID]                     INT             NULL,
    [ServiceProfessionalUserID]        INT             NULL,
    [JobTitleID]                       INT             NOT NULL,
    [LanguageID]                       INT             NOT NULL,
    [CountryID]                        INT             NOT NULL,
    [BookingStatusID]                  INT             NOT NULL,
    [BookingTypeID]                    INT             NOT NULL,
    [CancellationPolicyID]             INT             NOT NULL,
    [ParentBookingID]                  INT             NULL,
    [ServiceAddressID]                 INT             NULL,
    [ServiceDateID]                    INT             NULL,
    [AlternativeDate1ID]               INT             NULL,
    [AlternativeDate2ID]               INT             NULL,
    [PricingSummaryID]                 INT             NOT NULL,
    [PricingSummaryRevision]           INT             NOT NULL,
    [PaymentTransactionID]             VARCHAR (250)   NULL,
    [PaymentLastFourCardNumberDigits]  VARCHAR (64)    NULL,
    [paymentMethodID]                  VARCHAR (250)   NULL,
    [cancellationPaymentTransactionID] VARCHAR (250)   NULL,
    [ClientPayment]                    DECIMAL (25, 2) NULL,
    [ServiceProfessionalPaid]          DECIMAL (25, 2) NULL,
    [ServiceProfessionalPPFeePaid]     DECIMAL (25, 2) NULL,
    [LoconomicsPaid]                   DECIMAL (25, 2) NULL,
    [LoconomicsPPFeePaid]              DECIMAL (25, 2) NULL,
    [InstantBooking]                   BIT             CONSTRAINT [Contraint_booking_InstantBooking] DEFAULT ((0)) NOT NULL,
    [FirstTimeBooking]                 BIT             NOT NULL,
    [SendReminder]                     BIT             CONSTRAINT [Contraint_booking_SendReminder] DEFAULT ((0)) NOT NULL,
    [SendPromotional]                  BIT             CONSTRAINT [Contraint_booking_SendPromotional] DEFAULT ((0)) NOT NULL,
    [Recurrent]                        BIT             CONSTRAINT [Contraint_booking_Recurrent] DEFAULT ((0)) NOT NULL,
    [MultiSession]                     BIT             CONSTRAINT [Contraint_booking_MultiSession] DEFAULT ((0)) NOT NULL,
    [PricingAdjustmentApplied]         BIT             CONSTRAINT [Contraint__booking__PricingAdjustmentApplied] DEFAULT ((0)) NOT NULL,
    [PaymentEnabled]                   BIT             CONSTRAINT [DF_booking_PaymentEnabled] DEFAULT ((0)) NOT NULL,
    [PaymentCollected]                 BIT             CONSTRAINT [Contraint_booking_PaymentCollected] DEFAULT ((0)) NOT NULL,
    [PaymentAuthorized]                BIT             CONSTRAINT [Contraint_booking_PaymentAuthorized] DEFAULT ((0)) NOT NULL,
    [AwaitingResponseFromUserID]       INT             NULL,
    [PricingAdjustmentRequested]       BIT             CONSTRAINT [Contraint_booking_PricingAdjustmentRequested] DEFAULT ((0)) NOT NULL,
    [SupportTicketNumber]              VARCHAR (200)   NULL,
    [MessagingLog]                     NVARCHAR (400)  CONSTRAINT [Contraint_booking_MessagingLog] DEFAULT ('') NOT NULL,
    [CreatedDate]                      DATETIME        NOT NULL,
    [UpdatedDate]                      DATETIME        NOT NULL,
    [ModifiedBy]                       VARCHAR (25)    NOT NULL,
    [SpecialRequests]                  TEXT            NULL,
    [PreNotesToClient]                 TEXT            NULL,
    [PostNotesToClient]                TEXT            NULL,
    [PreNotesToSelf]                   TEXT            NULL,
    [PostNotesToSelf]                  TEXT            NULL,
    CONSTRAINT [PK__booking__bookingIDKey] PRIMARY KEY CLUSTERED ([BookingID] ASC)
);


GO
    
PRINT N'Creating [dbo].[bookingStatus]...';
GO
CREATE TABLE [dbo].[bookingStatus] (
    [BookingStatusID]          INT           NOT NULL,
    [BookingStatusName]        VARCHAR (50)  NOT NULL,
    [BookingStatusDescription] VARCHAR (500) NULL,
    [CreatedDate]              DATETIME      NOT NULL,
    [UpdatedDate]              DATETIME      NOT NULL,
    [ModifiedBy]               VARCHAR (25)  NOT NULL,
    [Active]                   BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([BookingStatusID] ASC)
);


GO
    
PRINT N'Creating [dbo].[bookingType]...';
GO
CREATE TABLE [dbo].[bookingType] (
    [BookingTypeID]                  INT            NOT NULL,
    [BookingTypeName]                VARCHAR (50)   NOT NULL,
    [BookingTypeDescription]         VARCHAR (500)  NULL,
    [CreatedDate]                    DATETIME       NOT NULL,
    [UpdatedDate]                    DATETIME       NOT NULL,
    [ModifiedBy]                     VARCHAR (25)   NOT NULL,
    [Active]                         BIT            NOT NULL,
    [FirstTimeServiceFeeFixed]       DECIMAL (5, 2) CONSTRAINT [DF__bookingty__Servi__2215F810] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeePercentage]  DECIMAL (5, 2) CONSTRAINT [DF__bookingty__Servi__230A1C49] DEFAULT ((0)) NOT NULL,
    [PaymentProcessingFeePercentage] DECIMAL (5, 2) CONSTRAINT [DF__bookingty__Payme__23FE4082] DEFAULT ((0)) NOT NULL,
    [PaymentProcessingFeeFixed]      DECIMAL (5, 2) CONSTRAINT [DF_bookingtype_PaymentProcessingFeeFixed] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeeMaximum]     DECIMAL (5, 2) CONSTRAINT [DF_bookingtype_FirstTimeServiceFeeMaximum] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeeMinimum]     DECIMAL (5, 2) CONSTRAINT [DF_bookingtype_FirstTimeServiceFeeMinimum] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK__bookingt__649EC4B15090EFD7] PRIMARY KEY CLUSTERED ([BookingTypeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarAvailabilityType]...';
GO
CREATE TABLE [dbo].[CalendarAvailabilityType] (
    [CalendarAvailabilityTypeID]          INT            NOT NULL,
    [LanguageID]                          INT            NOT NULL,
    [CountryID]                           INT            NOT NULL,
    [CalendarAvailabilityTypeName]        NVARCHAR (50)  NOT NULL,
    [CalendarAvailabilityTypeDescription] NVARCHAR (300) NOT NULL,
    [UserDescription]                     VARCHAR (500)  NULL,
    [AddAppointmentType]                  BIT            DEFAULT ((0)) NOT NULL,
    [SelectableAs]                        NVARCHAR (50)  NULL,
    CONSTRAINT [PK_CalendarAvailabilityType_1] PRIMARY KEY CLUSTERED ([CalendarAvailabilityTypeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarEventComments]...';
GO
CREATE TABLE [dbo].[CalendarEventComments] (
    [Id]      INT            IDENTITY (1, 1) NOT NULL,
    [IdEvent] INT            NOT NULL,
    [Comment] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarEventExceptionsPeriod]...';
GO
CREATE TABLE [dbo].[CalendarEventExceptionsPeriod] (
    [IdException] INT                NOT NULL,
    [DateStart]   DATETIMEOFFSET (0) NOT NULL,
    [DateEnd]     DATETIMEOFFSET (0) NULL,
    CONSTRAINT [PK_CalendarEventExceptionsPeriod] PRIMARY KEY CLUSTERED ([IdException] ASC, [DateStart] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarEventExceptionsPeriodsList]...';
GO
CREATE TABLE [dbo].[CalendarEventExceptionsPeriodsList] (
    [Id]      INT IDENTITY (1, 1) NOT NULL,
    [IdEvent] INT NOT NULL,
    CONSTRAINT [PK_CalendarEventExceptions] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarEventRecurrencesPeriod]...';
GO
CREATE TABLE [dbo].[CalendarEventRecurrencesPeriod] (
    [IdRecurrence] INT                NOT NULL,
    [DateStart]    DATETIMEOFFSET (0) NOT NULL,
    [DateEnd]      DATETIMEOFFSET (0) NULL,
    CONSTRAINT [PK_CalendarEventRecurrencesPeriod_1] PRIMARY KEY CLUSTERED ([IdRecurrence] ASC, [DateStart] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarEventRecurrencesPeriodList]...';
GO
CREATE TABLE [dbo].[CalendarEventRecurrencesPeriodList] (
    [Id]      INT IDENTITY (1, 1) NOT NULL,
    [IdEvent] INT NOT NULL,
    CONSTRAINT [PK_CalendarEventRecurrenceDates] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarEvents]...';
GO
CREATE TABLE [dbo].[CalendarEvents] (
    [Id]                         INT                IDENTITY (1, 1) NOT NULL,
    [UserId]                     INT                NOT NULL,
    [EventType]                  INT                CONSTRAINT [DF_CalendarEvents_EventType] DEFAULT ((1)) NOT NULL,
    [Summary]                    VARCHAR (500)      NULL,
    [StarTtime]                  DATETIMEOFFSET (0) NULL,
    [EndTime]                    DATETIMEOFFSET (0) NULL,
    [UID]                        VARCHAR (150)      NULL,
    [CalendarAvailabilityTypeID] INT                NOT NULL,
    [Transparency]               BIT                CONSTRAINT [DF_CalendarEvents_Transparency] DEFAULT ((0)) NOT NULL,
    [IsAllDay]                   BIT                CONSTRAINT [DF_CalendarEvents_IsAllDay] DEFAULT ((0)) NOT NULL,
    [StampTime]                  DATETIMEOFFSET (0) NULL,
    [TimeZone]                   NVARCHAR (100)     NULL,
    [Priority]                   INT                NULL,
    [Location]                   NVARCHAR (100)     NULL,
    [UpdatedDate]                DATETIMEOFFSET (0) NULL,
    [CreatedDate]                DATETIMEOFFSET (0) NULL,
    [ModifyBy]                   NVARCHAR (50)      NULL,
    [Class]                      NVARCHAR (50)      NULL,
    [Organizer]                  NVARCHAR (MAX)     NULL,
    [Sequence]                   INT                NULL,
    [Geo]                        NVARCHAR (100)     NULL,
    [RecurrenceId]               DATETIMEOFFSET (0) NULL,
    [TimeBlock]                  TIME (7)           NULL,
    [DayofWeek]                  INT                NULL,
    [Description]                NVARCHAR (MAX)     NULL,
    [Deleted]                    DATETIMEOFFSET (0) NULL,
    CONSTRAINT [PK_CalendarEvents] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarEventsAttendees]...';
GO
CREATE TABLE [dbo].[CalendarEventsAttendees] (
    [Id]       INT            IDENTITY (1, 1) NOT NULL,
    [IdEvent]  INT            NOT NULL,
    [Attendee] NVARCHAR (MAX) NULL,
    [Role]     NVARCHAR (50)  NULL,
    [Uri]      NVARCHAR (200) NULL,
    CONSTRAINT [PK_CalendarEventsAttendees] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarEventsContacts]...';
GO
CREATE TABLE [dbo].[CalendarEventsContacts] (
    [Id]      INT            IDENTITY (1, 1) NOT NULL,
    [IdEvent] INT            NOT NULL,
    [Contact] NVARCHAR (500) NULL,
    CONSTRAINT [PK_CalendarEventsContacts] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarEventType]...';
GO
CREATE TABLE [dbo].[CalendarEventType] (
    [EventTypeId] INT            NOT NULL,
    [EventType]   NVARCHAR (100) NULL,
    [Description] NVARCHAR (MAX) NULL,
    [DisplayName] NVARCHAR (100) NULL,
    CONSTRAINT [PK_EventType] PRIMARY KEY CLUSTERED ([EventTypeId] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarProviderAttributes]...';
GO
CREATE TABLE [dbo].[CalendarProviderAttributes] (
    [UserID]                  INT             NOT NULL,
    [AdvanceTime]             DECIMAL (10, 2) NOT NULL,
    [MinTime]                 DECIMAL (10, 2) CONSTRAINT [DF_CalendarProviderAttributes_MinTime] DEFAULT ((0)) NOT NULL,
    [MaxTime]                 DECIMAL (10, 2) CONSTRAINT [DF_CalendarProviderAttributes_MaxTime] DEFAULT ((0)) NOT NULL,
    [BetweenTime]             DECIMAL (10, 2) NOT NULL,
    [UseCalendarProgram]      BIT             NOT NULL,
    [CalendarType]            VARCHAR (200)   NULL,
    [CalendarURL]             VARCHAR (500)   NULL,
    [PrivateCalendarToken]    VARCHAR (128)   NULL,
    [IncrementsSizeInMinutes] INT             CONSTRAINT [DF_CalendarProviderAttributes_IncrementsSizeInMinutes] DEFAULT ((15)) NOT NULL,
    [TimeZone]                VARCHAR (50)    NULL,
    CONSTRAINT [PK__Calendar__1788CCAC22B5168E] PRIMARY KEY CLUSTERED ([UserID] ASC) WITH (FILLFACTOR = 100)
);


GO
    
PRINT N'Creating [dbo].[CalendarReccurrence]...';
GO
CREATE TABLE [dbo].[CalendarReccurrence] (
    [ID]              INT                IDENTITY (1, 1) NOT NULL,
    [EventID]         INT                NULL,
    [Count]           INT                NULL,
    [EvaluationMode]  NVARCHAR (50)      NULL,
    [Frequency]       INT                NULL,
    [Interval]        INT                NULL,
    [RestristionType] INT                NULL,
    [Until]           DATETIMEOFFSET (0) NULL,
    [FirstDayOfWeek]  INT                NULL,
    CONSTRAINT [PK_CalendarReccursive] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarReccurrenceFrequency]...';
GO
CREATE TABLE [dbo].[CalendarReccurrenceFrequency] (
    [ID]                   INT IDENTITY (1, 1) NOT NULL,
    [CalendarReccursiveID] INT NULL,
    [ByDay]                BIT NULL,
    [ByHour]               BIT NULL,
    [ByMinute]             BIT NULL,
    [ByMonth]              BIT NULL,
    [ByMonthDay]           BIT NULL,
    [BySecond]             BIT NULL,
    [BySetPosition]        BIT NULL,
    [ByWeekNo]             BIT NULL,
    [ByYearDay]            BIT NULL,
    [ExtraValue]           INT NULL,
    [FrequencyDay]         INT NULL,
    [DayOfWeek]            INT NULL,
    CONSTRAINT [PK_CalendarRecurrence] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
    
PRINT N'Creating [dbo].[CalendarRecurrenceFrequencyTypes]...';
GO
CREATE TABLE [dbo].[CalendarRecurrenceFrequencyTypes] (
    [ID]            INT           NOT NULL,
    [FrequencyType] NVARCHAR (30) NULL,
    [UnitPlural]    NVARCHAR (30) NULL,
    CONSTRAINT [PK_CalendarRecurrenceFrequencyTypes] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
    
PRINT N'Creating [dbo].[cancellationpolicy]...';
GO
CREATE TABLE [dbo].[cancellationpolicy] (
    [CancellationPolicyID]          INT            NOT NULL,
    [LanguageID]                    INT            NOT NULL,
    [CountryID]                     INT            NOT NULL,
    [CancellationPolicyName]        VARCHAR (50)   NOT NULL,
    [CancellationPolicyDescription] VARCHAR (1000) NULL,
    [HoursRequired]                 INT            NULL,
    [CancellationFeeAfter]          DECIMAL (5, 2) NULL,
    [CancellationFeeBefore]         DECIMAL (5, 2) NULL,
    [CreatedDate]                   DATETIME       NOT NULL,
    [UpdatedDate]                   DATETIME       NOT NULL,
    [ModifiedBy]                    VARCHAR (25)   NOT NULL,
    [Active]                        BIT            NOT NULL,
    CONSTRAINT [PK__cancella__4BAA8CCE7A0806B6] PRIMARY KEY CLUSTERED ([CancellationPolicyID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[CCCUsers]...';
GO
CREATE TABLE [dbo].[CCCUsers] (
    [UserID]             INT          NOT NULL,
    [InstitutionID]      INT          NULL,
    [FieldOfStudyID]     INT          NULL,
    [PlanExpirationDate] DATETIME     NULL,
    [UserType]           VARCHAR (25) NULL,
    [StudentID]          INT          NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC)
);


GO
    
PRINT N'Creating [dbo].[clienttype]...';
GO
CREATE TABLE [dbo].[clienttype] (
    [CllientTypeID]         INT           NOT NULL,
    [ClientTypeName]        VARCHAR (50)  NOT NULL,
    [ClientTypeDescription] VARCHAR (500) NULL,
    [LanguageID]            INT           NOT NULL,
    [CountryID]             INT           NOT NULL,
    [CreatedDate]           DATETIME      NOT NULL,
    [UpdatedDate]           DATETIME      NOT NULL,
    [ModifiedBy]            VARCHAR (25)  NULL,
    [Active]                BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([CllientTypeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);



GO
    
PRINT N'Creating [dbo].[country]...';
GO
CREATE TABLE [dbo].[country] (
    [CountryID]          INT           NOT NULL,
    [LanguageID]         INT           NOT NULL,
    [CountryName]        VARCHAR (100) NOT NULL,
    [CountryCode]        VARCHAR (3)   NOT NULL,
    [CountryCodeAlpha2]  CHAR (2)      NULL,
    [CountryCallingCode] VARCHAR (3)   NULL,
    [CreatedDate]        DATETIME      NULL,
    [UpdatedDate]        DATETIME      NULL,
    [ModifiedBy]         VARCHAR (25)  NULL,
    [Active]             BIT           NOT NULL,
    [numcode]            INT           NULL,
    CONSTRAINT [PK__country__BB42E5E768D28DBC] PRIMARY KEY CLUSTERED ([CountryID] ASC, [LanguageID] ASC) WITH (FILLFACTOR = 100)
);


GO
    
PRINT N'Creating [dbo].[county]...';
GO
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
    
PRINT N'Creating [dbo].[ExperienceLevel]...';
GO
CREATE TABLE [dbo].[ExperienceLevel] (
    [ExperienceLevelID]          INT           IDENTITY (1, 1) NOT NULL,
    [LanguageID]                 INT           NOT NULL,
    [CountryID]                  INT           NOT NULL,
    [ExperienceLevelName]        VARCHAR (140) NOT NULL,
    [ExperienceLevelDescription] VARCHAR (140) NULL,
    [CreatedDate]                DATETIME      NOT NULL,
    [UpdatedDate]                DATETIME      NOT NULL,
    [ModifiedBy]                 VARCHAR (25)  NOT NULL,
    CONSTRAINT [PK__Experien__2F4E34695728DECD] PRIMARY KEY CLUSTERED ([ExperienceLevelID] ASC, [LanguageID] ASC, [CountryID] ASC) WITH (FILLFACTOR = 100)
);


GO
    
PRINT N'Creating [dbo].[FieldOfStudy]...';
GO
CREATE TABLE [dbo].[FieldOfStudy] (
    [FieldOfStudyID]   INT          IDENTITY (1, 1) NOT NULL,
    [FieldOfStudyName] VARCHAR (50) NOT NULL,
    [CCCTOPCode]       INT          NULL,
    [LanguageID]       INT          NULL,
    [CountryID]        INT          NULL,
    [CreatedDate]      DATETIME     NULL,
    [UpdatedDate]      DATETIME     NULL,
    [ModifiedBy]       VARCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([FieldOfStudyID] ASC)
);


GO
    
PRINT N'Creating [dbo].[Gender]...';
GO
CREATE TABLE [dbo].[Gender] (
    [GenderID]         INT           NOT NULL,
    [LanguageID]       INT           NOT NULL,
    [CountryID]        INT           NOT NULL,
    [GenderSingular]   NVARCHAR (16) NOT NULL,
    [GenderPlural]     NVARCHAR (16) NOT NULL,
    [SubjectPronoun]   VARCHAR (25)  NULL,
    [ObjectPronoun]    VARCHAR (25)  NULL,
    [PossesivePronoun] VARCHAR (25)  NULL,
    CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED ([GenderID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[institution]...';
GO
CREATE TABLE [dbo].[institution] (
    [InstitutionID]          INT            IDENTITY (1, 1) NOT NULL,
    [DeptOfEdInstitutionID]  VARCHAR (25)   NULL,
    [InstitutionName]        VARCHAR (200)  NOT NULL,
    [InstitutionAddress]     VARCHAR (200)  NULL,
    [InstitutionCity]        VARCHAR (100)  NULL,
    [InstitutionState]       VARCHAR (25)   NULL,
    [StateProvinceID]        INT            NULL,
    [InstitutionZip]         VARCHAR (25)   NULL,
    [InstitutionPhone]       VARCHAR (25)   NULL,
    [InstitutionOPEID]       VARCHAR (25)   NULL,
    [InstitutionIPEDSUnitID] VARCHAR (25)   NULL,
    [InstitutionURL]         VARCHAR (2083) NULL,
    [CountryID]              INT            NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [UpdatedDate]            DATETIME       NOT NULL,
    [ModifiedBy]             VARCHAR (25)   NOT NULL,
    [SchoolID]               VARCHAR (3)    NULL,
    [DistrictName]           VARCHAR (50)   NULL,
    [DistrictID]             VARCHAR (3)    NULL,
    CONSTRAINT [PK__institut__8DF6B94D047AA831] PRIMARY KEY CLUSTERED ([InstitutionID] ASC)
);


GO
    
PRINT N'Creating [dbo].[jobTitleLicense]...';
GO
CREATE TABLE [dbo].[jobTitleLicense] (
    [PositionID]             INT           NOT NULL,
    [LicenseCertificationID] INT           NOT NULL,
    [StateProvinceID]        INT           NOT NULL,
    [CountryID]              INT           NOT NULL,
    [Required]               BIT           NOT NULL,
    [CreatedDate]            DATETIME      NOT NULL,
    [UpdatedDate]            DATETIME      NOT NULL,
    [ModifiedBy]             VARCHAR (25)  NOT NULL,
    [Active]                 BIT           NOT NULL,
    [MunicipalityID]         INT           DEFAULT ((0)) NOT NULL,
    [CountyID]               INT           DEFAULT ((0)) NOT NULL,
    [OptionGroup]            VARCHAR (100) NULL,
    CONSTRAINT [PK__jobTitle__5E077F7A5FC911C6] PRIMARY KEY CLUSTERED ([PositionID] ASC, [LicenseCertificationID] ASC, [StateProvinceID] ASC, [CountryID] ASC, [MunicipalityID] ASC, [CountyID] ASC)
);


GO
    
PRINT N'Creating [dbo].[JobTitlePlatform]...';
GO
CREATE TABLE [dbo].[JobTitlePlatform] (
    [JobTitleID]  INT                NOT NULL,
    [PlatformID]  INT                NOT NULL,
    [LanguageID]  INT                NOT NULL,
    [CountryID]   INT                NOT NULL,
    [CreatedDate] DATETIMEOFFSET (0) NOT NULL,
    [UpdatedDate] DATETIMEOFFSET (0) NOT NULL,
    [ModifiedBy]  NVARCHAR (4)       NOT NULL,
    [Active]      BIT                CONSTRAINT [DF_JobTitlePlatform_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_JobTitlePlatform] PRIMARY KEY CLUSTERED ([JobTitleID] ASC, [PlatformID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[JobTitleSolution]...';
GO
CREATE TABLE [dbo].[JobTitleSolution] (
    [JobTitleID]      INT                NOT NULL,
    [SolutionID]      INT                NOT NULL,
    [LanguageID]      INT                NOT NULL,
    [CountryID]       INT                NOT NULL,
    [DefaultSelected] BIT                NULL,
    [DisplayRank]     INT                NULL,
    [CreatedDate]     DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]     DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]      NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    PRIMARY KEY CLUSTERED ([JobTitleID] ASC, [SolutionID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[language]...';
GO
CREATE TABLE [dbo].[language] (
    [LanguageID]   INT          NOT NULL,
    [CountryID]    INT          NOT NULL,
    [LanguageName] VARCHAR (50) NOT NULL,
    [Active]       BIT          NULL,
    [LanguageCode] VARCHAR (2)  NULL,
    [CreatedDate]  DATETIME     NULL,
    [UpdatedDate]  DATETIME     NULL,
    [ModifiedBy]   VARCHAR (25) NULL,
    PRIMARY KEY CLUSTERED ([LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[languagelevel]...';
GO
CREATE TABLE [dbo].[languagelevel] (
    [LanguageLevelID]          INT            IDENTITY (1, 1) NOT NULL,
    [LanguageID]               INT            NOT NULL,
    [CountryID]                INT            NOT NULL,
    [LanguageLevelName]        VARCHAR (140)  NOT NULL,
    [LanguageLevelDescription] VARCHAR (2000) NULL,
    [CreatedDate]              DATETIME       NOT NULL,
    [UpdatedDate]              DATETIME       NOT NULL,
    [ModifiedBy]               VARCHAR (25)   NOT NULL,
    CONSTRAINT [PK__language__F5325F2353584DE9] PRIMARY KEY CLUSTERED ([LanguageLevelID] ASC, [LanguageID] ASC, [CountryID] ASC) WITH (FILLFACTOR = 100)
);


GO
    
PRINT N'Creating [dbo].[licensecertification]...';
GO
CREATE TABLE [dbo].[licensecertification] (
    [LicenseCertificationID]              INT            NOT NULL,
    [LicenseCertificationType]            VARCHAR (100)  NOT NULL,
    [LicenseCertificationTypeDescription] VARCHAR (4000) NULL,
    [LicenseCertificationAuthority]       VARCHAR (500)  NULL,
    [VerificationWebsiteURL]              VARCHAR (2078) NULL,
    [HowToGetLicensedURL]                 VARCHAR (2078) NULL,
    [CreatedDate]                         DATETIME       NOT NULL,
    [UpdatedDate]                         DATETIME       NOT NULL,
    [ModifiedBy]                          VARCHAR (25)   NOT NULL,
    [Active]                              BIT            NOT NULL,
    [LanguageID]                          INT            CONSTRAINT [DF__licensece__Langu__5BF880E2] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK__licensec__65E993A46F0B5556] PRIMARY KEY CLUSTERED ([LicenseCertificationID] ASC, [LanguageID] ASC)
);


GO
    
PRINT N'Creating [dbo].[Messages]...';
GO
CREATE TABLE [dbo].[Messages] (
    [MessageID]     INT            IDENTITY (1, 1) NOT NULL,
    [ThreadID]      INT            NOT NULL,
    [MessageTypeID] INT            NOT NULL,
    [AuxID]         INT            NULL,
    [AuxT]          NVARCHAR (50)  NULL,
    [BodyText]      VARCHAR (4000) NOT NULL,
    [CreatedDate]   DATETIME       NOT NULL,
    [UpdatedDate]   DATETIME       NOT NULL,
    [ModifiedBy]    VARCHAR (50)   NOT NULL,
    [SentByUserId]  INT            CONSTRAINT [DF_Messages_SentByUserId] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Messages_messageID] PRIMARY KEY CLUSTERED ([MessageID] ASC) WITH (FILLFACTOR = 100)
);



GO
    
PRINT N'Creating [dbo].[messagethreadstatus]...';
GO
CREATE TABLE [dbo].[messagethreadstatus] (
    [MessageThreadStatusID]          INT           NOT NULL,
    [MessageThreadStatusName]        VARCHAR (25)  NOT NULL,
    [MessageThreadStatusDescription] VARCHAR (100) NULL,
    [CreatedDate]                    DATETIME      NOT NULL,
    [UpdatedDate]                    DATETIME      NOT NULL,
    [ModifiedBy]                     VARCHAR (25)  NOT NULL,
    [Active]                         BIT           NOT NULL,
    [MessageStatusColor]             VARCHAR (7)   NOT NULL,
    CONSTRAINT [Pk_messagethreadstatus_0] PRIMARY KEY CLUSTERED ([MessageThreadStatusID] ASC),
    CONSTRAINT [Pk_messagethreadstatus] UNIQUE NONCLUSTERED ([MessageThreadStatusID] ASC)
);


GO
    
PRINT N'Creating [dbo].[messagetype]...';
GO
CREATE TABLE [dbo].[messagetype] (
    [MessageTypeID]          INT           NOT NULL,
    [LanguageID]             INT           NOT NULL,
    [CountryID]              INT           NOT NULL,
    [MessageTypeName]        VARCHAR (50)  NULL,
    [MessageTypeDescription] VARCHAR (200) NULL,
    [CreatedDate]            DATETIME      NOT NULL,
    [UpdatedDate]            DATETIME      NOT NULL,
    [ModifiedBy]             VARCHAR (25)  NOT NULL,
    [Active]                 BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([MessageTypeID] ASC, [LanguageID] ASC, [CountryID] ASC),
    CONSTRAINT [Pk_messagetype] UNIQUE NONCLUSTERED ([MessageTypeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[MessagingThreads]...';
GO
CREATE TABLE [dbo].[MessagingThreads] (
    [ThreadID]              INT            IDENTITY (1, 1) NOT NULL,
    [CustomerUserID]        INT            NOT NULL,
    [ProviderUserID]        INT            NOT NULL,
    [PositionID]            INT            NULL,
    [MessageThreadStatusID] INT            NOT NULL,
    [Subject]               NVARCHAR (100) NULL,
    [LastMessageID]         INT            NULL,
    [CreatedDate]           DATETIME       NOT NULL,
    [UpdatedDate]           DATETIME       NOT NULL,
    [ModifiedBy]            VARCHAR (50)   NOT NULL,
    CONSTRAINT [PK__Messagin__688356E41EC48A19] PRIMARY KEY CLUSTERED ([ThreadID] ASC)
);


GO
    
PRINT N'Creating [dbo].[municipality]...';
GO
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
    
PRINT N'Creating [dbo].[OwnerAcknowledgment]...';
GO
CREATE TABLE [dbo].[OwnerAcknowledgment] (
    [UserID]             INT                NOT NULL,
    [DateAcknowledged]   DATETIMEOFFSET (7) NOT NULL,
    [AcknowledgedFromIP] VARCHAR (25)       NOT NULL,
    [CreatedDate]        DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]        DATETIMEOFFSET (7) NOT NULL,
    [DetectedIPs]        VARCHAR (200)      NOT NULL,
    CONSTRAINT [PK_OwnerAcknowledgment] PRIMARY KEY CLUSTERED ([UserID] ASC)
);


GO
    
PRINT N'Creating [dbo].[OwnerStatus]...';
GO
CREATE TABLE [dbo].[OwnerStatus] (
    [OwnserStatusID]         INT           NOT NULL,
    [OwnerStatusName]        VARCHAR (50)  NOT NULL,
    [OwnerStatusDescription] VARCHAR (200) NULL,
    [CreatedDate]            DATETIME      NOT NULL,
    [UpdatedDate]            DATETIME      NOT NULL,
    [Active]                 BIT           NOT NULL,
    [UpdatedBy]              VARCHAR (3)   NULL,
    CONSTRAINT [PK_OwnerStatus] PRIMARY KEY CLUSTERED ([OwnserStatusID] ASC)
);


GO
    
PRINT N'Creating [dbo].[OwnerStatusHistory]...';
GO
CREATE TABLE [dbo].[OwnerStatusHistory] (
    [UserID]                 INT         NOT NULL,
    [OwnerStatusChangedDate] DATETIME    NOT NULL,
    [OwnerStatusID]          INT         NOT NULL,
    [OwnerStatusChangedBy]   VARCHAR (3) NOT NULL,
    CONSTRAINT [PK__OwnerSta__1788CCAC7F76C749] PRIMARY KEY CLUSTERED ([UserID] ASC, [OwnerStatusChangedDate] ASC)
);


GO
    
PRINT N'Creating [dbo].[Platform]...';
GO
CREATE TABLE [dbo].[Platform] (
    [PlatformID]       INT                NOT NULL,
    [LanguageID]       INT                NOT NULL,
    [CountryID]        INT                NOT NULL,
    [Name]             NVARCHAR (20)      NOT NULL,
    [ShortDescription] NVARCHAR (50)      NOT NULL,
    [LongDescription]  TEXT               NOT NULL,
    [FeesDescription]  TEXT               NOT NULL,
    [PositiveAspects]  TEXT               NOT NULL,
    [NegativeAspects]  TEXT               NOT NULL,
    [Advice]           TEXT               NOT NULL,
    [SignUpURL]        NVARCHAR (255)     NOT NULL,
    [SignInURL]        NVARCHAR (255)     NOT NULL,
    [CreatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]      DATETIMEOFFSET (0) NOT NULL,
    [ModifiedBy]       NVARCHAR (4)       NOT NULL,
    [Active]           BIT                CONSTRAINT [DF_Platform_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Platform] PRIMARY KEY CLUSTERED ([PlatformID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[positionbackgroundcheck]...';
GO
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


GO
    
PRINT N'Creating [dbo].[positionpricingtype]...';
GO
CREATE TABLE [dbo].[positionpricingtype] (
    [PositionID]    INT          NOT NULL,
    [PricingTypeID] INT          NOT NULL,
    [ClientTypeID]  INT          NOT NULL,
    [LanguageID]    INT          NOT NULL,
    [CountryID]     INT          NOT NULL,
    [CreatedDate]   DATETIME     NOT NULL,
    [UpdatedDate]   DATETIME     NOT NULL,
    [ModifiedBy]    VARCHAR (25) NOT NULL,
    [Active]        BIT          NOT NULL,
    PRIMARY KEY CLUSTERED ([PositionID] ASC, [PricingTypeID] ASC, [ClientTypeID] ASC, [LanguageID] ASC, [CountryID] ASC) WITH (FILLFACTOR = 100)
);


GO
    
PRINT N'Creating [dbo].[positionratings]...';
GO
CREATE TABLE [dbo].[positionratings] (
    [PositionID]                INT            NOT NULL,
    [LanguageID]                INT            NOT NULL,
    [CountryID]                 INT            NOT NULL,
    [Rating1]                   VARCHAR (25)   NOT NULL,
    [Rating2]                   VARCHAR (25)   NOT NULL,
    [Rating3]                   VARCHAR (25)   NOT NULL,
    [Rating4]                   VARCHAR (25)   NULL,
    [Rating1FormDescription]    VARCHAR (1000) NULL,
    [Rating2FormDescription]    VARCHAR (1000) NULL,
    [Rating3FormDescription]    VARCHAR (1000) NULL,
    [Rating4FormDescription]    VARCHAR (1000) NULL,
    [Rating1ProfileDescription] VARCHAR (1000) NULL,
    [Rating2ProfileDescription] VARCHAR (1000) NULL,
    [Rating3ProfileDescription] VARCHAR (1000) NULL,
    [Rating4ProfileDescription] VARCHAR (1000) NULL,
    [CreatedDate]               DATETIME       NOT NULL,
    [UpdatedDate]               DATETIME       NOT NULL,
    [ModifiedBy]                VARCHAR (25)   NOT NULL,
    CONSTRAINT [PK__position__E3225E7D52EE3995] PRIMARY KEY CLUSTERED ([CountryID] ASC, [LanguageID] ASC, [PositionID] ASC)
);


GO
    
PRINT N'Creating [dbo].[positions]...';
GO
CREATE TABLE [dbo].[positions] (
    [PositionID]                 INT            NOT NULL,
    [LanguageID]                 INT            NOT NULL,
    [CountryID]                  INT            NOT NULL,
    [PositionSingular]           VARCHAR (250)  NULL,
    [PositionPlural]             VARCHAR (250)  NULL,
    [Aliases]                    VARCHAR (200)  NULL,
    [PositionDescription]        VARCHAR (2000) NULL,
    [CreatedDate]                DATETIME       NULL,
    [UpdatedDate]                DATETIME       NULL,
    [ModifiedBy]                 VARCHAR (2)    NULL,
    [GovID]                      VARCHAR (20)   NULL,
    [GovPosition]                VARCHAR (200)  NULL,
    [GovPositionDescription]     VARCHAR (2000) NULL,
    [Active]                     BIT            NULL,
    [DisplayRank]                INT            NULL,
    [PositionSearchDescription]  VARCHAR (1000) NULL,
    [AttributesComplete]         BIT            CONSTRAINT [DF_positions_AttributesComplete] DEFAULT ((0)) NOT NULL,
    [StarRatingsComplete]        BIT            CONSTRAINT [DF_positions_StarRatingsComplete] DEFAULT ((0)) NOT NULL,
    [PricingTypeComplete]        BIT            CONSTRAINT [DF_positions_PricingTypeComplete] DEFAULT ((0)) NOT NULL,
    [EnteredByUserID]            INT            NULL,
    [Approved]                   BIT            NULL,
    [AddGratuity]                INT            DEFAULT ((0)) NOT NULL,
    [HIPAA]                      BIT            DEFAULT ((0)) NOT NULL,
    [SendReviewReminderToClient] BIT            DEFAULT ((1)) NOT NULL,
    [CanBeRemote]                BIT            DEFAULT ((0)) NOT NULL,
    [SuppressReviewOfClient]     BIT            DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_positions_1] PRIMARY KEY CLUSTERED ([PositionID] ASC, [LanguageID] ASC, [CountryID] ASC)
);



GO
    
PRINT N'Creating [dbo].[postalcode]...';
GO
CREATE TABLE [dbo].[postalcode] (
    [PostalCodeID]    INT           NOT NULL,
    [PostalCode]      VARCHAR (25)  NULL,
    [City]            VARCHAR (250) NULL,
    [StateProvinceID] INT           NOT NULL,
    [CountryID]       INT           NOT NULL,
    [Latitude]        FLOAT (53)    NULL,
    [Longitude]       FLOAT (53)    NULL,
    [StandardOffset]  DECIMAL (18)  NULL,
    [DST]             BIT           NULL,
    [Location]        VARCHAR (250) NULL,
    [PostalCodeType]  VARCHAR (50)  NULL,
    [CreatedDate]     DATETIME      NULL,
    [UpdatedDate]     DATETIME      NULL,
    [ModifiedBy]      VARCHAR (25)  NULL,
    [MunicipalityID]  INT           DEFAULT ((0)) NOT NULL,
    [CountyID]        INT           DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([PostalCodeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[postingTemplate]...';
GO
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


GO
    
PRINT N'Creating [dbo].[postingTemplateQuestion]...';
GO
CREATE TABLE [dbo].[postingTemplateQuestion] (
    [postingTemplateQuestionID] INT                IDENTITY (1, 1) NOT NULL,
    [postingTemplateID]         INT                NOT NULL,
    [questionID]                INT                NOT NULL,
    [legend]                    NVARCHAR (150)     NOT NULL,
    [branchLogic]               TEXT               NULL,
    [createdDate]               DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]               DATETIMEOFFSET (0) NOT NULL,
    [modifiedby]                NCHAR (5)          NOT NULL,
    [active]                    TINYINT            NOT NULL,
    CONSTRAINT [PK_postingTemplateQuestion] PRIMARY KEY CLUSTERED ([postingTemplateQuestionID] ASC)
);


GO
    
PRINT N'Creating [dbo].[PricingGroups]...';
GO
CREATE TABLE [dbo].[PricingGroups] (
    [PricingGroupID]      INT           NOT NULL,
    [InternalGroupName]   VARCHAR (50)  NOT NULL,
    [SelectionTitle]      VARCHAR (100) NOT NULL,
    [SummaryTitle]        VARCHAR (100) NOT NULL,
    [DynamicSummaryTitle] VARCHAR (100) NOT NULL,
    [LanguageID]          INT           NULL,
    [CountryID]           INT           NULL,
    CONSTRAINT [PK_PricingGroups] PRIMARY KEY CLUSTERED ([PricingGroupID] ASC)
);


GO
    
PRINT N'Creating [dbo].[pricingSummary]...';
GO
CREATE TABLE [dbo].[pricingSummary] (
    [PricingSummaryID]               INT            NOT NULL,
    [PricingSummaryRevision]         INT            CONSTRAINT [DF__pricinges__Prici__04CFADEC] DEFAULT ((1)) NOT NULL,
    [ServiceDurationMinutes]         INT            NULL,
    [FirstSessionDurationMinutes]    INT            NULL,
    [SubtotalPrice]                  DECIMAL (7, 2) NULL,
    [ClientServiceFeePrice]          DECIMAL (7, 2) NULL,
    [TotalPrice]                     DECIMAL (7, 2) NULL,
    [ServiceFeeAmount]               DECIMAL (7, 2) CONSTRAINT [DF_pricingestimate_PFeePrice] DEFAULT ((0)) NULL,
    [CreatedDate]                    DATETIME       NOT NULL,
    [UpdatedDate]                    DATETIME       NOT NULL,
    [ModifiedBy]                     VARCHAR (25)   NOT NULL,
    [Active]                         BIT            NOT NULL,
    [CancellationDate]               DATETIME       NULL,
    [CancellationFeeCharged]         DECIMAL (7, 2) NULL,
    [FirstTimeServiceFeeFixed]       DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeeFixed] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeePercentage]  DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeePercentage] DEFAULT ((0)) NOT NULL,
    [PaymentProcessingFeePercentage] DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_PaymentProcessingFeePercentage] DEFAULT ((0)) NOT NULL,
    [PaymentProcessingFeeFixed]      DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_PaymentProcessingFeeFixed] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeeMaximum]     DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeeMaximum] DEFAULT ((0)) NOT NULL,
    [FirstTimeServiceFeeMinimum]     DECIMAL (5, 2) CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeeMinimum] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK__pricinge__7F7D375D21D600EE] PRIMARY KEY CLUSTERED ([PricingSummaryID] ASC, [PricingSummaryRevision] ASC) WITH (FILLFACTOR = 100)
);


GO
    
PRINT N'Creating [dbo].[pricingSummaryDetail]...';
GO
CREATE TABLE [dbo].[pricingSummaryDetail] (
    [PricingSummaryID]             INT            NOT NULL,
    [PricingSummaryRevision]       INT            NOT NULL,
    [ServiceProfessionalServiceID] INT            NOT NULL,
    [ServiceProfessionalDataInput] VARCHAR (100)  NULL,
    [ClientDataInput]              VARCHAR (500)  NULL,
    [HourlyPrice]                  DECIMAL (5, 2) NULL,
    [Price]                        DECIMAL (7, 2) NULL,
    [ServiceDurationMinutes]       INT            NULL,
    [FirstSessionDurationMinutes]  INT            NULL,
    [ServiceName]                  VARCHAR (50)   NOT NULL,
    [ServiceDescription]           VARCHAR (1000) NULL,
    [NumberOfSessions]             INT            NOT NULL,
    [CreatedDate]                  DATETIME       NOT NULL,
    [UpdatedDate]                  DATETIME       NOT NULL,
    [ModifiedBy]                   VARCHAR (25)   NOT NULL,
    [IsRemoteService]              BIT            CONSTRAINT [DF_pricingSummaryDetail_IsRemoteService] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_pricingestimatedetail_1] PRIMARY KEY CLUSTERED ([PricingSummaryID] ASC, [PricingSummaryRevision] ASC, [ServiceProfessionalServiceID] ASC)
);


GO
    
PRINT N'Creating [dbo].[pricingtype]...';
GO
CREATE TABLE [dbo].[pricingtype] (
    [PricingTypeID] INT          NOT NULL,
    [LanguageID]    INT          CONSTRAINT [DF__pricingty__Langu__086B34A6] DEFAULT ((1)) NOT NULL,
    [CountryID]     INT          CONSTRAINT [DF__pricingty__Count__095F58DF] DEFAULT ((1)) NOT NULL,
    [Description]   VARCHAR (50) NULL,
    [CreatedDate]   DATETIME     NOT NULL,
    [UpdatedDate]   DATETIME     NOT NULL,
    [ModifiedBy]    VARCHAR (50) NOT NULL,
    [Active]        BIT          CONSTRAINT [DF__pricingty__Activ__0A537D18] DEFAULT ((1)) NOT NULL,
    [DisplayRank]   INT          NOT NULL,
    CONSTRAINT [PK_pricingtype_PricingTypeID] PRIMARY KEY CLUSTERED ([PricingTypeID] ASC, [LanguageID] ASC, [CountryID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [Pk_pricingtype] UNIQUE NONCLUSTERED ([PricingTypeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[PricingVariableDefinition]...';
GO
CREATE TABLE [dbo].[PricingVariableDefinition] (
    [PricingVariableID]          INT            NOT NULL,
    [LanguageID]                 INT            NOT NULL,
    [CountryID]                  INT            NOT NULL,
    [PositionID]                 INT            NOT NULL,
    [PricingTypeID]              INT            NOT NULL,
    [InternalName]               VARCHAR (60)   NOT NULL,
    [IsProviderVariable]         BIT            CONSTRAINT [DF_PricingVariableDefinition_IsProviderVariable] DEFAULT ((0)) NOT NULL,
    [IsCustomerVariable]         BIT            CONSTRAINT [DF_PricingVariableDefinition_IsCustomerVariable] DEFAULT ((0)) NOT NULL,
    [DataType]                   VARCHAR (50)   NOT NULL,
    [VariableLabel]              NVARCHAR (100) NULL,
    [VariableLabelPopUp]         NVARCHAR (200) NULL,
    [VariableNameSingular]       NVARCHAR (60)  NULL,
    [VariableNamePlural]         NVARCHAR (60)  NULL,
    [NumberIncludedLabel]        NVARCHAR (100) NULL,
    [NumberIncludedLabelPopUp]   NVARCHAR (200) NULL,
    [HourlySurchargeLabel]       NVARCHAR (100) NULL,
    [MinNumberAllowedLabel]      NVARCHAR (100) NULL,
    [MinNumberAllowedLabelPopUp] NVARCHAR (200) NULL,
    [MaxNumberAllowedLabel]      NVARCHAR (100) NULL,
    [MaxNumberAllowedLabelPopUp] NVARCHAR (200) NULL,
    [CalculateWithVariableID]    INT            NULL,
    [Active]                     BIT            CONSTRAINT [DF_PricingVariableDefinition_Active] DEFAULT ((1)) NOT NULL,
    [CreatedDate]                DATETIME       CONSTRAINT [DF_PricingVariableDefinition_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedDate]                DATETIME       CONSTRAINT [DF_PricingVariableDefinition_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]                 VARCHAR (25)   CONSTRAINT [DF_PricingVariableDefinition_ModifiedBy] DEFAULT ('sys') NOT NULL,
    [MinMaxValuesList]           NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_PricingVariableDefinition] PRIMARY KEY CLUSTERED ([PricingVariableID] ASC, [LanguageID] ASC, [CountryID] ASC, [PositionID] ASC, [PricingTypeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[PricingVariableValue]...';
GO
CREATE TABLE [dbo].[PricingVariableValue] (
    [PricingVariableID]        INT            NOT NULL,
    [ProviderPackageID]        INT            NOT NULL,
    [UserID]                   INT            NOT NULL,
    [PricingEstimateID]        INT            NOT NULL,
    [PricingEstimateRevision]  INT            NOT NULL,
    [Value]                    VARCHAR (100)  NOT NULL,
    [ProviderNumberIncluded]   DECIMAL (7, 2) NULL,
    [ProviderMinNumberAllowed] DECIMAL (7, 2) NULL,
    [ProviderMaxNumberAllowed] DECIMAL (7, 2) NULL,
    [CreatedDate]              DATETIME       CONSTRAINT [DF_PricingVariableValue_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedDate]              DATETIME       CONSTRAINT [DF_PricingVariableValue_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedBy]               VARCHAR (25)   CONSTRAINT [DF_PricingVariableValue_ModifiedBy] DEFAULT ('sys') NOT NULL,
    [Active]                   BIT            CONSTRAINT [DF_PricingVariableValue_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_PricingVariableValue] PRIMARY KEY CLUSTERED ([PricingVariableID] ASC, [ProviderPackageID] ASC, [UserID] ASC, [PricingEstimateID] ASC, [PricingEstimateRevision] ASC)
);


GO
    
PRINT N'Creating [dbo].[providerpackage]...';
GO
CREATE TABLE [dbo].[providerpackage] (
    [ProviderPackageID]              INT            IDENTITY (1, 1) NOT NULL,
    [PricingTypeID]                  INT            NOT NULL,
    [ProviderUserID]                 INT            NOT NULL,
    [PositionID]                     INT            NOT NULL,
    [LanguageID]                     INT            NOT NULL,
    [CountryID]                      INT            NOT NULL,
    [ProviderPackageName]            VARCHAR (50)   NOT NULL,
    [ProviderPackageDescription]     VARCHAR (1000) NULL,
    [ProviderPackagePrice]           DECIMAL (7, 2) NULL,
    [ProviderPackageServiceDuration] INT            NOT NULL,
    [FirstTimeClientsOnly]           BIT            CONSTRAINT [DF__providerp__First__1BD30ED5] DEFAULT ((0)) NOT NULL,
    [NumberOfSessions]               INT            CONSTRAINT [DF__providerp__Numbe__1CC7330E] DEFAULT ((1)) NOT NULL,
    [CreatedDate]                    DATETIME       NOT NULL,
    [UpdatedDate]                    DATETIME       NOT NULL,
    [ModifiedBy]                     VARCHAR (25)   NOT NULL,
    [Active]                         BIT            NOT NULL,
    [IsAddOn]                        BIT            CONSTRAINT [DF__providerp__IsAdd__1F398B65] DEFAULT ((0)) NOT NULL,
    [PriceRate]                      DECIMAL (7, 2) NULL,
    [PriceRateUnit]                  NVARCHAR (30)  COLLATE Modern_Spanish_CI_AS NULL,
    [IsPhone]                        BIT            CONSTRAINT [DF_providerpackage_IsPhone] DEFAULT ((0)) NOT NULL,
    [VisibleToClientID]              INT            DEFAULT ((0)) NOT NULL,
    [SolutionID]                     INT            CONSTRAINT [DF_providerpackage_SolutionID] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_providerpackage] PRIMARY KEY CLUSTERED ([ProviderPackageID] ASC)
);


GO
    
PRINT N'Creating [dbo].[providerpackagedetail]...';
GO
CREATE TABLE [dbo].[providerpackagedetail] (
    [ProviderPackageID]  INT          NOT NULL,
    [ServiceAttributeID] INT          NOT NULL,
    [CreatedDate]        DATETIME     DEFAULT ('sysdate') NOT NULL,
    [UpdatedDate]        DATETIME     DEFAULT ('sysdate') NOT NULL,
    [ModifiedBy]         VARCHAR (25) DEFAULT ('sys') NOT NULL,
    [Active]             BIT          DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_providerpackagedetail] PRIMARY KEY CLUSTERED ([ProviderPackageID] ASC, [ServiceAttributeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[ProviderPaymentAccount]...';
GO
CREATE TABLE [dbo].[ProviderPaymentAccount] (
    [ProviderUserID]    INT            NOT NULL,
    [MerchantAccountID] NVARCHAR (100) NOT NULL,
    [Status]            NVARCHAR (50)  NOT NULL,
    [Message]           NVARCHAR (400) NULL,
    [bt_signature]      NVARCHAR (MAX) NULL,
    [bt_payload]        NVARCHAR (MAX) NULL,
    [CreatedDate]       DATETIME       NOT NULL,
    [UpdatedDate]       DATETIME       NOT NULL,
    [ModifiedBy]        VARCHAR (25)   NOT NULL,
    CONSTRAINT [PK_ProviderPaymentAccount] PRIMARY KEY CLUSTERED ([ProviderUserID] ASC)
);


GO
    
PRINT N'Creating [dbo].[providerpaymentpreference]...';
GO
CREATE TABLE [dbo].[providerpaymentpreference] (
    [ProviderUserID]                  INT           NOT NULL,
    [ProviderPaymentPreferenceTypeID] INT           NOT NULL,
    [CreatedDate]                     DATETIME      NOT NULL,
    [UpdatedDate]                     DATETIME      NOT NULL,
    [Modifiedby]                      VARCHAR (25)  NOT NULL,
    [Verified]                        BIT           CONSTRAINT [DF__providerp__Verif__08D548FA] DEFAULT ((0)) NOT NULL,
    [AccountName]                     VARCHAR (100) NULL,
    [ABANumber]                       NUMERIC (9)   NULL,
    [LastThreeAccountDigits]          VARCHAR (64)  NULL,
    CONSTRAINT [PK_providerpaymentpreference] PRIMARY KEY CLUSTERED ([ProviderUserID] ASC)
);


GO
    
PRINT N'Creating [dbo].[providerpaymentpreferencetype]...';
GO
CREATE TABLE [dbo].[providerpaymentpreferencetype] (
    [ProviderPaymentPreferenceTypeID]          INT           NOT NULL,
    [LanguageID]                               INT           NOT NULL,
    [CountryID]                                INT           NOT NULL,
    [ProviderPaymentPreferenceTypeName]        VARCHAR (50)  NOT NULL,
    [ProviderPaymentPreferenceTypeDescription] VARCHAR (300) NULL,
    [DependsOnID]                              INT           NULL,
    [CreatedDate]                              DATETIME      NOT NULL,
    [UpdatedDate]                              DATETIME      NOT NULL,
    [ModifiedBy]                               VARCHAR (25)  NOT NULL,
    [Active]                                   BIT           NOT NULL,
    CONSTRAINT [PK__provider__A7C3000A031C6FA4] PRIMARY KEY CLUSTERED ([ProviderPaymentPreferenceTypeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[providerservicephoto]...';
GO
CREATE TABLE [dbo].[providerservicephoto] (
    [ProviderServicePhotoID] INT            IDENTITY (1, 1) NOT NULL,
    [UserID]                 INT            NOT NULL,
    [PositionID]             INT            NOT NULL,
    [PhotoCaption]           VARCHAR (150)  NULL,
    [PhotoAddress]           VARCHAR (2073) NOT NULL,
    [RankPosition]           INT            NOT NULL,
    [CreatedDate]            DATETIME       NOT NULL,
    [UpdatedDate]            DATETIME       NOT NULL,
    [ModifiedBy]             VARCHAR (25)   NOT NULL,
    [Active]                 BIT            NOT NULL,
    [IsPrimaryPhoto]         BIT            NOT NULL,
    CONSTRAINT [PK__servicep__D5090DBE39E294A9] PRIMARY KEY CLUSTERED ([ProviderServicePhotoID] ASC)
);


GO
    
PRINT N'Creating [dbo].[providertaxform]...';
GO
CREATE TABLE [dbo].[providertaxform] (
    [ProviderUserID]     INT           NOT NULL,
    [FullName]           VARCHAR (200) NOT NULL,
    [BusinessName]       VARCHAR (200) NULL,
    [StreetApt]          VARCHAR (100) NOT NULL,
    [City]               VARCHAR (100) NOT NULL,
    [PostalCodeID]       INT           NULL,
    [StateProvinceID]    INT           NOT NULL,
    [CountryID]          INT           NOT NULL,
    [TaxEntityTypeID]    INT           NOT NULL,
    [ExemptPayee]        BIT           NOT NULL,
    [TINTypeID]          VARCHAR (25)  NOT NULL,
    [Signature]          VARCHAR (200) NOT NULL,
    [UserIPAddress]      VARCHAR (500) NOT NULL,
    [DateTimeSubmitted]  DATETIME      NOT NULL,
    [CreatedDate]        DATETIME      NOT NULL,
    [UpdatedDate]        DATETIME      NOT NULL,
    [ModifiedBy]         VARCHAR (25)  NULL,
    [Active]             BIT           NOT NULL,
    [LastThreeTINDigits] VARCHAR (64)  NULL,
    CONSTRAINT [PK_providertaxform] PRIMARY KEY CLUSTERED ([ProviderUserID] ASC)
);


GO
    
PRINT N'Creating [dbo].[question]...';
GO
CREATE TABLE [dbo].[question] (
    [questionID]     INT                NOT NULL,
    [questionTypeID] INT                NOT NULL,
    [question]       NVARCHAR (120)     NOT NULL,
    [helpBlock]      NVARCHAR (300)     NULL,
    [options]        TEXT               NOT NULL,
    [languageID]     INT                NOT NULL,
    [countryID]      INT                NOT NULL,
    [createdDate]    DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]    DATETIMEOFFSET (0) NOT NULL,
    [modifiedBy]     NVARCHAR (10)      NOT NULL,
    [label]          NVARCHAR (120)     DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_question] PRIMARY KEY CLUSTERED ([questionID] ASC)
);


GO
    
PRINT N'Creating [dbo].[questionType]...';
GO
CREATE TABLE [dbo].[questionType] (
    [questionTypeID] INT                NOT NULL,
    [name]           NVARCHAR (50)      NOT NULL,
    [description]    NVARCHAR (500)     NOT NULL,
    [createdDate]    DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]    DATETIMEOFFSET (0) NOT NULL,
    [modifiedBy]     NVARCHAR (10)      NOT NULL,
    CONSTRAINT [PK_questionType] PRIMARY KEY CLUSTERED ([questionTypeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[ReferralSource]...';
GO
CREATE TABLE [dbo].[ReferralSource] (
    [ReferralSourceID] INT           NOT NULL,
    [Name]             NVARCHAR (80) NOT NULL,
    CONSTRAINT [PK_ReferralSource] PRIMARY KEY CLUSTERED ([ReferralSourceID] ASC)
);


GO
    
PRINT N'Creating [dbo].[SearchCategory]...';
GO
CREATE TABLE [dbo].[SearchCategory] (
    [SearchCategoryID] INT                NOT NULL,
    [LanguageID]       INT                NOT NULL,
    [CountryID]        INT                NOT NULL,
    [Name]             NVARCHAR (20)      NOT NULL,
    [ShortDescription] NVARCHAR (100)     NULL,
    [LongDescription]  NVARCHAR (300)     NULL,
    [SmallImage]       NVARCHAR (255)     NULL,
    [BannerImage]      NVARCHAR (255)     NULL,
    [DisplayRank]      INT                NULL,
    [CreatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]       NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]           BIT                DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([SearchCategoryID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[SearchSubCategory]...';
GO
CREATE TABLE [dbo].[SearchSubCategory] (
    [SearchSubCategoryID] INT                NOT NULL,
    [LanguageID]          INT                NOT NULL,
    [CountryID]           INT                NOT NULL,
    [SearchCategoryID]    INT                NOT NULL,
    [Name]                NVARCHAR (40)      NOT NULL,
    [Description]         NVARCHAR (100)     NULL,
    [Image]               NVARCHAR (255)     NULL,
    [DisplayRank]         INT                NULL,
    [CreatedDate]         DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]         DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]          NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]              BIT                DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([SearchSubCategoryID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[SearchSubCategorySolution]...';
GO
CREATE TABLE [dbo].[SearchSubCategorySolution] (
    [SearchSubCategoryID] INT                NOT NULL,
    [SolutionID]          INT                NOT NULL,
    [LanguageID]          INT                NOT NULL,
    [CountryID]           INT                NOT NULL,
    [DisplayRank]         INT                NULL,
    [CreatedDate]         DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]         DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]          NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    PRIMARY KEY CLUSTERED ([SearchSubCategoryID] ASC, [SolutionID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[serviceaddress]...';
GO
CREATE TABLE [dbo].[serviceaddress] (
    [AddressID]                   INT          NOT NULL,
    [UserID]                      INT          NOT NULL,
    [PositionID]                  INT          NOT NULL,
    [ServicesPerformedAtLocation] BIT          CONSTRAINT [DF__servicead__Servi__532343BF] DEFAULT ((0)) NOT NULL,
    [TravelFromLocation]          BIT          CONSTRAINT [DF__servicead__Trave__541767F8] DEFAULT ((0)) NOT NULL,
    [ServiceRadiusFromLocation]   VARCHAR (25) NULL,
    [TransportType]               INT          CONSTRAINT [DF__servicead__Trans__550B8C31] DEFAULT ((1)) NULL,
    [PreferredAddress]            BIT          CONSTRAINT [DF__servicead__Prefe__55FFB06A] DEFAULT ((0)) NOT NULL,
    [CreatedDate]                 DATETIME     NOT NULL,
    [UpdatedDate]                 DATETIME     NOT NULL,
    [ModifiedBy]                  VARCHAR (25) NOT NULL,
    [Active]                      BIT          NOT NULL,
    CONSTRAINT [PK__servicea__8F1793BE58DC1D15] PRIMARY KEY CLUSTERED ([AddressID] ASC, [UserID] ASC, [PositionID] ASC)
);


GO
    
PRINT N'Creating [dbo].[serviceattribute]...';
GO
CREATE TABLE [dbo].[serviceattribute] (
    [ServiceAttributeID]          INT            NOT NULL,
    [LanguageID]                  INT            NOT NULL,
    [CountryID]                   INT            NOT NULL,
    [SourceID]                    INT            DEFAULT (NULL) NULL,
    [Name]                        VARCHAR (100)  NULL,
    [ServiceAttributeDescription] VARCHAR (2000) NULL,
    [CreateDate]                  DATETIME       NULL,
    [UpdatedDate]                 DATETIME       NULL,
    [ModifiedBy]                  VARCHAR (45)   NULL,
    [Active]                      BIT            NULL,
    [DisplayRank]                 INT            DEFAULT ((1)) NOT NULL,
    [PositionReference]           INT            NULL,
    [EnteredByUserID]             INT            NULL,
    [Approved]                    BIT            NULL,
    CONSTRAINT [PK_serviceattribute] PRIMARY KEY CLUSTERED ([ServiceAttributeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[serviceattributecategory]...';
GO
CREATE TABLE [dbo].[serviceattributecategory] (
    [ServiceAttributeCategoryID]          INT           NOT NULL,
    [LanguageID]                          INT           NOT NULL,
    [CountryID]                           INT           NOT NULL,
    [ServiceAttributeCategory]            VARCHAR (200) NULL,
    [CreateDate]                          DATETIME      NULL,
    [UpdatedDate]                         DATETIME      NULL,
    [ModifiedBy]                          VARCHAR (20)  NULL,
    [Active]                              BIT           NULL,
    [SourceID]                            INT           NULL,
    [PricingOptionCategory]               BIT           NULL,
    [ServiceAttributeCategoryDescription] VARCHAR (500) NULL,
    [RequiredInput]                       BIT           NOT NULL,
    [SideBarCategory]                     BIT           CONSTRAINT [DF_serviceattributecategory_SideBarCategory] DEFAULT ((0)) NOT NULL,
    [EligibleForPackages]                 BIT           CONSTRAINT [DF_serviceattributecategory_EligibleForPackages] DEFAULT ((0)) NOT NULL,
    [DisplayRank]                         INT           CONSTRAINT [DF__serviceat__Displ__3C0AD43D] DEFAULT ((1)) NOT NULL,
    [PositionReference]                   INT           NULL,
    [BookingPathSelection]                BIT           DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_serviceattributecategory] PRIMARY KEY CLUSTERED ([ServiceAttributeCategoryID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[ServiceAttributeExperienceLevel]...';
GO
CREATE TABLE [dbo].[ServiceAttributeExperienceLevel] (
    [UserID]            INT          NOT NULL,
    [PositionID]        INT          NOT NULL,
    [LanguageID]        INT          NOT NULL,
    [CountryID]         INT          NOT NULL,
    [ExperienceLevelID] INT          NOT NULL,
    [CreatedDate]       DATETIME     NOT NULL,
    [UpdatedDate]       DATETIME     NOT NULL,
    [ModifiedBy]        VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_ServiceAttributeExperienceLevel_1] PRIMARY KEY CLUSTERED ([UserID] ASC, [PositionID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[ServiceAttributeLanguageLevel]...';
GO
CREATE TABLE [dbo].[ServiceAttributeLanguageLevel] (
    [UserID]             INT          NOT NULL,
    [PositionID]         INT          NOT NULL,
    [LanguageID]         INT          NOT NULL,
    [CountryID]          INT          NOT NULL,
    [ServiceAttributeID] INT          NOT NULL,
    [LanguageLevelID]    INT          NOT NULL,
    [CreatedDate]        DATETIME     NOT NULL,
    [UpdatedDate]        DATETIME     NOT NULL,
    [ModifiedBy]         VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_ServiceAttributeLanguageLevel] PRIMARY KEY CLUSTERED ([UserID] ASC, [PositionID] ASC, [LanguageID] ASC, [CountryID] ASC, [ServiceAttributeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[servicecategory]...';
GO
CREATE TABLE [dbo].[servicecategory] (
    [ServiceCategoryID] INT           NOT NULL,
    [LanguageID]        INT           NOT NULL,
    [CountryID]         INT           NOT NULL,
    [Name]              VARCHAR (45)  NULL,
    [Description]       VARCHAR (350) NULL,
    [CreatedDate]       DATETIME      NULL,
    [UpdatedDate]       DATETIME      NULL,
    [ModifiedBy]        VARCHAR (2)   NULL,
    [Active]            BIT           NULL,
    [ImagePath]         VARCHAR (200) NULL,
    [headline]          VARCHAR (250) NULL,
    CONSTRAINT [PK_servicecategory] PRIMARY KEY CLUSTERED ([ServiceCategoryID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[servicecategoryposition]...';
GO
CREATE TABLE [dbo].[servicecategoryposition] (
    [ServiceCategoryID] INT          NOT NULL,
    [PositionID]        INT          NOT NULL,
    [LanguageID]        INT          NOT NULL,
    [CountryID]         INT          NOT NULL,
    [Rank]              INT          DEFAULT ((1)) NOT NULL,
    [CreateDate]        DATETIME     NOT NULL,
    [UpdatedDate]       DATETIME     NOT NULL,
    [ModifiedBy]        VARCHAR (25) NOT NULL,
    [Active]            INT          DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ServiceCategoryID] ASC, [PositionID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[servicecategorypositionattribute]...';
GO
CREATE TABLE [dbo].[servicecategorypositionattribute] (
    [PositionID]                 INT          NOT NULL,
    [ServiceAttributeCategoryID] INT          NOT NULL,
    [ServiceAttributeID]         INT          NOT NULL,
    [LanguageID]                 INT          NOT NULL,
    [CountryID]                  INT          NOT NULL,
    [CreateDate]                 DATETIME     NOT NULL,
    [UpdatedDate]                DATETIME     NOT NULL,
    [ModifiedBy]                 VARCHAR (20) NOT NULL,
    [Active]                     BIT          DEFAULT ((1)) NOT NULL,
    [EnteredByUserID]            INT          NULL,
    [Approved]                   BIT          NULL,
    PRIMARY KEY CLUSTERED ([PositionID] ASC, [ServiceAttributeCategoryID] ASC, [ServiceAttributeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[ServiceProfessionalClient]...';
GO
CREATE TABLE [dbo].[ServiceProfessionalClient] (
    [ServiceProfessionalUserID]    INT      NOT NULL,
    [ClientUserID]                 INT      NOT NULL,
    [NotesAboutClient]             NTEXT    CONSTRAINT [DF_ProviderCustomer_NotesAboutCustomer] DEFAULT ('') NOT NULL,
    [ReferralSourceID]             INT      NOT NULL,
    [CreatedDate]                  DATETIME NOT NULL,
    [UpdatedDate]                  DATETIME NOT NULL,
    [Active]                       BIT      NOT NULL,
    [CreatedByBookingID]           INT      NULL,
    [DeletedByServiceProfessional] BIT      CONSTRAINT [DF_ServiceProfessionalClient_DeletedByServiceProfessional] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ProviderCustomer] PRIMARY KEY CLUSTERED ([ServiceProfessionalUserID] ASC, [ClientUserID] ASC)
);


GO
    
PRINT N'Creating [dbo].[servicesubcategory]...';
GO
CREATE TABLE [dbo].[servicesubcategory] (
    [ServiceSubCategoryID] INT           NOT NULL,
    [LanguageID]           INT           NOT NULL,
    [CountryID]            INT           NOT NULL,
    [Name]                 VARCHAR (45)  NULL,
    [Description]          VARCHAR (250) NULL,
    [CreatedDate]          DATETIME      NULL,
    [UpdatedDate]          DATETIME      NULL,
    [ModifiedBy]           VARCHAR (2)   NULL,
    [Active]               BIT           NULL,
    [ServiceCategoryID]    INT           NULL,
    [Rank]                 INT           NULL,
    [RankQuery]            VARCHAR (200) NULL,
    CONSTRAINT [PK_servicesubcategory] PRIMARY KEY CLUSTERED ([ServiceSubCategoryID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[Solution]...';
GO
CREATE TABLE [dbo].[Solution] (
    [SolutionID]              INT                NOT NULL,
    [LanguageID]              INT                NOT NULL,
    [CountryID]               INT                NOT NULL,
    [Name]                    NVARCHAR (100)     NOT NULL,
    [CredentialCheckRequired] BIT                DEFAULT ((0)) NOT NULL,
    [BackgroundCheckRequired] BIT                DEFAULT ((0)) NOT NULL,
    [IsHIPAA]                 BIT                DEFAULT ((0)) NOT NULL,
    [TaxActivityID]           INT                NULL,
    [PostingTemplateID]       INT                NULL,
    [Image]                   NVARCHAR (255)     NULL,
    [CreatedDate]             DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]             DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]              NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]                  BIT                DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([SolutionID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[Specialization]...';
GO
CREATE TABLE [dbo].[Specialization] (
    [SpecializationID] INT                NOT NULL,
    [LanguageID]       INT                NOT NULL,
    [CountryID]        INT                NOT NULL,
    [SolutionID]       INT                NOT NULL,
    [Name]             NVARCHAR (100)     NOT NULL,
    [DisplayRank]      INT                NULL,
    [CreatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [CreatedBy]        NVARCHAR (12)      CONSTRAINT [DF__Specializ__Creat__23D42350] DEFAULT ('staff') NOT NULL,
    [Approved]         BIT                CONSTRAINT [DF__Specializ__Appro__24C84789] DEFAULT ((0)) NULL,
    [Active]           BIT                CONSTRAINT [DF__Specializ__Activ__25BC6BC2] DEFAULT ((1)) NOT NULL,
    [EnteredByUserID]  INT                NULL,
    CONSTRAINT [PK_Specialization] PRIMARY KEY CLUSTERED ([SpecializationID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[stateprovince]...';
GO
CREATE TABLE [dbo].[stateprovince] (
    [StateProvinceID]   INT           NOT NULL,
    [StateProvinceName] VARCHAR (100) NULL,
    [StateProvinceCode] VARCHAR (25)  NULL,
    [CountryID]         INT           NOT NULL,
    [RegionCode]        VARCHAR (25)  NULL,
    [PostalCodePrefix]  VARCHAR (25)  NULL,
    PRIMARY KEY CLUSTERED ([StateProvinceID] ASC)
);


GO
    
PRINT N'Creating [dbo].[taxentitytype]...';
GO
CREATE TABLE [dbo].[taxentitytype] (
    [TaxEntityTypeID]          INT           NOT NULL,
    [LanguageID]               INT           NOT NULL,
    [CountryID]                INT           NOT NULL,
    [TaxEntityTypeName]        VARCHAR (75)  NULL,
    [TaxEntityTypeDescription] VARCHAR (300) NULL,
    [CreatedDate]              DATETIME      NOT NULL,
    [UpdatedDate]              DATETIME      NOT NULL,
    [ModifiedBy]               VARCHAR (25)  NOT NULL,
    [Active]                   BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([TaxEntityTypeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[tintype]...';
GO
CREATE TABLE [dbo].[tintype] (
    [TINTypeID]          INT            NOT NULL,
    [LanguageID]         INT            NOT NULL,
    [CountryID]          INT            NOT NULL,
    [TINTypeAbbr]        NVARCHAR (10)  COLLATE Modern_Spanish_CI_AS NOT NULL,
    [TINTypeName]        NVARCHAR (70)  NOT NULL,
    [TINTypeDescription] NVARCHAR (200) NULL,
    [CreatedDate]        DATETIME       NOT NULL,
    [UpdatedDate]        DATETIME       NOT NULL,
    [ModifiedBy]         VARCHAR (25)   NOT NULL,
    [Active]             BIT            NOT NULL,
    CONSTRAINT [PK__tintype__5B7925DB119F9925] PRIMARY KEY CLUSTERED ([TINTypeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[transporttype]...';
GO
CREATE TABLE [dbo].[transporttype] (
    [TransportTypeID]          INT           NOT NULL,
    [LanguageID]               INT           NOT NULL,
    [CountryID]                INT           NOT NULL,
    [TransportTypeName]        VARCHAR (50)  NOT NULL,
    [TransportTypeDescription] VARCHAR (300) NULL,
    [CreatedDate]              DATETIME      NOT NULL,
    [UpdatedDate]              DATETIME      NOT NULL,
    [ModifiedBy]               VARCHAR (25)  NOT NULL,
    [Active]                   BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([TransportTypeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserAlert]...';
GO
CREATE TABLE [dbo].[UserAlert] (
    [UserID]        INT            NOT NULL,
    [PositionID]    INT            NOT NULL,
    [AlertID]       INT            NOT NULL,
    [CreatedDate]   DATETIME       NOT NULL,
    [UpdatedDate]   DATETIME       NOT NULL,
    [ModifiedBy]    VARCHAR (25)   NOT NULL,
    [CompletedDate] DATETIME       NULL,
    [Active]        BIT            NOT NULL,
    [AlertQuery]    VARCHAR (1000) NULL,
    [Dismissed]     BIT            CONSTRAINT [DF_UserAlert_Dismissed] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK__provider__D933DA027BB05806] PRIMARY KEY CLUSTERED ([UserID] ASC, [PositionID] ASC, [AlertID] ASC)
);


GO
    
PRINT N'Creating [dbo].[userbackgroundcheck]...';
GO
CREATE TABLE [dbo].[userbackgroundcheck] (
    [UserID]            INT           NOT NULL,
    [BackgroundCheckID] INT           NOT NULL,
    [CreatedDate]       DATETIME      NOT NULL,
    [ModifiedDate]      DATETIME      NOT NULL,
    [ModifiedBy]        VARCHAR (25)  NOT NULL,
    [StatusID]          INT           NOT NULL,
    [Summary]           VARCHAR (200) NULL,
    [VerifiedBy]        VARCHAR (25)  NULL,
    [LastVerifiedDate]  DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([BackgroundCheckID] ASC, [UserID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserBadge]...';
GO
CREATE TABLE [dbo].[UserBadge] (
    [UserBadgeID] INT                IDENTITY (1, 1) NOT NULL,
    [UserID]      INT                NOT NULL,
    [SolutionID]  INT                NULL,
    [LanguageID]  INT                NOT NULL,
    [CountryID]   INT                NOT NULL,
    [BadgeURL]    NVARCHAR (255)     NOT NULL,
    [Type]        NVARCHAR (20)      NOT NULL,
    [Category]    NVARCHAR (50)      NOT NULL,
    [ExpiryDate]  DATETIMEOFFSET (0) NULL,
    [CreatedDate] DATETIMEOFFSET (0) NOT NULL,
    [UpdatedDate] DATETIMEOFFSET (0) NOT NULL,
    [CreatedBy]   NVARCHAR (4)       NOT NULL,
    [ModifiedBy]  NVARCHAR (4)       NOT NULL,
    [Active]      BIT                DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserBadge] PRIMARY KEY CLUSTERED ([UserBadgeID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserEarnings]...';
GO
CREATE TABLE [dbo].[UserEarnings] (
    [UserEarningsID] INT                IDENTITY (1, 1) NOT NULL,
    [UserID]         INT                NOT NULL,
    [PlatformID]     INT                NOT NULL,
    [ClientID]       INT                NOT NULL,
    [JobTitleID]     INT                NOT NULL,
    [Amount]         DECIMAL (10, 2)    NOT NULL,
    [Minutes]        INT                NOT NULL,
    [PaidDate]       DATETIMEOFFSET (0) NOT NULL,
    [Notes]          TEXT               NOT NULL,
    [CreatedDate]    DATETIMEOFFSET (0) NOT NULL,
    [UpdatedDate]    DATETIMEOFFSET (0) NOT NULL,
    [ModifiedBy]     NVARCHAR (4)       NOT NULL,
    [Active]         BIT                CONSTRAINT [DF_UserEarnings_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserEarnings] PRIMARY KEY CLUSTERED ([UserEarningsID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserEarningsEntry]...';
GO
CREATE TABLE [dbo].[UserEarningsEntry] (
    [UserID]                INT                NOT NULL,
    [EarningsEntryID]       INT                NOT NULL,
    [Amount]                DECIMAL (10, 2)    CONSTRAINT [DF_UserEarningsEntry_Amount] DEFAULT ((0)) NOT NULL,
    [PaidDate]              DATETIMEOFFSET (0) NOT NULL,
    [DurationMinutes]       INT                NOT NULL,
    [UserExternalListingID] INT                NOT NULL,
    [JobTitleID]            INT                NOT NULL,
    [ClientUserID]          INT                NULL,
    [CreatedDate]           DATETIMEOFFSET (0) NOT NULL,
    [UpdatedDate]           DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]            NVARCHAR (4)       NOT NULL,
    [Active]                BIT                CONSTRAINT [DF_UserEarningsEntry_Active] DEFAULT ((1)) NOT NULL,
    [Notes]                 TEXT               NULL,
    CONSTRAINT [PK_UserEarningsEntry] PRIMARY KEY CLUSTERED ([UserID] ASC, [EarningsEntryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[usereducation]...';
GO
CREATE TABLE [dbo].[usereducation] (
    [UserEducationID]   INT           IDENTITY (1, 1) NOT NULL,
    [UserID]            INT           NOT NULL,
    [InstitutionID]     INT           NOT NULL,
    [DegreeCertificate] VARCHAR (200) NOT NULL,
    [FieldOfStudy]      VARCHAR (200) NOT NULL,
    [FromYearAttended]  NUMERIC (4)   NULL,
    [ToYearAttended]    NUMERIC (4)   NULL,
    [CreatedDate]       DATETIME      NOT NULL,
    [ModifiedDate]      DATETIME      NOT NULL,
    [ModifiedBy]        VARCHAR (25)  NOT NULL,
    [VerifiedDate]      DATETIME      NULL,
    [VerifiedBy]        VARCHAR (25)  NULL,
    [Active]            BIT           NOT NULL,
    CONSTRAINT [PK__usereduc__A31C69552A363CC5] PRIMARY KEY CLUSTERED ([UserEducationID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserExternalListing]...';
GO
CREATE TABLE [dbo].[UserExternalListing] (
    [UserExternalListingID] INT                IDENTITY (1, 1) NOT NULL,
    [UserID]                INT                NOT NULL,
    [PlatformID]            INT                NOT NULL,
    [Title]                 NVARCHAR (50)      NOT NULL,
    [JobTitles]             TEXT               NOT NULL,
    [Notes]                 TEXT               NOT NULL,
    [CreatedDate]           DATETIMEOFFSET (0) NOT NULL,
    [UpdatedDate]           DATETIMEOFFSET (0) NOT NULL,
    [ModifiedBy]            NVARCHAR (4)       NOT NULL,
    [Active]                BIT                CONSTRAINT [DF_UserExternalListing_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserExternalListing] PRIMARY KEY CLUSTERED ([UserExternalListingID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserFeePayments]...';
GO
CREATE TABLE [dbo].[UserFeePayments] (
    [UserFeePaymentID]     INT                IDENTITY (1, 1) NOT NULL,
    [UserID]               INT                NOT NULL,
    [PaymentTransactionID] VARCHAR (250)      NOT NULL,
    [SubscriptionID]       VARCHAR (250)      NOT NULL,
    [PaymentDate]          DATETIMEOFFSET (0) NOT NULL,
    [PaymentAmount]        MONEY              NOT NULL,
    [PaymentPlan]          VARCHAR (25)       NOT NULL,
    [PaymentMethod]        VARCHAR (50)       NOT NULL,
    [PaymentStatus]        VARCHAR (50)       NOT NULL,
    [CreatedDate]          DATETIMEOFFSET (0) NOT NULL,
    [ModifiedDate]         DATETIMEOFFSET (0) NOT NULL,
    CONSTRAINT [PK__UserFeeP__1788CCAC0347582D] PRIMARY KEY CLUSTERED ([UserFeePaymentID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserLicenseCertifications]...';
GO
CREATE TABLE [dbo].[UserLicenseCertifications] (
    [userLicenseCertificationID] INT            IDENTITY (1, 1) NOT NULL,
    [ProviderUserID]             INT            NOT NULL,
    [PositionID]                 INT            NOT NULL,
    [LicenseCertificationID]     INT            NOT NULL,
    [VerificationStatusID]       INT            NOT NULL,
    [LicenseCertificationURL]    VARCHAR (2073) NULL,
    [LastName]                   VARCHAR (100)  NOT NULL,
    [FirstName]                  VARCHAR (100)  NOT NULL,
    [MiddleInitial]              VARCHAR (1)    NULL,
    [SecondLastName]             VARCHAR (100)  NULL,
    [BusinessName]               VARCHAR (200)  NULL,
    [LicenseCertificationNumber] VARCHAR (100)  NULL,
    [CreatedDate]                DATETIME       NOT NULL,
    [ExpirationDate]             DATETIME       NULL,
    [IssueDate]                  DATETIME       NULL,
    [Comments]                   VARCHAR (500)  NULL,
    [VerifiedBy]                 VARCHAR (25)   NULL,
    [LastVerifiedDate]           DATETIME       NULL,
    [SubmittedBy]                VARCHAR (25)   NULL,
    [SubmittedImageLocalURL]     VARCHAR (255)  NULL,
    PRIMARY KEY CLUSTERED ([userLicenseCertificationID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserListingSpecialization]...';
GO
CREATE TABLE [dbo].[UserListingSpecialization] (
    [UserID]           INT                NOT NULL,
    [UserListingID]    INT                NOT NULL,
    [SpecializationID] INT                NOT NULL,
    [LanguageID]       INT                NOT NULL,
    [CountryID]        INT                NOT NULL,
    [DisplayRank]      INT                NULL,
    [CreatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]      DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]       NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]           BIT                DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC, [UserListingID] ASC, [SpecializationID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[userOrganization]...';
GO
CREATE TABLE [dbo].[userOrganization] (
    [userID]         INT                NOT NULL,
    [orgName]        NVARCHAR (200)     NOT NULL,
    [orgDescription] NVARCHAR (400)     NULL,
    [orgWebsite]     NVARCHAR (255)     NULL,
    [updatedDate]    DATETIMEOFFSET (0) NULL,
    CONSTRAINT [PK_userOrganization] PRIMARY KEY CLUSTERED ([userID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserPaymentPlan]...';
GO
CREATE TABLE [dbo].[UserPaymentPlan] (
    [UserPaymentPlanID]          INT                IDENTITY (1, 1) NOT NULL,
    [UserID]                     INT                NOT NULL,
    [SubscriptionID]             VARCHAR (250)      NOT NULL,
    [PaymentPlan]                VARCHAR (25)       NOT NULL,
    [PaymentMethod]              VARCHAR (50)       NOT NULL,
    [PaymentPlanLastChangedDate] DATETIMEOFFSET (0) NOT NULL,
    [NextPaymentDueDate]         DATETIMEOFFSET (0) NULL,
    [NextPaymentAmount]          MONEY              NULL,
    [FirstBillingDate]           DATETIMEOFFSET (0) NOT NULL,
    [SubscriptionEndDate]        DATETIMEOFFSET (0) NULL,
    [PaymentMethodToken]         VARCHAR (250)      NOT NULL,
    [PaymentExpiryDate]          DATETIMEOFFSET (0) NULL,
    [PlanStatus]                 VARCHAR (50)       NOT NULL,
    [DaysPastDue]                INT                CONSTRAINT [DF_UserPaymentPlan_DaysPastDue] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK__Owner__1788CCAC6A7BAA63] PRIMARY KEY CLUSTERED ([UserPaymentPlanID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserPosting]...';
GO
CREATE TABLE [dbo].[UserPosting] (
    [userPostingID]            INT                IDENTITY (1, 1) NOT NULL,
    [userID]                   INT                NOT NULL,
    [solutionID]               INT                NOT NULL,
    [postingTemplateID]        INT                NULL,
    [title]                    NVARCHAR (50)      NOT NULL,
    [statusID]                 INT                NOT NULL,
    [neededSpecializationIDs]  VARCHAR (300)      NULL,
    [desiredSpecializationIDs] VARCHAR (300)      NULL,
    [languageID]               INT                NOT NULL,
    [countryID]                INT                NOT NULL,
    [createdDate]              DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]              DATETIMEOFFSET (0) NOT NULL,
    [modifiedBy]               NVARCHAR (10)      NOT NULL,
    CONSTRAINT [PK_UserPosting] PRIMARY KEY CLUSTERED ([userPostingID] ASC)
);



GO
    
PRINT N'Creating [dbo].[UserPostingQuestionResponse]...';
GO
CREATE TABLE [dbo].[UserPostingQuestionResponse] (
    [userPostingID]  INT            NOT NULL,
    [questionID]     INT            NOT NULL,
    [questionTypeID] INT            NOT NULL,
    [question]       NVARCHAR (120) NOT NULL,
    [helpBlock]      NVARCHAR (300) NULL,
    [options]        TEXT           NOT NULL,
    [responses]      TEXT           NOT NULL,
    [legend]         NVARCHAR (60)  NOT NULL,
    [branchLogic]    TEXT           NULL,
    [label]          NVARCHAR (120) DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_UserPostingQuestionResponse_1] PRIMARY KEY CLUSTERED ([userPostingID] ASC, [questionID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserPostingReaction]...';
GO
CREATE TABLE [dbo].[UserPostingReaction] (
    [userPostingID]             INT                NOT NULL,
    [serviceProfessionalUserID] INT                NOT NULL,
    [reactionTypeID]            INT                NOT NULL,
    [createdDate]               DATETIMEOFFSET (0) NOT NULL,
    [updatedDate]               DATETIMEOFFSET (0) NOT NULL,
    [message]                   TEXT               NULL,
    CONSTRAINT [PK_UserPostingReaction] PRIMARY KEY CLUSTERED ([userPostingID] ASC, [serviceProfessionalUserID] ASC)
);


GO
    
PRINT N'Creating [dbo].[userprofile]...';
GO
CREATE TABLE [dbo].[userprofile] (
    [UserId] INT            IDENTITY (1, 1) NOT NULL,
    [Email]  NVARCHAR (254) NOT NULL,
    CONSTRAINT [PK__userprof__1788CC4C023D5A04] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT [UQ__userprof__C9F284560519C6AF] UNIQUE NONCLUSTERED ([Email] ASC)
);


GO
    
PRINT N'Creating [dbo].[userprofilepositions]...';
GO
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
    CONSTRAINT [PK_userprofilepositions] PRIMARY KEY CLUSTERED ([UserListingID] ASC)
);


GO
    
PRINT N'Creating [dbo].[userprofileserviceattributes]...';
GO
CREATE TABLE [dbo].[userprofileserviceattributes] (
    [UserID]                     INT         NOT NULL,
    [PositionID]                 INT         NOT NULL,
    [ServiceAttributeCategoryID] INT         NOT NULL,
    [ServiceAttributeID]         INT         NOT NULL,
    [LanguageID]                 INT         NOT NULL,
    [CountryID]                  INT         NOT NULL,
    [CreateDate]                 DATETIME    NULL,
    [UpdatedDate]                DATETIME    NULL,
    [ModifiedBy]                 VARCHAR (3) NULL,
    [Active]                     BIT         NULL,
    CONSTRAINT [PK_userprofileserviceattributes_2] PRIMARY KEY CLUSTERED ([UserID] ASC, [PositionID] ASC, [ServiceAttributeCategoryID] ASC, [ServiceAttributeID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserReviews]...';
GO
CREATE TABLE [dbo].[UserReviews] (
    [BookingID]          INT             NOT NULL,
    [CustomerUserID]     INT             NOT NULL,
    [ProviderUserID]     INT             NOT NULL,
    [PositionID]         INT             NOT NULL,
    [PrivateReview]      NVARCHAR (1000) NULL,
    [PublicReview]       NVARCHAR (500)  NULL,
    [Rating1]            TINYINT         NULL,
    [Rating2]            TINYINT         NULL,
    [Rating3]            TINYINT         NULL,
    [Rating4]            TINYINT         NULL,
    [Answer1]            BIT             NULL,
    [Answer2]            BIT             NULL,
    [Answer1Comment]     NVARCHAR (1000) NULL,
    [Answer2Comment]     NVARCHAR (1000) NULL,
    [ServiceHours]       DECIMAL (18, 5) CONSTRAINT [DF_UserReviews_ServiceHours] DEFAULT ((0)) NULL,
    [HelpfulReviewCount] BIGINT          CONSTRAINT [DF_UserReviews_HelpfulReviewCount] DEFAULT ((0)) NULL,
    [CreatedDate]        DATETIME        NOT NULL,
    [UpdatedDate]        DATETIME        NOT NULL,
    [ModifiedBy]         VARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_UserReviews] PRIMARY KEY CLUSTERED ([BookingID] ASC, [CustomerUserID] ASC, [ProviderUserID] ASC, [PositionID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserReviewScores]...';
GO
CREATE TABLE [dbo].[UserReviewScores] (
    [UserID]         INT             NOT NULL,
    [PositionID]     INT             NOT NULL,
    [TotalRatings]   BIGINT          NULL,
    [Rating1]        DECIMAL (18, 2) NULL,
    [Rating2]        DECIMAL (18, 2) NULL,
    [Rating3]        DECIMAL (18, 2) NULL,
    [Rating4]        DECIMAL (18, 2) NULL,
    [Answer1]        BIGINT          NULL,
    [Answer2]        BIGINT          NULL,
    [ServiceHours]   DECIMAL (18, 2) NULL,
    [LastRatingDate] DATETIME        NULL,
    [CreatedDate]    DATETIME        NOT NULL,
    [UpdatedDate]    DATETIME        NOT NULL,
    [ModifiedBy]     VARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_ReviewScores_positionID_userID] PRIMARY KEY CLUSTERED ([PositionID] ASC, [UserID] ASC)
);



GO
    
PRINT N'Creating [dbo].[users]...';
GO
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
    
PRINT N'Creating [dbo].[usersignup]...';
GO
CREATE TABLE [dbo].[usersignup] (
    [UserId] INT           IDENTITY (1, 1) NOT NULL,
    [Email]  NVARCHAR (56) NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserSolution]...';
GO
CREATE TABLE [dbo].[UserSolution] (
    [UserSolutionID] INT                IDENTITY (1, 1) NOT NULL,
    [UserID]         INT                NOT NULL,
    [UserListingID]  INT                NOT NULL,
    [SolutionID]     INT                NOT NULL,
    [LanguageID]     INT                NOT NULL,
    [CountryID]      INT                NOT NULL,
    [DisplayRank]    INT                NULL,
    [CreatedDate]    DATETIMEOFFSET (7) NOT NULL,
    [UpdatedDate]    DATETIMEOFFSET (7) NOT NULL,
    [ModifiedBy]     NVARCHAR (4)       DEFAULT ('sys') NOT NULL,
    [Active]         BIT                DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserSolution] PRIMARY KEY CLUSTERED ([UserSolutionID] ASC)
);


GO
    
PRINT N'Creating [dbo].[UserStats]...';
GO
CREATE TABLE [dbo].[UserStats] (
    [UserID]              INT             NOT NULL,
    [ResponseTimeMinutes] DECIMAL (18, 2) NULL,
    [LastLoginTime]       DATETIME        NULL,
    [LastActivityTime]    DATETIME        NULL,
    CONSTRAINT [PK_UserStats] PRIMARY KEY CLUSTERED ([UserID] ASC)
);


GO
    
PRINT N'Creating [dbo].[userverification]...';
GO
CREATE TABLE [dbo].[userverification] (
    [UserID]               INT            NOT NULL,
    [VerificationID]       INT            NOT NULL,
    [PositionID]           INT            CONSTRAINT [DF_userverification_PositionID] DEFAULT ((0)) NOT NULL,
    [DateVerified]         DATETIME       NOT NULL,
    [CreatedDate]          DATETIME       NOT NULL,
    [UpdatedDate]          DATETIME       NOT NULL,
    [VerifiedBy]           VARCHAR (25)   NOT NULL,
    [LastVerifiedDate]     DATETIME       NOT NULL,
    [Active]               BIT            NOT NULL,
    [VerificationStatusID] INT            NOT NULL,
    [Comments]             VARCHAR (2000) NULL,
    CONSTRAINT [PK_userverification] PRIMARY KEY CLUSTERED ([UserID] ASC, [VerificationID] ASC, [PositionID] ASC)
);


GO
    
PRINT N'Creating [dbo].[verification]...';
GO
CREATE TABLE [dbo].[verification] (
    [VerificationID]          INT            NOT NULL,
    [VerificationType]        VARCHAR (100)  NOT NULL,
    [VerificationDescription] VARCHAR (1000) NOT NULL,
    [VerificationProcess]     VARCHAR (500)  NULL,
    [Icon]                    VARCHAR (15)   NULL,
    [LanguageID]              INT            NOT NULL,
    [CountryID]               INT            NOT NULL,
    [CreatedDate]             DATETIME       NOT NULL,
    [ModifiedDate]            DATETIME       NOT NULL,
    [ModifiedBy]              VARCHAR (25)   NULL,
    [Active]                  BIT            NOT NULL,
    [VerificationCategoryID]  INT            NOT NULL,
    [RankPosition]            INT            NULL,
    [SummaryGroup]            VARCHAR (20)   NULL,
    CONSTRAINT [PK__verficat__25EE1D1F0C1BC9F9] PRIMARY KEY CLUSTERED ([VerificationID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[verificationcategory]...';
GO
CREATE TABLE [dbo].[verificationcategory] (
    [VerificationCategoryID]          INT            NOT NULL,
    [LanguageID]                      INT            NOT NULL,
    [CountryID]                       INT            NOT NULL,
    [VerificationCategoryName]        VARCHAR (100)  NOT NULL,
    [VerificationCategoryDescription] VARCHAR (1000) NULL,
    [CreatedDate]                     DATETIME       NOT NULL,
    [UpdatedDate]                     DATETIME       NOT NULL,
    [ModifiedBy]                      VARCHAR (25)   NOT NULL,
    [Active]                          BIT            NOT NULL,
    [RankPosition]                    INT            NULL,
    PRIMARY KEY CLUSTERED ([VerificationCategoryID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[verificationstatus]...';
GO
CREATE TABLE [dbo].[verificationstatus] (
    [VerificationStatusID]                 INT           NOT NULL,
    [LanguageID]                           INT           NOT NULL,
    [CountryID]                            INT           NOT NULL,
    [VerificationStatusName]               VARCHAR (50)  NOT NULL,
    [VerificationStatusDisplayDescription] VARCHAR (300) NULL,
    [CreatedDate]                          DATETIME      NOT NULL,
    [UpdatedDate]                          DATETIME      NOT NULL,
    [ModifiedBy]                           VARCHAR (25)  NOT NULL,
    [Active]                               BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([VerificationStatusID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[VOCElement]...';
GO
CREATE TABLE [dbo].[VOCElement] (
    [VOCElementID]    INT           NOT NULL,
    [LanguageID]      INT           NOT NULL,
    [CountryID]       INT           NOT NULL,
    [VOCElementName]  VARCHAR (100) NULL,
    [ScoreStartValue] INT           NULL,
    [ScoreMidValue]   INT           NULL,
    [ScoreEndValue]   INT           NULL,
    [ScoreStartLabel] VARCHAR (25)  NULL,
    [ScoreMidLabel]   VARCHAR (25)  NULL,
    [ScoreEndLabel]   VARCHAR (25)  NULL,
    [CreateDate]      DATETIME      NOT NULL,
    [UpdatedDate]     DATETIME      NOT NULL,
    [ModifiedBy]      VARCHAR (3)   NOT NULL,
    [Active]          BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([VOCElementID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[VOCExperienceCategory]...';
GO
CREATE TABLE [dbo].[VOCExperienceCategory] (
    [VOCExperienceCategoryID]          INT           NOT NULL,
    [LanguageID]                       INT           NOT NULL,
    [CountryID]                        INT           NOT NULL,
    [VOCExperienceCategoryName]        VARCHAR (50)  NULL,
    [VOCExperienceCategoryDescription] VARCHAR (200) NULL,
    [CreateDate]                       DATETIME      NOT NULL,
    [UpdatedDate]                      DATETIME      NOT NULL,
    [ModifiedBy]                       VARCHAR (3)   NOT NULL,
    [Active]                           BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([VOCExperienceCategoryID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[VOCFeedback]...';
GO
CREATE TABLE [dbo].[VOCFeedback] (
    [VOCFeedbackID]           INT          IDENTITY (1, 1) NOT NULL,
    [VOCElementID]            INT          NOT NULL,
    [VOCExperienceCategoryID] INT          NOT NULL,
    [UserID]                  INT          NOT NULL,
    [Feedback]                TEXT         NOT NULL,
    [VOCFlag1]                VARCHAR (50) NULL,
    [VOCFlag2]                VARCHAR (50) NULL,
    [VOCFlag3]                VARCHAR (50) NULL,
    [VOCFlag4]                VARCHAR (50) NULL,
    [UserDevice]              TEXT         NULL,
    [ZenDeskTicketNumber]     INT          NULL,
    [ProviderUserID]          INT          NULL,
    [ProviderPositionID]      INT          NULL,
    [CreatedDate]             DATETIME     NOT NULL,
    [UpdatedDate]             DATETIME     NOT NULL,
    [ModifiedBy]              VARCHAR (3)  NOT NULL,
    CONSTRAINT [PK__VOCFeedb__B6FF22780B528E49] PRIMARY KEY CLUSTERED ([VOCFeedbackID] ASC)
);


GO
    
PRINT N'Creating [dbo].[VOCFlag]...';
GO
CREATE TABLE [dbo].[VOCFlag] (
    [VOCFlagID]           INT           NOT NULL,
    [LanguageID]          INT           NOT NULL,
    [CountryID]           INT           NOT NULL,
    [VOCFlagName]         VARCHAR (50)  NOT NULL,
    [VOCFlagNDescription] VARCHAR (500) NULL,
    [CreateDate]          DATETIME      NOT NULL,
    [UpdatedDate]         DATETIME      NOT NULL,
    [ModifiedBy]          VARCHAR (3)   NOT NULL,
    [Active]              BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([VOCFlagID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[VOCScores]...';
GO
CREATE TABLE [dbo].[VOCScores] (
    [VOCScoresID]             INT           NOT NULL,
    [UserID]                  INT           NOT NULL,
    [VOCElementID]            INT           NOT NULL,
    [Score]                   INT           NOT NULL,
    [Date]                    DATETIME      NOT NULL,
    [ProviderUserID]          INT           NULL,
    [ProviderPositionID]      INT           NULL,
    [UserDevice]              VARCHAR (100) NULL,
    [VOCExperienceCategoryID] INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([VOCScoresID] ASC, [UserID] ASC, [VOCElementID] ASC, [Score] ASC, [Date] ASC)
);


GO
    
PRINT N'Creating [dbo].[webpages_FacebookCredentials]...';
GO
CREATE TABLE [dbo].[webpages_FacebookCredentials] (
    [id]         INT    NOT NULL IDENTITY (1, 1),
    [UserId]     INT    NOT NULL,
    [FacebookId] BIGINT NOT NULL,
    CONSTRAINT [PK_webpages_FacebookCredentials] PRIMARY KEY CLUSTERED ([id] ASC)
);

GO
    
PRINT N'Creating [dbo].[webpages_Membership]...';
GO
CREATE TABLE [dbo].[webpages_Membership] (
    [UserId]                                  INT            NOT NULL,
    [CreateDate]                              DATETIME       NULL,
    [ConfirmationToken]                       NVARCHAR (128) NULL,
    [IsConfirmed]                             BIT            DEFAULT ((0)) NULL,
    [LastPasswordFailureDate]                 DATETIME       NULL,
    [PasswordFailuresSinceLastSuccess]        INT            DEFAULT ((0)) NOT NULL,
    [Password]                                NVARCHAR (128) NOT NULL,
    [PasswordChangedDate]                     DATETIME       NULL,
    [PasswordSalt]                            NVARCHAR (128) NOT NULL,
    [PasswordVerificationToken]               NVARCHAR (128) NULL,
    [PasswordVerificationTokenExpirationDate] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC)
);


GO
    
PRINT N'Creating [dbo].[webpages_OAuthMembership]...';
GO
CREATE TABLE [dbo].[webpages_OAuthMembership] (
    [Provider]       NVARCHAR (30)  NOT NULL,
    [ProviderUserId] NVARCHAR (100) NOT NULL,
    [UserId]         INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Provider] ASC, [ProviderUserId] ASC)
);


GO
    
PRINT N'Creating [dbo].[webpages_Roles]...';
GO
CREATE TABLE [dbo].[webpages_Roles] (
    [RoleId]   INT            IDENTITY (1, 1) NOT NULL,
    [RoleName] NVARCHAR (256) NOT NULL,
    PRIMARY KEY CLUSTERED ([RoleId] ASC),
    UNIQUE NONCLUSTERED ([RoleName] ASC)
);


GO
    
PRINT N'Creating [dbo].[webpages_UsersInRoles]...';
GO
CREATE TABLE [dbo].[webpages_UsersInRoles] (
    [UserId] INT NOT NULL,
    [RoleId] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC)
);


GO
    
PRINT N'Creating [dbo].[xJobTitlePricing]...';
GO
CREATE TABLE [dbo].[xJobTitlePricing] (
    [JobTitlePricingID]                INT           NOT NULL,
    [JobTitleID]                       INT           NOT NULL,
    [PricingTypeID]                    INT           NOT NULL,
    [LanguageID]                       INT           NOT NULL,
    [CountryID]                        INT           NOT NULL,
    [PricingTypeLabel]                 VARCHAR (100) NOT NULL,
    [PricingNameDefaultValue]          VARCHAR (100) NOT NULL,
    [PricingDescriptionPlaceholder]    VARCHAR (200) NOT NULL,
    [PricingRateUnitDefaultValue]      VARCHAR (100) NOT NULL,
    [PricingHelperLanguagePlaceholder] VARCHAR (500) NOT NULL,
    [IncludeTaskListOption]            BIT           NOT NULL,
    [RecurringEligible]                BIT           NOT NULL,
    [ShowFirstTimeClientsOnlyOption]   BIT           NOT NULL,
    [ShowExisitingClientsOnlyOption]   BIT           NOT NULL,
    [ShowSpecificClientOnlyOption]     BIT           NOT NULL,
    [ShowSlidingScaleOption]           BIT           NOT NULL,
    [ShowTradeOption]                  BIT           NOT NULL,
    [ShowServiceAreaOption]            BIT           NOT NULL,
    [ShowServiceLocationOption]        BIT           NOT NULL,
    [ShowRemoteLocationOption]         BIT           NOT NULL,
    [CreatedDate]                      DATETIME      NOT NULL,
    [UpdatedDate]                      DATETIME      NOT NULL,
    [ModifiedBy]                       VARCHAR (25)  NOT NULL,
    [Active]                           BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([JobTitlePricingID] ASC)
);


GO
    
PRINT N'Creating [dbo].[xJobTitleReviewRules]...';
GO
CREATE TABLE [dbo].[xJobTitleReviewRules] (
    [JobTitleID]                          INT         NOT NULL,
    [LanguageID]                          INT         NOT NULL,
    [CountryID]                           INT         NOT NULL,
    [SuppressReviewOfClient]              BIT         NOT NULL,
    [SuppressReviewOfServiceProfessional] BIT         NOT NULL,
    [RequestToReview]                     BIT         NOT NULL,
    [CreatedDate]                         DATETIME    NOT NULL,
    [UpdatedDate]                         DATETIME    NOT NULL,
    [ModifiedBy]                          VARCHAR (3) NOT NULL,
    [Active]                              BIT         NOT NULL,
    PRIMARY KEY CLUSTERED ([JobTitleID] ASC, [LanguageID] ASC, [CountryID] ASC)
);


GO
    
PRINT N'Creating [dbo].[xServiceProfessionalPricing]...';
GO
CREATE TABLE [dbo].[xServiceProfessionalPricing] (
    [ServiceProfessionalPricingID] INT            IDENTITY (1, 1) NOT NULL,
    [PricingTypeID]                INT            NOT NULL,
    [ServiceProfessionalUserID]    INT            NOT NULL,
    [JobTitleID]                   INT            NOT NULL,
    [LanguageID]                   INT            NOT NULL,
    [CountryID]                    INT            NOT NULL,
    [Name]                         VARCHAR (50)   NOT NULL,
    [Description]                  VARCHAR (1000) NULL,
    [Price]                        DECIMAL (7, 2) NULL,
    [Duration]                     INT            NOT NULL,
    [FirstTimeClientsOnly]         BIT            DEFAULT ((0)) NOT NULL,
    [NumberOfSessions]             INT            DEFAULT ((1)) NOT NULL,
    [CreatedDate]                  DATETIME       NOT NULL,
    [UpdatedDate]                  DATETIME       NOT NULL,
    [ModifiedBy]                   VARCHAR (25)   NOT NULL,
    [Active]                       BIT            NOT NULL,
    [IsAddOn]                      BIT            DEFAULT ((0)) NOT NULL,
    [PriceRate]                    DECIMAL (7, 2) NULL,
    [PriceRateUnit]                NVARCHAR (30)  NULL,
    [IsPhone]                      BIT            DEFAULT ((0)) NOT NULL,
    [VisibleToClientID]            INT            DEFAULT ((0)) NOT NULL,
    [ParentBookingID]              INT            NULL,
    [MaxAvailableSpots]            INT            DEFAULT ((1)) NOT NULL,
    [MaxCapacity]                  INT            DEFAULT ((1)) NOT NULL,
    [MinSpots]                     INT            DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ServiceProfessionalPricingID] ASC)
);


GO
    
PRINT N'Altering [dbo].[accountstatus]...';
GO

GO
    
PRINT N'Altering [dbo].[address]...';
GO

GO
    
PRINT N'Altering [dbo].[addresstype]...';
GO

GO
    
PRINT N'Altering [dbo].[alert]...';
GO

GO
    
PRINT N'Altering [dbo].[alerttype]...';
GO

GO
    
PRINT N'Altering [dbo].[authorizations]...';
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_authorizations_token]
    ON [dbo].[authorizations]([Token] ASC);


GO
    
PRINT N'Altering [dbo].[backgroundcheck]...';
GO

GO
    
PRINT N'Altering [dbo].[booking]...';
GO


ALTER TABLE [dbo].[booking] ADD
    CONSTRAINT [FK__booking__alternativeDate1] FOREIGN KEY ([AlternativeDate1ID]) REFERENCES [dbo].[CalendarEvents] ([Id]),
    CONSTRAINT [FK__booking__alternativeDate2] FOREIGN KEY ([AlternativeDate2ID]) REFERENCES [dbo].[CalendarEvents] ([Id]),
    CONSTRAINT [FK__booking__AwaitingResponseFromUserID] FOREIGN KEY ([AwaitingResponseFromUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK__booking__cancellationPolicy] FOREIGN KEY ([CancellationPolicyID], [LanguageID], [CountryID]) REFERENCES [dbo].[cancellationpolicy] ([CancellationPolicyID], [LanguageID], [CountryID]),
    CONSTRAINT [FK__booking__client] FOREIGN KEY ([ClientUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK__booking__jobtitle] FOREIGN KEY ([JobTitleID], [LanguageID], [CountryID]) REFERENCES [dbo].[positions] ([PositionID], [LanguageID], [CountryID]),
    CONSTRAINT [FK__booking__parentbooking] FOREIGN KEY ([ParentBookingID]) REFERENCES [dbo].[booking] ([BookingID]),
    CONSTRAINT [FK__booking__pricingSummary] FOREIGN KEY ([PricingSummaryID], [PricingSummaryRevision]) REFERENCES [dbo].[pricingSummary] ([PricingSummaryID], [PricingSummaryRevision]),
    CONSTRAINT [FK__booking__serviceAddress] FOREIGN KEY ([ServiceAddressID]) REFERENCES [dbo].[address] ([AddressID]),
    CONSTRAINT [FK__booking__serviceDate] FOREIGN KEY ([ServiceDateID]) REFERENCES [dbo].[CalendarEvents] ([Id]),
    CONSTRAINT [FK__booking__serviceProfessional] FOREIGN KEY ([ServiceProfessionalUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK__booking__status] FOREIGN KEY ([BookingStatusID]) REFERENCES [dbo].[bookingStatus] ([BookingStatusID]),
    CONSTRAINT [FK__booking__type] FOREIGN KEY ([BookingTypeID]) REFERENCES [dbo].[bookingType] ([BookingTypeID])


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The languageID related to the jobTitleID, and the one used on the API call by the creator of the booking', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'booking', @level2type = N'COLUMN', @level2name = N'LanguageID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The countryID related to the jobTitleID, and the one used on the API call by the creator of the booking', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'booking', @level2type = N'COLUMN', @level2name = N'CountryID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'It''s an initial setup flag, set on creation and no updated later. It lets know that payment processing is enabled on this booking, and later payment MUST be collected and performed. Payment must be enabled on the service professional account and optionally enable/disable for bookNow bookings depending on jobTitle and user setup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'booking', @level2type = N'COLUMN', @level2name = N'PaymentEnabled';


GO
    
PRINT N'Altering [dbo].[bookingStatus]...';
GO

GO
    
PRINT N'Altering [dbo].[bookingType]...';
GO

GO
    
PRINT N'Altering [dbo].[CalendarAvailabilityType]...';
GO

GO
    
PRINT N'Altering [dbo].[CalendarEventComments]...';
GO

ALTER TABLE [dbo].[CalendarEventComments] ADD
    CONSTRAINT [FK_Comments_CalendarEvents] FOREIGN KEY ([IdEvent]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarEventExceptionsPeriod]...';
GO


ALTER TABLE [dbo].[CalendarEventExceptionsPeriod] ADD
    CONSTRAINT [FK_CalendarEventExceptionsPeriods_CalendarEventExceptionsDates] FOREIGN KEY ([IdException]) REFERENCES [dbo].[CalendarEventExceptionsPeriodsList] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarEventExceptionsPeriodsList]...';
GO


ALTER TABLE [dbo].[CalendarEventExceptionsPeriodsList] ADD
    CONSTRAINT [FK_CalendarEventExceptions_CalendarEvents] FOREIGN KEY ([IdEvent]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarEventRecurrencesPeriod]...';
GO


ALTER TABLE [dbo].[CalendarEventRecurrencesPeriod] ADD
    CONSTRAINT [FK_CalendarEventRecurrencesPeriod_CalendarEventRecurrencesPeriodList] FOREIGN KEY ([IdRecurrence]) REFERENCES [dbo].[CalendarEventRecurrencesPeriodList] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarEventRecurrencesPeriodList]...';
GO


ALTER TABLE [dbo].[CalendarEventRecurrencesPeriodList] ADD
    CONSTRAINT [FK_CalendarEventRecurrencesPeriodList_CalendarEvents] FOREIGN KEY ([IdEvent]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarEvents]...';
GO


ALTER TABLE [dbo].[CalendarEvents] ADD
    CONSTRAINT [FK_CalendarEvents_CalendarAvailabilityType] FOREIGN KEY ([CalendarAvailabilityTypeID]) REFERENCES [dbo].[CalendarAvailabilityType] ([CalendarAvailabilityTypeID]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_CalendarEvents_CalendarEventType] FOREIGN KEY ([EventType]) REFERENCES [dbo].[CalendarEventType] ([EventTypeId]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarEventsAttendees]...';
GO


ALTER TABLE [dbo].[CalendarEventsAttendees] ADD
    CONSTRAINT [FK_CalendarEventsAttendees_CalendarEvents] FOREIGN KEY ([IdEvent]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarEventsContacts]...';
GO


ALTER TABLE [dbo].[CalendarEventsContacts] ADD
    CONSTRAINT [FK_CalendarEventsContacts_CalendarEvents] FOREIGN KEY ([IdEvent]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarEventType]...';
GO

GO
    
PRINT N'Altering [dbo].[CalendarProviderAttributes]...';
GO


ALTER TABLE [dbo].[CalendarProviderAttributes] ADD
    CONSTRAINT [FK_CalendarProviderAttributes_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarReccurrence]...';
GO


ALTER TABLE [dbo].[CalendarReccurrence] ADD
    CONSTRAINT [FK_CalendarReccurrence_CalendarRecurrenceFrequencyTypes] FOREIGN KEY ([Frequency]) REFERENCES [dbo].[CalendarRecurrenceFrequencyTypes] ([ID]),
    CONSTRAINT [FK_CalendarReccursive_CalendarEvents] FOREIGN KEY ([EventID]) REFERENCES [dbo].[CalendarEvents] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarReccurrenceFrequency]...';
GO


ALTER TABLE [dbo].[CalendarReccurrenceFrequency] ADD
    CONSTRAINT [FK_CalendarFrecuency_CalendarReccursive] FOREIGN KEY ([CalendarReccursiveID]) REFERENCES [dbo].[CalendarReccurrence] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[CalendarRecurrenceFrequencyTypes]...';
GO


ALTER TABLE [dbo].[CalendarRecurrenceFrequencyTypes] ADD
    CONSTRAINT [FK_CalendarRecurrenceFrequencyTypes_CalendarRecurrenceFrequencyTypes] FOREIGN KEY ([ID]) REFERENCES [dbo].[CalendarRecurrenceFrequencyTypes] ([ID])

GO
    
PRINT N'Altering [dbo].[cancellationpolicy]...';
GO

GO
    
PRINT N'Altering [dbo].[CCCUsers]...';
GO


ALTER TABLE [dbo].[CCCUsers] ADD
    CONSTRAINT [FK__CCCUsers__FieldOfStudyID] FOREIGN KEY ([FieldOfStudyID]) REFERENCES [dbo].[FieldOfStudy] ([FieldOfStudyID]),
    CONSTRAINT [FK__CCCUsers__InstitutionID] FOREIGN KEY ([InstitutionID]) REFERENCES [dbo].[institution] ([InstitutionID]),
    CONSTRAINT [FK__CCCUsers__UserID] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK__CCCUsers__UserID__6EA14102] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[clienttype]...';
GO

CREATE NONCLUSTERED INDEX [idx_clienttype]
    ON [dbo].[clienttype]([CllientTypeID] ASC, [CountryID] ASC);


GO
    
PRINT N'Altering [dbo].[country]...';
GO

GO
    
PRINT N'Altering [dbo].[county]...';
GO


ALTER TABLE [dbo].[county] ADD
    CONSTRAINT [FK__county__StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [dbo].[stateprovince] ([StateProvinceID])
GO
    
PRINT N'Altering [dbo].[ExperienceLevel]...';
GO

GO
    
PRINT N'Altering [dbo].[FieldOfStudy]...';
GO


ALTER TABLE [dbo].[FieldOfStudy] ADD
    CONSTRAINT [FK__FieldOfStudy__LanguageID__CountryID] FOREIGN KEY ([LanguageID], [CountryID]) REFERENCES [dbo].[language] ([LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[Gender]...';
GO

GO
    
PRINT N'Altering [dbo].[institution]...';
GO


ALTER TABLE [dbo].[institution] ADD
    CONSTRAINT [FK__instituti__State__153B1FDF] FOREIGN KEY ([StateProvinceID]) REFERENCES [dbo].[stateprovince] ([StateProvinceID])

GO
    
PRINT N'Altering [dbo].[jobTitleLicense]...';
GO

GO
    
PRINT N'Altering [dbo].[JobTitlePlatform]...';
GO


ALTER TABLE [dbo].[JobTitlePlatform] ADD
    CONSTRAINT [FK_JobTitlePlatform_Platform] FOREIGN KEY ([PlatformID], [LanguageID], [CountryID]) REFERENCES [dbo].[Platform] ([PlatformID], [LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[JobTitleSolution]...';
GO


ALTER TABLE [dbo].[JobTitleSolution] ADD
    CONSTRAINT [FK_JobTitleSolution_positions] FOREIGN KEY ([JobTitleID], [LanguageID], [CountryID]) REFERENCES [dbo].[positions] ([PositionID], [LanguageID], [CountryID]),
    CONSTRAINT [FK_JobTitleSolution_Solution] FOREIGN KEY ([SolutionID], [LanguageID], [CountryID]) REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[language]...';
GO

GO
    
PRINT N'Altering [dbo].[languagelevel]...';
GO

GO
    
PRINT N'Altering [dbo].[licensecertification]...';
GO

GO
    
PRINT N'Altering [dbo].[Messages]...';
GO

CREATE NONCLUSTERED INDEX [idx_Messages]
    ON [dbo].[Messages]([MessageTypeID] ASC);


GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2014-02-18
-- Description:	Set field SentByUserId based on
-- the MessageTypeID
-- =============================================
CREATE TRIGGER AutoSetMessageSentByUserId
   ON  dbo.Messages
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE Messages SET
		SentByUserId = CASE 
		WHEN MessageTypeID IN (1, 2, 4, 5, 6, 9, 12, 14, 16, 18) THEN T.CustomerUserID
		WHEN MessageTypeID IN (3, 7, 10, 13, 15, 17) THEN T.ProviderUserID
		WHEN MessageTypeID IN (8, 19) THEN 0 -- the system
		END
	FROM MessagingThreads AS T
	WHERE T.ThreadID = Messages.ThreadID
	AND SentByUserId is null
END

GO
    
PRINT N'Altering [dbo].[messagethreadstatus]...';
GO

GO
    
PRINT N'Altering [dbo].[messagetype]...';
GO

GO
    
PRINT N'Altering [dbo].[MessagingThreads]...';
GO


ALTER TABLE [dbo].[MessagingThreads] ADD
    CONSTRAINT [Fk_MessagingThreads_2] FOREIGN KEY ([CustomerUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK_MessagingThreads_Messages] FOREIGN KEY ([LastMessageID]) REFERENCES [dbo].[Messages] ([MessageID]),
    CONSTRAINT [FK_MessagingThreads_messagethreadstatus] FOREIGN KEY ([MessageThreadStatusID]) REFERENCES [dbo].[messagethreadstatus] ([MessageThreadStatusID]),
    CONSTRAINT [FK_MessagingThreads_users] FOREIGN KEY ([ProviderUserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[municipality]...';
GO


ALTER TABLE [dbo].[municipality] ADD
    FOREIGN KEY ([CountyID]) REFERENCES [dbo].[county] ([CountyID])

GO
    
PRINT N'Altering [dbo].[OwnerAcknowledgment]...';
GO


ALTER TABLE [dbo].[OwnerAcknowledgment] ADD
    CONSTRAINT [FK_OwnerAcknowledgment_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[OwnerStatus]...';
GO

GO
    
PRINT N'Altering [dbo].[OwnerStatusHistory]...';
GO

GO
    
PRINT N'Altering [dbo].[Platform]...';
GO


ALTER TABLE [dbo].[Platform] ADD
    CONSTRAINT [FK_Platform_language] FOREIGN KEY ([LanguageID], [CountryID]) REFERENCES [dbo].[language] ([LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[positionbackgroundcheck]...';
GO

GO
    
PRINT N'Altering [dbo].[positionpricingtype]...';
GO


ALTER TABLE [dbo].[positionpricingtype] ADD
    CONSTRAINT [Fk_positionpricingtype] FOREIGN KEY ([PricingTypeID], [LanguageID], [CountryID]) REFERENCES [dbo].[pricingtype] ([PricingTypeID], [LanguageID], [CountryID]),
    CONSTRAINT [Fk_positionpricingtype_0] FOREIGN KEY ([PositionID], [LanguageID], [CountryID]) REFERENCES [dbo].[positions] ([PositionID], [LanguageID], [CountryID]),
    CONSTRAINT [Fk_positionpricingtype_1] FOREIGN KEY ([ClientTypeID], [LanguageID], [CountryID]) REFERENCES [dbo].[clienttype] ([CllientTypeID], [LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[positionratings]...';
GO

GO
    
PRINT N'Altering [dbo].[positions]...';
GO

CREATE NONCLUSTERED INDEX [idx_positions]
    ON [dbo].[positions]([PositionID] ASC);


GO
    
PRINT N'Altering [dbo].[postalcode]...';
GO


ALTER TABLE [dbo].[postalcode] ADD
    CONSTRAINT [FK__postalcode__CountyID] FOREIGN KEY ([CountyID]) REFERENCES [dbo].[county] ([CountyID]),
    CONSTRAINT [FK__postalcode__MunicipalityID] FOREIGN KEY ([MunicipalityID]) REFERENCES [dbo].[municipality] ([MunicipalityID]),
    CONSTRAINT [FK__postalcode__StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [dbo].[stateprovince] ([StateProvinceID])

GO
    
PRINT N'Altering [dbo].[postingTemplate]...';
GO

GO
    
PRINT N'Altering [dbo].[postingTemplateQuestion]...';
GO


ALTER TABLE [dbo].[postingTemplateQuestion] ADD
    CONSTRAINT [FK_postingTemplateQuestion_postingTemplate] FOREIGN KEY ([postingTemplateID]) REFERENCES [dbo].[postingTemplate] ([postingTemplateID]),
    CONSTRAINT [FK_postingTemplateQuestion_question] FOREIGN KEY ([questionID]) REFERENCES [dbo].[question] ([questionID])

GO
    
PRINT N'Altering [dbo].[PricingGroups]...';
GO

GO
    
PRINT N'Altering [dbo].[pricingSummary]...';
GO


ALTER TABLE [dbo].[pricingSummary] ADD
    CONSTRAINT [FK_pricingestimate_pricingestimate] FOREIGN KEY ([PricingSummaryID], [PricingSummaryRevision]) REFERENCES [dbo].[pricingSummary] ([PricingSummaryID], [PricingSummaryRevision])

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Payment processing fees price', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'pricingSummary', @level2type = N'COLUMN', @level2name = N'ServiceFeeAmount';


GO
    
PRINT N'Altering [dbo].[pricingSummaryDetail]...';
GO

GO
    
PRINT N'Altering [dbo].[pricingtype]...';
GO

GO
    
PRINT N'Altering [dbo].[PricingVariableDefinition]...';
GO

GO
    
PRINT N'Altering [dbo].[PricingVariableValue]...';
GO

GO
    
PRINT N'Altering [dbo].[providerpackage]...';
GO

GO
    
PRINT N'Altering [dbo].[providerpackagedetail]...';
GO

GO
    
PRINT N'Altering [dbo].[ProviderPaymentAccount]...';
GO

GO
    
PRINT N'Altering [dbo].[providerpaymentpreference]...';
GO

GO
    
PRINT N'Altering [dbo].[providerpaymentpreferencetype]...';
GO

GO
    
PRINT N'Altering [dbo].[providerservicephoto]...';
GO

GO
    
PRINT N'Altering [dbo].[providertaxform]...';
GO

GO
    
PRINT N'Altering [dbo].[question]...';
GO


ALTER TABLE [dbo].[question] ADD
    CONSTRAINT [FK_question_questionType] FOREIGN KEY ([questionTypeID]) REFERENCES [dbo].[questionType] ([questionTypeID])

GO
    
PRINT N'Altering [dbo].[questionType]...';
GO

GO
    
PRINT N'Altering [dbo].[ReferralSource]...';
GO

GO
    
PRINT N'Altering [dbo].[SearchCategory]...';
GO


ALTER TABLE [dbo].[SearchCategory] ADD
    CONSTRAINT [FK_SearchCategory_language] FOREIGN KEY ([LanguageID], [CountryID]) REFERENCES [dbo].[language] ([LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[SearchSubCategory]...';
GO


ALTER TABLE [dbo].[SearchSubCategory] ADD
    CONSTRAINT [FK_SearchSubCategory_language] FOREIGN KEY ([LanguageID], [CountryID]) REFERENCES [dbo].[language] ([LanguageID], [CountryID]),
    CONSTRAINT [FK_SearchSubCategory_SearchCategory] FOREIGN KEY ([SearchCategoryID], [LanguageID], [CountryID]) REFERENCES [dbo].[SearchCategory] ([SearchCategoryID], [LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[SearchSubCategorySolution]...';
GO


ALTER TABLE [dbo].[SearchSubCategorySolution] ADD
    CONSTRAINT [FK_SearchSubCategorySolution_language] FOREIGN KEY ([LanguageID], [CountryID]) REFERENCES [dbo].[language] ([LanguageID], [CountryID]),
    CONSTRAINT [FK_SearchSubCategorySolution_SearchSubCategory] FOREIGN KEY ([SearchSubCategoryID], [LanguageID], [CountryID]) REFERENCES [dbo].[SearchSubCategory] ([SearchSubCategoryID], [LanguageID], [CountryID]),
    CONSTRAINT [FK_SearchSubCategorySolution_Solution] FOREIGN KEY ([SolutionID], [LanguageID], [CountryID]) REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[serviceaddress]...';
GO


ALTER TABLE [dbo].[serviceaddress] ADD
    CONSTRAINT [FK__servicead__UserI__56F3D4A3] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[serviceattribute]...';
GO

GO
    
PRINT N'Altering [dbo].[serviceattributecategory]...';
GO

GO
    
PRINT N'Altering [dbo].[ServiceAttributeExperienceLevel]...';
GO

GO
    
PRINT N'Altering [dbo].[ServiceAttributeLanguageLevel]...';
GO

GO
    
PRINT N'Altering [dbo].[servicecategory]...';
GO

GO
    
PRINT N'Altering [dbo].[servicecategoryposition]...';
GO

GO
    
PRINT N'Altering [dbo].[servicecategorypositionattribute]...';
GO

GO
    
PRINT N'Altering [dbo].[ServiceProfessionalClient]...';
GO


ALTER TABLE [dbo].[ServiceProfessionalClient] ADD
    CONSTRAINT [FK_ProviderCustomer_ReferralSource] FOREIGN KEY ([ReferralSourceID]) REFERENCES [dbo].[ReferralSource] ([ReferralSourceID]),
    CONSTRAINT [FK_ProviderCustomer_users] FOREIGN KEY ([ServiceProfessionalUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK_ProviderCustomer_users1] FOREIGN KEY ([ClientUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK_ServiceProfessionalClient_booking] FOREIGN KEY ([CreatedByBookingID]) REFERENCES [dbo].[booking] ([BookingID])

GO
    
PRINT N'Altering [dbo].[servicesubcategory]...';
GO


ALTER TABLE [dbo].[servicesubcategory] ADD
    CONSTRAINT [FK_servicesubcategory_servicecategory] FOREIGN KEY ([ServiceCategoryID], [LanguageID], [CountryID]) REFERENCES [dbo].[servicecategory] ([ServiceCategoryID], [LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[Solution]...';
GO


ALTER TABLE [dbo].[Solution] ADD
    CONSTRAINT [FK_Solution_language] FOREIGN KEY ([LanguageID], [CountryID]) REFERENCES [dbo].[language] ([LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[Specialization]...';
GO


ALTER TABLE [dbo].[Specialization] ADD
    CONSTRAINT [FK_Specialization_Solution] FOREIGN KEY ([SolutionID], [LanguageID], [CountryID]) REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID])

GO
    
PRINT N'Altering [dbo].[stateprovince]...';
GO

GO
    
PRINT N'Altering [dbo].[taxentitytype]...';
GO

GO
    
PRINT N'Altering [dbo].[tintype]...';
GO

GO
    
PRINT N'Altering [dbo].[transporttype]...';
GO

GO
    
PRINT N'Altering [dbo].[UserAlert]...';
GO

GO
    
PRINT N'Altering [dbo].[userbackgroundcheck]...';
GO


ALTER TABLE [dbo].[userbackgroundcheck] ADD
    CONSTRAINT [FK__userbackg__Provi__4BB72C21] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[UserBadge]...';
GO


ALTER TABLE [dbo].[UserBadge] ADD
    CONSTRAINT [FK_UserBadge_Solution] FOREIGN KEY ([SolutionID], [LanguageID], [CountryID]) REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID]),
    CONSTRAINT [FK_UserBadge_UserBadge] FOREIGN KEY ([UserBadgeID]) REFERENCES [dbo].[UserBadge] ([UserBadgeID]),
    CONSTRAINT [FK_UserBadge_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Special value ''user'' means createdy by the userID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserBadge', @level2type = N'COLUMN', @level2name = N'CreatedBy';


GO
    
PRINT N'Altering [dbo].[UserEarnings]...';
GO


ALTER TABLE [dbo].[UserEarnings] ADD
    CONSTRAINT [FK_UserEarnings_UserEarnings] FOREIGN KEY ([UserEarningsID]) REFERENCES [dbo].[UserEarnings] ([UserEarningsID]),
    CONSTRAINT [FK_UserEarnings_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK_UserEarnings_users1] FOREIGN KEY ([ClientID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[UserEarningsEntry]...';
GO


ALTER TABLE [dbo].[UserEarningsEntry] ADD
    CONSTRAINT [FK_UserEarningsEntry_ServiceProfessionalClient] FOREIGN KEY ([UserID], [ClientUserID]) REFERENCES [dbo].[ServiceProfessionalClient] ([ServiceProfessionalUserID], [ClientUserID]),
    CONSTRAINT [FK_UserEarningsEntry_UserExternalListing] FOREIGN KEY ([UserExternalListingID]) REFERENCES [dbo].[UserExternalListing] ([UserExternalListingID]),
    CONSTRAINT [FK_UserEarningsEntry_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[usereducation]...';
GO


ALTER TABLE [dbo].[usereducation] ADD
    CONSTRAINT [FK__usereduca__Insti__2D12A970] FOREIGN KEY ([InstitutionID]) REFERENCES [dbo].[institution] ([InstitutionID]),
    CONSTRAINT [FK__usereduca__UserI__2C1E8537] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[UserExternalListing]...';
GO


ALTER TABLE [dbo].[UserExternalListing] ADD
    CONSTRAINT [FK_UserExternalListing_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'JSON array with { jobTitleID: jobTitleSingularName }', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserExternalListing', @level2type = N'COLUMN', @level2name = N'JobTitles';


GO
    
PRINT N'Altering [dbo].[UserFeePayments]...';
GO

GO
    
PRINT N'Altering [dbo].[UserLicenseCertifications]...';
GO


ALTER TABLE [dbo].[UserLicenseCertifications] ADD
    CONSTRAINT [FK_userlicen__ProviderUserID] FOREIGN KEY ([ProviderUserID]) REFERENCES [dbo].[users] ([UserID]),
    CONSTRAINT [FK__userlicen__Provi__5B045CA9] FOREIGN KEY ([ProviderUserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[UserListingSpecialization]...';
GO


ALTER TABLE [dbo].[UserListingSpecialization] ADD
    CONSTRAINT [FK_UserListingSpecialization_Specialization] FOREIGN KEY ([SpecializationID], [LanguageID], [CountryID]) REFERENCES [dbo].[Specialization] ([SpecializationID], [LanguageID], [CountryID]),
    CONSTRAINT [FK_UserListingSpecialization_userprofilepositions] FOREIGN KEY ([UserListingID]) REFERENCES [dbo].[userprofilepositions] ([UserListingID]),
    CONSTRAINT [FK_UserListingSpecialization_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[userOrganization]...';
GO


ALTER TABLE [dbo].[userOrganization] ADD
    CONSTRAINT [FK_userOrganization_users] FOREIGN KEY ([userID]) REFERENCES [dbo].[users] ([UserID]) ON DELETE CASCADE ON UPDATE CASCADE

GO
    
PRINT N'Altering [dbo].[UserPaymentPlan]...';
GO

GO
    
PRINT N'Altering [dbo].[UserPosting]...';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Comma separated list of integers (JSON like but don''t need to be surrounded by square brackets)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserPosting', @level2type = N'COLUMN', @level2name = N'neededSpecializationIDs';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Comma separated list of integers (JSON like but don''t need to be surrounded by square brackets)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserPosting', @level2type = N'COLUMN', @level2name = N'desiredSpecializationIDs';


GO
    
PRINT N'Altering [dbo].[UserPostingQuestionResponse]...';
GO


ALTER TABLE [dbo].[UserPostingQuestionResponse] ADD
    CONSTRAINT [FK_UserPostingQuestionResponse_question] FOREIGN KEY ([questionID]) REFERENCES [dbo].[question] ([questionID]),
    CONSTRAINT [FK_UserPostingQuestionResponse_questionType] FOREIGN KEY ([questionTypeID]) REFERENCES [dbo].[questionType] ([questionTypeID]),
    CONSTRAINT [FK_UserPostingQuestionResponse_UserPosting] FOREIGN KEY ([userPostingID]) REFERENCES [dbo].[UserPosting] ([userPostingID])

GO
    
PRINT N'Altering [dbo].[UserPostingReaction]...';
GO


ALTER TABLE [dbo].[UserPostingReaction] ADD
    CONSTRAINT [FK_UserPostingReaction_UserPosting] FOREIGN KEY ([userPostingID]) REFERENCES [dbo].[UserPosting] ([userPostingID]),
    CONSTRAINT [FK_UserPostingReaction_users] FOREIGN KEY ([serviceProfessionalUserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[userprofile]...';
GO

GO
    
PRINT N'Altering [dbo].[userprofilepositions]...';
GO


ALTER TABLE [dbo].[userprofilepositions] ADD
    CONSTRAINT [FK_userprofilepositions_accountstatus] FOREIGN KEY ([StatusID]) REFERENCES [dbo].[accountstatus] ([AccountStatusID]),
    CONSTRAINT [FK_userprofilepositions_positions] FOREIGN KEY ([PositionID], [LanguageID], [CountryID]) REFERENCES [dbo].[positions] ([PositionID], [LanguageID], [CountryID]),
    CONSTRAINT [FK_userprofilepositions_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

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

GO
    
PRINT N'Altering [dbo].[userprofileserviceattributes]...';
GO

GO
    
PRINT N'Altering [dbo].[UserReviews]...';
GO

GO
    
PRINT N'Altering [dbo].[UserReviewScores]...';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Average of total ratings for Rating1 value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Rating1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Average of total ratings for Rating1 value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Rating2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Average of total ratings for Rating1 value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Rating3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Average of total ratings for Rating1 value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Rating4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Number of ratings with a positive answer in Answer1 (value 1, true, yes)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Answer1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Number of ratings with a positive answer in Answer2 (value 1, true, yes)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserReviewScores', @level2type = N'COLUMN', @level2name = N'Answer2';


GO
    
PRINT N'Altering [dbo].[users]...';
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


GO
    
PRINT N'Altering [dbo].[usersignup]...';
GO

GO
    
PRINT N'Altering [dbo].[UserSolution]...';
GO


ALTER TABLE [dbo].[UserSolution] ADD
    CONSTRAINT [FK_UserSolution_Solution] FOREIGN KEY ([SolutionID], [LanguageID], [CountryID]) REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID]),
    CONSTRAINT [FK_UserSolution_userprofilepositions] FOREIGN KEY ([UserListingID]) REFERENCES [dbo].[userprofilepositions] ([UserListingID]),
    CONSTRAINT [FK_UserSolution_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[UserStats]...';
GO

ALTER TABLE [dbo].[UserStats] ADD
    CONSTRAINT [FK_UserStats_users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID])

GO
    
PRINT N'Altering [dbo].[userverification]...';
GO

GO
    
PRINT N'Altering [dbo].[verification]...';
GO

GO
    
PRINT N'Altering [dbo].[verificationcategory]...';
GO

GO
    
PRINT N'Altering [dbo].[verificationstatus]...';
GO

GO
    
PRINT N'Altering [dbo].[VOCElement]...';
GO

GO
    
PRINT N'Altering [dbo].[VOCExperienceCategory]...';
GO

GO
    
PRINT N'Altering [dbo].[VOCFeedback]...';
GO

GO
    
PRINT N'Altering [dbo].[VOCFlag]...';
GO

GO
    
PRINT N'Altering [dbo].[VOCScores]...';
GO

GO
    
PRINT N'Altering [dbo].[webpages_FacebookCredentials]...';
GO

GO
    
PRINT N'Altering [dbo].[webpages_Membership]...';
GO

GO
    
PRINT N'Altering [dbo].[webpages_OAuthMembership]...';
GO

GO
    
PRINT N'Altering [dbo].[webpages_Roles]...';
GO

GO
    
PRINT N'Altering [dbo].[webpages_UsersInRoles]...';
GO


ALTER TABLE [dbo].[webpages_UsersInRoles] ADD
    CONSTRAINT [fk_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[webpages_Roles] ([RoleId]),
    CONSTRAINT [fk_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[userprofile] ([UserId])

GO
    
PRINT N'Altering [dbo].[xJobTitlePricing]...';
GO

GO
    
PRINT N'Altering [dbo].[xJobTitleReviewRules]...';
GO

GO
    
PRINT N'Altering [dbo].[xServiceProfessionalPricing]...';
GO

GO
    

PRINT N'Creating [dbo].[fx_concat]...';
GO

/* Iago Lorenzo Salgueiro:
 * Concat two strings with a nexus
 * between if they are not null.
 * If some string is null or empty, only the
 * another will be retrived, without nexus
 */
CREATE function [dbo].[fx_concat] (
 @str1 varchar(8000),
 @str2 varchar(8000),
 @nexo varchar(8000) = ''
)
RETURNS varchar(8000)
AS
BEGIN
 DECLARE @ret varchar(8000)
 if @str1 is null OR @str1 like ''
  SET @ret = @str2
 else if @str2 is null OR @str2 like ''
  SET @ret = @str1
 else
  SET @ret = @str1 + @nexo + @str2

 if @ret is null
  SET @ret = ''

 return @ret

END

GO
        
PRINT N'Creating [dbo].[fx_concatBothOrNothing]...';
GO
/* Iago Lorenzo Salgueiro:
 * Concat two strings with a nexus
 * between if they are not null.
 * If some string is null or empty,
 * empty string is returned
 */
CREATE function [dbo].[fx_concatBothOrNothing] (
 @str1 varchar(8000),
 @str2 varchar(8000),
 @nexo varchar(8000) = ''
)
RETURNS varchar(8000)
AS
BEGIN
 DECLARE @ret varchar(8000)
 if @str1 is null OR @str1 like '' OR @str2 is null OR @str2 like ''
  SET @ret = ''
 else
  SET @ret = @str1 + @nexo + @str2

 return @ret

END
GO
        
PRINT N'Creating [dbo].[fx_IfNW]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Returns the @value if is not 
-- null, not empty and not a white spaces string
-- In that cases, the @default value is returned
-- Default can be null, empty, whitespaces
-- really or whatever you want.
-- =============================================
CREATE FUNCTION [dbo].[fx_IfNW]
(
	@value nvarchar(4000),
	@default nvarchar(4000)
)
RETURNS nvarchar(4000)
AS
BEGIN

	DECLARE @ret nvarchar(4000)

	IF @value is null OR @value like ''
		OR RTRIM(LTRIM(@value)) like ''
		SET @ret = @default
	ELSE
		SET @ret = @value

	RETURN @ret

END
GO
        
PRINT N'Creating [dbo].[fxCheckAlertAffectsUser]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 06/29/2012
-- Description:	Returns 1 (as bit, means true)
-- if that alert must be checked for
-- that user, because the user type (IsCustomer,
-- IsProvider) and the AlertTypeID (only
-- providers alert, only customers, both)
-- =============================================
CREATE FUNCTION [dbo].[fxCheckAlertAffectsUser] (
	@UserID int,
	@AlertID int
) RETURNS Bit
AS BEGIN
	DECLARE @IsProvider bit, @IsCustomer bit
	DECLARE @AlertTypeID int
	SELECT @IsProvider = IsProvider FROM Users WHERE UserID = @UserID
	SELECT @IsCustomer = IsCustomer FROM Users WHERE UserID = @UserID
	
	DECLARE @Checked bit
	SET @Checked = Cast (0 As bit)
	
	IF @IsProvider = 1 AND @AlertID IN (SELECT AlertID FROM Alert WHERE ProviderAlert = 1)
		SET @Checked = Cast (1 As bit)
	IF @IsCustomer = 1 AND @AlertID IN (SELECT AlertID FROM Alert WHERE CustomerAlert = 1)
		SET @Checked = Cast (1 As bit)
		
	RETURN @Checked
END
GO
        
PRINT N'Creating [dbo].[GetPositionString]...';
GO
CREATE FUNCTION dbo.GetPositionString ( @UserID INT,@LangaugeID INT, @CountryID INT, @PositionCnt INT )

RETURNS VARCHAR(8000) AS BEGIN

        DECLARE @r VARCHAR(8000), @l VARCHAR(8000)

        SELECT @PositionCnt = @PositionCnt - 1,  @r = a.PositionSingular + ', '
          FROM positions a
          JOIN dbo.userprofilepositions up
              on a.positionid = up.PositionID
              AND a.LanguageID = up.LanguageID
              AND a.CountryID = up.CountryID 
        WHERE up.UserID = @UserID and up.LanguageID = @LangaugeID and up.CountryID = @CountryID
        
              
           AND @PositionCnt = ( SELECT COUNT(*) FROM positions a2
                          JOIN dbo.userprofilepositions up2
                          on a2.positionid = up2.PositionID
                          AND a2.LanguageID = up2.LanguageID
                          AND a2.CountryID = up2.CountryID 
                          
                       WHERE up.UserID = up2.UserID
                         AND a.PositionSingular <= a2.PositionSingular 
                         AND up.LanguageID = up2.LanguageID
                         AND up.CountryID = up2.CountryID
                          
                         
                         
                    ) ;
        IF @PositionCnt > 0 BEGIN
              EXEC @l = dbo.GetPositionString @UserID,@LangaugeID,@CountryID, @PositionCnt ;
              SET @r =  @l + @r ;
END
RETURN @r ;
END
GO
        
PRINT N'Creating [dbo].[isMarketplacePaymentAccountActive]...';
GO

-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2015-09-15
-- Description:	Checks if the payment account
-- to collect payments on the marketplace
-- bookings for a given userID is active.
-- =============================================
CREATE FUNCTION isMarketplacePaymentAccountActive
(
	@userID int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ret bit

	SET @ret = CASE WHEN EXISTS (
		SELECT	ProviderUserID
		FROM	ProviderPaymentAccount
		WHERE	ProviderUserID = @UserID
				 AND
				-- Braintree given status must be 'active' or 'pending'
                -- Allow for 'pending' is a small risk we take on 2013/12/11 https://github.com/dani0198/Loconomics/issues/408#issuecomment-30338668
				[Status] IN ('active', 'pending')
	) THEN CAST(1 as bit) ELSE CAST(0 as bit) END

	-- Return the result of the function
	RETURN @ret

END
GO
        

PRINT N'Creating [dbo].[vwServiceCategoryPositionAttribute]...';
GO
CREATE VIEW [vwServiceCategoryPositionAttribute] AS

	SELECT TOP 100 PERCENT
		d.PositionID
		,se.ServiceAttributeCategoryID
		,s.ServiceAttributeID
		,s.LanguageID
		,s.CountryID
		
		,d.Active As ServiceCategoryPositionAttributeActive
		,s.Active As ServiceAttributeActive
		,se.Active As ServiceAttributeCategoryActive
		
		,s.SourceID As ServiceAttributeSourceID
		,s.Name As ServiceAttributeName
		,s.ServiceAttributeDescription
		
		,s.DisplayRank As ServiceAttributeDisplayRank
		
		,se.ServiceAttributeCategory
		,se.ServiceAttributeCategoryDescription
		
		,se.SourceID As ServiceAttributeCategorySourceID
		,se.PricingOptionCategory
		,se.RequiredInput As ServiceAttributeCategoryRequiredInput
		,se.EligibleForPackages
		,se.SideBarCategory
		,se.DisplayRank As ServiceAttributeCategoryDisplayRank

	FROM servicecategorypositionattribute d
	  join serviceattribute s 
	  on d.ServiceAttributeID = s.ServiceAttributeID 
	  join serviceattributecategory se 
	  on d.ServiceAttributeCategoryID = se.ServiceAttributeCategoryID 
	  and d.LanguageID = se.LanguageID
	  and d.CountryID = se.CountryID
	  and se.LanguageID = s.LanguageID
	  and se.CountryID = s.CountryID

	ORDER BY s.DisplayRank ASC, s.Name ASC
GO
        
PRINT N'Creating [dbo].[vwUsersContactData]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2013-02-27
-- Description:	Gets users records with some
-- common extra information and its contact
-- and location data, getting location from
-- its address list that is assigned as 'home'
-- location.
-- =============================================
CREATE VIEW vwUsersContactData AS

    SELECT
        -- Basic data
        a.UserID
        ,UP.Email
        ,a.CreatedDate As MemberSinceDate

        -- Name
        ,FirstName
        ,LastName
        ,SecondLastName
        ,MiddleIn
        ,(dbo.fx_concat(dbo.fx_concat(dbo.fx_concat(FirstName, dbo.fx_concatBothOrNothing(MiddleIn, '.', ''), ' '), LastName, ' '), SecondLastName, ' ')) As FullName
    
        -- DEPRECATED PHOTO
        ,Photo

        -- User Type
        ,coalesce(IsAdmin, cast(0 as bit)) As IsAdmin
        ,IsCustomer
        ,IsProvider
        ,AccountStatusID

        -- Only Providers:
        ,(CASE WHEN IsProvider=1 AND (
            SELECT count(*) FROM UserProfilePositions As UPS WHERE UPS.UserID = A.UserID AND UPS.Active=1
            ) > 0 THEN Cast(1 As bit)
            ELSE Cast(0 As bit)
        END) As IsActiveProvider

        ,ProviderWebsiteURL
        ,ProviderProfileURL

        -- Contact data
        ,MobilePhone
        ,AlternatePhone
    
        -- Address
        ,L.AddressLine1
        ,L.AddressLine2
        ,L.City
        ,L.StateProvinceID
        ,SP.StateProvinceName
        ,SP.StateProvinceCode
        ,L.CountryID
        ,PC.PostalCode
        ,L.PostalCodeID

        -- Personal data
        ,PublicBio
        ,A.GenderID
        ,GenderSingular
        ,GenderPlural
        ,SubjectPronoun
        ,ObjectPronoun
        ,PossesivePronoun
                                    
        -- Some preferences
        ,PreferredLanguageID
        ,PreferredCountryID
        ,IAuthZumigoVerification
        ,IAuthZumigoLocation

    FROM Users A
         INNER JOIN
        UserProfile As UP
          ON UP.UserID = A.UserID
         INNER JOIN
        Gender As G
          ON G.GenderID = A.GenderID
          	AND G.LanguageID = A.PreferredLanguageID  
          	AND G.CountryID = A.PreferredCountryID                                
         LEFT JOIN
        Address As L
          ON L.UserID = A.UserID
            AND L.AddressTypeID = 1 -- Only one address with type 1 (home) can exists
         LEFT JOIN
        StateProvince As SP
          ON SP.StateProvinceID = L.StateProvinceID
         LEFT JOIN
        PostalCode As PC
          ON PC.PostalCodeID = L.PostalCodeID
GO
        

PRINT N'Creating [dbo].[CheckUserEmail]...';
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.CheckUserEmail
	-- Add the parameters for the stored procedure here
	@Email nvarchar(56)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT Email FROM UserProfile WHERE LOWER(Email) = LOWER(@Email)
    
    
    
    
    
END
GO
        
PRINT N'Creating [dbo].[CreateCustomer]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 16/04/2012
-- Description:	Create a Loconomics User as
-- only Customer profile and minimum information
-- (from the Register page or Facebook Login).
-- =============================================
CREATE PROCEDURE [dbo].[CreateCustomer]
	-- Add the parameters for the stored procedure here
	
		@UserID int,
		@Firstname varchar(45),
        @Lastname varchar(145),
		@Lang int,
		@CountryId int,
        @GenderID int = -1,
		@PublicBio varchar(500) = null,
		@Phone varchar(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO dbo.users (
		UserID,
		FirstName,
		LastName,
		MiddleIn,
		SecondLastName,
		GenderID,
		PreferredLanguageID,
		PreferredCountryID,
		PublicBio,
		IsProvider,
		IsCustomer,
		MobilePhone,
		CreatedDate,
		UpdatedDate,
		ModifiedBy,
		Active,
		TrialEndDate
	) VALUES (
		@UserID,
		@Firstname,
		@Lastname,
		'',
		'',
		coalesce(@GenderID, -1),
		@Lang,
		@CountryId,
		@PublicBio,
		0,
		1,
		@Phone,
		GETDATE(),
		GETDATE(),
		'SYS',
		1,
		DATEADD(DAY, 14, SYSDATETIMEOFFSET())
	)
	
	-- Check alerts for the user to get its state updated
	EXEC TestAllUserAlerts @UserID
END

GO
        
PRINT N'Creating [dbo].[CreateProviderFromUser]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-03
-- Description:	Converts an existing user 
-- (a customer) into a provider, allowing
-- update some user data and setting needed
-- provider fields as in CreateProvider proc.
-- =============================================
CREATE PROCEDURE [dbo].[CreateProviderFromUser] (
	@UserID int,
	@Firstname varchar(45),
    @Lastname varchar(145),
    @PostalCodeID int,
    @StateProvinceID int,
    @LangID int,
    @CountryID int,
    @emailcontact bit,
    @BookCode varchar(64)
) AS BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE Users SET
		FirstName = coalesce(@FirstName, FirstName),
		LastName = coalesce(@LastName, LastName),
		PreferredLanguageID = coalesce(@LangID, PreferredLanguageID),
		PreferredCountryID = coalesce(@CountryID, PreferredCountryID),
		BookCode = @BookCode,
		IsProvider = 1,
		-- This proc is used most of time by providers registered from facebook, or users
		-- that start using the normal register form and then continues with the provider-sign-up,
		-- but only wants be providers: here we update the IsCustomer field based on if user
		-- have activity as customer of not (if it have bookingrequests, is customer, else
		-- only provider)
		IsCustomer = (CASE WHEN (
			SELECT	count(*)
			FROM	BookingRequest
			WHERE	BookingRequest.CustomerUserID = @UserID
		) = 0 THEN Cast(0 As bit) ELSE Cast(1 As bit) END),
		UpdatedDate = getdate(),
		ModifiedBy = 'sys',
		Active = 1
	WHERE	UserID = @UserID
	
	-- Set the address
	EXEC SetHomeAddress @UserID, '', '', '', @StateProvinceID, @PostalCodeID, @CountryID, @LangID
	
	-- Check alerts for the user to get its state updated
	EXEC TestAllUserAlerts @UserID
END
GO
        
PRINT N'Creating [dbo].[DeleteBookingRequest]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-12-28
-- Description:	Allow fully remove a Booking 
-- Request and related records created for it
-- based on our general rules for booking 
-- invalidation and removing all.
-- This MUST NOT be used normally, only because
-- errors on system, corrupt bookings or testing
-- IMPORTANT: Procedure cannot Refund or Void
-- the Braintree transaction, the booking
-- TransactionID is returned to do it manually,
-- or use the app method LcData.Booking.InvalidateBookingRequest
-- previous deletion to ensure is done auto.
-- =============================================
CREATE PROCEDURE DeleteBookingRequest
	@BookingRequestID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @invalidOk int
	DECLARE @tranID varchar(250)
	DECLARE @returnMessage varchar(1000)
	
	-- Invalidate the booking request with the general procedure, with a temporary
	-- 'timed out' status, this ensure all related records not need are removed
	-- and all remains clean.
	EXEC @invalidOk = dbo.InvalidateBookingRequest @BookingRequestID, 3

	IF @invalidOk = 0 BEGIN
		-- Get TransactionID to be returned later
		SELECT	@tranID = coalesce(PaymentTransactionID, '__THERE IS NO TRANSACTION__')
		FROM	bookingrequest
		WHERE	BookingRequestID = @BookingRequestID

		-- Remove the request
		DELETE FROM bookingrequest WHERE BookingRequestID = @BookingRequestID
		
		SET @returnMessage = 'Braintree cannot be Refunded or Void from here, do it manually for the next TransactionID if is not a Test: ' + @tranID
	END ELSE
		SET @returnMessage = 'Not deleted, could not be Invalidated becuase error number: ' + Cast(coalesce(@invalidOk, -1) as varchar)

	SELECT @returnMessage As [Message]
	PRINT @returnMessage
END
GO
        
PRINT N'Creating [dbo].[DeleteUser]...';
GO


/* CAUTION!
 * Delete all data from an user
 * account
 * TODO: need be update with all
 * the tables (calendar, pricing, etc.)
 */
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 17/04/2012
-- Description:	Delete all data from an user
-- account
-- TODO: need be update with all
-- the tables (calendar, pricing, etc.)
-- =============================================
CREATE PROCEDURE [dbo].[DeleteUser]
	(
	@UserId int
	)
AS
	SET NOCOUNT ON
	
DELETE PPD 
FROM providerpackagedetail PPD
INNER JOIN providerpackage PP
ON PP.ProviderPackageID = PPD.ProviderPackageID
AND (PP.ProviderUserID = @UserId OR PP.visibleToClientID = @UserId)

DELETE
FROM providerpackage
WHERE ProviderUserID = @UserId OR VisibleToClientID = @UserId

delete
FROM	CalendarProviderAttributes
WHERE userid = @UserID

delete
FROM			UserAlert
WHERE userid = @UserID

delete
FROM            UserLicenseCertifications
where provideruserid =  @UserId

delete
from	userstats
where userid = @userid

delete
from userbackgroundcheck
where userid = @userid

delete
from	serviceaddress
where addressid IN (
	select addressid
	from [address]
	where userid = @userid
)

delete
from	address
where userid = @userid

delete
from			booking
where clientuserid = @userid or serviceprofessionaluserid = @userid

delete
from			ServiceProfessionalClient
where clientuserid = @userid or serviceprofessionaluserid = @userid

delete
from			[messages]
where threadid IN (
	select threadid
	from messagingthreads
	where customeruserid = @userid or provideruserid = @userid
)

delete
FROM            messagingthreads
where provideruserid =  @UserId OR customeruserid = @UserID

delete
FROM            providerpaymentpreference
where provideruserid =  @UserId

delete
FROM            usereducation
where userid =  @UserId

delete
FROM            userreviews
where provideruserid =  @UserId OR customeruserId = @UserId

delete
FROM            providertaxform
where provideruserid =  @UserId

delete
FROM            userverification
where userid =  @UserId

delete
FROM            userprofileserviceattributes
where userid =  @UserId

delete
FROM			UserSolution
where userid =  @UserId

delete
FROM            userprofilepositions
where userid =  @UserId

delete
FROM            CCCUsers
where userid =  @UserId

delete
FROM            userprofile
where userid =  @UserId

delete
FROM            users
where userid = @UserId

delete
FROM            webpages_usersinroles
where userid =  @UserId

delete
FROM            webpages_oauthmembership
where userid =  @UserId

delete
FROM            webpages_membership
where userid = @UserId

delete
FROM            webpages_facebookcredentials
where userid = @UserId



GO
        
PRINT N'Creating [dbo].[DeleteUserPosition]...';
GO
CREATE PROCEDURE DeleteUserPosition (
	@UserID int,
	@PositionID int
) AS BEGIN

delete from [ServiceAttributeLanguageLevel]
where userid = @UserID AND PositionID = @PositionID

delete from ServiceAttributeExperienceLevel
where userid = @UserID AND PositionID = @PositionID

delete from userprofileserviceattributes
where userid = @UserID AND PositionID = @PositionID

delete from userprofilepositions
where userid = @UserID AND PositionID = @PositionID

END
GO
        
PRINT N'Creating [dbo].[DelUserVerification]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2013-07-15
-- Description:	Delete a user-verification
-- record, if there is one.
-- =============================================
CREATE PROCEDURE DelUserVerification
	@UserID int,
	@VerificationID int,
    @PositionID int = 0
AS
BEGIN
	DELETE FROM userverification
	WHERE UserID = @UserID
		AND VerificationID = @VerificationID
        AND PositionID = @PositionID
END
GO
        
PRINT N'Creating [dbo].[GetPosition]...';
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPosition]
	-- Add the parameters for the stored procedure here
	
	@PositionID int,
	@LanguageID int = 1,
	@CountryID int = 1

-- exec getuserprofile 2,14

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
			SELECT 
				PositionSingular,
				PositionDescription
			FROM dbo.positions b
			WHERE b.PositionID = @PositionID
			and b.LanguageID = @LanguageID
			and b.CountryID = @CountryID

END
GO
        
PRINT N'Creating [dbo].[GetSearchResults]...';
GO
CREATE PROCEDURE [dbo].[GetSearchResults]
@LanguageID int, @CountryID int, @SearchTerm varchar(300), @SubCategory varchar(300)
 WITH EXEC AS CALLER
AS

--EXEC dbo.GetSearchResults 1,1,'%',''

IF @SubCategory <> ''
BEGIN
	DECLARE @ServiceCategoryID AS INT

	SELECT @ServiceCategoryID = ServiceCategoryID 
	FROM servicecategory 
	WHERE Name = @SubCategory 
		AND LanguageID = @LanguageID 
		AND CountryID = @CountryID

	SELECT 
		d.UserID
		,d.FirstName
		,d.LastName
		,a.PositionID
		,c.PositionSingular
		,a.UpdatedDate
		,Positions=STUFF((SELECT ', ' + PositionSingular FROM Positions As P0 INNER JOIN UserProfilePositions As UP0 ON P0.PositionID = UP0.PositionID WHERE UP0.UserID = D.UserID AND P0.LanguageID = @LanguageID AND P0.CountryID = @CountryID FOR XML PATH('')) , 1 , 1 , '' )
		,S.Name as ServiceName 
	FROM dbo.users d 
	JOIN dbo.userprofilepositions a 
		ON d.UserID = a.UserID 
	JOIN  positions c 
		ON a.PositionID = c.PositionID
		AND a.LanguageID = c.LanguageID
		AND a.CountryID = c.CountryID
	JOIN dbo.servicecategoryposition SCP
		ON C.PositionID = SCP.PositionID
		AND a.LanguageID = SCP.LanguageID
		AND a.CountryID = SCP.CountryID
	JOIN dbo.servicecategory S
		ON SCP.ServiceCategoryID = S.ServiceCategoryID
		AND a.LanguageID = S.LanguageID
		AND a.CountryID = S.CountryID
	WHERE S.ServiceCategoryID = @ServiceCategoryID
		AND a.LanguageID = @LanguageID and a.CountryID = @CountryID
		AND d.Active = 1
		AND a.Active = 1
		AND a.StatusID = 1
		AND c.Active = 1
		AND s.Active = 1
		AND scp.Active = 1
		AND (
			@SearchTerm like ''
			 OR
			c.PositionSingular like @SearchTerm
			 OR
			c.PositionPlural like @SearchTerm
			 OR
			c.PositionDescription like @SearchTerm
			 OR
			c.Aliases like @SearchTerm
			 OR
			c.GovPosition like @SearchTerm
			 OR
			c.GovPositionDescription like @SearchTerm
		)
END

ELSE --IF @SearchTerm <> '%'
BEGIN
	SELECT 
		d.UserID
		,d.FirstName
		,d.LastName
		,a.PositionID
		,c.PositionSingular
		,a.UpdatedDate
		,Positions=STUFF((SELECT ', ' + PositionSingular FROM Positions As P0 INNER JOIN UserProfilePositions As UP0 ON P0.PositionID = UP0.PositionID WHERE UP0.UserID = D.UserID AND P0.LanguageID = @LanguageID AND P0.CountryID = @CountryID FOR XML PATH('')) , 1 , 1 , '' )
		--,rs.Rating1
		--,rs.Rating2
		--,rs.Rating3
		--,rs.Rating4 
	FROM dbo.users d 
	JOIN dbo.userprofilepositions a 
		ON d.UserID = a.UserID 
	JOIN  positions c 
		ON a.PositionID = c.PositionID 
		AND a.LanguageID = c.LanguageID
		AND a.CountryID = c.CountryID
	--LEFT JOIN dbo.UserReviewScores rs ON (d.UserID = rs.UserID)
	WHERE
		a.LanguageID = @LanguageID
		AND a.CountryID = @CountryID
		AND d.Active = 1
		AND a.Active = 1
		AND c.Active = 1
		AND (
			c.PositionSingular like @SearchTerm
			 OR
			c.PositionPlural like @SearchTerm
			 OR
			c.PositionDescription like @SearchTerm
			 OR
			c.Aliases like @SearchTerm
			 OR
			c.GovPosition like @SearchTerm
			 OR
			c.GovPositionDescription like @SearchTerm
			 OR
			a.PositionIntro like @SearchTerm
			 OR
			EXISTS (
				SELECT *
				FROM	UserProfileServiceAttributes As UA
						 INNER JOIN
						ServiceAttribute As SA
						  ON UA.ServiceAttributeID = SA.ServiceAttributeID
							AND UA.Active = 1
							AND SA.Active = 1
							AND SA.LanguageID = UA.LanguageID
							AND SA.CountryID = UA.CountryID
				WHERE
						UA.UserID = a.UserID
						AND UA.PositionID = a.PositionID
						AND UA.LanguageID = @LanguageID
						AND UA.CountryID = @CountryID
						AND (
						 SA.Name like @SearchTerm
						  OR
						 SA.ServiceAttributeDescription like @SearchTerm
						)
			)
		)
END
GO
        
PRINT N'Creating [dbo].[GetServiceAttributeCategories]...';
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetServiceAttributeCategories]
	-- Add the parameters for the stored procedure here

	@PositionID int,
	@LanguageID int = 1,
	@CountryID int = 1,
	@OnlyBookingPathSelection bit = 0

-- exec GetServiceAttributeCategories 14,1,1

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	   SELECT DISTINCT
	   a.DisplayRank,
	   a.ServiceAttributeCategoryID,
	   a.ServiceAttributeCategory as ServiceCat,
	   a.ServiceAttributeCategoryDescription,
	   a.RequiredInput,
	   a.SideBarCategory
	   FROM serviceattributecategory a
	   join servicecategorypositionattribute c
	   on a.ServiceAttributeCategoryID = c.ServiceAttributeCategoryID
	   and a.LanguageID = c.LanguageID
	   and a.CountryID = c.CountryID
	   WHERE  c.PositionID = @PositionID
	   and c.LanguageID  = @LanguageID
	   and c.CountryID = @CountryID
	   and (a.PricingOptionCategory is null OR a.PricingOptionCategory = 1)
	   -- only actived
	   and a.Active = 1
	   and c.Active = 1
	   -- booking path selection
	   and (@OnlyBookingPathSelection = 0 OR BookingPathSelection = 1)
	   ORDER BY a.DisplayRank ASC, a.ServiceAttributeCategory ASC
	   
	


END
GO
        
PRINT N'Creating [dbo].[GetServiceAttributes]...';
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetServiceAttributes]
	-- Add the parameters for the stored procedure here

	@PositionID int,
	-- CategoryID can be Zero (0) to retrieve all attributes without regarding the category
	@ServiceAttributeCategoryID int,
	@LanguageID int = 1,
	@CountryID int = 1,
	@UserID int = 0,
	@OnlyUserChecked bit = 0

-- exec GetServiceAttributes 14,2,1,1

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		  SELECT 
		  se.ServiceAttributeCategoryID, 
		  se.ServiceAttributeCategory as ServiceCat,
		  s.ServiceAttributeDescription,
		  s.ServiceAttributeID, 
		  s.Name as ServiceAttribute,
		  
		  -- iagosrl: added UserChecked to know if is an attribute
		  -- assigned to the @UserID
		  (case when @UserID <= 0 OR us.UserID is null then cast(0 as bit)
				else cast(1 as bit)
		  end) as UserChecked
		  ,coalesce(se.EligibleForPackages, cast(0 as bit)) As EligibleForPackages
		  
		  from servicecategorypositionattribute d
		  join serviceattribute s 
		  on d.ServiceAttributeID = s.ServiceAttributeID 
		  join serviceattributecategory se 
		  on d.ServiceAttributeCategoryID = se.ServiceAttributeCategoryID 
		  and d.LanguageID = se.LanguageID
		  and d.CountryID = se.CountryID
		  and se.LanguageID = s.LanguageID
		  and se.CountryID = s.CountryID
		  
		  -- iagosrl: I added param @UserID to optionally (left join) get
		  --  attributes selected by the user, not filtering else adding a
		  --  new result field 'UserChecked' as true/false
		  left join userprofileserviceattributes as us
		  on d.ServiceAttributeID = us.ServiceAttributeID
		  and d.ServiceAttributeCategoryID = us.ServiceAttributeCategoryID
		  and d.PositionID = us.PositionID
		  and d.LanguageID = us.LanguageID
		  and d.CountryID = us.CountryID
		  and us.Active = 1
		  and us.UserID = @UserID
		  
		  WHERE  d.PositionID = @PositionID  
		  -- iagosrl: 2012-07-20, added the possibility of value Zero of CategoryID parameter to retrieve position attributes from all position-mapped categories
		  and (@ServiceAttributeCategoryID = 0 OR d.ServiceAttributeCategoryID = @ServiceAttributeCategoryID)
		  and d.LanguageID  = @LanguageID
		  and d.CountryID = @CountryID
		  -- only actived
		  and d.Active = 1
		  and se.Active = 1
		  and s.Active = 1
		  and (@OnlyUserChecked = 0 OR us.UserID > 0)
		  ORDER BY s.DisplayRank ASC, s.Name ASC

END
GO
        
PRINT N'Creating [dbo].[GetUserCalendarProviderAttributes]...';
GO

CREATE PROC [dbo].[GetUserCalendarProviderAttributes]

@UserID int


as

SELECT AdvanceTime,MinTime,MaxTime,BetweenTime,UseCalendarProgram,CalendarType,CalendarURL, PrivateCalendarToken, IncrementsSizeInMinutes
FROM CalendarProviderAttributes
WHERE UserID = @UserID
GO
        
PRINT N'Creating [dbo].[GetUserDetails]...';
GO





CREATE PROC dbo.GetUserDetails

@UserID int


as




select 

FirstName, 
LastName,
SecondLastName,
MiddleIn,
PostalCode,
Photo,
PreferredLanguageID,
PreferredCountryID,
ADD_Details 
from users a 
join dbo.userprofilepositionadditional b 
on a.userid = b.userid  where a.UserID = @UserID
GO
        
PRINT N'Creating [dbo].[GetUserProfile]...';
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.GetUserProfile
	-- Add the parameters for the stored procedure here
	@UserID int,
	@PositionID int,
	@LanguageID int = 1,
	@CountryID int = 1

-- exec getuserprofile 2,14

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
			SELECT 
			FirstName + ' ' + LastName as ProviderName,
			PostalCode,
			Photo,
			PreferredLanguageID,
			PreferredCountryID,
			ADD_Details 
			FROM users a 
			JOIN dbo.userprofilepositionadditional b 
			ON a.userid = b.userid  
			WHERE a.UserID = @UserID
			and b.PositionID = @PositionID
			and b.LanguageID = @LanguageID
			and b.CountryID = @CountryID

END
GO
        
PRINT N'Creating [dbo].[InsertUserProfilePositions]...';
GO
CREATE PROC [dbo].[InsertUserProfilePositions]

@UserID int,
@PositionID int,
@LanguageID int,
@CountryID int,
@CancellationPolicyID int,
@Intro varchar(400) = '',
@InstantBooking bit = 0,
@collectPaymentAtBookMeButton bit = 0,
@title nvarchar(50)

AS

DECLARE @ResultMessage varchar(50)
DECLARE @userListingID int

BEGIN TRY

	INSERT INTO userprofilepositions (
		UserID, PositionID, LanguageID, CountryID, CreateDate, UpdatedDate, ModifiedBy, Active, StatusID, PositionIntro, CancellationPolicyID, InstantBooking,
		collectPaymentAtBookMeButton, Title
	) VALUES(
		@UserID,@PositionID,@LanguageID,@CountryID, GETDATE(), GETDATE(), 'sys', 1, 2, @Intro, @CancellationPolicyID, @InstantBooking,
		@collectPaymentAtBookMeButton, @title
	)

	SET @userListingID = @@Identity
	
	-- Check alerts for the position to get its state updated
	EXEC TestAllUserAlerts @UserID, @PositionID

	SELECT 'Success' as Result, @userListingID as userListingID

END TRY

BEGIN CATCH

 SET @ResultMessage =  ERROR_MESSAGE();

-- TODO This needs refactor, since this error never happens now since userListingID exists
-- (may be different message per unique index on positionID) may be the source of the issue #840
IF @ResultMessage like 'Violation of PRIMARY KEY%'
 
BEGIN

	-- SELECT 'You already have this position loaded' as Result

	IF EXISTS (SELECT * FROM UserProfilePositions WHERE
		UserID = @UserID AND PositionID = @PositionID
		AND LanguageID = @LanguageID AND CountryID = @CountryID
		AND Active = 0) BEGIN
		
		SELECT 'Position could not be added' As Result
		
	END ELSE BEGIN
	
		-- Enable this position and continue, no error
		UPDATE UserProfilePositions
		SET StatusID = 2
			,UpdatedDate = GETDATE()
			,ModifiedBy = 'sys'
			,PositionIntro = @Intro
			,CancellationPolicyID = @CancellationPolicyID
			,InstantBooking = @InstantBooking
			,collectPaymentAtBookMeButton = @collectPaymentAtBookMeButton
		WHERE 
			UserID = @UserID AND PositionID = @PositionID
			AND LanguageID = @LanguageID AND CountryID = @CountryID
			
		-- Check alerts for the position to get its state updated
		EXEC TestAllUserAlerts @UserID, @PositionID

		SELECT @userListingID = userListingID FROM UserProfilePositions
		WHERE 
			UserID = @UserID AND PositionID = @PositionID
			AND LanguageID = @LanguageID AND CountryID = @CountryID

		SELECT 'Success' as Result, @userListingID as userListingID
	END
END

ELSE
BEGIN

	SELECT 'Sorry, it appears we have an error: ' + @ResultMessage as Result
	
END

END CATCH

GO
        
PRINT N'Creating [dbo].[ListPositions]...';
GO





CREATE PROC [dbo].[ListPositions]

@LanguageID int = 1,
@CountryID int  = 1

as



select  
a.positionid,  
a.PositionSingular  as position  
from positions a 
where a.LanguageID = @LanguageID and a.CountryID = @CountryID
and a.PositionSingular is not null
order by 2 asc
GO
        
PRINT N'Creating [dbo].[SearchCategories]...';
GO





CREATE PROC [dbo].[SearchCategories]

@LanguageID int = 1,
@CountryID int  = 1,
@ServiceCategoryID int = 1
as

--exec [dbo].[SearchCategories]

select  
ServiceSubCategoryID,
Name,
Rank as ServiceRank
from dbo.servicesubcategory
where LanguageID = @LanguageID and CountryID = @CountryID
and ServiceCategoryID = @ServiceCategoryID
and rank <=5



--b.positionid,  
--a.PositionSingular  as position  
--from positions a join servicecategoryposition  b   
--on a.positionid = b.positionid  
--join servicesubcategory c  on b.ServiceSubCategoryID = c.ServiceSubCategoryID    
--where a.LanguageID = @LanguageID and a.CountryID = @CountryID
GO
        
PRINT N'Creating [dbo].[SearchCategoriesPositions]...';
GO
CREATE PROC [dbo].[SearchCategoriesPositions]

@LanguageID int = 1,
@CountryID int  = 1,
@ServiceCategoryID int = 1,
@ServiceSubCategoryID int = 1
as

--exec [dbo].[SearchCategoriesPositions] 1,1

-- Need a rank attribute for each user position for preferred provider

SELECT  
c.ServiceSubCategoryID,
c.Name,
c.Rank as ServiceRank,
b.positionid,  
a.PositionSingular  as position,
tpur.PrivateReview,
tpur.PublicReview, 
tpur.Rating1,
tpur.Rating2,
tpur.Rating3,
MIN(up.UserID),
COUNT(DISTINCT BookingID) AS ReviewCount,
0 as VerificationsCount,
0 as LicensesCount

FROM  positions a 

LEFT JOIN servicecategoryposition  b   
  ON a.positionid = b.positionid  

LEFT JOIN servicesubcategory c  
  ON b.ServiceCategoryID = c.ServiceCategoryID  

LEFT JOIN dbo.userprofilepositions up
  ON a.positionid = up.PositionID
  AND a.LanguageID = up.LanguageID
  AND a.CountryID = up.CountryID

LEFT JOIN UserReviews ur
  ON a.PositionID = ur.PositionID
  AND up.UserID = ur.ProviderUserID

LEFT JOIN (SELECT TOP 1 ProviderUserID,
                        PositionID,
                        PrivateReview,
                        PublicReview ,
                        Rating1,
                        Rating2,
                        Rating3
           FROM dbo.UserReviews ORDER BY CreatedDate) tpur
           
on ur.PositionID = tpur.PositionID 
and ur.ProviderUserID = tpur.ProviderUserID

WHERE a.LanguageID = @LanguageID and a.CountryID = @CountryID
and c.ServiceCategoryID = @ServiceCategoryID
and c.ServiceSubCategoryID = @ServiceSubCategoryID
and c.rank <=5
GROUP BY c.ServiceSubCategoryID,
c.Name,
c.Rank,
b.positionid,  
a.PositionSingular,
tpur.PrivateReview,
tpur.PublicReview, 
tpur.Rating1,
tpur.Rating2,
tpur.Rating3

GO
        
PRINT N'Creating [dbo].[SearchPositions]...';
GO
CREATE PROCEDURE [dbo].[SearchPositions]
/*
Highlight and execute the following statement to drop the procedure
before executing the create statement.

DROP PROCEDURE dbo.SearchPositions;

*/

-- =============================================
-- Author:      <Author,,Name>
-- Create date: <Create Date,,>
-- Description: <Description,,>
-- =============================================
    -- Add the parameters for the stored procedure here
    @SearchTerm varchar(150),
    @LanguageID int = 1,
    @CountryID int = 1

--exec dbo.GetPositions '%Cleaner%',1,1

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    SELECT DISTINCT 
        c.PositionSingular, c.PositionID, c.PositionDescription
    FROM positions c
    WHERE  
        c.LanguageID = @LanguageID 
        AND c.CountryID = @CountryID
        AND c.Active = 1
        AND (c.Approved = 1 Or c.Approved is null) -- Avoid not approved, allowing pending (null) and approved (1)
        AND dbo.fx_IfNW(c.PositionSingular, null) is not null
        AND (
            c.PositionSingular like @SearchTerm
             OR
            c.PositionPlural like @SearchTerm
             OR
            c.PositionDescription like @SearchTerm
             OR
            c.Aliases like @SearchTerm
             OR
            c.GovPosition like @SearchTerm
             OR
            c.GovPositionDescription like @SearchTerm
             OR
            EXISTS (
                SELECT *
                FROM    ServiceCategoryPositionAttribute As SP
                         INNER JOIN
                        ServiceAttribute As SA
                          ON SP.ServiceAttributeID = SA.ServiceAttributeID
                            AND SP.Active = 1
                            AND SA.Active = 1
                            AND SA.LanguageID = SP.LanguageID
                            AND SA.CountryID = SP.CountryID
                WHERE
                        SP.PositionID = c.PositionID
                        AND SA.LanguageID = @LanguageID
                        AND SA.CountryID = @CountryID
                        AND (
                         SA.Name like @SearchTerm
                          OR
                         SA.ServiceAttributeDescription like @SearchTerm
                        )
            )
        )

    ORDER BY PositionSingular
END
GO
        
PRINT N'Creating [dbo].[SearchPositionsByCategory]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2013-01-03
-- Description:	Get the list of positions 
-- inside the CategoryID given, for categorized
-- search results page
-- =============================================
CREATE PROCEDURE [dbo].[SearchPositionsByCategory]
	@LanguageID int
	,@CountryID int
	,@Category nvarchar(400)
	,@City nvarchar(400)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @ServiceCategoryID AS INT
	SELECT @ServiceCategoryID = ServiceCategoryID 
	FROM servicecategory 
	WHERE Name = @Category
		AND LanguageID = @LanguageID 
		AND CountryID = @CountryID

    SELECT	P.PositionID as jobTitleID
			,P.PositionPlural as pluralName
			,P.PositionSingular as singularName
			,P.PositionDescription as description
			,P.PositionSearchDescription as searchDescription

			,coalesce((SELECT
				avg( (coalesce(UR2.Rating1, 0) + coalesce(UR2.Rating2, 0) + coalesce(UR2.Rating3, 0)) / 3) As AVR
			  FROM UserReviews As UR2
				INNER JOIN
				  UserProfilePositions As UP2
				  ON UP2.PositionID = UR2.PositionID
				    AND UR2.ProviderUserID = UP2.UserID
					AND UP2.LanguageID = @LanguageID
					AND UP2.CountryID = @CountryID
					AND UP2.Active = 1
					AND UP2.StatusID = 1
			  WHERE UR2.PositionID = P.PositionID
			), 0) As averageRating
			
			,coalesce(sum(ur.TotalRatings), 0) As totalRatings
			,avg(US.ResponseTimeMinutes) As averageResponseTimeMinutes
			,avg(PHR.HourlyRate) As averageHourlyRate
			,count(UP.UserID) As serviceProfessionalsCount
			
	FROM	Positions As P
			 INNER JOIN
			ServiceCategoryPosition As SCP
			  ON P.PositionID = SCP.PositionID
				AND P.LanguageID = SCP.LanguageID
				AND P.CountryID = SCP.CountryID
				
			 LEFT JOIN
			UserProfilePositions As UP
			  ON UP.PositionID = P.PositionID
			    AND UP.LanguageID = P.LanguageID
			    AND UP.CountryID = P.CountryID
			    AND UP.Active = 1
			    AND UP.StatusID = 1
			 LEFT JOIN
			UserReviewScores AS UR
			  ON UR.UserID = UP.UserID
				AND UR.PositionID = UP.PositionID
			 LEFT JOIN
			UserStats As US
			  ON US.UserID = UP.UserID
			 LEFT JOIN
			(SELECT	ProviderPackage.ProviderUserID As UserID
					,ProviderPackage.PositionID
					,min(PriceRate) As HourlyRate
					,LanguageID
					,CountryID
			 FROM	ProviderPackage
			 WHERE	ProviderPackage.Active = 1
					AND ProviderPackage.PriceRateUnit like 'HOUR' 
					AND ProviderPackage.PriceRate > 0
			 GROUP BY	ProviderPackage.ProviderUserID, ProviderPackage.PositionID
						,LanguageID, CountryID
			) As PHR
			  ON PHR.UserID = UP.UserID
			    AND PHR.PositionID = UP.PositionID
				AND PHR.LanguageID = P.LanguageID
				AND PHR.CountryID = P.CountryID
	WHERE
			SCP.ServiceCategoryID = @ServiceCategoryID
			 AND
			SCP.Active = 1
			 AND
			P.Active = 1
			 AND
			P.LanguageID = @LanguageID
			 AND
			P.CountryID = @CountryID
	GROUP BY P.PositionID, P.PositionPlural, P.PositionSingular, P.PositionDescription, P.PositionSearchDescription, P.DisplayRank
	ORDER BY serviceProfessionalsCount DESC, P.DisplayRank, P.PositionPlural
END
GO
        
PRINT N'Creating [dbo].[SearchProvidersByPositionSingular]...';
GO
CREATE PROCEDURE [dbo].[SearchProvidersByPositionSingular]
@LanguageID int,
@CountryID int,
@PositionSingular varchar(300),
@City nvarchar(400)
 WITH EXEC AS CALLER
AS

--EXEC dbo.SearchProvidersByPositionSingular 1,1,'Cleaner', 'San Francisco'

	SELECT 
		d.userID
		,d.firstName
		,d.lastName
		,d.secondLastName
		,d.businessName
		,a.PositionID As jobTitleID
		--,c.PositionSingular
		--,a.UpdatedDate
		,jobTitles=STUFF((SELECT ', ' + PositionSingular FROM Positions As P0 INNER JOIN UserProfilePositions As UP0 ON P0.PositionID = UP0.PositionID WHERE UP0.UserID = D.UserID AND P0.LanguageID = @LanguageID AND P0.CountryID = @CountryID AND UP0.StatusID = 1 AND UP0.Active = 1 AND P0.Active = 1 AND P0.Approved <> 0 FOR XML PATH('')) , 1 , 1 , '' )
		--,rs.Rating1
		--,rs.Rating2
		--,rs.Rating3
		--,rs.Rating4 
	FROM dbo.users d 
	JOIN dbo.userprofilepositions a 
		ON d.UserID = a.UserID 
	JOIN  positions c 
		ON a.PositionID = c.PositionID 
		AND a.LanguageID = c.LanguageID
		AND a.CountryID = c.CountryID
	--LEFT JOIN dbo.UserReviewScores rs ON (d.UserID = rs.UserID)
	WHERE
		a.LanguageID = @LanguageID
		AND a.CountryID = @CountryID
		AND d.Active = 1
		AND a.Active = 1
		AND a.StatusID = 1
		AND c.Active = 1
		AND c.PositionSingular like @PositionSingular
GO
        
PRINT N'Creating [dbo].[SearchTopProvidersByPosition]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro	
-- Create date: 2013-01-07
-- Description:	Get a short list of providers
-- in the specific position for the search page
-- results. List is limited to the top most
-- rated providers.
-- Minimum information is returned, not full
-- user information.
-- =============================================
CREATE PROCEDURE SearchTopProvidersByPosition
	@LanguageID int,
	@CountryID int,
	@PositionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT TOP 8 UserID
		,FirstName
		--, Rating -- returning Rating for testing only
	FROM (

		SELECT	UP.UserID
				,U.FirstName
				,((coalesce(Rating1, 0) + coalesce(Rating2, 0) + coalesce(Rating3, 0)) / 3) As Rating
		FROM	Users As U
				 INNER JOIN
				UserProfilePositions As UP
				  ON UP.UserID = U.UserID
				 LEFT JOIN
				UserReviewScores AS UR
				  ON UR.UserID = UP.UserID
					AND UR.PositionID = UP.PositionID
		WHERE
				U.Active = 1
				 AND
				UP.PositionID = @PositionID
				 AND
				UP.Active = 1
				 AND
				UP.StatusID = 1
				 AND
				UP.LanguageID = @LanguageID
				 AND
				UP.CountryID = @CountryID
	) As T
	-- The top best rated providers:
	ORDER BY Rating DESC 

END
GO
        
PRINT N'Creating [dbo].[SetCalendarProviderAttributes]...';
GO

-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2014-02-12
-- Description:	It sets (insert or update) the
-- given calendar attributes for the provider,
-- each field is optional to be set, if null is
-- given, current db value is preserved.
--
-- NOTE: minTime and maxTime fields are being 
-- gradually removed, firstly from user use and 
-- later totally from code and db #279.
-- This proc doesn't provide way to set both of
-- that since code is not using it already.
-- NOTE: with standard iCal support, fields
-- UseCalendarProgram and CalendarType gets
-- unused, with fixed values of 1 and ''.
-- =============================================
CREATE PROC [dbo].[SetCalendarProviderAttributes] (
	@UserID int,
	@AdvanceTime decimal(10, 2),
	@BetweenTime decimal(10, 2),
	@CalendarURL varchar(500),
	@PrivateCalendarToken varchar(128),
	@IncrementsSizeInMinutes int = null
) AS BEGIN

	IF EXISTS (SELECT * FROM CalendarProviderAttributes WHERE UserID = @UserID)
        
        UPDATE CalendarProviderAttributes SET
			AdvanceTime = coalesce(@AdvanceTime, AdvanceTime),
            BetweenTime = coalesce(@BetweenTime, BetweenTime),
            CalendarURL = coalesce(@CalendarURL, CalendarURL),
            PrivateCalendarToken = dbo.fx_IfNW(@PrivateCalendarToken, PrivateCalendarToken),
            IncrementsSizeInMinutes = coalesce(@IncrementsSizeInMinutes, IncrementsSizeInMinutes)
            
            -- Deprecated fields, to be removed:
            ,CalendarType = ''
            ,UseCalendarProgram = 1
         WHERE UserID = @UserID 
 
	ELSE
      
		INSERT INTO CalendarProviderAttributes (
			UserID,
			AdvanceTime,
			BetweenTime,
			CalendarURL,
			PrivateCalendarToken,
			IncrementsSizeInMinutes
			
			-- Deprecated fields, to be removed:
			,CalendarType
			,UseCalendarProgram
			,MinTime
			,MaxTime
		) VALUES (
			@UserID,
			coalesce(@AdvanceTime, 0),
			coalesce(@BetweenTime, 0),
			@CalendarURL,
			@PrivateCalendarToken,
			@IncrementsSizeInMinutes
			
			-- Deprecated fields
			,''
			,1
			,0
			,0
		)

END
GO
        
PRINT N'Creating [dbo].[SetHomeAddress]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2013-04-08
-- Description:	Sets the data for the user
-- special 'Home' address, updating the
-- address or inserting a new record if
-- not exists
-- =============================================
CREATE PROCEDURE SetHomeAddress
	@UserID int,
	@AddressLine1 varchar(100),
	@AddressLine2 varchar(100),
	@City varchar(100),
	@StateProvinceID int,
	@PostalCodeID int,
	@CountryID int,
	@LanguageID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE  Address WITH (serializable)
    SET     AddressLine1 = @AddressLine1
            ,AddressLine2 = @AddressLine2
            ,City = @City
            ,StateProvinceID = @StateProvinceID
            ,PostalCodeID = @PostalCodeID
            ,CountryID = @CountryID

            ,Active = 1
            ,UpdatedDate = getdate()
            ,ModifiedBy = 'sys'
    WHERE   UserId = @UserID
                AND
            AddressTypeID = 1 -- Ever Type: Home

    IF @@rowcount = 0
    BEGIN
        DECLARE @AddressName nvarchar(50)
        SELECT @AddressName = AddressType
        FROM AddressType
        WHERE AddressTypeID = 1 -- Home
                AND LanguageID = @LanguageID
                AND CountryID = @CountryID

        INSERT INTO Address (UserID, AddressTypeID, AddressName,
            AddressLine1, AddressLine2, City, StateProvinceID, PostalCodeID, CountryID,
            Active, CreatedDate, UpdatedDate, ModifiedBy)
        VALUES (@UserID, 1 /* Type: Home */, @AddressName, 
            @AddressLine1, @AddressLine2, @City, @StateProvinceID, @PostalCodeID, @CountryID, 
            1, getdate(), getdate(), 'sys')
    END
END
GO
        
PRINT N'Creating [dbo].[SetUserAlert]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Allow active or disactive
--  (remove) an alert for an user and position
--  (PositionID=0 for alerts not related with
--  a position), with current Date-Time.
--  
-- =============================================
CREATE PROCEDURE [dbo].[SetUserAlert]
	@UserID int
	,@PositionID int
	,@AlertID int
	,@Active bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF @Active = 1 BEGIN
		UPDATE UserAlert WITH (Serializable) SET
			Active = 1,
			UpdatedDate = getdate(),
			ModifiedBy = 'sys'
		WHERE
			UserID = @UserID
			 AND
			PositionID = @PositionID
			 AND
			AlertID = @AlertID
			
		IF @@RowCount = 0
			INSERT INTO UserAlert (
				UserID, PositionID, AlertID, CreatedDate, UpdatedDate,
				ModifiedBy, Active
			) VALUES (
				@UserID, @PositionID, @AlertID, getdate(), getdate(),
				'sys', 1
			)

    END ELSE BEGIN
		DELETE FROM UserAlert
		WHERE UserID = @UserID AND PositionID = @PositionID
			AND AlertID = @AlertID
    END
END
GO
        
PRINT N'Creating [dbo].[SetUserVerification]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-07-17
-- Description:	Inserts or update a user 
-- verification record.
-- =============================================
CREATE PROCEDURE [dbo].[SetUserVerification]
	@UserID int
	,@VerificationID int
	,@VerifiedDate datetime
	,@VerificationStatusID int
	,@PositionID int = 0
AS
BEGIN
    UPDATE UserVerification WITH (serializable) SET
        UpdatedDate = getdate(),
        VerifiedBy = 'sys',
        LastVerifiedDate = @VerifiedDate,
        Active = 1,
        VerificationStatusID = @VerificationStatusID,
        PositionID = @PositionID
    WHERE
        UserID = @UserID
         AND
        VerificationID = @VerificationID

    IF @@rowcount = 0 BEGIN
        INSERT INTO UserVerification (
            UserID, VerificationID, DateVerified, CreatedDate, 
            UpdatedDate, VerifiedBy, LastVerifiedDate, Active, VerificationStatusID
        ) VALUES (
            @UserID, @VerificationID, @VerifiedDate, getdate(), getdate(), 'sys', getdate(), 1, @VerificationStatusID
        )
    END
END
GO
        
PRINT N'Creating [dbo].[sp_MSforeach_worker]...';
GO



CREATE proc [dbo].[sp_MSforeach_worker]
	@command1 nvarchar(2000), @replacechar nchar(1) = N'?', @command2 nvarchar(2000) = null, @command3 nvarchar(2000) = null, @worker_type int =1
as

	create table #qtemp (	/* Temp command storage */
		qnum				int				NOT NULL,
		qchar				nvarchar(2000)	COLLATE database_default NULL
	)

	set nocount on
	declare @name nvarchar(517), @namelen int, @q1 nvarchar(2000), @q2 nvarchar(2000)
   declare @q3 nvarchar(2000), @q4 nvarchar(2000), @q5 nvarchar(2000)
	declare @q6 nvarchar(2000), @q7 nvarchar(2000), @q8 nvarchar(2000), @q9 nvarchar(2000), @q10 nvarchar(2000)
	declare @cmd nvarchar(2000), @replacecharindex int, @useq tinyint, @usecmd tinyint, @nextcmd nvarchar(2000)
   declare @namesave nvarchar(517), @nametmp nvarchar(517), @nametmp2 nvarchar(258)

	declare @local_cursor cursor
	if @worker_type=1	
		set @local_cursor = hCForEachDatabase
	else
		set @local_cursor = hCForEachTable
	
	open @local_cursor
	fetch @local_cursor into @name

	while (@@fetch_status >= 0) begin

      select @namesave = @name
		select @useq = 1, @usecmd = 1, @cmd = @command1, @namelen = datalength(@name)
		while (@cmd is not null) begin		/* Generate @q* for exec() */
			select @replacecharindex = charindex(@replacechar, @cmd)
			while (@replacecharindex <> 0) begin

            /* 7.0, if name contains ' character, and the name has been single quoted in command, double all of them in dbname */
            /* if the name has not been single quoted in command, do not doulbe them */
            /* if name contains ] character, and the name has been [] quoted in command, double all of ] in dbname */
            select @name = @namesave
            select @namelen = datalength(@name)
            declare @tempindex int
            if (substring(@cmd, @replacecharindex - 1, 1) = N'''') begin
               /* if ? is inside of '', we need to double all the ' in name */
               select @name = REPLACE(@name, N'''', N'''''')
            end else if (substring(@cmd, @replacecharindex - 1, 1) = N'[') begin
               /* if ? is inside of [], we need to double all the ] in name */
               select @name = REPLACE(@name, N']', N']]')
            end else if ((@name LIKE N'%].%]') and (substring(@name, 1, 1) = N'[')) begin
               /* ? is NOT inside of [] nor '', and the name is in [owner].[name] format, handle it */
               /* !!! work around, when using LIKE to find string pattern, can't use '[', since LIKE operator is treating '[' as a wide char */
               select @tempindex = charindex(N'].[', @name)
               select @nametmp  = substring(@name, 2, @tempindex-2 )
               select @nametmp2 = substring(@name, @tempindex+3, len(@name)-@tempindex-3 )
               select @nametmp  = REPLACE(@nametmp, N']', N']]')
               select @nametmp2 = REPLACE(@nametmp2, N']', N']]')
               select @name = N'[' + @nametmp + N'].[' + @nametmp2 + ']'
            end else if ((@name LIKE N'%]') and (substring(@name, 1, 1) = N'[')) begin
               /* ? is NOT inside of [] nor '', and the name is in [name] format, handle it */
               /* j.i.c., since we should not fall into this case */
               /* !!! work around, when using LIKE to find string pattern, can't use '[', since LIKE operator is treating '[' as a wide char */
               select @nametmp = substring(@name, 2, len(@name)-2 )
               select @nametmp = REPLACE(@nametmp, N']', N']]')
               select @name = N'[' + @nametmp + N']'
            end
            /* Get the new length */
            select @namelen = datalength(@name)

            /* start normal process */
				if (datalength(@cmd) + @namelen - 1 > 2000) begin
					/* Overflow; put preceding stuff into the temp table */
					if (@useq > 9) begin
						close @local_cursor
						if @worker_type=1	
							deallocate hCForEachDatabase
						else
							deallocate hCForEachTable
						return 1
					end
					if (@replacecharindex < @namelen) begin
						/* If this happened close to beginning, make sure expansion has enough room. */
						/* In this case no trailing space can occur as the row ends with @name. */
						select @nextcmd = substring(@cmd, 1, @replacecharindex)
						select @cmd = substring(@cmd, @replacecharindex + 1, 2000)
						select @nextcmd = stuff(@nextcmd, @replacecharindex, 1, @name)
						select @replacecharindex = charindex(@replacechar, @cmd)
						insert #qtemp values (@useq, @nextcmd)
						select @useq = @useq + 1
						continue
					end
					/* Move the string down and stuff() in-place. */
					/* Because varchar columns trim trailing spaces, we may need to prepend one to the following string. */
					/* In this case, the char to be replaced is moved over by one. */
					insert #qtemp values (@useq, substring(@cmd, 1, @replacecharindex - 1))
					if (substring(@cmd, @replacecharindex - 1, 1) = N' ') begin
						select @cmd = N' ' + substring(@cmd, @replacecharindex, 2000)
						select @replacecharindex = 2
					end else begin
						select @cmd = substring(@cmd, @replacecharindex, 2000)
						select @replacecharindex = 1
					end
					select @useq = @useq + 1
				end
				select @cmd = stuff(@cmd, @replacecharindex, 1, @name)
				select @replacecharindex = charindex(@replacechar, @cmd)
			end

			/* Done replacing for current @cmd.  Get the next one and see if it's to be appended. */
			select @usecmd = @usecmd + 1
			select @nextcmd = case (@usecmd) when 2 then @command2 when 3 then @command3 else null end
			if (@nextcmd is not null and substring(@nextcmd, 1, 2) = N'++') begin
				insert #qtemp values (@useq, @cmd)
				select @cmd = substring(@nextcmd, 3, 2000), @useq = @useq + 1
				continue
			end

			/* Now exec() the generated @q*, and see if we had more commands to exec().  Continue even if errors. */
			/* Null them first as the no-result-set case won't. */
			select @q1 = null, @q2 = null, @q3 = null, @q4 = null, @q5 = null, @q6 = null, @q7 = null, @q8 = null, @q9 = null, @q10 = null
			select @q1 = qchar from #qtemp where qnum = 1
			select @q2 = qchar from #qtemp where qnum = 2
			select @q3 = qchar from #qtemp where qnum = 3
			select @q4 = qchar from #qtemp where qnum = 4
			select @q5 = qchar from #qtemp where qnum = 5
			select @q6 = qchar from #qtemp where qnum = 6
			select @q7 = qchar from #qtemp where qnum = 7
			select @q8 = qchar from #qtemp where qnum = 8
			select @q9 = qchar from #qtemp where qnum = 9
			select @q10 = qchar from #qtemp where qnum = 10
			truncate table #qtemp
			exec (@q1 + @q2 + @q3 + @q4 + @q5 + @q6 + @q7 + @q8 + @q9 + @q10 + @cmd)
			select @cmd = @nextcmd, @useq = 1
		end
    fetch @local_cursor into @name
	end /* while FETCH_SUCCESS */
	close @local_cursor
	if @worker_type=1	
		deallocate hCForEachDatabase
	else
		deallocate hCForEachTable
		
	return 0


GO
        
PRINT N'Creating [dbo].[sp_MSforeachtable]...';
GO

CREATE proc [dbo].[sp_MSforeachtable]
	@command1 nvarchar(2000), @replacechar nchar(1) = N'?', @command2 nvarchar(2000) = null,
  @command3 nvarchar(2000) = null, @whereand nvarchar(2000) = null,
	@precommand nvarchar(2000) = null, @postcommand nvarchar(2000) = null
AS
	declare @mscat nvarchar(12)
	select @mscat = ltrim(str(convert(int, 0x0002)))
	if (@precommand is not null)
		exec(@precommand)
   exec(N'declare hCForEachTable cursor global for select ''['' + REPLACE(schema_name(syso.schema_id), N'']'', N'']]'') + '']'' + ''.'' + ''['' + REPLACE(object_name(o.id), N'']'', N'']]'') + '']'' from dbo.sysobjects o join sys.all_objects syso on o.id = syso.object_id '
         + N' where OBJECTPROPERTY(o.id, N''IsUserTable'') = 1 ' + N' and o.category & ' + @mscat + N' = 0 '
         + @whereand)
	declare @retval int
	select @retval = @@error
	if (@retval = 0)
		exec @retval = dbo.sp_MSforeach_worker @command1, @replacechar, @command2, @command3, 0
	if (@retval = 0 and @postcommand is not null)
		exec(@postcommand)
	return @retval

GO
        
PRINT N'Creating [dbo].[TestAlertAvailability]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'availability' are satisfied, 
-- updating user alert and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertAvailability]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 2
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		-- #735 ATTRIBUTES DISABLED (TEMPORARLY MAYBE)
		-- EXISTS (SELECT UserID FROM [CalendarProviderAttributes]
		-- WHERE UserID = @UserID)
		-- AND
		-- Updated script to follow new Calendar back-end that use events
		-- with a specific type instead of the special -and deleted- table 'FreeEvents':
		--AND EXISTS (SELECT UserID FROM [CalendarProviderFreeEvents]
		--WHERE UserID = @UserID)
		EXISTS (SELECT UserID FROM [CalendarEvents]
		WHERE UserID = @UserID AND EventType = 2)
	BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID, 0
END
GO
        
PRINT N'Creating [dbo].[TestAlertBackgroundCheck]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Modified date: 2013-04-11
-- Description:	Test if the conditions for the
-- alert type 'backgroundcheck' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- There are 2 alerts for this test:
--  12: backgroundcheck  (optional)
--  18: required-backgroundcheck  (required)
-- Because lookup backgroundacheck tables can
-- be required or not, any required one is 
-- related to the aler 18 and others to the
-- alert 12.
-- FROM DATE 2013-04-11:
-- Alerts will be off when almost a request
-- was done from provider, passing the test
-- request with state 'verified:2' and too
-- 'pending:1' and 'contact us:3; but not 
-- 'rejected/unable to verified:4'.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertBackgroundCheck]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 0
	
	DECLARE @OptionalAlertID int
	SET @OptionalAlertID = 12
	DECLARE @RequiredAlertID int
	SET @RequiredAlertID = 18
	DECLARE @IsRequired bit
    
    /* Background check must be checked per position, but is not saved
		on userverification per position. This means special treatment,
		and we must too ensure that is enabled only on positions affected
		by background-check according to the table PositionBackgroundCheck.
	   A position can satisfy a required background check if user has
	   already a background check with greater ID.
     */
    DECLARE @cur CURSOR
    DECLARE @PositionID int
    DECLARE @HigherBackgroundCheckID int
    
	SET @cur = CURSOR FOR 
		SELECT DISTINCT
		 PositionID
		FROM
		 UserProfilePositions
		WHERE
	     UserID = @UserID
	     
	OPEN @cur
	FETCH NEXT FROM @cur INTO @PositionID
	WHILE @@FETCH_STATUS = 0 BEGIN
		
		/* Go to a 2-steps loop, first for Optional and second for Required alert.
			allowing only tweak to vars preserving unduplicated the important code
		 */
		DECLARE @i int
		SET @i = 0
		WHILE @i < 2 BEGIN
			-- Setting up loop vars
			IF @i = 0 BEGIN
				-- Setting up vars for Optional
				SET @AlertID = @OptionalAlertID
				SET @IsRequired = 0
			END ELSE IF @i = 1 BEGIN
				-- Setting up vars for Required
				SET @AlertID = @RequiredAlertID
				SET @IsRequired = 1
			END ELSE
				BREAK

			/***
				RUN TEST CODE
			 ***/
			-- Reset var to avoid residual data
			SET @HigherBackgroundCheckID = null
			-- Get the higher background check that this position request for this user
			-- Or the lower background check if is a non-required alert
			SELECT	@HigherBackgroundCheckID = (CASE
						WHEN @IsRequired = 1
						 THEN MAX(PB.BackgroundCheckID)
						WHEN @IsRequired = 0
						 THEN MIN(PB.BackgroundCheckID)
					END)
			FROM	PositionBackgroundCheck As PB
			WHERE	PB.PositionID = @PositionID
				AND PB.[Required] = @IsRequired AND PB.Active = 1
				AND PB.CountryID = (SELECT TOP 1 CountryID FROM vwUsersContactData WHERE UserID = @UserID)
				AND PB.StateProvinceID = (SELECT TOP 1 StateProvinceID FROM vwUsersContactData WHERE UserID = @UserID)	

			-- First ever check if this type of alert affects this type of user
			IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
				-- if there is no a required background check, test passed
				@HigherBackgroundCheckID is null
				 OR
				-- if there is a required background check, check if user
				-- possess this or a greater background check to pass the test
				EXISTS (
					SELECT	UserID
					FROM	UserBackgroundCheck
					WHERE	UserID = @UserID
						-- Valid requests to off alert, depending on Status:
						AND StatusID IN (1, 2, 3)
						AND (
							-- For No-required, must have almost one background check, independently
							-- of is equals or greater, almost one
							@IsRequired = 0
							OR
							-- For required, must have a background check equals or greater than
							-- the higher one required for the position
							BackgroundCheckID >= @HigherBackgroundCheckID
						)
			) BEGIN
				-- PASSED: disable alert
				EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 0
			END ELSE BEGIN
				-- NOT PASSED: active alert
				EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 1
			END
		

			-- Next loop:
			SET @i = @i + 1
		END
		
		-- Next Position
		FETCH NEXT FROM @cur INTO @PositionID
	END
	CLOSE @cur
	DEALLOCATE @cur
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID
	
			/* Old code: In-loop-inside-if check based on UserVerification; deprecated by a better, more controlled, background check
			EXISTS (
				SELECT	UserID
				FROM	UserVerification As UV
				WHERE	UV.UserID = @UserID
						 AND
						UV.VerificationID = 7
						 AND
						UV.Active = 1
						 AND
						UV.VerificationStatusID = 1 -- 1:confirmed
				*/
END
GO
        
PRINT N'Creating [dbo].[TestAlertBasicInfoVerification]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'basicinfoverification' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertBasicInfoVerification]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 10
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		3 = ( -- 3 Verifications being checked (1, 2, 4)
			SELECT	count(*)
			FROM	UserVerification As UV
			WHERE	UV.UserID = @UserID
					 AND
					UV.VerificationID IN (1, 2, 4)
					 AND
					UV.Active = 1
					 AND
					UV.VerificationStatusID = 1 -- 1:confirmed
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID
END
GO
        
PRINT N'Creating [dbo].[TestAlertEducation]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2013-06-12
-- Description:	Test if the conditions for the
-- alert type 'add-education' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertEducation]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 20
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		EXISTS (SELECT UserID FROM UserEducation
				WHERE UserID = @UserID
					AND Active = 1
					/* Only require activation and InstitutionID, and this
					last is not-null and foreign key */
					/*AND FromYearAttended is not null
					AND (
						dbo.fx_IfNW(DegreeCertificate , null) is not null
						OR
						dbo.fx_IfNW(FieldOfStudy , null) is not null
					)*/
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID
END
GO
        
PRINT N'Creating [dbo].[TestAlertLocation]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'location' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertLocation]
	@UserID int
	,@PositionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 16
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		-- Check that user has that position (this is a position related alert). If it has not (=0), alert will off because doesn't affect:
		(SELECT count(*) FROM userprofilepositions WHERE UserID=@UserID AND PositionID=@PositionID) = 0 OR
		EXISTS (SELECT AddressID FROM ServiceAddress
	WHERE UserID = @UserID
		AND PositionID = @PositionID
		AND ( -- Must have almost one address to perfor work Or from it travel
			ServicesPerformedAtLocation = 1
			 OR
			TravelFromLocation = 1
		)
		AND Active = 1
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID, @PositionID
END
GO
        
PRINT N'Creating [dbo].[TestAlertPayment]...';
GO

-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'payment' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertPayment]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 5

	DECLARE @hasInstantBooking bit
	IF (SELECT sum(Cast(InstantBooking as int)) FROM userprofilepositions WHERE userID = @UserID) > 0
	BEGIN
		SET @hasInstantBooking = 1
	END
	
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		@hasInstantBooking = Cast(0 as bit) OR
		/* Marketplace Way */
		dbo.isMarketplacePaymentAccountActive(@UserID) = Cast(1 as bit)
	BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID
END
    
GO
        
PRINT N'Creating [dbo].[TestAlertPersonalInfo]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Modified date: 2017-11-09
-- Description:	Test if the conditions for the
-- alert type 'personalinfo' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertPersonalInfo]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 3
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
	  (
		EXISTS (
			SELECT UserID
			FROM Users
			WHERE 
				UserID = @UserID
				AND dbo.fx_IfNW(FirstName, null) is not null
				AND dbo.fx_IfNW(LastName, null) is not null
				AND (
				 dbo.fx_IfNW(MobilePhone, null) is not null
				  OR
				 dbo.fx_IfNW(AlternatePhone, null) is not null
				)
				-- GenderID now in TestAlertPublicBio, to match new forms
				--AND GenderID > 0
		)
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID
END

GO
        
PRINT N'Creating [dbo].[TestAlertPhoto]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'photo' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertPhoto]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 4
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		EXISTS (SELECT UserID FROM Users
	WHERE UserID = @UserID
		AND dbo.fx_IfNW(Photo, null) is not null
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID
END
GO
        
PRINT N'Creating [dbo].[TestAlertPositionServices]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'positionservices' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertPositionServices]
	@UserID int,
	@PositionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 8
	
	DECLARE @CATS TABLE (CatID int)
	
	INSERT INTO @CATS (CatID)
	SELECT DISTINCT A.ServiceAttributeCategoryID
	FROM ServiceAttributeCategory As A
		  INNER JOIN
		 ServiceCategoryPositionAttribute As B
		   ON A.ServiceAttributeCategoryID = B.ServiceAttributeCategoryID
			AND B.PositionID = @PositionID
	WHERE A.RequiredInput = 1
		AND A.Active = 1
		AND B.Active = 1
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		-- Check that user has that position (this is a position related alert). If it has not (=0), alert will off because doesn't affect:
		(SELECT count(*) FROM userprofilepositions WHERE UserID=@UserID AND PositionID=@PositionID) = 0 OR
		-- Check all required data
		-- Must have almost one service attribute selected 
		-- per required category for the position
		@PositionID = 0
		OR (SELECT count(*) FROM (SELECT A.ServiceAttributeCategoryID
		FROM userprofileserviceattributes As A
		 INNER JOIN
		ServiceCategoryPositionAttribute As B
		  ON A.ServiceAttributeCategoryID = B.ServiceAttributeCategoryID
		   AND A.ServiceAttributeID = B.ServiceAttributeID
		  -- We only check the 'RequiredInput' Categories
		   AND B.ServiceAttributeCategoryID IN (SELECT CatID FROM @CATS)
		WHERE A.UserID = @UserID AND A.PositionID = @PositionID
			AND A.Active = 1 AND B.Active = 1
		GROUP BY A.ServiceAttributeCategoryID
	) As Z) = (SELECT count(*) FROM @CATS)
	BEGIN
		--PRINT 'you''re cool!'
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 0
	END ELSE BEGIN
		--PRINT 'buuuhhhh!'
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID, @PositionID
END
GO
        
PRINT N'Creating [dbo].[TestAlertPricingDetails]...';
GO

CREATE PROCEDURE [dbo].[TestAlertPricingDetails]
	@UserID int,
	@PositionID int
AS
BEGIN
	
	
	SET NOCOUNT ON;
	DECLARE @AlertID int
	SET @AlertID = 1
    
    
    IF	dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		
		(SELECT count(*) FROM userprofilepositions WHERE UserID=@UserID AND PositionID=@PositionID) = 0 OR
		
		
		EXISTS (SELECT * FROM ProviderPackage
			WHERE ProviderUserID = @UserID
				AND PositionID = @PositionID
				AND Active = 1
		)
	
		BEGIN
		
		EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 0
	END ELSE BEGIN
		
		EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 1
	END
	
	
	EXEC dbo.TestProfileActivation @UserID, @PositionID
END
GO
        
PRINT N'Creating [dbo].[TestAlertProfessionalLicense]...';
GO
CREATE PROCEDURE [dbo].[TestAlertProfessionalLicense]
    @UserID int
    ,@PositionID int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    DECLARE @AlertID int
    SET @AlertID = 0
    
    DECLARE @OptionalAlertID int
    SET @OptionalAlertID = 13
    DECLARE @RequiredAlertID int
    SET @RequiredAlertID = 19
    DECLARE @IsRequired bit
    
    /* Go to a 2-steps loop, first for Optional and second for Required alert.
        allowing only tweak to vars preserving unduplicated the important code
     */
    DECLARE @i int
    SET @i = -1
    WHILE @i < 2 BEGIN
        -- Next loop:
        SET @i = @i + 1
        -- Setting up loop vars
        IF @i = 0 BEGIN
            -- Setting up vars for Optional
            SET @AlertID = @OptionalAlertID
            SET @IsRequired = 0
        END ELSE IF @i = 1 BEGIN
            -- Setting up vars for Required
            SET @AlertID = @RequiredAlertID
            SET @IsRequired = 1
        END ELSE
            BREAK

        /***
            RUN TEST CODE
            
            Global set of conditions to match to pass the alert (disable the alert):
            IF (
                alertAffectsUser = 0
                 OR
                userHasPosition = 0
                 OR
                -- Has all required licenses
                (
                    countryLevel = 0
                     AND
                    stateProvinceLevel = 0
                     AND
                    countyLevel = 0
                     AND
                    municipalLevel = 0
                )
                 OR
                -- There are no required licenses
                (
                    -- User has almost one license of the required list of licenses (changed on 2013-03-26 issue #203)
                    userLicensesOfEachOptionGroup > 0
                )
            )
         ***/
         
        -- GET RESULT FOR EACH INDIVIDUAL QUERY
         
        -- First ever check if this type of alert affects this type of user
        DECLARE @alertAffectsUser bit
        SET @alertAffectsUser = dbo.fxCheckAlertAffectsUser(@UserID, @AlertID)

        -- Check that user has that position (this is a position related alert). If it has not (=0), alert will off because doesn't affect:
        DECLARE @userHasPosition int
        SELECT @userHasPosition = count(*) FROM userprofilepositions WHERE UserID=@UserID AND PositionID=@PositionID

        -- Check if the user has all the required licenses (can be 0 if 0 are required) 
        -- Check Country-level 
        DECLARE @countryLevel int
        SELECT
            @countryLevel = COUNT(*)
        FROM
            jobTitleLicense JL
            INNER JOIN
            Country C
            ON JL.countryID = C.countryID
            LEFT JOIN
            userLicenseCertifications UL
            ON JL.LicenseCertificationID = UL.LicenseCertificationID
            AND UL.ProviderUserID = @userID
        WHERE
            JL.positionID in (@PositionID, -1) 
            AND C.languageID = (SELECT PreferredLanguageID FROM users WHERE UserID = @userID)
            AND C.countryID in (SELECT
            P.countryID
        FROM
            serviceaddress As SA
             INNER JOIN
            address As A
              ON A.AddressID = SA.AddressID
             INNER JOIN
            postalcode As P
            ON A.PostalCodeID = P.PostalCodeID
        WHERE
            SA.UserID = @userID
            AND SA.PositionID = @PositionID
            AND JL.Active = 1
            AND P.countryID not in ('0','-1')
            AND JL.Required = @IsRequired
        GROUP BY
            P.countryID)
        
        -- Check StateProvince-level 
        DECLARE @stateProvinceLevel int
        SELECT
            @stateProvinceLevel = COUNT(*)
            FROM
                jobTitleLicense JL
                INNER JOIN
                StateProvince SP
                ON JL.stateProvinceID = SP.stateProvinceID
                LEFT JOIN
                userLicenseCertifications UL
                ON JL.LicenseCertificationID = UL.LicenseCertificationID
                AND UL.ProviderUserID = @userID
            WHERE
                JL.positionID = @PositionID
                AND SP.stateProvinceID in (SELECT
                P.stateProvinceID
            FROM
                serviceaddress As SA
                 INNER JOIN
                address As A
                  ON A.AddressID = SA.AddressID
                 INNER JOIN
                postalcode As P
                ON A.PostalCodeID = P.PostalCodeID
            WHERE
                SA.UserID = @userID
                AND SA.PositionID = @PositionID
                AND JL.Active = 1
                AND P.stateProvinceID not in ('0','-1')
                AND JL.Required = @IsRequired
            GROUP BY
                P.stateProvinceID)
                
        -- Check County-level
        DECLARE @countyLevel int
        SELECT
            @countyLevel = COUNT(*)
            FROM
                jobTitleLicense JL
                INNER JOIN
                county CT
                ON JL.countyID = CT.countyID
                LEFT JOIN
                userLicenseCertifications UL
                ON JL.LicenseCertificationID = UL.LicenseCertificationID
                AND UL.ProviderUserID = @userID
            WHERE
                JL.positionID = @PositionID
                AND CT.countyID in (SELECT
                P.countyID
            FROM
                serviceaddress As SA
                 INNER JOIN
                address As A
                  ON A.AddressID = SA.AddressID
                 INNER JOIN
                postalcode As P
                ON A.PostalCodeID = P.PostalCodeID
            WHERE
                SA.UserID = @userID
                AND SA.PositionID = @PositionID
                AND JL.Active = 1
                AND P.countyID not in ('0','-1')
                AND JL.Required = @IsRequired
            GROUP BY
                P.countyID)
                
        -- Check Municipal-level 
        DECLARE @municipalLevel int
        SELECT
            @municipalLevel = COUNT(*)
        FROM
            jobTitleLicense JL
            INNER JOIN
            municipality M
            ON JL.MunicipalityID = M.MunicipalityID
            LEFT JOIN
            userLicenseCertifications UL
            ON JL.LicenseCertificationID = UL.LicenseCertificationID
            AND UL.ProviderUserID = @userID
        WHERE
            JL.positionID = @PositionID
            AND M.MunicipalityID in (SELECT
            P.MunicipalityID
        FROM
            serviceaddress As SA
             INNER JOIN
            address As A
              ON A.AddressID = SA.AddressID
             INNER JOIN
            postalcode As P
            ON A.PostalCodeID = P.PostalCodeID
        WHERE
            SA.UserID = @userID
            AND SA.PositionID = @PositionID
            AND JL.Active = 1
            AND P.MunicipalityID not in ('0','-1')
            AND JL.Required = @IsRequired
        GROUP BY
            P.MunicipalityID)
                
        
        -- If there are no (required) licenses
        DECLARE @userLicensesOfEachOptionGroup int
        SELECT 
            @userLicensesOfEachOptionGroup =
            CASE 
                WHEN COUNT(DISTINCT OptionGroup) <= SUM(
                    CASE
                        WHEN numberVerified > 0 AND OptionGroup is NOT NULL
                        THEN 1
                        ELSE 0
                    END
                )
                THEN 1
                ELSE 0
            END
         FROM
            (
                SELECT
                    JL.OptionGroup
                    ,COUNT(DISTINCT(JL.licenseCertificationID)) as numberOfLicenseOptions
                    ,SUM(CASE WHEN UL.StatusID IN (1, 2, 3, 5, 6) THEN 1 ELSE 0 END) as numberVerified
                FROM
                    (
                        SELECT
                            JL.OptionGroup
                            ,JL.licenseCertificationID
                        FROM
                            JobTitleLicense JL
                        WHERE
                            JL.Required = @IsRequired
                            AND JL.PositionID = @PositionID
                            AND licenseCertificationID in
                            (
                                (
                                SELECT
                                    JL.licenseCertificationID
                                FROM
                                    jobTitleLicense JL
                                    INNER JOIN
                                    Country C
                                    ON JL.countryID = C.countryID
                                    LEFT JOIN
                                    userLicenseCertifications UL
                                    ON JL.LicenseCertificationID = UL.LicenseCertificationID
                                    AND UL.ProviderUserID = @userID
                                WHERE
                                    JL.positionID in (@PositionID, -1) 
                                    AND C.languageID = (SELECT PreferredLanguageID FROM users WHERE UserID = @userID)
                                    AND C.countryID in
                                    (
                                        SELECT
                                            P.countryID
                                        FROM
                                            serviceaddress As SA
                                             INNER JOIN
                                            address As A
                                              ON A.AddressID = SA.AddressID
                                             INNER JOIN
                                            postalcode As P
                                            ON A.PostalCodeID = P.PostalCodeID
                                        WHERE
                                            SA.UserID = @userID
                                            AND SA.PositionID = @PositionID
                                            AND JL.Active = 1
                                            AND P.countryID not in ('0','-1')
                                            AND JL.Required = @IsRequired
                                        GROUP BY
                                            P.countryID
                                    )
                                ) UNION (
                                SELECT
                                    JL.licenseCertificationID
                                FROM
                                    jobTitleLicense JL
                                    INNER JOIN
                                    StateProvince SP
                                    ON JL.stateProvinceID = SP.stateProvinceID
                                    LEFT JOIN
                                    userLicenseCertifications UL
                                    ON JL.LicenseCertificationID = UL.LicenseCertificationID
                                    AND UL.ProviderUserID = @userID
                                WHERE
                                    JL.positionID = @PositionID
                                    AND SP.stateProvinceID in
                                    (
                                        SELECT
                                            P.stateProvinceID
                                        FROM
                                            serviceaddress As SA
                                             INNER JOIN
                                            address As A
                                              ON A.AddressID = SA.AddressID
                                             INNER JOIN
                                            postalcode As P
                                            ON A.PostalCodeID = P.PostalCodeID
                                        WHERE
                                            SA.UserID = @userID
                                            AND SA.PositionID = @PositionID
                                            AND JL.Active = 1
                                            AND P.stateProvinceID not in ('0','-1')
                                            AND JL.Required = @IsRequired
                                        GROUP BY
                                            P.stateProvinceID
                                    )
                                ) UNION (
                                SELECT
                                    JL.licenseCertificationID
                                FROM
                                    jobTitleLicense JL
                                    INNER JOIN
                                    county CT
                                    ON JL.countyID = CT.countyID
                                    LEFT JOIN
                                    userLicenseCertifications UL
                                    ON JL.LicenseCertificationID = UL.LicenseCertificationID
                                    AND UL.ProviderUserID = @userID
                                WHERE
                                    JL.positionID = @PositionID
                                    AND JL.Active = 1
                                    AND JL.Required = @IsRequired
                                    AND CT.countyID in
                                    (
                                        SELECT
                                            P.countyID
                                        FROM
                                            serviceaddress As SA
                                             INNER JOIN
                                            address As A
                                              ON A.AddressID = SA.AddressID
                                             INNER JOIN
                                            postalcode As P
                                            ON A.PostalCodeID = P.PostalCodeID
                                        WHERE
                                            SA.UserID = @userID
                                            AND SA.PositionID = @PositionID
                                            AND P.countyID not in ('0','-1')
                                        GROUP BY
                                            P.countyID
                                    )
                                ) UNION (
                                SELECT
                                    JL.licenseCertificationID
                                FROM
                                    jobTitleLicense JL
                                    INNER JOIN
                                    municipality M
                                    ON JL.MunicipalityID = M.MunicipalityID
                                    LEFT JOIN
                                    userLicenseCertifications UL
                                    ON JL.LicenseCertificationID = UL.LicenseCertificationID
                                    AND UL.ProviderUserID = @userID
                                WHERE
                                    JL.positionID = @PositionID
                                    AND M.MunicipalityID in
                                    (
                                        SELECT
                                        P.MunicipalityID
                                        FROM
                                            serviceaddress As SA
                                             INNER JOIN
                                            address As A
                                              ON A.AddressID = SA.AddressID
                                             INNER JOIN
                                            postalcode As P
                                            ON A.PostalCodeID = P.PostalCodeID
                                        WHERE
                                            SA.UserID = @userID
                                            AND SA.PositionID = @PositionID
                                            AND JL.Active = 1
                                            AND P.MunicipalityID not in ('0','-1')
                                            AND JL.Required = @IsRequired
                                        GROUP BY
                                            P.MunicipalityID
                                    )
                                )
                            )
                        GROUP BY
                            JL.OptionGroup
                            ,JL.licenseCertificationID
                    ) as JL
                LEFT JOIN
                (
                    SELECT 
                        V.licenseCertificationID,
                        V.VerificationStatusID as statusID
                    FROM
                        userlicensecertifications As V
                    WHERE
                        V.ProviderUserID = @userID
                         AND
                        V.PositionID = @PositionID
                ) as UL
                ON
                    JL.LicenseCertificationID = UL.LicenseCertificationID
                GROUP BY OptionGroup
            ) as hasAllRequiredLicenses


        -- FINAL CHECK OF CONDITIONS
        IF (
            @alertAffectsUser = 0
             OR
            @userHasPosition = 0
             OR
            -- Has all required licenses
            (
                @countryLevel = 0
                 AND
                @stateProvinceLevel = 0
                 AND
                @countyLevel = 0
                 AND
                @municipalLevel = 0
            )
             OR
            -- There are no required licenses
            (
                -- User has almost one license of the required list of licenses (changed on 2013-03-26 issue #203)
                @userLicensesOfEachOptionGroup > 0
            )
        )
        BEGIN
            -- PASSED: disable alert
            EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 0
        END ELSE BEGIN
            -- NOT PASSED: active alert
            EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 1
        END
    END
    
    -- Test if user profile must be actived or not
    EXEC dbo.TestProfileActivation @UserID, @PositionID
    

END

GO
        
PRINT N'Creating [dbo].[TestAlertPublicBio]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'publicbio' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertPublicBio]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 9
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		EXISTS (
			SELECT UserID
			FROM Users
			WHERE UserID = @UserID
				AND dbo.fx_IfNW(PublicBio, null) is not null
				--AND GenderID > 0
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID
END
GO
        
PRINT N'Creating [dbo].[TestAlertReferenceRequests]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'referencerequests' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertReferenceRequests]
	@UserID int
	,@PositionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 14
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		-- Check that user has that position (this is a position related alert). If it has not (=0), alert will off because doesn't affect:
		(SELECT count(*) FROM userprofilepositions WHERE UserID=@UserID AND PositionID=@PositionID) = 0 OR
		EXISTS (
			SELECT	UserID
			FROM	UserVerification As UV
			WHERE	UV.UserID = @UserID
					 AND
					UV.VerificationID = 12 -- Reference(s) from former clients
				    -- Only 12, 11 is for 'Loconomics' user-reviewed' out of this alert.
					 AND
					UV.Active = 1
					 AND
					-- Check for verifications: 1:confirmed, 2:pending
					-- Pending is enough because means a request done by
					-- provider, and this alert is just for the request not
					-- require confirmations (but confirmation do the work, too)
					UV.VerificationStatusID IN (1, 2)
					 AND
					(
					 -- Its verification for this position..
					 UV.PositionID = @PositionID
					  OR
					 -- or is verification for 'any' position
					 UV.PositionID = 0
					)
					
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID, @PositionID
END
GO
        
PRINT N'Creating [dbo].[TestAlertShowcaseWork]...';
GO

-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'showcasework' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertShowcaseWork]
	@UserID int
	,@PositionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 17
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		-- Check that user has that position (this is a position related alert). If it has not (=0), alert will off because doesn't affect:
		(SELECT count(*) FROM userprofilepositions WHERE UserID=@UserID AND PositionID=@PositionID) = 0 OR
		EXISTS (SELECT ProviderServicePhotoID FROM ProviderServicePhoto
	WHERE UserID = @UserID
		AND PositionID = @PositionID
		-- Must be almost one photo with address, caption and must be primary photo (to avoid provider has photos but not one chosed as primary)
		AND dbo.fx_IfNW(PhotoAddress, null) is not null
		AND IsPrimaryPhoto = 1
		AND Active = 1
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID, @PositionID
END
GO
        
PRINT N'Creating [dbo].[TestAlertSocialMediaVerification]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'socialmediaverification' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertSocialMediaVerification]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 11
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		EXISTS (
			SELECT	UserID
			FROM	UserVerification As UV
					 INNER JOIN
					Verification As V
					  ON UV.VerificationID = V.VerificationID
			WHERE	UV.UserID = @UserID
					 AND
					V.VerificationCategoryID = 3
					 AND
					UV.Active = 1
					 AND
					V.Active = 1
					 AND
					UV.VerificationStatusID = 1 -- 1:confirmed
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID
END
GO
        
PRINT N'Creating [dbo].[TestAlertTaxDocs]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Test if the conditions for the
-- alert type 'taxdocs' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertTaxDocs]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 6
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		EXISTS (SELECT ProviderUserID FROM ProviderTaxForm
	WHERE ProviderUserID = @UserID
		AND dbo.fx_IfNW(FullName, null) is not null
		AND dbo.fx_IfNW(StreetApt, null) is not null
		AND dbo.fx_IfNW(City, null) is not null
		AND dbo.fx_IfNW(PostalCodeID, null) is not null
		AND dbo.fx_IfNW(StateProvinceID, null) is not null
		AND dbo.fx_IfNW(CountryID, null) is not null
		AND dbo.fx_IfNW([Signature], null) is not null
		AND dbo.fx_IfNW(TINTypeID, null) is not null
		AND dbo.fx_IfNW(DateTimeSubmitted, null) is not null
		AND dbo.fx_IfNW(LastThreeTINDigits, null) is not null
		AND (
		 TaxEntityTypeID = 1
		  OR
		 dbo.fx_IfNW(BusinessName, null) is not null
		)
		AND Active = 1
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID
END
GO
        
PRINT N'Creating [dbo].[TestAlertVerifyEmail]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-07-17
-- Description:	Test if the conditions for the
-- alert type 'verifyemail' are satisfied, 
-- updating user points and enabling or 
-- disabling it profile.
-- =============================================
CREATE PROCEDURE [dbo].[TestAlertVerifyEmail]
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AlertID int
	SET @AlertID = 15
    
    -- First ever check if this type of alert affects this type of user
    IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 0 OR
		EXISTS (SELECT UserID FROM webpages_Membership
	WHERE UserID = @UserID
		AND ConfirmationToken is null
		AND IsConfirmed = 1
	) BEGIN
		-- PASSED: disable alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 0
	END ELSE BEGIN
		-- NOT PASSED: active alert
		EXEC dbo.SetUserAlert @UserID, 0, @AlertID, 1
	END
	
	-- Test if user profile must be actived or not
	EXEC dbo.TestProfileActivation @UserID
END
GO
        
PRINT N'Creating [dbo].[TestAllUserAlerts]...';
GO

CREATE PROCEDURE [dbo].[TestAllUserAlerts] 
	@UserID int
	,@PositionID int = 0
AS
BEGIN
	
	
	SET NOCOUNT ON;
    EXEC TestAlertPersonalInfo				@UserID
    EXEC TestAlertPhoto						@UserID
    EXEC TestAlertPayment					@UserID
	
	EXEC TestAlertAvailability				@UserID
	EXEC TestAlertSocialMediaVerification	@UserID
	EXEC TestAlertBackgroundCheck			@UserID
	EXEC TestAlertBasicInfoVerification		@UserID	
	EXEC TestAlertVerifyEmail				@UserID
	EXEC TestAlertPublicBio					@UserID
	EXEC TestAlertEducation					@UserID
	
    IF @PositionID = 0 BEGIN
		DECLARE @cur CURSOR
		SET @cur = CURSOR FOR 
			SELECT DISTINCT
			 PositionID
			FROM
			 UserProfilePositions
			WHERE
		     UserID = @UserID
		     AND PositionID <> 0
			 
		OPEN @cur
		FETCH NEXT FROM @cur INTO @PositionID
		WHILE @@FETCH_STATUS = 0 BEGIN
			
			EXEC TestAlertPricingDetails		@UserID, @PositionID
			EXEC TestAlertPositionServices		@UserID, @PositionID
			EXEC TestAlertReferenceRequests		@UserID, @PositionID
			EXEC TestAlertProfessionalLicense	@UserID, @PositionID
			EXEC TestAlertLocation				@UserID, @PositionID
			EXEC TestAlertShowcaseWork			@UserID, @PositionID
			
			FETCH NEXT FROM @cur INTO @PositionID
		END
		CLOSE @cur
		DEALLOCATE @cur
    END ELSE BEGIN
		EXEC TestAlertPricingDetails		@UserID, @PositionID
		EXEC TestAlertPositionServices		@UserID, @PositionID
		EXEC TestAlertReferenceRequests		@UserID, @PositionID
		EXEC TestAlertProfessionalLicense	@UserID, @PositionID
		EXEC TestAlertLocation				@UserID, @PositionID
		EXEC TestAlertShowcaseWork			@UserID, @PositionID
    END
    
    EXEC TestProfileActivation @UserID, @PositionID
END
GO
        
PRINT N'Creating [dbo].[TestAllUsersAlerts]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description: Execute the TestAllUserAlerts
-- per ALL users on the database and all its
-- positions
-- CAREFUL: database performance can be affected
-- by this, use as an utility on testing or
-- special maintenance / update that can require
-- it.
-- =============================================
CREATE PROCEDURE [dbo].[TestAllUsersAlerts]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @UserID int
    DECLARE @cur CURSOR
    
	SET @cur = CURSOR FOR 
		SELECT UserID
		FROM Users
		WHERE Active = 1
		 
	OPEN @cur
	FETCH NEXT FROM @cur INTO @UserID
	WHILE @@FETCH_STATUS = 0 BEGIN
		-- Execute this same proc but for a concrete positionID
		EXEC TestAllUserAlerts @UserID
		
		FETCH NEXT FROM @cur INTO @UserID
	END
	CLOSE @cur
	DEALLOCATE @cur

END
GO
        
PRINT N'Creating [dbo].[TestProfileActivation]...';
GO
CREATE PROCEDURE [dbo].[TestProfileActivation]
	@UserID int,
	@PositionID int = 0
AS
BEGIN
	
	
	SET NOCOUNT ON;
    DECLARE @cur CURSOR
    
    IF @PositionID = 0 BEGIN
		SET @cur = CURSOR FOR 
			SELECT DISTINCT
			 PositionID
			FROM
			 UserProfilePositions
			WHERE
		     UserID = @UserID
		     AND PositionID <> 0
			 
		OPEN @cur
		FETCH NEXT FROM @cur INTO @PositionID
		WHILE @@FETCH_STATUS = 0 BEGIN
			
			EXEC TestProfileActivation @UserID, @PositionID
			
			FETCH NEXT FROM @cur INTO @PositionID
		END
		CLOSE @cur
		DEALLOCATE @cur
    END ELSE BEGIN

		-- StatusID (marketplaceReady and auto switch status)
		IF (SELECT TOP 1 StatusID FROM UserProfilePositions
			WHERE UserID = @UserID AND PositionID = @PositionID)
			IN (1, 2) -- Its a state for automatic activation
		BEGIN	
			
			UPDATE UserProfilePositions SET
				StatusID = 
				CASE WHEN (SELECT count(*)
					FROM UserAlert As UA
						 INNER JOIN
						Alert As A
						  ON UA.AlertID = A.AlertID
					WHERE UA.UserID = @UserID
							AND
						  (UA.PositionID = 0 OR UA.PositionID = @PositionID)
							AND
						  A.Required = 1
							AND
						  UA.Active = 1
				) = 0 THEN 1 
				ELSE 2 
				END,
				
				UpdatedDate = GETDATE(),
				ModifiedBy = 'sys'
			WHERE	
				UserID = @UserID AND PositionID = @PositionID
		END
		
		-- Flag BookMeButtonReady
		UPDATE UserProfilePositions SET
			bookMeButtonReady = 
			CASE WHEN (SELECT count(*)
				FROM UserAlert As UA
					 INNER JOIN
					Alert As A
					  ON UA.AlertID = A.AlertID
				WHERE UA.UserID = @UserID
						AND
					  (UA.PositionID = 0 OR UA.PositionID = @PositionID)
						AND
					  A.bookMeButtonRequired = 1
						AND
					  UA.Active = 1
			) = 0 THEN 1 
			ELSE 0 
			END,
			
			UpdatedDate = GETDATE(),
			ModifiedBy = 'sys'
		WHERE	
			UserID = @UserID AND PositionID = @PositionID
	END
END

GO
        
PRINT N'Creating [dbo].[UnDeleteUser]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-08-17
-- Description:	Restore a user account removed
-- throught the page /Account/$Delete/.
-- Of course, only restore from a 'weak delete'
-- =============================================
CREATE PROCEDURE UnDeleteUser
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE userprofile SET Email = substring(Email, len('DELETED:') + 2, len(Email) - len('DELETED: '))
    WHERE UserID = @UserID
    
    UPDATE users SET Active = 1, AccountStatusID = 1
    WHERE UserID = @UserID
END
GO
        
PRINT N'Creating [dbo].[ut_AutocheckReviewVerifications]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2013-07-15
-- Description:	Automatically checks the reviews
-- providers have from customers to enable or
-- disable the related user-verifications:
-- 11: loconomics user reviewed
-- 12: review from former client
-- =============================================
CREATE PROCEDURE ut_AutocheckReviewVerifications
AS BEGIN

	DECLARE @cur CURSOR
	DECLARE @UserID int, @PositionID int, @RevDate datetime
	
	----------------------------------
	-- Reviews
	
	SET @cur = CURSOR FOR
		SELECT	UserID, PositionID
		FROM	userprofilepositions
		WHERE	Active = 1

	OPEN @cur
	FETCH NEXT FROM @cur INTO @UserID, @PositionID
	WHILE @@FETCH_STATUS = 0 BEGIN

		-- Check 12: 'review from former client'
		SET @RevDate = null
		SELECT TOP 1 @RevDate = CreatedDate
		FROM UserReviews
		WHERE ProviderUserID = @UserID
			AND BookingID = 0
			AND PositionID = @PositionID

		IF @RevDate is not null
			-- There is reviews from former clients, verification confirmed
			EXEC SetUserVerification @UserID, 12, @RevDate, 1, @PositionID
		ELSE BEGIN
			-- Check if there is a verification already
			SET @RevDate = null
			SELECT TOP 1 @RevDate = CreatedDate
			FROM UserVerification
			WHERE	UserID = @UserID
					AND VerificationID = 12
					AND (PositionID = 0 OR PositionID = @PositionID)
			IF @RevDate is not null
				-- State: Pending, enough to off the provider-alert but not
				-- show the verification as done.
				-- Verification specific for the position
				EXEC SetUserVerification @UserID, 12, @RevDate, 2, @PositionID
		END

		-- Check 11: 'Loconomics user reviewed'
		SET @RevDate = null
		SELECT TOP 1 @RevDate = CreatedDate
		FROM UserReviews
		WHERE ProviderUserID = @UserID
			AND BookingID > 0
			AND PositionID = @PositionID

		IF @RevDate is not null
			EXEC SetUserVerification @UserID, 11, @RevDate, 1, @PositionID
		ELSE
			EXEC DelUserVerification @UserID, 11, @PositionID

		FETCH NEXT FROM @cur INTO @UserID, @PositionID
	END
	CLOSE @cur
	DEALLOCATE @cur

    -------------------------------
	-- Final check
	
	SET @cur = CURSOR FOR
		SELECT	UserID
		FROM	Users
		WHERE	Active = 1 AND IsProvider = 1
	
	OPEN @cur
	FETCH NEXT FROM @cur INTO @UserID
	WHILE @@FETCH_STATUS = 0 BEGIN

		-- Remove old user-verifications for 'loconomics reviews' without positionID,
		-- that doesn't work (and check was already done in previous loop)
		EXEC DelUserVerification @UserID, 11, 0

		-- Remove old user-verifications for 'former customers' without positionID,
		-- that doesn't work (and check was already done in previous loop)
		EXEC DelUserVerification @UserID, 12, 0

		FETCH NEXT FROM @cur INTO @UserID
	END
	CLOSE @cur
	DEALLOCATE @cur

END
GO
        
PRINT N'Creating [dbo].[ut_ModifyUserAlertsState]...';
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-08-18
-- Description:	Allow FORCE enable or disable all
-- the alerts affecting the user given for
-- the position given (or common profile if
-- zero), WITHOUT perform the alert 
-- tests/conditions (what can means data
-- corruption in some cases, waiting that some
-- things are complete because the alert is off
-- and they are not).
-- 
-- NOTE: Utility procedure, not to use
-- from the program, else as sysadmin, tester
-- or developer.
-- 
-- =============================================
CREATE PROCEDURE [dbo].[ut_ModifyUserAlertsState] 
	@UserID int
	,@PositionID int = 0
	,@StateActive bit = 1 -- 0 to disable all alerts
	,@TestProfileActivation bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @AlertID int
	DECLARE @PositionSpecific bit
    DECLARE @cur CURSOR
    
	SET @cur = CURSOR FOR 
		SELECT AlertID, PositionSpecific
		FROM Alert
		
	OPEN @cur
	FETCH NEXT FROM @cur INTO @AlertID, @PositionSpecific
	WHILE @@FETCH_STATUS = 0 BEGIN
	
		IF dbo.fxCheckAlertAffectsUser(@UserID, @AlertID) = 1 BEGIN
			IF @PositionSpecific = 1 BEGIN
				IF @PositionID > 0
					EXEC dbo.SetUserAlert @UserID, @PositionID, @AlertID, @StateActive
			END ELSE
				EXEC dbo.SetUserAlert @UserID, 0, @AlertID, @StateActive
		END

		FETCH NEXT FROM @cur INTO @AlertID, @PositionSpecific
	END
	CLOSE @cur
	DEALLOCATE @cur
    
    IF @TestProfileActivation = 1
		EXEC TestProfileActivation @UserID, @PositionID
END
GO
        
PRINT N'Creating [dbo].[ZZIsUserAProvider]...';
GO

CREATE PROC dbo.[ZZIsUserAProvider]

@UserID int

As

select 

count(*) As answer
from users a 
where
	a.UserID = @UserID
	 AND
	a.IsProvider = 1
GO
        
