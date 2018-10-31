USE [master]
GO
/****** Object:  Database [Dev]    Script Date: 10/1/18 8:41:34 PM ******/
CREATE DATABASE [Dev]
GO
ALTER DATABASE [Dev] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Dev].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Dev] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Dev] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Dev] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Dev] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Dev] SET ARITHABORT OFF 
GO
ALTER DATABASE [Dev] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Dev] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Dev] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Dev] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Dev] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Dev] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Dev] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Dev] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Dev] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Dev] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Dev] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Dev] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Dev] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Dev] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Dev] SET  MULTI_USER 
GO
ALTER DATABASE [Dev] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Dev] SET ENCRYPTION ON
GO
USE [Dev]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_concat]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[fx_concatBothOrNothing]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[fx_IfNW]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[fxCheckAlertAffectsUser]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[GetPositionString]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetPositionString] ( @UserID INT,@LangaugeID INT, @CountryID INT, @PositionCnt INT )

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
/****** Object:  UserDefinedFunction [dbo].[isMarketplacePaymentAccountActive]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2015-09-15
-- Description:	Checks if the payment account
-- to collect payments on the marketplace
-- bookings for a given userID is active.
-- =============================================
CREATE FUNCTION [dbo].[isMarketplacePaymentAccountActive]
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
/****** Object:  Table [dbo].[accountstatus]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[accountstatus](
	[AccountStatusID] [int] NOT NULL,
	[AccountStatusName] [varchar](25) NOT NULL,
	[AccountStatusDescription] [varchar](200) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[address]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[AddressTypeID] [int] NOT NULL,
	[AddressName] [varchar](50) NOT NULL,
	[AddressLine1] [varchar](100) NOT NULL,
	[AddressLine2] [varchar](100) NULL,
	[City] [varchar](100) NOT NULL,
	[StateProvinceID] [int] NOT NULL,
	[PostalCodeID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[GoogleMapsURL] [varchar](2073) NULL,
	[SpecialInstructions] [varchar](1000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [PK_address_1] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[addresstype]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[addresstype](
	[AddressTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[AddressType] [varchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[UniquePerUser] [bit] NOT NULL,
	[Selectable] [bit] NOT NULL,
 CONSTRAINT [PK__addresst__9E7638F92C88998B] PRIMARY KEY CLUSTERED 
(
	[AddressTypeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[alert]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alert](
	[AlertID] [int] NOT NULL,
	[AlertTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[AlertName] [varchar](30) NOT NULL,
	[AlertHeadlineDisplay] [varchar](100) NULL,
	[AlertTextDisplay] [varchar](300) NOT NULL,
	[AlertDescription] [varchar](500) NULL,
	[AlertEmailText] [varchar](25) NULL,
	[ProviderProfileCompletePoints] [int] NOT NULL,
	[CustomerProfileCompletePoints] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[AlertPageURL] [varchar](2000) NULL,
	[Required] [bit] NOT NULL,
	[PositionSpecific] [bit] NOT NULL,
	[DisplayRank] [int] NOT NULL,
	[ProviderAlert] [bit] NOT NULL,
	[CustomerAlert] [bit] NOT NULL,
	[bookMeButtonRequired] [bit] NOT NULL,
 CONSTRAINT [PK__alert__AAFF8BB7025D5595] PRIMARY KEY CLUSTERED 
(
	[AlertID] ASC,
	[AlertTypeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[alerttype]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alerttype](
	[AlertTypeID] [int] NOT NULL,
	[AlertTypeName] [varchar](200) NOT NULL,
	[AlertTypeDescription] [varchar](200) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[DisplayRank] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AlertTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[authorizations]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[authorizations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Token] [varchar](216) NOT NULL,
	[UserID] [int] NOT NULL,
	[Scope] [varchar](100) NOT NULL,
	[CreatedDate] [datetimeoffset](0) NOT NULL,
	[DeletedDate] [datetimeoffset](0) NULL,
	[ClientAddress] [varchar](64) NULL,
	[UserAgent] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[backgroundcheck]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[backgroundcheck](
	[BackgroundCheckID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[BackgroundCheckName] [varchar](100) NOT NULL,
	[BackgroundCheckDescription] [varchar](1000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[BackGroundCheckPrice] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[BackgroundCheckID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[booking]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[booking](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[ClientUserID] [int] NULL,
	[ServiceProfessionalUserID] [int] NULL,
	[JobTitleID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[BookingStatusID] [int] NOT NULL,
	[BookingTypeID] [int] NOT NULL,
	[CancellationPolicyID] [int] NOT NULL,
	[ParentBookingID] [int] NULL,
	[ServiceAddressID] [int] NULL,
	[ServiceDateID] [int] NULL,
	[AlternativeDate1ID] [int] NULL,
	[AlternativeDate2ID] [int] NULL,
	[PricingSummaryID] [int] NOT NULL,
	[PricingSummaryRevision] [int] NOT NULL,
	[PaymentTransactionID] [varchar](250) NULL,
	[PaymentLastFourCardNumberDigits] [varchar](64) NULL,
	[paymentMethodID] [varchar](250) NULL,
	[cancellationPaymentTransactionID] [varchar](250) NULL,
	[ClientPayment] [decimal](25, 2) NULL,
	[ServiceProfessionalPaid] [decimal](25, 2) NULL,
	[ServiceProfessionalPPFeePaid] [decimal](25, 2) NULL,
	[LoconomicsPaid] [decimal](25, 2) NULL,
	[LoconomicsPPFeePaid] [decimal](25, 2) NULL,
	[InstantBooking] [bit] NOT NULL,
	[FirstTimeBooking] [bit] NOT NULL,
	[SendReminder] [bit] NOT NULL,
	[SendPromotional] [bit] NOT NULL,
	[Recurrent] [bit] NOT NULL,
	[MultiSession] [bit] NOT NULL,
	[PricingAdjustmentApplied] [bit] NOT NULL,
	[PaymentEnabled] [bit] NOT NULL,
	[PaymentCollected] [bit] NOT NULL,
	[PaymentAuthorized] [bit] NOT NULL,
	[AwaitingResponseFromUserID] [int] NULL,
	[PricingAdjustmentRequested] [bit] NOT NULL,
	[SupportTicketNumber] [varchar](200) NULL,
	[MessagingLog] [nvarchar](400) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[SpecialRequests] [text] NULL,
	[PreNotesToClient] [text] NULL,
	[PostNotesToClient] [text] NULL,
	[PreNotesToSelf] [text] NULL,
	[PostNotesToSelf] [text] NULL,
 CONSTRAINT [PK__booking__bookingIDKey] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bookingStatus]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bookingStatus](
	[BookingStatusID] [int] NOT NULL,
	[BookingStatusName] [varchar](50) NOT NULL,
	[BookingStatusDescription] [varchar](500) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookingStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bookingType]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bookingType](
	[BookingTypeID] [int] NOT NULL,
	[BookingTypeName] [varchar](50) NOT NULL,
	[BookingTypeDescription] [varchar](500) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[FirstTimeServiceFeeFixed] [decimal](5, 2) NOT NULL,
	[FirstTimeServiceFeePercentage] [decimal](5, 2) NOT NULL,
	[PaymentProcessingFeePercentage] [decimal](5, 2) NOT NULL,
	[PaymentProcessingFeeFixed] [decimal](5, 2) NOT NULL,
	[FirstTimeServiceFeeMaximum] [decimal](5, 2) NOT NULL,
	[FirstTimeServiceFeeMinimum] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK__bookingt__649EC4B15090EFD7] PRIMARY KEY CLUSTERED 
(
	[BookingTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarAvailabilityType]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarAvailabilityType](
	[CalendarAvailabilityTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[CalendarAvailabilityTypeName] [nvarchar](50) NOT NULL,
	[CalendarAvailabilityTypeDescription] [nvarchar](300) NOT NULL,
	[UserDescription] [varchar](500) NULL,
	[AddAppointmentType] [bit] NOT NULL,
	[SelectableAs] [nvarchar](50) NULL,
 CONSTRAINT [PK_CalendarAvailabilityType_1] PRIMARY KEY CLUSTERED 
(
	[CalendarAvailabilityTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarEventComments]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarEventComments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEvent] [int] NOT NULL,
	[Comment] [nvarchar](max) NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarEventExceptionsPeriod]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarEventExceptionsPeriod](
	[IdException] [int] NOT NULL,
	[DateStart] [datetimeoffset](0) NOT NULL,
	[DateEnd] [datetimeoffset](0) NULL,
 CONSTRAINT [PK_CalendarEventExceptionsPeriod] PRIMARY KEY CLUSTERED 
(
	[IdException] ASC,
	[DateStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarEventExceptionsPeriodsList]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarEventExceptionsPeriodsList](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEvent] [int] NOT NULL,
 CONSTRAINT [PK_CalendarEventExceptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarEventRecurrencesPeriod]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarEventRecurrencesPeriod](
	[IdRecurrence] [int] NOT NULL,
	[DateStart] [datetimeoffset](0) NOT NULL,
	[DateEnd] [datetimeoffset](0) NULL,
 CONSTRAINT [PK_CalendarEventRecurrencesPeriod_1] PRIMARY KEY CLUSTERED 
(
	[IdRecurrence] ASC,
	[DateStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarEventRecurrencesPeriodList]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarEventRecurrencesPeriodList](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEvent] [int] NOT NULL,
 CONSTRAINT [PK_CalendarEventRecurrenceDates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarEvents]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarEvents](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[EventType] [int] NOT NULL,
	[Summary] [varchar](500) NULL,
	[StarTtime] [datetimeoffset](0) NULL,
	[EndTime] [datetimeoffset](0) NULL,
	[UID] [varchar](150) NULL,
	[CalendarAvailabilityTypeID] [int] NOT NULL,
	[Transparency] [bit] NOT NULL,
	[IsAllDay] [bit] NOT NULL,
	[StampTime] [datetimeoffset](0) NULL,
	[TimeZone] [nvarchar](100) NULL,
	[Priority] [int] NULL,
	[Location] [nvarchar](100) NULL,
	[UpdatedDate] [datetimeoffset](0) NULL,
	[CreatedDate] [datetimeoffset](0) NULL,
	[ModifyBy] [nvarchar](50) NULL,
	[Class] [nvarchar](50) NULL,
	[Organizer] [nvarchar](max) NULL,
	[Sequence] [int] NULL,
	[Geo] [nvarchar](100) NULL,
	[RecurrenceId] [datetimeoffset](0) NULL,
	[TimeBlock] [time](7) NULL,
	[DayofWeek] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[Deleted] [datetimeoffset](0) NULL,
 CONSTRAINT [PK_CalendarEvents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarEventsAttendees]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarEventsAttendees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEvent] [int] NOT NULL,
	[Attendee] [nvarchar](max) NULL,
	[Role] [nvarchar](50) NULL,
	[Uri] [nvarchar](200) NULL,
 CONSTRAINT [PK_CalendarEventsAttendees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarEventsContacts]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarEventsContacts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEvent] [int] NOT NULL,
	[Contact] [nvarchar](500) NULL,
 CONSTRAINT [PK_CalendarEventsContacts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarEventType]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarEventType](
	[EventTypeId] [int] NOT NULL,
	[EventType] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[DisplayName] [nvarchar](100) NULL,
 CONSTRAINT [PK_EventType] PRIMARY KEY CLUSTERED 
(
	[EventTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarProviderAttributes]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarProviderAttributes](
	[UserID] [int] NOT NULL,
	[AdvanceTime] [decimal](10, 2) NOT NULL,
	[MinTime] [decimal](10, 2) NOT NULL,
	[MaxTime] [decimal](10, 2) NOT NULL,
	[BetweenTime] [decimal](10, 2) NOT NULL,
	[UseCalendarProgram] [bit] NOT NULL,
	[CalendarType] [varchar](200) NULL,
	[CalendarURL] [varchar](500) NULL,
	[PrivateCalendarToken] [varchar](128) NULL,
	[IncrementsSizeInMinutes] [int] NOT NULL,
	[TimeZone] [varchar](50) NULL,
 CONSTRAINT [PK__Calendar__1788CCAC22B5168E] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarReccurrence]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarReccurrence](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [int] NULL,
	[Count] [int] NULL,
	[EvaluationMode] [nvarchar](50) NULL,
	[Frequency] [int] NULL,
	[Interval] [int] NULL,
	[RestristionType] [int] NULL,
	[Until] [datetimeoffset](0) NULL,
	[FirstDayOfWeek] [int] NULL,
 CONSTRAINT [PK_CalendarReccursive] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarReccurrenceFrequency]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarReccurrenceFrequency](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CalendarReccursiveID] [int] NULL,
	[ByDay] [bit] NULL,
	[ByHour] [bit] NULL,
	[ByMinute] [bit] NULL,
	[ByMonth] [bit] NULL,
	[ByMonthDay] [bit] NULL,
	[BySecond] [bit] NULL,
	[BySetPosition] [bit] NULL,
	[ByWeekNo] [bit] NULL,
	[ByYearDay] [bit] NULL,
	[ExtraValue] [int] NULL,
	[FrequencyDay] [int] NULL,
	[DayOfWeek] [int] NULL,
 CONSTRAINT [PK_CalendarRecurrence] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CalendarRecurrenceFrequencyTypes]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarRecurrenceFrequencyTypes](
	[ID] [int] NOT NULL,
	[FrequencyType] [nvarchar](30) NULL,
	[UnitPlural] [nvarchar](30) NULL,
 CONSTRAINT [PK_CalendarRecurrenceFrequencyTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cancellationpolicy]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cancellationpolicy](
	[CancellationPolicyID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[CancellationPolicyName] [varchar](50) NOT NULL,
	[CancellationPolicyDescription] [varchar](1000) NULL,
	[HoursRequired] [int] NULL,
	[CancellationFeeAfter] [decimal](5, 2) NULL,
	[CancellationFeeBefore] [decimal](5, 2) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK__cancella__4BAA8CCE7A0806B6] PRIMARY KEY CLUSTERED 
(
	[CancellationPolicyID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CCCUsers]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CCCUsers](
	[UserID] [int] NOT NULL,
	[InstitutionID] [int] NULL,
	[FieldOfStudyID] [int] NULL,
	[PlanExpirationDate] [datetime] NULL,
	[UserType] [varchar](25) NULL,
	[StudentID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[clienttype]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clienttype](
	[CllientTypeID] [int] NOT NULL,
	[ClientTypeName] [varchar](50) NOT NULL,
	[ClientTypeDescription] [varchar](500) NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CllientTypeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[country]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country](
	[CountryID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryName] [varchar](100) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
	[CountryCodeAlpha2] [char](2) NULL,
	[CountryCallingCode] [varchar](3) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](25) NULL,
	[Active] [bit] NOT NULL,
	[numcode] [int] NULL,
 CONSTRAINT [PK__country__BB42E5E768D28DBC] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC,
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[county]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[county](
	[CountyID] [int] NOT NULL,
	[CountyName] [varchar](100) NULL,
	[FIPSCode] [int] NULL,
	[StateProvinceID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CountyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExperienceLevel]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExperienceLevel](
	[ExperienceLevelID] [int] IDENTITY(1,1) NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[ExperienceLevelName] [varchar](140) NOT NULL,
	[ExperienceLevelDescription] [varchar](140) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
 CONSTRAINT [PK__Experien__2F4E34695728DECD] PRIMARY KEY CLUSTERED 
(
	[ExperienceLevelID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FieldOfStudy]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FieldOfStudy](
	[FieldOfStudyID] [int] IDENTITY(1,1) NOT NULL,
	[FieldOfStudyName] [varchar](50) NOT NULL,
	[CCCTOPCode] [int] NULL,
	[LanguageID] [int] NULL,
	[CountryID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[FieldOfStudyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[GenderID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[GenderSingular] [nvarchar](16) NOT NULL,
	[GenderPlural] [nvarchar](16) NOT NULL,
	[SubjectPronoun] [varchar](25) NULL,
	[ObjectPronoun] [varchar](25) NULL,
	[PossesivePronoun] [varchar](25) NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[institution]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[institution](
	[InstitutionID] [int] IDENTITY(1,1) NOT NULL,
	[DeptOfEdInstitutionID] [varchar](25) NULL,
	[InstitutionName] [varchar](200) NOT NULL,
	[InstitutionAddress] [varchar](200) NULL,
	[InstitutionCity] [varchar](100) NULL,
	[InstitutionState] [varchar](25) NULL,
	[StateProvinceID] [int] NULL,
	[InstitutionZip] [varchar](25) NULL,
	[InstitutionPhone] [varchar](25) NULL,
	[InstitutionOPEID] [varchar](25) NULL,
	[InstitutionIPEDSUnitID] [varchar](25) NULL,
	[InstitutionURL] [varchar](2083) NULL,
	[CountryID] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[SchoolID] [varchar](3) NULL,
	[DistrictName] [varchar](50) NULL,
	[DistrictID] [varchar](3) NULL,
 CONSTRAINT [PK__institut__8DF6B94D047AA831] PRIMARY KEY CLUSTERED 
(
	[InstitutionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jobTitleLicense]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobTitleLicense](
	[PositionID] [int] NOT NULL,
	[LicenseCertificationID] [int] NOT NULL,
	[StateProvinceID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Required] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[MunicipalityID] [int] NOT NULL,
	[CountyID] [int] NOT NULL,
	[OptionGroup] [varchar](100) NULL,
 CONSTRAINT [PK__jobTitle__5E077F7A5FC911C6] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC,
	[LicenseCertificationID] ASC,
	[StateProvinceID] ASC,
	[CountryID] ASC,
	[MunicipalityID] ASC,
	[CountyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobTitlePlatform]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobTitlePlatform](
	[JobTitleID] [int] NOT NULL,
	[PlatformID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[CreatedDate] [datetimeoffset](0) NOT NULL,
	[UpdatedDate] [datetimeoffset](0) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_JobTitlePlatform] PRIMARY KEY CLUSTERED 
(
	[JobTitleID] ASC,
	[PlatformID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobTitleSolution]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobTitleSolution](
	[JobTitleID] [int] NOT NULL,
	[SolutionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[DefaultSelected] [bit] NULL,
	[DisplayRank] [int] NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[UpdatedDate] [datetimeoffset](7) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[JobTitleID] ASC,
	[SolutionID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[language]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[language](
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[LanguageName] [varchar](50) NOT NULL,
	[Active] [bit] NULL,
	[LanguageCode] [varchar](2) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[languagelevel]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[languagelevel](
	[LanguageLevelID] [int] IDENTITY(1,1) NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[LanguageLevelName] [varchar](140) NOT NULL,
	[LanguageLevelDescription] [varchar](2000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
 CONSTRAINT [PK__language__F5325F2353584DE9] PRIMARY KEY CLUSTERED 
(
	[LanguageLevelID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[licensecertification]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[licensecertification](
	[LicenseCertificationID] [int] NOT NULL,
	[LicenseCertificationType] [varchar](100) NOT NULL,
	[LicenseCertificationTypeDescription] [varchar](4000) NULL,
	[LicenseCertificationAuthority] [varchar](500) NULL,
	[VerificationWebsiteURL] [varchar](2078) NULL,
	[HowToGetLicensedURL] [varchar](2078) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[LanguageID] [int] NOT NULL,
 CONSTRAINT [PK__licensec__65E993A46F0B5556] PRIMARY KEY CLUSTERED 
(
	[LicenseCertificationID] ASC,
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[ThreadID] [int] NOT NULL,
	[MessageTypeID] [int] NOT NULL,
	[AuxID] [int] NULL,
	[AuxT] [nvarchar](50) NULL,
	[BodyText] [varchar](4000) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NOT NULL,
	[SentByUserId] [int] NOT NULL,
 CONSTRAINT [PK_Messages_messageID] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messagethreadstatus]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[messagethreadstatus](
	[MessageThreadStatusID] [int] NOT NULL,
	[MessageThreadStatusName] [varchar](25) NOT NULL,
	[MessageThreadStatusDescription] [varchar](100) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[MessageStatusColor] [varchar](7) NOT NULL,
 CONSTRAINT [Pk_messagethreadstatus_0] PRIMARY KEY CLUSTERED 
(
	[MessageThreadStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Pk_messagethreadstatus] UNIQUE NONCLUSTERED 
(
	[MessageThreadStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messagetype]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[messagetype](
	[MessageTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[MessageTypeName] [varchar](50) NULL,
	[MessageTypeDescription] [varchar](200) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageTypeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Pk_messagetype] UNIQUE NONCLUSTERED 
(
	[MessageTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MessagingThreads]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessagingThreads](
	[ThreadID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerUserID] [int] NOT NULL,
	[ProviderUserID] [int] NOT NULL,
	[PositionID] [int] NULL,
	[MessageThreadStatusID] [int] NOT NULL,
	[Subject] [nvarchar](100) NULL,
	[LastMessageID] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Messagin__688356E41EC48A19] PRIMARY KEY CLUSTERED 
(
	[ThreadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[municipality]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[municipality](
	[MunicipalityID] [int] NOT NULL,
	[CountyID] [int] NOT NULL,
	[MunicipalityName] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MunicipalityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OwnerAcknowledgment]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnerAcknowledgment](
	[UserID] [int] NOT NULL,
	[DateAcknowledged] [datetimeoffset](7) NOT NULL,
	[AcknowledgedFromIP] [varchar](25) NOT NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[UpdatedDate] [datetimeoffset](7) NOT NULL,
	[DetectedIPs] [varchar](200) NOT NULL,
 CONSTRAINT [PK_OwnerAcknowledgment] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OwnerStatus]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnerStatus](
	[OwnserStatusID] [int] NOT NULL,
	[OwnerStatusName] [varchar](50) NOT NULL,
	[OwnerStatusDescription] [varchar](200) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
	[UpdatedBy] [varchar](3) NULL,
 CONSTRAINT [PK_OwnerStatus] PRIMARY KEY CLUSTERED 
(
	[OwnserStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OwnerStatusHistory]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnerStatusHistory](
	[UserID] [int] NOT NULL,
	[OwnerStatusChangedDate] [datetime] NOT NULL,
	[OwnerStatusID] [int] NOT NULL,
	[OwnerStatusChangedBy] [varchar](3) NOT NULL,
 CONSTRAINT [PK__OwnerSta__1788CCAC7F76C749] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[OwnerStatusChangedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Platform]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Platform](
	[PlatformID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[ShortDescription] [nvarchar](50) NOT NULL,
	[LongDescription] [text] NOT NULL,
	[FeesDescription] [text] NOT NULL,
	[PositiveAspects] [text] NOT NULL,
	[NegativeAspects] [text] NOT NULL,
	[Advice] [text] NOT NULL,
	[SignUpURL] [nvarchar](255) NOT NULL,
	[SignInURL] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[UpdatedDate] [datetimeoffset](0) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Platform] PRIMARY KEY CLUSTERED 
(
	[PlatformID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[positionbackgroundcheck]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[positionbackgroundcheck](
	[PositionID] [int] NOT NULL,
	[BackgroundCheckID] [varchar](25) NOT NULL,
	[StateProvinceID] [varchar](25) NOT NULL,
	[CountryID] [varchar](25) NOT NULL,
	[Required] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC,
	[BackgroundCheckID] ASC,
	[PositionID] ASC,
	[StateProvinceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[positionpricingtype]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[positionpricingtype](
	[PositionID] [int] NOT NULL,
	[PricingTypeID] [int] NOT NULL,
	[ClientTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC,
	[PricingTypeID] ASC,
	[ClientTypeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[positionratings]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[positionratings](
	[PositionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Rating1] [varchar](25) NOT NULL,
	[Rating2] [varchar](25) NOT NULL,
	[Rating3] [varchar](25) NOT NULL,
	[Rating4] [varchar](25) NULL,
	[Rating1FormDescription] [varchar](1000) NULL,
	[Rating2FormDescription] [varchar](1000) NULL,
	[Rating3FormDescription] [varchar](1000) NULL,
	[Rating4FormDescription] [varchar](1000) NULL,
	[Rating1ProfileDescription] [varchar](1000) NULL,
	[Rating2ProfileDescription] [varchar](1000) NULL,
	[Rating3ProfileDescription] [varchar](1000) NULL,
	[Rating4ProfileDescription] [varchar](1000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
 CONSTRAINT [PK__position__E3225E7D52EE3995] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC,
	[LanguageID] ASC,
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[positions]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[positions](
	[PositionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[PositionSingular] [varchar](250) NULL,
	[PositionPlural] [varchar](250) NULL,
	[Aliases] [varchar](200) NULL,
	[PositionDescription] [varchar](2000) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](2) NULL,
	[GovID] [varchar](20) NULL,
	[GovPosition] [varchar](200) NULL,
	[GovPositionDescription] [varchar](2000) NULL,
	[Active] [bit] NULL,
	[DisplayRank] [int] NULL,
	[PositionSearchDescription] [varchar](1000) NULL,
	[AttributesComplete] [bit] NOT NULL,
	[StarRatingsComplete] [bit] NOT NULL,
	[PricingTypeComplete] [bit] NOT NULL,
	[EnteredByUserID] [int] NULL,
	[Approved] [bit] NULL,
	[AddGratuity] [int] NOT NULL,
	[HIPAA] [bit] NOT NULL,
	[SendReviewReminderToClient] [bit] NOT NULL,
	[CanBeRemote] [bit] NOT NULL,
	[SuppressReviewOfClient] [bit] NOT NULL,
 CONSTRAINT [PK_positions_1] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[postalcode]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[postalcode](
	[PostalCodeID] [int] NOT NULL,
	[PostalCode] [varchar](25) NULL,
	[City] [varchar](250) NULL,
	[StateProvinceID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[StandardOffset] [decimal](18, 0) NULL,
	[DST] [bit] NULL,
	[Location] [varchar](250) NULL,
	[PostalCodeType] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](25) NULL,
	[MunicipalityID] [int] NOT NULL,
	[CountyID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PostalCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[postingTemplate]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[postingTemplate](
	[postingTemplateID] [int] NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[languageID] [int] NOT NULL,
	[countryID] [int] NOT NULL,
	[createdDate] [datetimeoffset](0) NOT NULL,
	[updatedDate] [datetimeoffset](0) NOT NULL,
	[modifiedBy] [nchar](5) NOT NULL,
 CONSTRAINT [PK_postingTemplate] PRIMARY KEY CLUSTERED 
(
	[postingTemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[postingTemplateQuestion]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[postingTemplateQuestion](
	[postingTemplateQuestionID] [int] IDENTITY(1,1) NOT NULL,
	[postingTemplateID] [int] NOT NULL,
	[questionID] [int] NOT NULL,
	[legend] [nvarchar](150) NOT NULL,
	[branchLogic] [text] NULL,
	[createdDate] [datetimeoffset](0) NOT NULL,
	[updatedDate] [datetimeoffset](0) NOT NULL,
	[modifiedby] [nchar](5) NOT NULL,
	[active] [tinyint] NOT NULL,
 CONSTRAINT [PK_postingTemplateQuestion] PRIMARY KEY CLUSTERED 
(
	[postingTemplateQuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricingGroups]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PricingGroups](
	[PricingGroupID] [int] NOT NULL,
	[InternalGroupName] [varchar](50) NOT NULL,
	[SelectionTitle] [varchar](100) NOT NULL,
	[SummaryTitle] [varchar](100) NOT NULL,
	[DynamicSummaryTitle] [varchar](100) NOT NULL,
	[LanguageID] [int] NULL,
	[CountryID] [int] NULL,
 CONSTRAINT [PK_PricingGroups] PRIMARY KEY CLUSTERED 
(
	[PricingGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pricingSummary]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pricingSummary](
	[PricingSummaryID] [int] NOT NULL,
	[PricingSummaryRevision] [int] NOT NULL,
	[ServiceDurationMinutes] [int] NULL,
	[FirstSessionDurationMinutes] [int] NULL,
	[SubtotalPrice] [decimal](7, 2) NULL,
	[ClientServiceFeePrice] [decimal](7, 2) NULL,
	[TotalPrice] [decimal](7, 2) NULL,
	[ServiceFeeAmount] [decimal](7, 2) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[CancellationDate] [datetime] NULL,
	[CancellationFeeCharged] [decimal](7, 2) NULL,
	[FirstTimeServiceFeeFixed] [decimal](5, 2) NOT NULL,
	[FirstTimeServiceFeePercentage] [decimal](5, 2) NOT NULL,
	[PaymentProcessingFeePercentage] [decimal](5, 2) NOT NULL,
	[PaymentProcessingFeeFixed] [decimal](5, 2) NOT NULL,
	[FirstTimeServiceFeeMaximum] [decimal](5, 2) NOT NULL,
	[FirstTimeServiceFeeMinimum] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK__pricinge__7F7D375D21D600EE] PRIMARY KEY CLUSTERED 
(
	[PricingSummaryID] ASC,
	[PricingSummaryRevision] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pricingSummaryDetail]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pricingSummaryDetail](
	[PricingSummaryID] [int] NOT NULL,
	[PricingSummaryRevision] [int] NOT NULL,
	[ServiceProfessionalServiceID] [int] NOT NULL,
	[ServiceProfessionalDataInput] [varchar](100) NULL,
	[ClientDataInput] [varchar](500) NULL,
	[HourlyPrice] [decimal](5, 2) NULL,
	[Price] [decimal](7, 2) NULL,
	[ServiceDurationMinutes] [int] NULL,
	[FirstSessionDurationMinutes] [int] NULL,
	[ServiceName] [varchar](50) NOT NULL,
	[ServiceDescription] [varchar](1000) NULL,
	[NumberOfSessions] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[IsRemoteService] [bit] NOT NULL,
 CONSTRAINT [PK_pricingestimatedetail_1] PRIMARY KEY CLUSTERED 
(
	[PricingSummaryID] ASC,
	[PricingSummaryRevision] ASC,
	[ServiceProfessionalServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pricingtype]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pricingtype](
	[PricingTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Description] [varchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
	[DisplayRank] [int] NOT NULL,
 CONSTRAINT [PK_pricingtype_PricingTypeID] PRIMARY KEY CLUSTERED 
(
	[PricingTypeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Pk_pricingtype] UNIQUE NONCLUSTERED 
(
	[PricingTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricingVariableDefinition]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PricingVariableDefinition](
	[PricingVariableID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[PricingTypeID] [int] NOT NULL,
	[InternalName] [varchar](60) NOT NULL,
	[IsProviderVariable] [bit] NOT NULL,
	[IsCustomerVariable] [bit] NOT NULL,
	[DataType] [varchar](50) NOT NULL,
	[VariableLabel] [nvarchar](100) NULL,
	[VariableLabelPopUp] [nvarchar](200) NULL,
	[VariableNameSingular] [nvarchar](60) NULL,
	[VariableNamePlural] [nvarchar](60) NULL,
	[NumberIncludedLabel] [nvarchar](100) NULL,
	[NumberIncludedLabelPopUp] [nvarchar](200) NULL,
	[HourlySurchargeLabel] [nvarchar](100) NULL,
	[MinNumberAllowedLabel] [nvarchar](100) NULL,
	[MinNumberAllowedLabelPopUp] [nvarchar](200) NULL,
	[MaxNumberAllowedLabel] [nvarchar](100) NULL,
	[MaxNumberAllowedLabelPopUp] [nvarchar](200) NULL,
	[CalculateWithVariableID] [int] NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[MinMaxValuesList] [nvarchar](max) NULL,
 CONSTRAINT [PK_PricingVariableDefinition] PRIMARY KEY CLUSTERED 
(
	[PricingVariableID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC,
	[PositionID] ASC,
	[PricingTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricingVariableValue]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PricingVariableValue](
	[PricingVariableID] [int] NOT NULL,
	[ProviderPackageID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[PricingEstimateID] [int] NOT NULL,
	[PricingEstimateRevision] [int] NOT NULL,
	[Value] [varchar](100) NOT NULL,
	[ProviderNumberIncluded] [decimal](7, 2) NULL,
	[ProviderMinNumberAllowed] [decimal](7, 2) NULL,
	[ProviderMaxNumberAllowed] [decimal](7, 2) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_PricingVariableValue] PRIMARY KEY CLUSTERED 
(
	[PricingVariableID] ASC,
	[ProviderPackageID] ASC,
	[UserID] ASC,
	[PricingEstimateID] ASC,
	[PricingEstimateRevision] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[providerpackage]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[providerpackage](
	[ProviderPackageID] [int] IDENTITY(1,1) NOT NULL,
	[PricingTypeID] [int] NOT NULL,
	[ProviderUserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[ProviderPackageName] [varchar](50) NOT NULL,
	[ProviderPackageDescription] [varchar](1000) NULL,
	[ProviderPackagePrice] [decimal](7, 2) NULL,
	[ProviderPackageServiceDuration] [int] NOT NULL,
	[FirstTimeClientsOnly] [bit] NOT NULL,
	[NumberOfSessions] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[IsAddOn] [bit] NOT NULL,
	[PriceRate] [decimal](7, 2) NULL,
	[PriceRateUnit] [nvarchar](30) NULL,
	[IsPhone] [bit] NOT NULL,
	[VisibleToClientID] [int] NOT NULL,
	[SolutionID] [int] NOT NULL,
 CONSTRAINT [PK_providerpackage] PRIMARY KEY CLUSTERED 
(
	[ProviderPackageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[providerpackagedetail]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[providerpackagedetail](
	[ProviderPackageID] [int] NOT NULL,
	[ServiceAttributeID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_providerpackagedetail] PRIMARY KEY CLUSTERED 
(
	[ProviderPackageID] ASC,
	[ServiceAttributeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProviderPaymentAccount]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProviderPaymentAccount](
	[ProviderUserID] [int] NOT NULL,
	[MerchantAccountID] [nvarchar](100) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Message] [nvarchar](400) NULL,
	[bt_signature] [nvarchar](max) NULL,
	[bt_payload] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
 CONSTRAINT [PK_ProviderPaymentAccount] PRIMARY KEY CLUSTERED 
(
	[ProviderUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[providerpaymentpreference]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[providerpaymentpreference](
	[ProviderUserID] [int] NOT NULL,
	[ProviderPaymentPreferenceTypeID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[Modifiedby] [varchar](25) NOT NULL,
	[Verified] [bit] NOT NULL,
	[AccountName] [varchar](100) NULL,
	[ABANumber] [numeric](9, 0) NULL,
	[LastThreeAccountDigits] [varchar](64) NULL,
 CONSTRAINT [PK_providerpaymentpreference] PRIMARY KEY CLUSTERED 
(
	[ProviderUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[providerpaymentpreferencetype]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[providerpaymentpreferencetype](
	[ProviderPaymentPreferenceTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[ProviderPaymentPreferenceTypeName] [varchar](50) NOT NULL,
	[ProviderPaymentPreferenceTypeDescription] [varchar](300) NULL,
	[DependsOnID] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK__provider__A7C3000A031C6FA4] PRIMARY KEY CLUSTERED 
(
	[ProviderPaymentPreferenceTypeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[providerservicephoto]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[providerservicephoto](
	[ProviderServicePhotoID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[PhotoCaption] [varchar](150) NULL,
	[PhotoAddress] [varchar](2073) NOT NULL,
	[RankPosition] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[IsPrimaryPhoto] [bit] NOT NULL,
 CONSTRAINT [PK__servicep__D5090DBE39E294A9] PRIMARY KEY CLUSTERED 
(
	[ProviderServicePhotoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[providertaxform]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[providertaxform](
	[ProviderUserID] [int] NOT NULL,
	[FullName] [varchar](200) NOT NULL,
	[BusinessName] [varchar](200) NULL,
	[StreetApt] [varchar](100) NOT NULL,
	[City] [varchar](100) NOT NULL,
	[PostalCodeID] [int] NULL,
	[StateProvinceID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[TaxEntityTypeID] [int] NOT NULL,
	[ExemptPayee] [bit] NOT NULL,
	[TINTypeID] [varchar](25) NOT NULL,
	[Signature] [varchar](200) NOT NULL,
	[UserIPAddress] [varchar](500) NOT NULL,
	[DateTimeSubmitted] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NULL,
	[Active] [bit] NOT NULL,
	[LastThreeTINDigits] [varchar](64) NULL,
 CONSTRAINT [PK_providertaxform] PRIMARY KEY CLUSTERED 
(
	[ProviderUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question](
	[questionID] [int] NOT NULL,
	[questionTypeID] [int] NOT NULL,
	[question] [nvarchar](120) NOT NULL,
	[helpBlock] [nvarchar](300) NULL,
	[options] [text] NOT NULL,
	[languageID] [int] NOT NULL,
	[countryID] [int] NOT NULL,
	[createdDate] [datetimeoffset](0) NOT NULL,
	[updatedDate] [datetimeoffset](0) NOT NULL,
	[modifiedBy] [nvarchar](10) NOT NULL,
	[label] [nvarchar](120) NOT NULL,
 CONSTRAINT [PK_question] PRIMARY KEY CLUSTERED 
(
	[questionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[questionType]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[questionType](
	[questionTypeID] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NOT NULL,
	[createdDate] [datetimeoffset](0) NOT NULL,
	[updatedDate] [datetimeoffset](0) NOT NULL,
	[modifiedBy] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_questionType] PRIMARY KEY CLUSTERED 
(
	[questionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReferralSource]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferralSource](
	[ReferralSourceID] [int] NOT NULL,
	[Name] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK_ReferralSource] PRIMARY KEY CLUSTERED 
(
	[ReferralSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchCategory]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchCategory](
	[SearchCategoryID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[ShortDescription] [nvarchar](100) NULL,
	[LongDescription] [nvarchar](300) NULL,
	[SmallImage] [nvarchar](255) NULL,
	[BannerImage] [nvarchar](255) NULL,
	[DisplayRank] [int] NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[UpdatedDate] [datetimeoffset](7) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SearchCategoryID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchSubCategory]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchSubCategory](
	[SearchSubCategoryID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[SearchCategoryID] [int] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Image] [nvarchar](255) NULL,
	[DisplayRank] [int] NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[UpdatedDate] [datetimeoffset](7) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SearchSubCategoryID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchSubCategorySolution]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchSubCategorySolution](
	[SearchSubCategoryID] [int] NOT NULL,
	[SolutionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[DisplayRank] [int] NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[UpdatedDate] [datetimeoffset](7) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SearchSubCategoryID] ASC,
	[SolutionID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[serviceaddress]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[serviceaddress](
	[AddressID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[ServicesPerformedAtLocation] [bit] NOT NULL,
	[TravelFromLocation] [bit] NOT NULL,
	[ServiceRadiusFromLocation] [varchar](25) NULL,
	[TransportType] [int] NULL,
	[PreferredAddress] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK__servicea__8F1793BE58DC1D15] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC,
	[UserID] ASC,
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[serviceattribute]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[serviceattribute](
	[ServiceAttributeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[SourceID] [int] NULL,
	[Name] [varchar](100) NULL,
	[ServiceAttributeDescription] [varchar](2000) NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](45) NULL,
	[Active] [bit] NULL,
	[DisplayRank] [int] NOT NULL,
	[PositionReference] [int] NULL,
	[EnteredByUserID] [int] NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_serviceattribute] PRIMARY KEY CLUSTERED 
(
	[ServiceAttributeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[serviceattributecategory]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[serviceattributecategory](
	[ServiceAttributeCategoryID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[ServiceAttributeCategory] [varchar](200) NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[Active] [bit] NULL,
	[SourceID] [int] NULL,
	[PricingOptionCategory] [bit] NULL,
	[ServiceAttributeCategoryDescription] [varchar](500) NULL,
	[RequiredInput] [bit] NOT NULL,
	[SideBarCategory] [bit] NOT NULL,
	[EligibleForPackages] [bit] NOT NULL,
	[DisplayRank] [int] NOT NULL,
	[PositionReference] [int] NULL,
	[BookingPathSelection] [bit] NOT NULL,
 CONSTRAINT [PK_serviceattributecategory] PRIMARY KEY CLUSTERED 
(
	[ServiceAttributeCategoryID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceAttributeExperienceLevel]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceAttributeExperienceLevel](
	[UserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[ExperienceLevelID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
 CONSTRAINT [PK_ServiceAttributeExperienceLevel_1] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[PositionID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceAttributeLanguageLevel]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceAttributeLanguageLevel](
	[UserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[ServiceAttributeID] [int] NOT NULL,
	[LanguageLevelID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
 CONSTRAINT [PK_ServiceAttributeLanguageLevel] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[PositionID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC,
	[ServiceAttributeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[servicecategory]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[servicecategory](
	[ServiceCategoryID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Name] [varchar](45) NULL,
	[Description] [varchar](350) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](2) NULL,
	[Active] [bit] NULL,
	[ImagePath] [varchar](200) NULL,
	[headline] [varchar](250) NULL,
 CONSTRAINT [PK_servicecategory] PRIMARY KEY CLUSTERED 
(
	[ServiceCategoryID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[servicecategoryposition]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[servicecategoryposition](
	[ServiceCategoryID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Rank] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceCategoryID] ASC,
	[PositionID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[servicecategorypositionattribute]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[servicecategorypositionattribute](
	[PositionID] [int] NOT NULL,
	[ServiceAttributeCategoryID] [int] NOT NULL,
	[ServiceAttributeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NOT NULL,
	[Active] [bit] NOT NULL,
	[EnteredByUserID] [int] NULL,
	[Approved] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC,
	[ServiceAttributeCategoryID] ASC,
	[ServiceAttributeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceProfessionalClient]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceProfessionalClient](
	[ServiceProfessionalUserID] [int] NOT NULL,
	[ClientUserID] [int] NOT NULL,
	[NotesAboutClient] [ntext] NOT NULL,
	[ReferralSourceID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedByBookingID] [int] NULL,
	[DeletedByServiceProfessional] [bit] NOT NULL,
 CONSTRAINT [PK_ProviderCustomer] PRIMARY KEY CLUSTERED 
(
	[ServiceProfessionalUserID] ASC,
	[ClientUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[servicesubcategory]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[servicesubcategory](
	[ServiceSubCategoryID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Name] [varchar](45) NULL,
	[Description] [varchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](2) NULL,
	[Active] [bit] NULL,
	[ServiceCategoryID] [int] NULL,
	[Rank] [int] NULL,
	[RankQuery] [varchar](200) NULL,
 CONSTRAINT [PK_servicesubcategory] PRIMARY KEY CLUSTERED 
(
	[ServiceSubCategoryID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Solution]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solution](
	[SolutionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CredentialCheckRequired] [bit] NOT NULL,
	[BackgroundCheckRequired] [bit] NOT NULL,
	[IsHIPAA] [bit] NOT NULL,
	[TaxActivityID] [int] NULL,
	[PostingTemplateID] [int] NULL,
	[Image] [nvarchar](255) NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[UpdatedDate] [datetimeoffset](7) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SolutionID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specialization]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specialization](
	[SpecializationID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[SolutionID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DisplayRank] [int] NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[UpdatedDate] [datetimeoffset](7) NOT NULL,
	[CreatedBy] [nvarchar](12) NOT NULL,
	[Approved] [bit] NULL,
	[Active] [bit] NOT NULL,
	[EnteredByUserID] [int] NULL,
 CONSTRAINT [PK_Specialization] PRIMARY KEY CLUSTERED 
(
	[SpecializationID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stateprovince]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stateprovince](
	[StateProvinceID] [int] NOT NULL,
	[StateProvinceName] [varchar](100) NULL,
	[StateProvinceCode] [varchar](25) NULL,
	[CountryID] [int] NOT NULL,
	[RegionCode] [varchar](25) NULL,
	[PostalCodePrefix] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[StateProvinceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[taxentitytype]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[taxentitytype](
	[TaxEntityTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[TaxEntityTypeName] [varchar](75) NULL,
	[TaxEntityTypeDescription] [varchar](300) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TaxEntityTypeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tintype]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tintype](
	[TINTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[TINTypeAbbr] [nvarchar](10) NOT NULL,
	[TINTypeName] [nvarchar](70) NOT NULL,
	[TINTypeDescription] [nvarchar](200) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK__tintype__5B7925DB119F9925] PRIMARY KEY CLUSTERED 
(
	[TINTypeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tmp_users]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tmp_users](
	[UserID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[MiddleIn] [varchar](1) NOT NULL,
	[LastName] [varchar](145) NOT NULL,
	[SecondLastName] [varchar](145) NOT NULL,
	[NickName] [varchar](50) NULL,
	[PublicBio] [varchar](4000) NULL,
	[GenderID] [int] NOT NULL,
	[PreferredLanguageID] [int] NULL,
	[PreferredCountryID] [int] NULL,
	[IsProvider] [bit] NOT NULL,
	[IsCustomer] [bit] NOT NULL,
	[IsMember] [bit] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsContributor] [bit] NOT NULL,
	[IsCollaborator] [bit] NOT NULL,
	[Photo] [varchar](150) NULL,
	[MobilePhone] [varchar](20) NULL,
	[AlternatePhone] [varchar](20) NULL,
	[CanReceiveSms] [bit] NOT NULL,
	[ProviderProfileURL] [varchar](2078) NULL,
	[ProviderWebsiteURL] [varchar](2078) NULL,
	[SMSBookingCommunication] [bit] NOT NULL,
	[PhoneBookingCommunication] [bit] NOT NULL,
	[LoconomicsMarketingCampaigns] [bit] NOT NULL,
	[ProfileSEOPermission] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Active] [bit] NULL,
	[LoconomicsCommunityCommunication] [bit] NOT NULL,
	[IAuthZumigoVerification] [bit] NULL,
	[IAuthZumigoLocation] [bit] NULL,
	[LoconomicsDBMCampaigns] [bit] NOT NULL,
	[AccountStatusID] [int] NOT NULL,
	[CoBrandedPartnerPermissions] [bit] NOT NULL,
	[MarketingSource] [varchar](2055) NULL,
	[BookCode] [varchar](64) NULL,
	[OnboardingStep] [varchar](60) NULL,
	[BirthMonthDay] [int] NULL,
	[BirthMonth] [int] NULL,
	[BusinessName] [nvarchar](145) NULL,
	[AlternativeEmail] [nvarchar](56) NULL,
	[ReferredByUserID] [int] NULL,
	[SignupDevice] [nvarchar](20) NULL,
	[OwnerStatusID] [int] NULL,
	[OwnerAnniversaryDate] [datetime] NULL,
	[IsHipaaAdmin] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transporttype]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transporttype](
	[TransportTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[TransportTypeName] [varchar](50) NOT NULL,
	[TransportTypeDescription] [varchar](300) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TransportTypeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAlert]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAlert](
	[UserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[AlertID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[CompletedDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[AlertQuery] [varchar](1000) NULL,
	[Dismissed] [bit] NOT NULL,
 CONSTRAINT [PK__provider__D933DA027BB05806] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[PositionID] ASC,
	[AlertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userbackgroundcheck]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userbackgroundcheck](
	[UserID] [int] NOT NULL,
	[BackgroundCheckID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[StatusID] [int] NOT NULL,
	[Summary] [varchar](200) NULL,
	[VerifiedBy] [varchar](25) NULL,
	[LastVerifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BackgroundCheckID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserBadge]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserBadge](
	[UserBadgeID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[SolutionID] [int] NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[BadgeURL] [nvarchar](255) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[ExpiryDate] [datetimeoffset](0) NULL,
	[CreatedDate] [datetimeoffset](0) NOT NULL,
	[UpdatedDate] [datetimeoffset](0) NOT NULL,
	[CreatedBy] [nvarchar](4) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_UserBadge] PRIMARY KEY CLUSTERED 
(
	[UserBadgeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserEarnings]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserEarnings](
	[UserEarningsID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[PlatformID] [int] NOT NULL,
	[ClientID] [int] NOT NULL,
	[JobTitleID] [int] NOT NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[Minutes] [int] NOT NULL,
	[PaidDate] [datetimeoffset](0) NOT NULL,
	[Notes] [text] NOT NULL,
	[CreatedDate] [datetimeoffset](0) NOT NULL,
	[UpdatedDate] [datetimeoffset](0) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_UserEarnings] PRIMARY KEY CLUSTERED 
(
	[UserEarningsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserEarningsEntry]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserEarningsEntry](
	[UserID] [int] NOT NULL,
	[EarningsEntryID] [int] NOT NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[PaidDate] [datetimeoffset](0) NOT NULL,
	[DurationMinutes] [int] NOT NULL,
	[UserExternalListingID] [int] NOT NULL,
	[JobTitleID] [int] NOT NULL,
	[ClientUserID] [int] NULL,
	[CreatedDate] [datetimeoffset](0) NOT NULL,
	[UpdatedDate] [datetimeoffset](7) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
	[Notes] [text] NULL,
 CONSTRAINT [PK_UserEarningsEntry] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[EarningsEntryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usereducation]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usereducation](
	[UserEducationID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[InstitutionID] [int] NOT NULL,
	[DegreeCertificate] [varchar](200) NOT NULL,
	[FieldOfStudy] [varchar](200) NOT NULL,
	[FromYearAttended] [numeric](4, 0) NULL,
	[ToYearAttended] [numeric](4, 0) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[VerifiedDate] [datetime] NULL,
	[VerifiedBy] [varchar](25) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK__usereduc__A31C69552A363CC5] PRIMARY KEY CLUSTERED 
(
	[UserEducationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserExternalListing]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserExternalListing](
	[UserExternalListingID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[PlatformID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[JobTitles] [text] NOT NULL,
	[Notes] [text] NOT NULL,
	[CreatedDate] [datetimeoffset](0) NOT NULL,
	[UpdatedDate] [datetimeoffset](0) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_UserExternalListing] PRIMARY KEY CLUSTERED 
(
	[UserExternalListingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserFeePayments]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFeePayments](
	[UserFeePaymentID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[PaymentTransactionID] [varchar](250) NOT NULL,
	[SubscriptionID] [varchar](250) NOT NULL,
	[PaymentDate] [datetimeoffset](0) NOT NULL,
	[PaymentAmount] [money] NOT NULL,
	[PaymentPlan] [varchar](25) NOT NULL,
	[PaymentMethod] [varchar](50) NOT NULL,
	[PaymentStatus] [varchar](50) NOT NULL,
	[CreatedDate] [datetimeoffset](0) NOT NULL,
	[ModifiedDate] [datetimeoffset](0) NOT NULL,
 CONSTRAINT [PK__UserFeeP__1788CCAC0347582D] PRIMARY KEY CLUSTERED 
(
	[UserFeePaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLicenseCertifications]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLicenseCertifications](
	[userLicenseCertificationID] [int] IDENTITY(1,1) NOT NULL,
	[ProviderUserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[LicenseCertificationID] [int] NOT NULL,
	[VerificationStatusID] [int] NOT NULL,
	[LicenseCertificationURL] [varchar](2073) NULL,
	[LastName] [varchar](100) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[MiddleInitial] [varchar](1) NULL,
	[SecondLastName] [varchar](100) NULL,
	[BusinessName] [varchar](200) NULL,
	[LicenseCertificationNumber] [varchar](100) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NULL,
	[IssueDate] [datetime] NULL,
	[Comments] [varchar](500) NULL,
	[VerifiedBy] [varchar](25) NULL,
	[LastVerifiedDate] [datetime] NULL,
	[SubmittedBy] [varchar](25) NULL,
	[SubmittedImageLocalURL] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[userLicenseCertificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserListingSpecialization]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserListingSpecialization](
	[UserID] [int] NOT NULL,
	[UserListingID] [int] NOT NULL,
	[SpecializationID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[DisplayRank] [int] NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[UpdatedDate] [datetimeoffset](7) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[UserListingID] ASC,
	[SpecializationID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userOrganization]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userOrganization](
	[userID] [int] NOT NULL,
	[orgName] [nvarchar](200) NOT NULL,
	[orgDescription] [nvarchar](400) NULL,
	[orgWebsite] [nvarchar](255) NULL,
	[updatedDate] [datetimeoffset](0) NULL,
 CONSTRAINT [PK_userOrganization] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPaymentPlan]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPaymentPlan](
	[UserPaymentPlanID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[SubscriptionID] [varchar](250) NOT NULL,
	[PaymentPlan] [varchar](25) NOT NULL,
	[PaymentMethod] [varchar](50) NOT NULL,
	[PaymentPlanLastChangedDate] [datetimeoffset](0) NOT NULL,
	[NextPaymentDueDate] [datetimeoffset](0) NULL,
	[NextPaymentAmount] [money] NULL,
	[FirstBillingDate] [datetimeoffset](0) NOT NULL,
	[SubscriptionEndDate] [datetimeoffset](0) NULL,
	[PaymentMethodToken] [varchar](250) NOT NULL,
	[PaymentExpiryDate] [datetimeoffset](0) NULL,
	[PlanStatus] [varchar](50) NOT NULL,
	[DaysPastDue] [int] NOT NULL,
 CONSTRAINT [PK__Owner__1788CCAC6A7BAA63] PRIMARY KEY CLUSTERED 
(
	[UserPaymentPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPosting]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPosting](
	[userPostingID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[solutionID] [int] NOT NULL,
	[postingTemplateID] [int] NULL,
	[title] [nvarchar](50) NOT NULL,
	[statusID] [int] NOT NULL,
	[neededSpecializationIDs] [varchar](300) NULL,
	[desiredSpecializationIDs] [varchar](300) NULL,
	[languageID] [int] NOT NULL,
	[countryID] [int] NOT NULL,
	[createdDate] [datetimeoffset](0) NOT NULL,
	[updatedDate] [datetimeoffset](0) NOT NULL,
	[modifiedBy] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_UserPosting] PRIMARY KEY CLUSTERED 
(
	[userPostingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPostingQuestionResponse]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPostingQuestionResponse](
	[userPostingID] [int] NOT NULL,
	[questionID] [int] NOT NULL,
	[questionTypeID] [int] NOT NULL,
	[question] [nvarchar](120) NOT NULL,
	[helpBlock] [nvarchar](300) NULL,
	[options] [text] NOT NULL,
	[responses] [text] NOT NULL,
	[legend] [nvarchar](60) NOT NULL,
	[branchLogic] [text] NULL,
	[label] [nvarchar](120) NOT NULL,
 CONSTRAINT [PK_UserPostingQuestionResponse_1] PRIMARY KEY CLUSTERED 
(
	[userPostingID] ASC,
	[questionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPostingReaction]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPostingReaction](
	[userPostingID] [int] NOT NULL,
	[serviceProfessionalUserID] [int] NOT NULL,
	[reactionTypeID] [int] NOT NULL,
	[createdDate] [datetimeoffset](0) NOT NULL,
	[updatedDate] [datetimeoffset](0) NOT NULL,
	[message] [text] NULL,
 CONSTRAINT [PK_UserPostingReaction] PRIMARY KEY CLUSTERED 
(
	[userPostingID] ASC,
	[serviceProfessionalUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userprofile]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userprofile](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](254) NOT NULL,
 CONSTRAINT [PK__userprof__1788CC4C023D5A04] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__userprof__C9F284560519C6AF] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userprofilepositions]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userprofilepositions](
	[UserListingID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](3) NULL,
	[Active] [bit] NULL,
	[PositionIntro] [varchar](2000) NULL,
	[StatusID] [int] NOT NULL,
	[CancellationPolicyID] [int] NULL,
	[InstantBooking] [bit] NOT NULL,
	[bookMeButtonReady] [bit] NOT NULL,
	[collectPaymentAtBookMeButton] [bit] NOT NULL,
	[Title] [nvarchar](50) NULL,
 CONSTRAINT [PK_userprofilepositions] PRIMARY KEY CLUSTERED 
(
	[UserListingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userprofileserviceattributes]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userprofileserviceattributes](
	[UserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[ServiceAttributeCategoryID] [int] NOT NULL,
	[ServiceAttributeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](3) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_userprofileserviceattributes_2] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[PositionID] ASC,
	[ServiceAttributeCategoryID] ASC,
	[ServiceAttributeID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserReviews]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserReviews](
	[BookingID] [int] NOT NULL,
	[CustomerUserID] [int] NOT NULL,
	[ProviderUserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[PrivateReview] [nvarchar](1000) NULL,
	[PublicReview] [nvarchar](500) NULL,
	[Rating1] [tinyint] NULL,
	[Rating2] [tinyint] NULL,
	[Rating3] [tinyint] NULL,
	[Rating4] [tinyint] NULL,
	[Answer1] [bit] NULL,
	[Answer2] [bit] NULL,
	[Answer1Comment] [nvarchar](1000) NULL,
	[Answer2Comment] [nvarchar](1000) NULL,
	[ServiceHours] [decimal](18, 5) NULL,
	[HelpfulReviewCount] [bigint] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_UserReviews] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC,
	[CustomerUserID] ASC,
	[ProviderUserID] ASC,
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserReviewScores]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserReviewScores](
	[UserID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[TotalRatings] [bigint] NULL,
	[Rating1] [decimal](18, 2) NULL,
	[Rating2] [decimal](18, 2) NULL,
	[Rating3] [decimal](18, 2) NULL,
	[Rating4] [decimal](18, 2) NULL,
	[Answer1] [bigint] NULL,
	[Answer2] [bigint] NULL,
	[ServiceHours] [decimal](18, 2) NULL,
	[LastRatingDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ReviewScores_positionID_userID] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[UserID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[MiddleIn] [varchar](1) NOT NULL,
	[LastName] [varchar](145) NOT NULL,
	[SecondLastName] [varchar](145) NOT NULL,
	[NickName] [varchar](50) NULL,
	[PublicBio] [varchar](4000) NULL,
	[GenderID] [int] NOT NULL,
	[PreferredLanguageID] [int] NOT NULL,
	[PreferredCountryID] [int] NOT NULL,
	[IsProvider] [bit] NOT NULL,
	[IsCustomer] [bit] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsCollaborator] [bit] NOT NULL,
	[Photo] [varchar](150) NULL,
	[MobilePhone] [varchar](20) NULL,
	[AlternatePhone] [varchar](20) NULL,
	[CanReceiveSms] [bit] NOT NULL,
	[ProviderProfileURL] [varchar](2078) NULL,
	[ProviderWebsiteURL] [varchar](2078) NULL,
	[SMSBookingCommunication] [bit] NOT NULL,
	[PhoneBookingCommunication] [bit] NOT NULL,
	[LoconomicsMarketingCampaigns] [bit] NOT NULL,
	[ProfileSEOPermission] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Active] [bit] NULL,
	[LoconomicsCommunityCommunication] [bit] NOT NULL,
	[IAuthZumigoVerification] [bit] NULL,
	[IAuthZumigoLocation] [bit] NULL,
	[LoconomicsDBMCampaigns] [bit] NOT NULL,
	[AccountStatusID] [int] NOT NULL,
	[CoBrandedPartnerPermissions] [bit] NOT NULL,
	[MarketingSource] [varchar](2055) NULL,
	[BookCode] [varchar](64) NULL,
	[OnboardingStep] [varchar](60) NULL,
	[BirthMonthDay] [int] NULL,
	[BirthMonth] [int] NULL,
	[BusinessName] [nvarchar](145) NULL,
	[AlternativeEmail] [nvarchar](56) NULL,
	[ReferredByUserID] [int] NULL,
	[SignupDevice] [nvarchar](20) NULL,
	[OwnerStatusID] [int] NULL,
	[OwnerAnniversaryDate] [datetime] NULL,
	[IsHipaaAdmin] [bit] NOT NULL,
	[IsContributor] [bit] NULL,
	[TrialEndDate] [datetimeoffset](7) NULL,
	[BirthYear] [int] NULL,
	[IsOrganization] [bit] NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usersignup]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usersignup](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](56) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSolution]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSolution](
	[UserSolutionID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[UserListingID] [int] NOT NULL,
	[SolutionID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[DisplayRank] [int] NULL,
	[CreatedDate] [datetimeoffset](7) NOT NULL,
	[UpdatedDate] [datetimeoffset](7) NOT NULL,
	[ModifiedBy] [nvarchar](4) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_UserSolution] PRIMARY KEY CLUSTERED 
(
	[UserSolutionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserStats]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserStats](
	[UserID] [int] NOT NULL,
	[ResponseTimeMinutes] [decimal](18, 2) NULL,
	[LastLoginTime] [datetime] NULL,
	[LastActivityTime] [datetime] NULL,
 CONSTRAINT [PK_UserStats] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userverification]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userverification](
	[UserID] [int] NOT NULL,
	[VerificationID] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[DateVerified] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[VerifiedBy] [varchar](25) NOT NULL,
	[LastVerifiedDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
	[VerificationStatusID] [int] NOT NULL,
	[Comments] [varchar](2000) NULL,
 CONSTRAINT [PK_userverification] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[VerificationID] ASC,
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[verification]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[verification](
	[VerificationID] [int] NOT NULL,
	[VerificationType] [varchar](100) NOT NULL,
	[VerificationDescription] [varchar](1000) NOT NULL,
	[VerificationProcess] [varchar](500) NULL,
	[Icon] [varchar](15) NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NULL,
	[Active] [bit] NOT NULL,
	[VerificationCategoryID] [int] NOT NULL,
	[RankPosition] [int] NULL,
	[SummaryGroup] [varchar](20) NULL,
 CONSTRAINT [PK__verficat__25EE1D1F0C1BC9F9] PRIMARY KEY CLUSTERED 
(
	[VerificationID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[verificationcategory]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[verificationcategory](
	[VerificationCategoryID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[VerificationCategoryName] [varchar](100) NOT NULL,
	[VerificationCategoryDescription] [varchar](1000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[RankPosition] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[VerificationCategoryID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[verificationstatus]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[verificationstatus](
	[VerificationStatusID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[VerificationStatusName] [varchar](50) NOT NULL,
	[VerificationStatusDisplayDescription] [varchar](300) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VerificationStatusID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VOCElement]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VOCElement](
	[VOCElementID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[VOCElementName] [varchar](100) NULL,
	[ScoreStartValue] [int] NULL,
	[ScoreMidValue] [int] NULL,
	[ScoreEndValue] [int] NULL,
	[ScoreStartLabel] [varchar](25) NULL,
	[ScoreMidLabel] [varchar](25) NULL,
	[ScoreEndLabel] [varchar](25) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](3) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VOCElementID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VOCExperienceCategory]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VOCExperienceCategory](
	[VOCExperienceCategoryID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[VOCExperienceCategoryName] [varchar](50) NULL,
	[VOCExperienceCategoryDescription] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](3) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VOCExperienceCategoryID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VOCFeedback]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VOCFeedback](
	[VOCFeedbackID] [int] IDENTITY(1,1) NOT NULL,
	[VOCElementID] [int] NOT NULL,
	[VOCExperienceCategoryID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Feedback] [text] NOT NULL,
	[VOCFlag1] [varchar](50) NULL,
	[VOCFlag2] [varchar](50) NULL,
	[VOCFlag3] [varchar](50) NULL,
	[VOCFlag4] [varchar](50) NULL,
	[UserDevice] [text] NULL,
	[ZenDeskTicketNumber] [int] NULL,
	[ProviderUserID] [int] NULL,
	[ProviderPositionID] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](3) NOT NULL,
 CONSTRAINT [PK__VOCFeedb__B6FF22780B528E49] PRIMARY KEY CLUSTERED 
(
	[VOCFeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VOCFlag]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VOCFlag](
	[VOCFlagID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[VOCFlagName] [varchar](50) NOT NULL,
	[VOCFlagNDescription] [varchar](500) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](3) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VOCFlagID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VOCScores]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VOCScores](
	[VOCScoresID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[VOCElementID] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ProviderUserID] [int] NULL,
	[ProviderPositionID] [int] NULL,
	[UserDevice] [varchar](100) NULL,
	[VOCExperienceCategoryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VOCScoresID] ASC,
	[UserID] ASC,
	[VOCElementID] ASC,
	[Score] ASC,
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_FacebookCredentials]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_FacebookCredentials](
	[UserId] [int] NOT NULL,
	[FacebookId] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[xJobTitlePricing]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[xJobTitlePricing](
	[JobTitlePricingID] [int] NOT NULL,
	[JobTitleID] [int] NOT NULL,
	[PricingTypeID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[PricingTypeLabel] [varchar](100) NOT NULL,
	[PricingNameDefaultValue] [varchar](100) NOT NULL,
	[PricingDescriptionPlaceholder] [varchar](200) NOT NULL,
	[PricingRateUnitDefaultValue] [varchar](100) NOT NULL,
	[PricingHelperLanguagePlaceholder] [varchar](500) NOT NULL,
	[IncludeTaskListOption] [bit] NOT NULL,
	[RecurringEligible] [bit] NOT NULL,
	[ShowFirstTimeClientsOnlyOption] [bit] NOT NULL,
	[ShowExisitingClientsOnlyOption] [bit] NOT NULL,
	[ShowSpecificClientOnlyOption] [bit] NOT NULL,
	[ShowSlidingScaleOption] [bit] NOT NULL,
	[ShowTradeOption] [bit] NOT NULL,
	[ShowServiceAreaOption] [bit] NOT NULL,
	[ShowServiceLocationOption] [bit] NOT NULL,
	[ShowRemoteLocationOption] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[JobTitlePricingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[xJobTitleReviewRules]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[xJobTitleReviewRules](
	[JobTitleID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[SuppressReviewOfClient] [bit] NOT NULL,
	[SuppressReviewOfServiceProfessional] [bit] NOT NULL,
	[RequestToReview] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](3) NOT NULL,
	[Active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[JobTitleID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[xServiceProfessionalPricing]    Script Date: 10/1/18 8:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[xServiceProfessionalPricing](
	[ServiceProfessionalPricingID] [int] IDENTITY(1,1) NOT NULL,
	[PricingTypeID] [int] NOT NULL,
	[ServiceProfessionalUserID] [int] NOT NULL,
	[JobTitleID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](1000) NULL,
	[Price] [decimal](7, 2) NULL,
	[Duration] [int] NOT NULL,
	[FirstTimeClientsOnly] [bit] NOT NULL,
	[NumberOfSessions] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](25) NOT NULL,
	[Active] [bit] NOT NULL,
	[IsAddOn] [bit] NOT NULL,
	[PriceRate] [decimal](7, 2) NULL,
	[PriceRateUnit] [nvarchar](30) NULL,
	[IsPhone] [bit] NOT NULL,
	[VisibleToClientID] [int] NOT NULL,
	[ParentBookingID] [int] NULL,
	[MaxAvailableSpots] [int] NOT NULL,
	[MaxCapacity] [int] NOT NULL,
	[MinSpots] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceProfessionalPricingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwServiceCategoryPositionAttribute]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwServiceCategoryPositionAttribute] AS

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
/****** Object:  View [dbo].[vwUsersContactData]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
CREATE VIEW [dbo].[vwUsersContactData] AS

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
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_authorizations_token]    Script Date: 10/1/18 8:41:35 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_authorizations_token] ON [dbo].[authorizations]
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_clienttype]    Script Date: 10/1/18 8:41:35 PM ******/
CREATE NONCLUSTERED INDEX [idx_clienttype] ON [dbo].[clienttype]
(
	[CllientTypeID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_Messages]    Script Date: 10/1/18 8:41:35 PM ******/
CREATE NONCLUSTERED INDEX [idx_Messages] ON [dbo].[Messages]
(
	[MessageTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_positions]    Script Date: 10/1/18 8:41:35 PM ******/
CREATE NONCLUSTERED INDEX [idx_positions] ON [dbo].[positions]
(
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_userprofilepositions]    Script Date: 10/1/18 8:41:35 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_userprofilepositions] ON [dbo].[userprofilepositions]
(
	[UserID] ASC,
	[PositionID] ASC,
	[LanguageID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[accountstatus] ADD  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[accountstatus] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[addresstype] ADD  CONSTRAINT [DF_addresstype_Selectable]  DEFAULT ((1)) FOR [Selectable]
GO
ALTER TABLE [dbo].[alert] ADD  CONSTRAINT [DF__alert__PositionS__5E94F66B]  DEFAULT ((0)) FOR [PositionSpecific]
GO
ALTER TABLE [dbo].[alert] ADD  CONSTRAINT [DF__alert__DisplayRa__3CFEF876]  DEFAULT ((1)) FOR [DisplayRank]
GO
ALTER TABLE [dbo].[alert] ADD  DEFAULT ((1)) FOR [ProviderAlert]
GO
ALTER TABLE [dbo].[alert] ADD  DEFAULT ((0)) FOR [CustomerAlert]
GO
ALTER TABLE [dbo].[alert] ADD  CONSTRAINT [DF_alert_bookMeButtonRequired]  DEFAULT ((0)) FOR [bookMeButtonRequired]
GO
ALTER TABLE [dbo].[alerttype] ADD  DEFAULT ((1)) FOR [LanguageID]
GO
ALTER TABLE [dbo].[alerttype] ADD  DEFAULT ((1)) FOR [CountryID]
GO
ALTER TABLE [dbo].[alerttype] ADD  DEFAULT ((1)) FOR [DisplayRank]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [Contraint_booking_InstantBooking]  DEFAULT ((0)) FOR [InstantBooking]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [Contraint_booking_SendReminder]  DEFAULT ((0)) FOR [SendReminder]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [Contraint_booking_SendPromotional]  DEFAULT ((0)) FOR [SendPromotional]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [Contraint_booking_Recurrent]  DEFAULT ((0)) FOR [Recurrent]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [Contraint_booking_MultiSession]  DEFAULT ((0)) FOR [MultiSession]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [Contraint__booking__PricingAdjustmentApplied]  DEFAULT ((0)) FOR [PricingAdjustmentApplied]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [DF_booking_PaymentEnabled]  DEFAULT ((0)) FOR [PaymentEnabled]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [Contraint_booking_PaymentCollected]  DEFAULT ((0)) FOR [PaymentCollected]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [Contraint_booking_PaymentAuthorized]  DEFAULT ((0)) FOR [PaymentAuthorized]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [Contraint_booking_PricingAdjustmentRequested]  DEFAULT ((0)) FOR [PricingAdjustmentRequested]
GO
ALTER TABLE [dbo].[booking] ADD  CONSTRAINT [Contraint_booking_MessagingLog]  DEFAULT ('') FOR [MessagingLog]
GO
ALTER TABLE [dbo].[bookingType] ADD  CONSTRAINT [DF__bookingty__Servi__2215F810]  DEFAULT ((0)) FOR [FirstTimeServiceFeeFixed]
GO
ALTER TABLE [dbo].[bookingType] ADD  CONSTRAINT [DF__bookingty__Servi__230A1C49]  DEFAULT ((0)) FOR [FirstTimeServiceFeePercentage]
GO
ALTER TABLE [dbo].[bookingType] ADD  CONSTRAINT [DF__bookingty__Payme__23FE4082]  DEFAULT ((0)) FOR [PaymentProcessingFeePercentage]
GO
ALTER TABLE [dbo].[bookingType] ADD  CONSTRAINT [DF_bookingtype_PaymentProcessingFeeFixed]  DEFAULT ((0)) FOR [PaymentProcessingFeeFixed]
GO
ALTER TABLE [dbo].[bookingType] ADD  CONSTRAINT [DF_bookingtype_FirstTimeServiceFeeMaximum]  DEFAULT ((0)) FOR [FirstTimeServiceFeeMaximum]
GO
ALTER TABLE [dbo].[bookingType] ADD  CONSTRAINT [DF_bookingtype_FirstTimeServiceFeeMinimum]  DEFAULT ((0)) FOR [FirstTimeServiceFeeMinimum]
GO
ALTER TABLE [dbo].[CalendarAvailabilityType] ADD  DEFAULT ((0)) FOR [AddAppointmentType]
GO
ALTER TABLE [dbo].[CalendarEvents] ADD  CONSTRAINT [DF_CalendarEvents_EventType]  DEFAULT ((1)) FOR [EventType]
GO
ALTER TABLE [dbo].[CalendarEvents] ADD  CONSTRAINT [DF_CalendarEvents_Transparency]  DEFAULT ((0)) FOR [Transparency]
GO
ALTER TABLE [dbo].[CalendarEvents] ADD  CONSTRAINT [DF_CalendarEvents_IsAllDay]  DEFAULT ((0)) FOR [IsAllDay]
GO
ALTER TABLE [dbo].[CalendarProviderAttributes] ADD  CONSTRAINT [DF_CalendarProviderAttributes_MinTime]  DEFAULT ((0)) FOR [MinTime]
GO
ALTER TABLE [dbo].[CalendarProviderAttributes] ADD  CONSTRAINT [DF_CalendarProviderAttributes_MaxTime]  DEFAULT ((0)) FOR [MaxTime]
GO
ALTER TABLE [dbo].[CalendarProviderAttributes] ADD  CONSTRAINT [DF_CalendarProviderAttributes_IncrementsSizeInMinutes]  DEFAULT ((15)) FOR [IncrementsSizeInMinutes]
GO
ALTER TABLE [dbo].[jobTitleLicense] ADD  DEFAULT ((0)) FOR [MunicipalityID]
GO
ALTER TABLE [dbo].[jobTitleLicense] ADD  DEFAULT ((0)) FOR [CountyID]
GO
ALTER TABLE [dbo].[JobTitlePlatform] ADD  CONSTRAINT [DF_JobTitlePlatform_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[JobTitleSolution] ADD  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[licensecertification] ADD  CONSTRAINT [DF__licensece__Langu__5BF880E2]  DEFAULT ((1)) FOR [LanguageID]
GO
ALTER TABLE [dbo].[Messages] ADD  CONSTRAINT [DF_Messages_SentByUserId]  DEFAULT ((0)) FOR [SentByUserId]
GO
ALTER TABLE [dbo].[Platform] ADD  CONSTRAINT [DF_Platform_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[positions] ADD  CONSTRAINT [DF_positions_AttributesComplete]  DEFAULT ((0)) FOR [AttributesComplete]
GO
ALTER TABLE [dbo].[positions] ADD  CONSTRAINT [DF_positions_StarRatingsComplete]  DEFAULT ((0)) FOR [StarRatingsComplete]
GO
ALTER TABLE [dbo].[positions] ADD  CONSTRAINT [DF_positions_PricingTypeComplete]  DEFAULT ((0)) FOR [PricingTypeComplete]
GO
ALTER TABLE [dbo].[positions] ADD  DEFAULT ((0)) FOR [AddGratuity]
GO
ALTER TABLE [dbo].[positions] ADD  DEFAULT ((0)) FOR [HIPAA]
GO
ALTER TABLE [dbo].[positions] ADD  DEFAULT ((1)) FOR [SendReviewReminderToClient]
GO
ALTER TABLE [dbo].[positions] ADD  DEFAULT ((0)) FOR [CanBeRemote]
GO
ALTER TABLE [dbo].[positions] ADD  DEFAULT ((0)) FOR [SuppressReviewOfClient]
GO
ALTER TABLE [dbo].[postalcode] ADD  DEFAULT ((0)) FOR [MunicipalityID]
GO
ALTER TABLE [dbo].[postalcode] ADD  DEFAULT ((0)) FOR [CountyID]
GO
ALTER TABLE [dbo].[pricingSummary] ADD  CONSTRAINT [DF__pricinges__Prici__04CFADEC]  DEFAULT ((1)) FOR [PricingSummaryRevision]
GO
ALTER TABLE [dbo].[pricingSummary] ADD  CONSTRAINT [DF_pricingestimate_PFeePrice]  DEFAULT ((0)) FOR [ServiceFeeAmount]
GO
ALTER TABLE [dbo].[pricingSummary] ADD  CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeeFixed]  DEFAULT ((0)) FOR [FirstTimeServiceFeeFixed]
GO
ALTER TABLE [dbo].[pricingSummary] ADD  CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeePercentage]  DEFAULT ((0)) FOR [FirstTimeServiceFeePercentage]
GO
ALTER TABLE [dbo].[pricingSummary] ADD  CONSTRAINT [DF_pricingSummary_PaymentProcessingFeePercentage]  DEFAULT ((0)) FOR [PaymentProcessingFeePercentage]
GO
ALTER TABLE [dbo].[pricingSummary] ADD  CONSTRAINT [DF_pricingSummary_PaymentProcessingFeeFixed]  DEFAULT ((0)) FOR [PaymentProcessingFeeFixed]
GO
ALTER TABLE [dbo].[pricingSummary] ADD  CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeeMaximum]  DEFAULT ((0)) FOR [FirstTimeServiceFeeMaximum]
GO
ALTER TABLE [dbo].[pricingSummary] ADD  CONSTRAINT [DF_pricingSummary_FirstTimeServiceFeeMinimum]  DEFAULT ((0)) FOR [FirstTimeServiceFeeMinimum]
GO
ALTER TABLE [dbo].[pricingSummaryDetail] ADD  CONSTRAINT [DF_pricingSummaryDetail_IsRemoteService]  DEFAULT ((0)) FOR [IsRemoteService]
GO
ALTER TABLE [dbo].[pricingtype] ADD  CONSTRAINT [DF__pricingty__Langu__086B34A6]  DEFAULT ((1)) FOR [LanguageID]
GO
ALTER TABLE [dbo].[pricingtype] ADD  CONSTRAINT [DF__pricingty__Count__095F58DF]  DEFAULT ((1)) FOR [CountryID]
GO
ALTER TABLE [dbo].[pricingtype] ADD  CONSTRAINT [DF__pricingty__Activ__0A537D18]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[PricingVariableDefinition] ADD  CONSTRAINT [DF_PricingVariableDefinition_IsProviderVariable]  DEFAULT ((0)) FOR [IsProviderVariable]
GO
ALTER TABLE [dbo].[PricingVariableDefinition] ADD  CONSTRAINT [DF_PricingVariableDefinition_IsCustomerVariable]  DEFAULT ((0)) FOR [IsCustomerVariable]
GO
ALTER TABLE [dbo].[PricingVariableDefinition] ADD  CONSTRAINT [DF_PricingVariableDefinition_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[PricingVariableDefinition] ADD  CONSTRAINT [DF_PricingVariableDefinition_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PricingVariableDefinition] ADD  CONSTRAINT [DF_PricingVariableDefinition_UpdatedDate]  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[PricingVariableDefinition] ADD  CONSTRAINT [DF_PricingVariableDefinition_ModifiedBy]  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[PricingVariableValue] ADD  CONSTRAINT [DF_PricingVariableValue_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PricingVariableValue] ADD  CONSTRAINT [DF_PricingVariableValue_UpdatedDate]  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[PricingVariableValue] ADD  CONSTRAINT [DF_PricingVariableValue_ModifiedBy]  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[PricingVariableValue] ADD  CONSTRAINT [DF_PricingVariableValue_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[providerpackage] ADD  CONSTRAINT [DF__providerp__First__1BD30ED5]  DEFAULT ((0)) FOR [FirstTimeClientsOnly]
GO
ALTER TABLE [dbo].[providerpackage] ADD  CONSTRAINT [DF__providerp__Numbe__1CC7330E]  DEFAULT ((1)) FOR [NumberOfSessions]
GO
ALTER TABLE [dbo].[providerpackage] ADD  CONSTRAINT [DF__providerp__IsAdd__1F398B65]  DEFAULT ((0)) FOR [IsAddOn]
GO
ALTER TABLE [dbo].[providerpackage] ADD  CONSTRAINT [DF_providerpackage_IsPhone]  DEFAULT ((0)) FOR [IsPhone]
GO
ALTER TABLE [dbo].[providerpackage] ADD  DEFAULT ((0)) FOR [VisibleToClientID]
GO
ALTER TABLE [dbo].[providerpackage] ADD  CONSTRAINT [DF_providerpackage_SolutionID]  DEFAULT ((0)) FOR [SolutionID]
GO
ALTER TABLE [dbo].[providerpackagedetail] ADD  DEFAULT ('sysdate') FOR [CreatedDate]
GO
ALTER TABLE [dbo].[providerpackagedetail] ADD  DEFAULT ('sysdate') FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[providerpackagedetail] ADD  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[providerpackagedetail] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[providerpaymentpreference] ADD  CONSTRAINT [DF__providerp__Verif__08D548FA]  DEFAULT ((0)) FOR [Verified]
GO
ALTER TABLE [dbo].[question] ADD  DEFAULT ('') FOR [label]
GO
ALTER TABLE [dbo].[SearchCategory] ADD  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[SearchCategory] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[SearchSubCategory] ADD  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[SearchSubCategory] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[SearchSubCategorySolution] ADD  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[serviceaddress] ADD  CONSTRAINT [DF__servicead__Servi__532343BF]  DEFAULT ((0)) FOR [ServicesPerformedAtLocation]
GO
ALTER TABLE [dbo].[serviceaddress] ADD  CONSTRAINT [DF__servicead__Trave__541767F8]  DEFAULT ((0)) FOR [TravelFromLocation]
GO
ALTER TABLE [dbo].[serviceaddress] ADD  CONSTRAINT [DF__servicead__Trans__550B8C31]  DEFAULT ((1)) FOR [TransportType]
GO
ALTER TABLE [dbo].[serviceaddress] ADD  CONSTRAINT [DF__servicead__Prefe__55FFB06A]  DEFAULT ((0)) FOR [PreferredAddress]
GO
ALTER TABLE [dbo].[serviceattribute] ADD  DEFAULT (NULL) FOR [SourceID]
GO
ALTER TABLE [dbo].[serviceattribute] ADD  DEFAULT ((1)) FOR [DisplayRank]
GO
ALTER TABLE [dbo].[serviceattributecategory] ADD  CONSTRAINT [DF_serviceattributecategory_SideBarCategory]  DEFAULT ((0)) FOR [SideBarCategory]
GO
ALTER TABLE [dbo].[serviceattributecategory] ADD  CONSTRAINT [DF_serviceattributecategory_EligibleForPackages]  DEFAULT ((0)) FOR [EligibleForPackages]
GO
ALTER TABLE [dbo].[serviceattributecategory] ADD  CONSTRAINT [DF__serviceat__Displ__3C0AD43D]  DEFAULT ((1)) FOR [DisplayRank]
GO
ALTER TABLE [dbo].[serviceattributecategory] ADD  DEFAULT ((0)) FOR [BookingPathSelection]
GO
ALTER TABLE [dbo].[servicecategoryposition] ADD  DEFAULT ((1)) FOR [Rank]
GO
ALTER TABLE [dbo].[servicecategoryposition] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[servicecategorypositionattribute] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ServiceProfessionalClient] ADD  CONSTRAINT [DF_ProviderCustomer_NotesAboutCustomer]  DEFAULT ('') FOR [NotesAboutClient]
GO
ALTER TABLE [dbo].[ServiceProfessionalClient] ADD  CONSTRAINT [DF_ServiceProfessionalClient_DeletedByServiceProfessional]  DEFAULT ((0)) FOR [DeletedByServiceProfessional]
GO
ALTER TABLE [dbo].[Solution] ADD  DEFAULT ((0)) FOR [CredentialCheckRequired]
GO
ALTER TABLE [dbo].[Solution] ADD  DEFAULT ((0)) FOR [BackgroundCheckRequired]
GO
ALTER TABLE [dbo].[Solution] ADD  DEFAULT ((0)) FOR [IsHIPAA]
GO
ALTER TABLE [dbo].[Solution] ADD  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[Solution] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Specialization] ADD  CONSTRAINT [DF__Specializ__Creat__23D42350]  DEFAULT ('staff') FOR [CreatedBy]
GO
ALTER TABLE [dbo].[Specialization] ADD  CONSTRAINT [DF__Specializ__Appro__24C84789]  DEFAULT ((0)) FOR [Approved]
GO
ALTER TABLE [dbo].[Specialization] ADD  CONSTRAINT [DF__Specializ__Activ__25BC6BC2]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF_users_IsMember]  DEFAULT ((0)) FOR [IsMember]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF_users_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF_users_IsContributor]  DEFAULT ((0)) FOR [IsContributor]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF__users__Collabora__5E7FE7D2]  DEFAULT ((0)) FOR [IsCollaborator]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF_users_CanReceiveSms]  DEFAULT ((0)) FOR [CanReceiveSms]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF__users__SMSBookin__3B2BBE9D]  DEFAULT ((1)) FOR [SMSBookingCommunication]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF__users__PhoneBook__3C1FE2D6]  DEFAULT ((1)) FOR [PhoneBookingCommunication]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF__users__Loconomic__3D14070F]  DEFAULT ((1)) FOR [LoconomicsMarketingCampaigns]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF__users__ProviderP__3E082B48]  DEFAULT ((1)) FOR [ProfileSEOPermission]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF__users__Loconomic__3EFC4F81]  DEFAULT ((1)) FOR [LoconomicsCommunityCommunication]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF__users__Loconomic__45FE52CB]  DEFAULT ((1)) FOR [LoconomicsDBMCampaigns]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF__users__AccountSt__6265874F]  DEFAULT ((1)) FOR [AccountStatusID]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF__users__CoBranded__691284DE]  DEFAULT ((1)) FOR [CoBrandedPartnerPermissions]
GO
ALTER TABLE [dbo].[Tmp_users] ADD  CONSTRAINT [DF__users__IsHipaaAd__70F39DC8]  DEFAULT ((0)) FOR [IsHipaaAdmin]
GO
ALTER TABLE [dbo].[UserAlert] ADD  CONSTRAINT [DF_UserAlert_Dismissed]  DEFAULT ((0)) FOR [Dismissed]
GO
ALTER TABLE [dbo].[UserBadge] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[UserEarnings] ADD  CONSTRAINT [DF_UserEarnings_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[UserEarningsEntry] ADD  CONSTRAINT [DF_UserEarningsEntry_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[UserEarningsEntry] ADD  CONSTRAINT [DF_UserEarningsEntry_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[UserExternalListing] ADD  CONSTRAINT [DF_UserExternalListing_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[UserListingSpecialization] ADD  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[UserListingSpecialization] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[UserPaymentPlan] ADD  CONSTRAINT [DF_UserPaymentPlan_DaysPastDue]  DEFAULT ((0)) FOR [DaysPastDue]
GO
ALTER TABLE [dbo].[UserPostingQuestionResponse] ADD  DEFAULT ('') FOR [label]
GO
ALTER TABLE [dbo].[userprofilepositions] ADD  CONSTRAINT [DF_userprofilepositions_StatusID]  DEFAULT ((1)) FOR [StatusID]
GO
ALTER TABLE [dbo].[userprofilepositions] ADD  CONSTRAINT [DF_userprofilepositions_InstantBooking]  DEFAULT ((0)) FOR [InstantBooking]
GO
ALTER TABLE [dbo].[userprofilepositions] ADD  CONSTRAINT [DF_userprofilepositions_bookMeButtonReady]  DEFAULT ((0)) FOR [bookMeButtonReady]
GO
ALTER TABLE [dbo].[userprofilepositions] ADD  CONSTRAINT [DF_userprofilepositions_collectPaymentAtBookMeButton]  DEFAULT ((1)) FOR [collectPaymentAtBookMeButton]
GO
ALTER TABLE [dbo].[UserReviews] ADD  CONSTRAINT [DF_UserReviews_ServiceHours]  DEFAULT ((0)) FOR [ServiceHours]
GO
ALTER TABLE [dbo].[UserReviews] ADD  CONSTRAINT [DF_UserReviews_HelpfulReviewCount]  DEFAULT ((0)) FOR [HelpfulReviewCount]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_GenderID]  DEFAULT ((-1)) FOR [GenderID]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF__users__IsProvide__3943762B]  DEFAULT ((0)) FOR [IsProvider]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF__users__IsCustome__3A379A64]  DEFAULT ((0)) FOR [IsCustomer]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [IsCollaborator]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [CanReceiveSms]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [SMSBookingCommunication]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [PhoneBookingCommunication]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [LoconomicsMarketingCampaigns]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [ProfileSEOPermission]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [LoconomicsCommunityCommunication]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [LoconomicsDBMCampaigns]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [AccountStatusID]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [CoBrandedPartnerPermissions]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [IsHipaaAdmin]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [users_IsContributor_default]  DEFAULT (CONVERT([bit],(0),0)) FOR [IsContributor]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [IsOrganization]
GO
ALTER TABLE [dbo].[UserSolution] ADD  DEFAULT ('sys') FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[UserSolution] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[userverification] ADD  CONSTRAINT [DF_userverification_PositionID]  DEFAULT ((0)) FOR [PositionID]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
ALTER TABLE [dbo].[xServiceProfessionalPricing] ADD  DEFAULT ((0)) FOR [FirstTimeClientsOnly]
GO
ALTER TABLE [dbo].[xServiceProfessionalPricing] ADD  DEFAULT ((1)) FOR [NumberOfSessions]
GO
ALTER TABLE [dbo].[xServiceProfessionalPricing] ADD  DEFAULT ((0)) FOR [IsAddOn]
GO
ALTER TABLE [dbo].[xServiceProfessionalPricing] ADD  DEFAULT ((0)) FOR [IsPhone]
GO
ALTER TABLE [dbo].[xServiceProfessionalPricing] ADD  DEFAULT ((0)) FOR [VisibleToClientID]
GO
ALTER TABLE [dbo].[xServiceProfessionalPricing] ADD  DEFAULT ((1)) FOR [MaxAvailableSpots]
GO
ALTER TABLE [dbo].[xServiceProfessionalPricing] ADD  DEFAULT ((1)) FOR [MaxCapacity]
GO
ALTER TABLE [dbo].[xServiceProfessionalPricing] ADD  DEFAULT ((1)) FOR [MinSpots]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__alternativeDate1] FOREIGN KEY([AlternativeDate1ID])
REFERENCES [dbo].[CalendarEvents] ([Id])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__alternativeDate1]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__alternativeDate2] FOREIGN KEY([AlternativeDate2ID])
REFERENCES [dbo].[CalendarEvents] ([Id])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__alternativeDate2]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__AwaitingResponseFromUserID] FOREIGN KEY([AwaitingResponseFromUserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__AwaitingResponseFromUserID]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__cancellationPolicy] FOREIGN KEY([CancellationPolicyID], [LanguageID], [CountryID])
REFERENCES [dbo].[cancellationpolicy] ([CancellationPolicyID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__cancellationPolicy]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__client] FOREIGN KEY([ClientUserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__client]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__jobtitle] FOREIGN KEY([JobTitleID], [LanguageID], [CountryID])
REFERENCES [dbo].[positions] ([PositionID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__jobtitle]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__parentbooking] FOREIGN KEY([ParentBookingID])
REFERENCES [dbo].[booking] ([BookingID])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__parentbooking]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__pricingSummary] FOREIGN KEY([PricingSummaryID], [PricingSummaryRevision])
REFERENCES [dbo].[pricingSummary] ([PricingSummaryID], [PricingSummaryRevision])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__pricingSummary]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__serviceAddress] FOREIGN KEY([ServiceAddressID])
REFERENCES [dbo].[address] ([AddressID])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__serviceAddress]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__serviceDate] FOREIGN KEY([ServiceDateID])
REFERENCES [dbo].[CalendarEvents] ([Id])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__serviceDate]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__serviceProfessional] FOREIGN KEY([ServiceProfessionalUserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__serviceProfessional]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__status] FOREIGN KEY([BookingStatusID])
REFERENCES [dbo].[bookingStatus] ([BookingStatusID])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__status]
GO
ALTER TABLE [dbo].[booking]  WITH CHECK ADD  CONSTRAINT [FK__booking__type] FOREIGN KEY([BookingTypeID])
REFERENCES [dbo].[bookingType] ([BookingTypeID])
GO
ALTER TABLE [dbo].[booking] CHECK CONSTRAINT [FK__booking__type]
GO
ALTER TABLE [dbo].[CalendarEventComments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_CalendarEvents] FOREIGN KEY([IdEvent])
REFERENCES [dbo].[CalendarEvents] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarEventComments] CHECK CONSTRAINT [FK_Comments_CalendarEvents]
GO
ALTER TABLE [dbo].[CalendarEventExceptionsPeriod]  WITH CHECK ADD  CONSTRAINT [FK_CalendarEventExceptionsPeriods_CalendarEventExceptionsDates] FOREIGN KEY([IdException])
REFERENCES [dbo].[CalendarEventExceptionsPeriodsList] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarEventExceptionsPeriod] CHECK CONSTRAINT [FK_CalendarEventExceptionsPeriods_CalendarEventExceptionsDates]
GO
ALTER TABLE [dbo].[CalendarEventExceptionsPeriodsList]  WITH CHECK ADD  CONSTRAINT [FK_CalendarEventExceptions_CalendarEvents] FOREIGN KEY([IdEvent])
REFERENCES [dbo].[CalendarEvents] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarEventExceptionsPeriodsList] CHECK CONSTRAINT [FK_CalendarEventExceptions_CalendarEvents]
GO
ALTER TABLE [dbo].[CalendarEventRecurrencesPeriod]  WITH CHECK ADD  CONSTRAINT [FK_CalendarEventRecurrencesPeriod_CalendarEventRecurrencesPeriodList] FOREIGN KEY([IdRecurrence])
REFERENCES [dbo].[CalendarEventRecurrencesPeriodList] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarEventRecurrencesPeriod] CHECK CONSTRAINT [FK_CalendarEventRecurrencesPeriod_CalendarEventRecurrencesPeriodList]
GO
ALTER TABLE [dbo].[CalendarEventRecurrencesPeriodList]  WITH CHECK ADD  CONSTRAINT [FK_CalendarEventRecurrencesPeriodList_CalendarEvents] FOREIGN KEY([IdEvent])
REFERENCES [dbo].[CalendarEvents] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarEventRecurrencesPeriodList] CHECK CONSTRAINT [FK_CalendarEventRecurrencesPeriodList_CalendarEvents]
GO
ALTER TABLE [dbo].[CalendarEvents]  WITH CHECK ADD  CONSTRAINT [FK_CalendarEvents_CalendarAvailabilityType] FOREIGN KEY([CalendarAvailabilityTypeID])
REFERENCES [dbo].[CalendarAvailabilityType] ([CalendarAvailabilityTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarEvents] CHECK CONSTRAINT [FK_CalendarEvents_CalendarAvailabilityType]
GO
ALTER TABLE [dbo].[CalendarEvents]  WITH CHECK ADD  CONSTRAINT [FK_CalendarEvents_CalendarEventType] FOREIGN KEY([EventType])
REFERENCES [dbo].[CalendarEventType] ([EventTypeId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarEvents] CHECK CONSTRAINT [FK_CalendarEvents_CalendarEventType]
GO
ALTER TABLE [dbo].[CalendarEventsAttendees]  WITH CHECK ADD  CONSTRAINT [FK_CalendarEventsAttendees_CalendarEvents] FOREIGN KEY([IdEvent])
REFERENCES [dbo].[CalendarEvents] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarEventsAttendees] CHECK CONSTRAINT [FK_CalendarEventsAttendees_CalendarEvents]
GO
ALTER TABLE [dbo].[CalendarEventsContacts]  WITH CHECK ADD  CONSTRAINT [FK_CalendarEventsContacts_CalendarEvents] FOREIGN KEY([IdEvent])
REFERENCES [dbo].[CalendarEvents] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarEventsContacts] CHECK CONSTRAINT [FK_CalendarEventsContacts_CalendarEvents]
GO
ALTER TABLE [dbo].[CalendarProviderAttributes]  WITH CHECK ADD  CONSTRAINT [FK_CalendarProviderAttributes_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarProviderAttributes] CHECK CONSTRAINT [FK_CalendarProviderAttributes_users]
GO
ALTER TABLE [dbo].[CalendarReccurrence]  WITH CHECK ADD  CONSTRAINT [FK_CalendarReccurrence_CalendarRecurrenceFrequencyTypes] FOREIGN KEY([Frequency])
REFERENCES [dbo].[CalendarRecurrenceFrequencyTypes] ([ID])
GO
ALTER TABLE [dbo].[CalendarReccurrence] CHECK CONSTRAINT [FK_CalendarReccurrence_CalendarRecurrenceFrequencyTypes]
GO
ALTER TABLE [dbo].[CalendarReccurrence]  WITH CHECK ADD  CONSTRAINT [FK_CalendarReccursive_CalendarEvents] FOREIGN KEY([EventID])
REFERENCES [dbo].[CalendarEvents] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarReccurrence] CHECK CONSTRAINT [FK_CalendarReccursive_CalendarEvents]
GO
ALTER TABLE [dbo].[CalendarReccurrenceFrequency]  WITH CHECK ADD  CONSTRAINT [FK_CalendarFrecuency_CalendarReccursive] FOREIGN KEY([CalendarReccursiveID])
REFERENCES [dbo].[CalendarReccurrence] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CalendarReccurrenceFrequency] CHECK CONSTRAINT [FK_CalendarFrecuency_CalendarReccursive]
GO
ALTER TABLE [dbo].[CalendarRecurrenceFrequencyTypes]  WITH CHECK ADD  CONSTRAINT [FK_CalendarRecurrenceFrequencyTypes_CalendarRecurrenceFrequencyTypes] FOREIGN KEY([ID])
REFERENCES [dbo].[CalendarRecurrenceFrequencyTypes] ([ID])
GO
ALTER TABLE [dbo].[CalendarRecurrenceFrequencyTypes] CHECK CONSTRAINT [FK_CalendarRecurrenceFrequencyTypes_CalendarRecurrenceFrequencyTypes]
GO
ALTER TABLE [dbo].[CCCUsers]  WITH CHECK ADD FOREIGN KEY([FieldOfStudyID])
REFERENCES [dbo].[FieldOfStudy] ([FieldOfStudyID])
GO
ALTER TABLE [dbo].[CCCUsers]  WITH CHECK ADD FOREIGN KEY([InstitutionID])
REFERENCES [dbo].[institution] ([InstitutionID])
GO
ALTER TABLE [dbo].[CCCUsers]  WITH CHECK ADD  CONSTRAINT [FK__CCCUsers__UserID__6EA14102] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[CCCUsers] CHECK CONSTRAINT [FK__CCCUsers__UserID__6EA14102]
GO
ALTER TABLE [dbo].[CCCUsers]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[county]  WITH CHECK ADD FOREIGN KEY([StateProvinceID])
REFERENCES [dbo].[stateprovince] ([StateProvinceID])
GO
ALTER TABLE [dbo].[FieldOfStudy]  WITH CHECK ADD FOREIGN KEY([LanguageID], [CountryID])
REFERENCES [dbo].[language] ([LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[institution]  WITH CHECK ADD  CONSTRAINT [FK__instituti__State__153B1FDF] FOREIGN KEY([StateProvinceID])
REFERENCES [dbo].[stateprovince] ([StateProvinceID])
GO
ALTER TABLE [dbo].[institution] CHECK CONSTRAINT [FK__instituti__State__153B1FDF]
GO
ALTER TABLE [dbo].[JobTitlePlatform]  WITH CHECK ADD  CONSTRAINT [FK_JobTitlePlatform_Platform] FOREIGN KEY([PlatformID], [LanguageID], [CountryID])
REFERENCES [dbo].[Platform] ([PlatformID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[JobTitlePlatform] CHECK CONSTRAINT [FK_JobTitlePlatform_Platform]
GO
ALTER TABLE [dbo].[JobTitleSolution]  WITH CHECK ADD  CONSTRAINT [FK_JobTitleSolution_positions] FOREIGN KEY([JobTitleID], [LanguageID], [CountryID])
REFERENCES [dbo].[positions] ([PositionID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[JobTitleSolution] CHECK CONSTRAINT [FK_JobTitleSolution_positions]
GO
ALTER TABLE [dbo].[JobTitleSolution]  WITH CHECK ADD  CONSTRAINT [FK_JobTitleSolution_Solution] FOREIGN KEY([SolutionID], [LanguageID], [CountryID])
REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[JobTitleSolution] CHECK CONSTRAINT [FK_JobTitleSolution_Solution]
GO
ALTER TABLE [dbo].[MessagingThreads]  WITH CHECK ADD  CONSTRAINT [Fk_MessagingThreads_2] FOREIGN KEY([CustomerUserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[MessagingThreads] CHECK CONSTRAINT [Fk_MessagingThreads_2]
GO
ALTER TABLE [dbo].[MessagingThreads]  WITH CHECK ADD  CONSTRAINT [FK_MessagingThreads_Messages] FOREIGN KEY([LastMessageID])
REFERENCES [dbo].[Messages] ([MessageID])
GO
ALTER TABLE [dbo].[MessagingThreads] CHECK CONSTRAINT [FK_MessagingThreads_Messages]
GO
ALTER TABLE [dbo].[MessagingThreads]  WITH CHECK ADD  CONSTRAINT [FK_MessagingThreads_messagethreadstatus] FOREIGN KEY([MessageThreadStatusID])
REFERENCES [dbo].[messagethreadstatus] ([MessageThreadStatusID])
GO
ALTER TABLE [dbo].[MessagingThreads] CHECK CONSTRAINT [FK_MessagingThreads_messagethreadstatus]
GO
ALTER TABLE [dbo].[MessagingThreads]  WITH CHECK ADD  CONSTRAINT [FK_MessagingThreads_users] FOREIGN KEY([ProviderUserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[MessagingThreads] CHECK CONSTRAINT [FK_MessagingThreads_users]
GO
ALTER TABLE [dbo].[municipality]  WITH CHECK ADD FOREIGN KEY([CountyID])
REFERENCES [dbo].[county] ([CountyID])
GO
ALTER TABLE [dbo].[OwnerAcknowledgment]  WITH CHECK ADD  CONSTRAINT [FK_OwnerAcknowledgment_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[OwnerAcknowledgment] CHECK CONSTRAINT [FK_OwnerAcknowledgment_users]
GO
ALTER TABLE [dbo].[Platform]  WITH CHECK ADD  CONSTRAINT [FK_Platform_language] FOREIGN KEY([LanguageID], [CountryID])
REFERENCES [dbo].[language] ([LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[Platform] CHECK CONSTRAINT [FK_Platform_language]
GO
ALTER TABLE [dbo].[positionpricingtype]  WITH CHECK ADD  CONSTRAINT [Fk_positionpricingtype] FOREIGN KEY([PricingTypeID], [LanguageID], [CountryID])
REFERENCES [dbo].[pricingtype] ([PricingTypeID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[positionpricingtype] CHECK CONSTRAINT [Fk_positionpricingtype]
GO
ALTER TABLE [dbo].[positionpricingtype]  WITH CHECK ADD  CONSTRAINT [Fk_positionpricingtype_0] FOREIGN KEY([PositionID], [LanguageID], [CountryID])
REFERENCES [dbo].[positions] ([PositionID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[positionpricingtype] CHECK CONSTRAINT [Fk_positionpricingtype_0]
GO
ALTER TABLE [dbo].[positionpricingtype]  WITH CHECK ADD  CONSTRAINT [Fk_positionpricingtype_1] FOREIGN KEY([ClientTypeID], [LanguageID], [CountryID])
REFERENCES [dbo].[clienttype] ([CllientTypeID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[positionpricingtype] CHECK CONSTRAINT [Fk_positionpricingtype_1]
GO
ALTER TABLE [dbo].[postalcode]  WITH CHECK ADD FOREIGN KEY([CountyID])
REFERENCES [dbo].[county] ([CountyID])
GO
ALTER TABLE [dbo].[postalcode]  WITH CHECK ADD FOREIGN KEY([MunicipalityID])
REFERENCES [dbo].[municipality] ([MunicipalityID])
GO
ALTER TABLE [dbo].[postalcode]  WITH CHECK ADD FOREIGN KEY([StateProvinceID])
REFERENCES [dbo].[stateprovince] ([StateProvinceID])
GO
ALTER TABLE [dbo].[postingTemplateQuestion]  WITH CHECK ADD  CONSTRAINT [FK_postingTemplateQuestion_postingTemplate] FOREIGN KEY([postingTemplateID])
REFERENCES [dbo].[postingTemplate] ([postingTemplateID])
GO
ALTER TABLE [dbo].[postingTemplateQuestion] CHECK CONSTRAINT [FK_postingTemplateQuestion_postingTemplate]
GO
ALTER TABLE [dbo].[postingTemplateQuestion]  WITH CHECK ADD  CONSTRAINT [FK_postingTemplateQuestion_question] FOREIGN KEY([questionID])
REFERENCES [dbo].[question] ([questionID])
GO
ALTER TABLE [dbo].[postingTemplateQuestion] CHECK CONSTRAINT [FK_postingTemplateQuestion_question]
GO
ALTER TABLE [dbo].[pricingSummary]  WITH CHECK ADD  CONSTRAINT [FK_pricingestimate_pricingestimate] FOREIGN KEY([PricingSummaryID], [PricingSummaryRevision])
REFERENCES [dbo].[pricingSummary] ([PricingSummaryID], [PricingSummaryRevision])
GO
ALTER TABLE [dbo].[pricingSummary] CHECK CONSTRAINT [FK_pricingestimate_pricingestimate]
GO
ALTER TABLE [dbo].[question]  WITH CHECK ADD  CONSTRAINT [FK_question_questionType] FOREIGN KEY([questionTypeID])
REFERENCES [dbo].[questionType] ([questionTypeID])
GO
ALTER TABLE [dbo].[question] CHECK CONSTRAINT [FK_question_questionType]
GO
ALTER TABLE [dbo].[SearchCategory]  WITH CHECK ADD  CONSTRAINT [FK_SearchCategory_language] FOREIGN KEY([LanguageID], [CountryID])
REFERENCES [dbo].[language] ([LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[SearchCategory] CHECK CONSTRAINT [FK_SearchCategory_language]
GO
ALTER TABLE [dbo].[SearchSubCategory]  WITH CHECK ADD  CONSTRAINT [FK_SearchSubCategory_language] FOREIGN KEY([LanguageID], [CountryID])
REFERENCES [dbo].[language] ([LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[SearchSubCategory] CHECK CONSTRAINT [FK_SearchSubCategory_language]
GO
ALTER TABLE [dbo].[SearchSubCategory]  WITH CHECK ADD  CONSTRAINT [FK_SearchSubCategory_SearchCategory] FOREIGN KEY([SearchCategoryID], [LanguageID], [CountryID])
REFERENCES [dbo].[SearchCategory] ([SearchCategoryID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[SearchSubCategory] CHECK CONSTRAINT [FK_SearchSubCategory_SearchCategory]
GO
ALTER TABLE [dbo].[SearchSubCategorySolution]  WITH CHECK ADD  CONSTRAINT [FK_SearchSubCategorySolution_language] FOREIGN KEY([LanguageID], [CountryID])
REFERENCES [dbo].[language] ([LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[SearchSubCategorySolution] CHECK CONSTRAINT [FK_SearchSubCategorySolution_language]
GO
ALTER TABLE [dbo].[SearchSubCategorySolution]  WITH CHECK ADD  CONSTRAINT [FK_SearchSubCategorySolution_SearchSubCategory] FOREIGN KEY([SearchSubCategoryID], [LanguageID], [CountryID])
REFERENCES [dbo].[SearchSubCategory] ([SearchSubCategoryID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[SearchSubCategorySolution] CHECK CONSTRAINT [FK_SearchSubCategorySolution_SearchSubCategory]
GO
ALTER TABLE [dbo].[SearchSubCategorySolution]  WITH CHECK ADD  CONSTRAINT [FK_SearchSubCategorySolution_Solution] FOREIGN KEY([SolutionID], [LanguageID], [CountryID])
REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[SearchSubCategorySolution] CHECK CONSTRAINT [FK_SearchSubCategorySolution_Solution]
GO
ALTER TABLE [dbo].[serviceaddress]  WITH CHECK ADD  CONSTRAINT [FK__servicead__UserI__56F3D4A3] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[serviceaddress] CHECK CONSTRAINT [FK__servicead__UserI__56F3D4A3]
GO
ALTER TABLE [dbo].[ServiceProfessionalClient]  WITH CHECK ADD  CONSTRAINT [FK_ProviderCustomer_ReferralSource] FOREIGN KEY([ReferralSourceID])
REFERENCES [dbo].[ReferralSource] ([ReferralSourceID])
GO
ALTER TABLE [dbo].[ServiceProfessionalClient] CHECK CONSTRAINT [FK_ProviderCustomer_ReferralSource]
GO
ALTER TABLE [dbo].[ServiceProfessionalClient]  WITH CHECK ADD  CONSTRAINT [FK_ProviderCustomer_users] FOREIGN KEY([ServiceProfessionalUserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[ServiceProfessionalClient] CHECK CONSTRAINT [FK_ProviderCustomer_users]
GO
ALTER TABLE [dbo].[ServiceProfessionalClient]  WITH CHECK ADD  CONSTRAINT [FK_ProviderCustomer_users1] FOREIGN KEY([ClientUserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[ServiceProfessionalClient] CHECK CONSTRAINT [FK_ProviderCustomer_users1]
GO
ALTER TABLE [dbo].[ServiceProfessionalClient]  WITH CHECK ADD  CONSTRAINT [FK_ServiceProfessionalClient_booking] FOREIGN KEY([CreatedByBookingID])
REFERENCES [dbo].[booking] ([BookingID])
GO
ALTER TABLE [dbo].[ServiceProfessionalClient] CHECK CONSTRAINT [FK_ServiceProfessionalClient_booking]
GO
ALTER TABLE [dbo].[servicesubcategory]  WITH CHECK ADD  CONSTRAINT [FK_servicesubcategory_servicecategory] FOREIGN KEY([ServiceCategoryID], [LanguageID], [CountryID])
REFERENCES [dbo].[servicecategory] ([ServiceCategoryID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[servicesubcategory] CHECK CONSTRAINT [FK_servicesubcategory_servicecategory]
GO
ALTER TABLE [dbo].[Solution]  WITH CHECK ADD  CONSTRAINT [FK_Solution_language] FOREIGN KEY([LanguageID], [CountryID])
REFERENCES [dbo].[language] ([LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[Solution] CHECK CONSTRAINT [FK_Solution_language]
GO
ALTER TABLE [dbo].[Specialization]  WITH CHECK ADD  CONSTRAINT [FK_Specialization_Solution] FOREIGN KEY([SolutionID], [LanguageID], [CountryID])
REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[Specialization] CHECK CONSTRAINT [FK_Specialization_Solution]
GO
ALTER TABLE [dbo].[userbackgroundcheck]  WITH CHECK ADD  CONSTRAINT [FK__userbackg__Provi__4BB72C21] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[userbackgroundcheck] CHECK CONSTRAINT [FK__userbackg__Provi__4BB72C21]
GO
ALTER TABLE [dbo].[UserBadge]  WITH CHECK ADD  CONSTRAINT [FK_UserBadge_Solution] FOREIGN KEY([SolutionID], [LanguageID], [CountryID])
REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[UserBadge] CHECK CONSTRAINT [FK_UserBadge_Solution]
GO
ALTER TABLE [dbo].[UserBadge]  WITH CHECK ADD  CONSTRAINT [FK_UserBadge_UserBadge] FOREIGN KEY([UserBadgeID])
REFERENCES [dbo].[UserBadge] ([UserBadgeID])
GO
ALTER TABLE [dbo].[UserBadge] CHECK CONSTRAINT [FK_UserBadge_UserBadge]
GO
ALTER TABLE [dbo].[UserBadge]  WITH CHECK ADD  CONSTRAINT [FK_UserBadge_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserBadge] CHECK CONSTRAINT [FK_UserBadge_users]
GO
ALTER TABLE [dbo].[UserEarnings]  WITH CHECK ADD  CONSTRAINT [FK_UserEarnings_UserEarnings] FOREIGN KEY([UserEarningsID])
REFERENCES [dbo].[UserEarnings] ([UserEarningsID])
GO
ALTER TABLE [dbo].[UserEarnings] CHECK CONSTRAINT [FK_UserEarnings_UserEarnings]
GO
ALTER TABLE [dbo].[UserEarnings]  WITH CHECK ADD  CONSTRAINT [FK_UserEarnings_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserEarnings] CHECK CONSTRAINT [FK_UserEarnings_users]
GO
ALTER TABLE [dbo].[UserEarnings]  WITH CHECK ADD  CONSTRAINT [FK_UserEarnings_users1] FOREIGN KEY([ClientID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserEarnings] CHECK CONSTRAINT [FK_UserEarnings_users1]
GO
ALTER TABLE [dbo].[UserEarningsEntry]  WITH CHECK ADD  CONSTRAINT [FK_UserEarningsEntry_ServiceProfessionalClient] FOREIGN KEY([UserID], [ClientUserID])
REFERENCES [dbo].[ServiceProfessionalClient] ([ServiceProfessionalUserID], [ClientUserID])
GO
ALTER TABLE [dbo].[UserEarningsEntry] CHECK CONSTRAINT [FK_UserEarningsEntry_ServiceProfessionalClient]
GO
ALTER TABLE [dbo].[UserEarningsEntry]  WITH CHECK ADD  CONSTRAINT [FK_UserEarningsEntry_UserExternalListing] FOREIGN KEY([UserExternalListingID])
REFERENCES [dbo].[UserExternalListing] ([UserExternalListingID])
GO
ALTER TABLE [dbo].[UserEarningsEntry] CHECK CONSTRAINT [FK_UserEarningsEntry_UserExternalListing]
GO
ALTER TABLE [dbo].[UserEarningsEntry]  WITH CHECK ADD  CONSTRAINT [FK_UserEarningsEntry_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserEarningsEntry] CHECK CONSTRAINT [FK_UserEarningsEntry_users]
GO
ALTER TABLE [dbo].[usereducation]  WITH CHECK ADD  CONSTRAINT [FK__usereduca__Insti__2D12A970] FOREIGN KEY([InstitutionID])
REFERENCES [dbo].[institution] ([InstitutionID])
GO
ALTER TABLE [dbo].[usereducation] CHECK CONSTRAINT [FK__usereduca__Insti__2D12A970]
GO
ALTER TABLE [dbo].[usereducation]  WITH CHECK ADD  CONSTRAINT [FK__usereduca__UserI__2C1E8537] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[usereducation] CHECK CONSTRAINT [FK__usereduca__UserI__2C1E8537]
GO
ALTER TABLE [dbo].[UserExternalListing]  WITH CHECK ADD  CONSTRAINT [FK_UserExternalListing_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserExternalListing] CHECK CONSTRAINT [FK_UserExternalListing_users]
GO
ALTER TABLE [dbo].[UserLicenseCertifications]  WITH CHECK ADD FOREIGN KEY([ProviderUserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserLicenseCertifications]  WITH CHECK ADD  CONSTRAINT [FK__userlicen__Provi__5B045CA9] FOREIGN KEY([ProviderUserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserLicenseCertifications] CHECK CONSTRAINT [FK__userlicen__Provi__5B045CA9]
GO
ALTER TABLE [dbo].[UserListingSpecialization]  WITH CHECK ADD  CONSTRAINT [FK_UserListingSpecialization_Specialization] FOREIGN KEY([SpecializationID], [LanguageID], [CountryID])
REFERENCES [dbo].[Specialization] ([SpecializationID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[UserListingSpecialization] CHECK CONSTRAINT [FK_UserListingSpecialization_Specialization]
GO
ALTER TABLE [dbo].[UserListingSpecialization]  WITH CHECK ADD  CONSTRAINT [FK_UserListingSpecialization_userprofilepositions] FOREIGN KEY([UserListingID])
REFERENCES [dbo].[userprofilepositions] ([UserListingID])
GO
ALTER TABLE [dbo].[UserListingSpecialization] CHECK CONSTRAINT [FK_UserListingSpecialization_userprofilepositions]
GO
ALTER TABLE [dbo].[UserListingSpecialization]  WITH CHECK ADD  CONSTRAINT [FK_UserListingSpecialization_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserListingSpecialization] CHECK CONSTRAINT [FK_UserListingSpecialization_users]
GO
ALTER TABLE [dbo].[userOrganization]  WITH CHECK ADD  CONSTRAINT [FK_userOrganization_users] FOREIGN KEY([userID])
REFERENCES [dbo].[users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[userOrganization] CHECK CONSTRAINT [FK_userOrganization_users]
GO
ALTER TABLE [dbo].[UserPostingQuestionResponse]  WITH CHECK ADD  CONSTRAINT [FK_UserPostingQuestionResponse_question] FOREIGN KEY([questionID])
REFERENCES [dbo].[question] ([questionID])
GO
ALTER TABLE [dbo].[UserPostingQuestionResponse] CHECK CONSTRAINT [FK_UserPostingQuestionResponse_question]
GO
ALTER TABLE [dbo].[UserPostingQuestionResponse]  WITH CHECK ADD  CONSTRAINT [FK_UserPostingQuestionResponse_questionType] FOREIGN KEY([questionTypeID])
REFERENCES [dbo].[questionType] ([questionTypeID])
GO
ALTER TABLE [dbo].[UserPostingQuestionResponse] CHECK CONSTRAINT [FK_UserPostingQuestionResponse_questionType]
GO
ALTER TABLE [dbo].[UserPostingQuestionResponse]  WITH CHECK ADD  CONSTRAINT [FK_UserPostingQuestionResponse_UserPosting] FOREIGN KEY([userPostingID])
REFERENCES [dbo].[UserPosting] ([userPostingID])
GO
ALTER TABLE [dbo].[UserPostingQuestionResponse] CHECK CONSTRAINT [FK_UserPostingQuestionResponse_UserPosting]
GO
ALTER TABLE [dbo].[UserPostingReaction]  WITH CHECK ADD  CONSTRAINT [FK_UserPostingReaction_UserPosting] FOREIGN KEY([userPostingID])
REFERENCES [dbo].[UserPosting] ([userPostingID])
GO
ALTER TABLE [dbo].[UserPostingReaction] CHECK CONSTRAINT [FK_UserPostingReaction_UserPosting]
GO
ALTER TABLE [dbo].[UserPostingReaction]  WITH CHECK ADD  CONSTRAINT [FK_UserPostingReaction_users] FOREIGN KEY([serviceProfessionalUserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserPostingReaction] CHECK CONSTRAINT [FK_UserPostingReaction_users]
GO
ALTER TABLE [dbo].[userprofilepositions]  WITH CHECK ADD  CONSTRAINT [FK_userprofilepositions_accountstatus] FOREIGN KEY([StatusID])
REFERENCES [dbo].[accountstatus] ([AccountStatusID])
GO
ALTER TABLE [dbo].[userprofilepositions] CHECK CONSTRAINT [FK_userprofilepositions_accountstatus]
GO
ALTER TABLE [dbo].[userprofilepositions]  WITH CHECK ADD  CONSTRAINT [FK_userprofilepositions_positions] FOREIGN KEY([PositionID], [LanguageID], [CountryID])
REFERENCES [dbo].[positions] ([PositionID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[userprofilepositions] CHECK CONSTRAINT [FK_userprofilepositions_positions]
GO
ALTER TABLE [dbo].[userprofilepositions]  WITH CHECK ADD  CONSTRAINT [FK_userprofilepositions_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[userprofilepositions] CHECK CONSTRAINT [FK_userprofilepositions_users]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_accountstatus] FOREIGN KEY([AccountStatusID])
REFERENCES [dbo].[accountstatus] ([AccountStatusID])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_accountstatus]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_OwnerStatus] FOREIGN KEY([OwnerStatusID])
REFERENCES [dbo].[OwnerStatus] ([OwnserStatusID])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_OwnerStatus]
GO
ALTER TABLE [dbo].[UserSolution]  WITH CHECK ADD  CONSTRAINT [FK_UserSolution_Solution] FOREIGN KEY([SolutionID], [LanguageID], [CountryID])
REFERENCES [dbo].[Solution] ([SolutionID], [LanguageID], [CountryID])
GO
ALTER TABLE [dbo].[UserSolution] CHECK CONSTRAINT [FK_UserSolution_Solution]
GO
ALTER TABLE [dbo].[UserSolution]  WITH CHECK ADD  CONSTRAINT [FK_UserSolution_userprofilepositions] FOREIGN KEY([UserListingID])
REFERENCES [dbo].[userprofilepositions] ([UserListingID])
GO
ALTER TABLE [dbo].[UserSolution] CHECK CONSTRAINT [FK_UserSolution_userprofilepositions]
GO
ALTER TABLE [dbo].[UserSolution]  WITH CHECK ADD  CONSTRAINT [FK_UserSolution_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserSolution] CHECK CONSTRAINT [FK_UserSolution_users]
GO
ALTER TABLE [dbo].[UserStats]  WITH CHECK ADD  CONSTRAINT [FK_UserStats_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([UserID])
GO
ALTER TABLE [dbo].[UserStats] CHECK CONSTRAINT [FK_UserStats_users]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[userprofile] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
/****** Object:  StoredProcedure [dbo].[CheckUserEmail]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckUserEmail]
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
/****** Object:  StoredProcedure [dbo].[CreateCustomer]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[CreateProviderFromUser]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[DeleteBookingRequest]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
CREATE PROCEDURE [dbo].[DeleteBookingRequest]
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
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[DeleteUserPosition]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUserPosition] (
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
/****** Object:  StoredProcedure [dbo].[DelUserVerification]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2013-07-15
-- Description:	Delete a user-verification
-- record, if there is one.
-- =============================================
CREATE PROCEDURE [dbo].[DelUserVerification]
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
/****** Object:  StoredProcedure [dbo].[GetPosition]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[GetSearchResults]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[GetServiceAttributeCategories]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[GetServiceAttributes]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[GetUserCalendarProviderAttributes]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetUserCalendarProviderAttributes]

@UserID int


as

SELECT AdvanceTime,MinTime,MaxTime,BetweenTime,UseCalendarProgram,CalendarType,CalendarURL, PrivateCalendarToken, IncrementsSizeInMinutes
FROM CalendarProviderAttributes
WHERE UserID = @UserID
GO
/****** Object:  StoredProcedure [dbo].[GetUserDetails]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROC [dbo].[GetUserDetails]

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
/****** Object:  StoredProcedure [dbo].[GetUserProfile]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserProfile]
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
/****** Object:  StoredProcedure [dbo].[InsertCalendarProviderAttributes]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InsertCalendarProviderAttributes]

@UserID int,
@AdvanceTime decimal(10, 2),
@MinTime decimal(10, 2),
@MaxTime decimal(10, 2),
@BetweenTime decimal(10, 2),
@UseCalendarProgram bit,
@CalendarType varchar(200),
@CalendarURL varchar(500),
@PrivateCalendarToken varchar(128)

as


IF EXISTS (SELECT * FROM CalendarProviderAttributes WHERE UserID = @UserID)

BEGIN 

        
        UPDATE CalendarProviderAttributes
        SET AdvanceTime = @AdvanceTime,
            MinTime = @MinTime,
            MaxTime = @MaxTime,
            BetweenTime = @BetweenTime,
            UseCalendarProgram = @UseCalendarProgram,
            CalendarType = @CalendarType,
            CalendarURL = @CalendarURL,
            PrivateCalendarToken = dbo.fx_IfNW(@PrivateCalendarToken, PrivateCalendarToken)
         WHERE UserID = @UserID 
 
END
ELSE
BEGIN
      
      INSERT INTO CalendarProviderAttributes VALUES (@UserID,@AdvanceTime,@MinTime,@MaxTime,@BetweenTime,@UseCalendarProgram,@CalendarType,@CalendarURL,@PrivateCalendarToken)

END
GO
/****** Object:  StoredProcedure [dbo].[InsertUserProfilePositions]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[ListPositions]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[SearchCategories]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[SearchCategoriesPositions]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[SearchPositions]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[SearchPositionsByCategory]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[SearchProvidersByPositionSingular]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[SearchTopProvidersByPosition]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
CREATE PROCEDURE [dbo].[SearchTopProvidersByPosition]
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
/****** Object:  StoredProcedure [dbo].[SetCalendarProviderAttributes]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[SetHomeAddress]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2013-04-08
-- Description:	Sets the data for the user
-- special 'Home' address, updating the
-- address or inserting a new record if
-- not exists
-- =============================================
CREATE PROCEDURE [dbo].[SetHomeAddress]
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
/****** Object:  StoredProcedure [dbo].[SetUserAlert]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[SetUserVerification]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_MSforeach_worker]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_MSforeachtable]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertAvailability]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertBackgroundCheck]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertBasicInfoVerification]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertEducation]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertLocation]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertPayment]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertPersonalInfo]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertPhoto]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertPositionServices]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertPricingDetails]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertProfessionalLicense]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertPublicBio]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertReferenceRequests]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertShowcaseWork]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertSocialMediaVerification]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertTaxDocs]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAlertVerifyEmail]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAllUserAlerts]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestAllUsersAlerts]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[TestProfileActivation]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[UnDeleteUser]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-08-17
-- Description:	Restore a user account removed
-- throught the page /Account/$Delete/.
-- Of course, only restore from a 'weak delete'
-- =============================================
CREATE PROCEDURE [dbo].[UnDeleteUser]
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
/****** Object:  StoredProcedure [dbo].[ut_AutocheckReviewVerifications]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
CREATE PROCEDURE [dbo].[ut_AutocheckReviewVerifications]
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
/****** Object:  StoredProcedure [dbo].[ut_ModifyUserAlertsState]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[ZZIsUserAProvider]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ZZIsUserAProvider]

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
/****** Object:  Trigger [dbo].[AutoSetMessageSentByUserId]    Script Date: 10/1/18 8:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2014-02-18
-- Description:	Set field SentByUserId based on
-- the MessageTypeID
-- =============================================
CREATE TRIGGER [dbo].[AutoSetMessageSentByUserId]
   ON  [dbo].[Messages]
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
ALTER TABLE [dbo].[Messages] ENABLE TRIGGER [AutoSetMessageSentByUserId]
GO
/****** Object:  Trigger [dbo].[trigInitialProviderPositionAlertTest]    Script Date: 10/1/18 8:41:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Execute all user tests on insert
--  to active all the alerts
-- =============================================
CREATE TRIGGER [dbo].[trigInitialProviderPositionAlertTest]
   ON  [dbo].[userprofilepositions]
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
ALTER TABLE [dbo].[userprofilepositions] ENABLE TRIGGER [trigInitialProviderPositionAlertTest]
GO
/****** Object:  Trigger [dbo].[trigInitialUserAlertTest]    Script Date: 10/1/18 8:41:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Iago Lorenzo Salgueiro
-- Create date: 2012-06-01
-- Description:	Execute all user tests on insert
--  to active all the alerts
-- =============================================
CREATE TRIGGER [dbo].[trigInitialUserAlertTest]
   ON  [dbo].[users]
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
ALTER TABLE [dbo].[users] ENABLE TRIGGER [trigInitialUserAlertTest]
GO
USE [master]
GO
ALTER DATABASE [Dev] SET  READ_WRITE 
GO
