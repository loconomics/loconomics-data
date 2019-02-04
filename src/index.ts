import "reflect-metadata"
import {createConnection} from "typeorm"

import {AccountStatus} from "./entities/AccountStatus"
import {Address} from "./entities/Address"
import {AddressType} from "./entities/AddressType"
import {Alert} from "./entities/Alert"
import {AlertType} from "./entities/AlertType"
import {Authorization} from "./entities/Authorization"
import {BackgroundCheck} from "./entities/BackgroundCheck"
import {Booking} from "./entities/Booking"
import {BookingStatus} from "./entities/BookingStatus"
import {BookingType} from "./entities/BookingType"
import {CalendarAvailabilityType} from "./entities/CalendarAvailabilityType"
import {CalendarEvent} from "./entities/CalendarEvent"
import {CalendarEventAttendee} from "./entities/CalendarEventAttendee"
import {CalendarEventComment} from "./entities/CalendarEventComment"
import {CalendarEventContact} from "./entities/CalendarEventContact"
import {CalendarEventExceptionPeriod} from "./entities/CalendarEventExceptionPeriod"
import {CalendarEventExceptionPeriodList} from "./entities/CalendarEventExceptionPeriodList"
import {CalendarEventRecurrencePeriod} from "./entities/CalendarEventRecurrencePeriod"
import {CalendarEventRecurrencePeriodList} from "./entities/CalendarEventRecurrencePeriodList"
import {CalendarEventType} from "./entities/CalendarEventType"
import {CalendarProviderAttribute} from "./entities/CalendarProviderAttribute"
import {CalendarRecurrence} from "./entities/CalendarRecurrence"
import {CalendarRecurrenceFrequencyType} from "./entities/CalendarRecurrenceFrequencyType"
import {CancellationPolicy} from "./entities/CancellationPolicy"
import {CCCUser} from "./entities/CCCUser"
import {ClientType} from "./entities/ClientType"
import {Country} from "./entities/Country"
import {County} from "./entities/County"
import {ExperienceLevel} from "./entities/ExperienceLevel"
import {FieldOfStudy} from "./entities/FieldOfStudy"
import {Gender} from "./entities/Gender"
import {Institution} from "./entities/Institution"
import {JobTitleLicense} from "./entities/JobTitleLicense"
import {JobTitlePlatform} from "./entities/JobTitlePlatform"
import {LanguageLevel} from "./entities/LanguageLevel"
import {LicenseCertification} from "./entities/LicenseCertification"
import {Message} from "./entities/Message"
import {MessageThreadStatus} from "./entities/MessageThreadStatus"
import {MessageType} from "./entities/MessageType"
import {MessagingThread} from "./entities/MessagingThread"
import {Municipality} from "./entities/Municipality"
import {OwnerAcknowledgment} from "./entities/OwnerAcknowledgment"
import {OwnerStatus} from "./entities/OwnerStatus"
import {OwnerStatusHistory} from "./entities/OwnerStatusHistory"
import {Platform} from "./entities/Platform"
import {Position} from "./entities/Position"
import {PositionBackgroundCheck} from "./entities/PositionBackgroundCheck"
import {PositionPricingType} from "./entities/PositionPricingType"
import {PositionRating} from "./entities/PositionRating"
import {PostalCode} from "./entities/PostalCode"
import {PostingTemplate} from "./entities/PostingTemplate"
import {PostingTemplateQuestion} from "./entities/PostingTemplateQuestion"
import {PricingGroup} from "./entities/PricingGroup"
import {PricingSummary} from "./entities/PricingSummary"
import {PricingSummaryDetail} from "./entities/PricingSummaryDetail"
import {PricingType} from "./entities/PricingType"
import {PricingVariableDefinition} from "./entities/PricingVariableDefinition"
import {PricingVariableValue} from "./entities/PricingVariableValue"
import {ProviderPackage} from "./entities/ProviderPackage"
import {ProviderPackageDetail} from "./entities/ProviderPackageDetail"
import {ProviderPaymentAccount} from "./entities/ProviderPaymentAccount"
import {ProviderPaymentPreference} from "./entities/ProviderPaymentPreference"
import {ProviderPaymentPreferenceType} from "./entities/ProviderPaymentPreferenceType"
import {ProviderServicePhoto} from "./entities/ProviderServicePhoto"
import {ProviderTaxForm} from "./entities/ProviderTaxForm"
import {Question} from "./entities/Question"
import {QuestionType} from "./entities/QuestionType"
import {ReferralSource} from "./entities/ReferralSource"
import {SearchCategory} from "./entities/SearchCategory"
import {SearchSubcategory} from "./entities/SearchSubcategory"
import {SearchSubcategorySolution} from "./entities/SearchSubcategorySolution"
import {ServiceAddress} from "./entities/ServiceAddress"
import {ServiceAttribute} from "./entities/ServiceAttribute"
import {ServiceAttributeExperienceLevel} from "./entities/ServiceAttributeExperienceLevel"
import {ServiceAttributeCategory} from "./entities/ServiceAttributeCategory"
import {ServiceAttributeLanguageLevel} from "./entities/ServiceAttributeLanguageLevel"
import {ServiceCategory} from "./entities/ServiceCategory"
import {ServiceCategoryPosition} from "./entities/ServiceCategoryPosition"
import {ServiceCategoryPositionAttribute} from "./entities/ServiceCategoryPositionAttribute"
import {ServiceProfessionalClient} from "./entities/ServiceProfessionalClient"
import {ServiceSubcategory} from "./entities/ServiceSubcategory"
import {Solution} from "./entities/Solution"
import {Specialization} from "./entities/Specialization"
import {StateProvince} from "./entities/StateProvince"
import {TaxEntityType} from "./entities/TaxEntityType"
import {TinType} from "./entities/TinType"
import {TransportType} from "./entities/TransportType"
import {User} from "./entities/User"
import {UserAlert} from "./entities/UserAlert"
import {UserBadge} from "./entities/UserBadge"
import {UserEarning} from "./entities/UserEarning"
import {UserEarningsEntry} from "./entities/UserEarningsEntry"
import {UserExternalListing} from "./entities/UserExternalListing"
import {UserFeePayment} from "./entities/UserFeePayment"
import {UserListingSpecialization} from "./entities/UserListingSpecialization"
import {UserPaymentPlan} from "./entities/UserPaymentPlan"
import {UserBackgroundCheck} from "./entities/UserBackgroundCheck"
import {UserEducation} from "./entities/UserEducation"
import {UserLicenseCertification} from "./entities/UserLicenseCertification"
import {UserOrganization} from "./entities/UserOrganization"
import {UserPosting} from "./entities/UserPosting"
import {UserPostingQuestionResponse} from "./entities/UserPostingQuestionResponse"
import {UserPostingReaction} from "./entities/UserPostingReaction"
import {UserProfile} from "./entities/UserProfile"
import {UserProfilePosition} from "./entities/UserProfilePosition"
import {UserProfileServiceAttribute} from "./entities/UserProfileServiceAttribute"
import {UserReview} from "./entities/UserReview"
import {UserReviewScore} from "./entities/UserReviewScore"
import {UserSignup} from "./entities/UserSignup"
import {UserSolution} from "./entities/UserSolution"
import {UserStat} from "./entities/UserStat"
import {UserVerification} from "./entities/UserVerification"
import {Verification} from "./entities/Verification"
import {VerificationCategory} from "./entities/VerificationCategory"
import {VerificationStatus} from "./entities/VerificationStatus"
import {VOCElement} from "./entities/VOCElement"
import {VOCExperienceCategory} from "./entities/VOCExperienceCategory"
import {VOCFeedback} from "./entities/VOCFeedback"
import {VOCFlag} from "./entities/VOCFlag"
import {VOCScore} from "./entities/VOCScore"
import {WebpageFacebookCredential} from "./entities/WebpageFacebookCredential"
import {WebpageMembership} from "./entities/WebpageMembership"
import {WebpageOAuthMembership} from "./entities/WebpageOAuthMembership"
import {WebpageRole} from "./entities/WebpageRole"
import {XJobTitlePricing} from "./entities/XJobTitlePricing"
import {XJobTitleReviewRule} from "./entities/XJobTitleReviewRule"
import {XServiceProfessionalPricing} from "./entities/XServiceProfessionalPricing"

export {
  AccountStatus,
  Address,
  AddressType,
  Alert,
  AlertType,
  Authorization,
  BackgroundCheck,
  Booking,
  BookingStatus,
  BookingType,
  CalendarAvailabilityType,
  CalendarEvent,
  CalendarEventAttendee,
  CalendarEventComment,
  CalendarEventContact,
  CalendarEventExceptionPeriod,
  CalendarEventExceptionPeriodList,
  CalendarEventRecurrencePeriod,
  CalendarEventRecurrencePeriodList,
  CalendarEventType,
  CalendarProviderAttribute,
  CalendarRecurrence,
  CalendarRecurrenceFrequencyType,
  CancellationPolicy,
  CCCUser,
  ClientType,
  Country,
  County,
  ExperienceLevel,
  FieldOfStudy,
  Gender,
  Institution,
  JobTitleLicense,
  JobTitlePlatform,
  LanguageLevel,
  LicenseCertification,
  Message,
  MessageThreadStatus,
  MessageType,
  MessagingThread,
  Municipality,
  OwnerAcknowledgment,
  OwnerStatus,
  OwnerStatusHistory,
  Platform,
  Position,
  PositionBackgroundCheck,
  PositionPricingType,
  PositionRating,
  PostalCode,
  PostingTemplate,
  PostingTemplateQuestion,
  PricingGroup,
  PricingSummary,
  PricingSummaryDetail,
  PricingType,
  PricingVariableDefinition,
  PricingVariableValue,
  ProviderPackage,
  ProviderPackageDetail,
  ProviderPaymentAccount,
  ProviderPaymentPreference,
  ProviderPaymentPreferenceType,
  ProviderServicePhoto,
  ProviderTaxForm,
  Question,
  QuestionType,
  ReferralSource,
  SearchCategory,
  SearchSubcategory,
  SearchSubcategorySolution,
  ServiceAddress,
  ServiceAttribute,
  ServiceAttributeExperienceLevel,
  ServiceAttributeCategory,
  ServiceAttributeLanguageLevel,
  ServiceCategory,
  ServiceCategoryPosition,
  ServiceCategoryPositionAttribute,
  ServiceProfessionalClient,
  ServiceSubcategory,
  Solution,
  Specialization,
  StateProvince,
  TaxEntityType,
  TinType,
  TransportType,
  User,
  UserAlert,
  UserBadge,
  UserEarning,
  UserEarningsEntry,
  UserExternalListing,
  UserFeePayment,
  UserListingSpecialization,
  UserPaymentPlan,
  UserBackgroundCheck,
  UserEducation,
  UserLicenseCertification,
  UserOrganization,
  UserPosting,
  UserPostingQuestionResponse,
  UserPostingReaction,
  UserProfile,
  UserProfilePosition,
  UserProfileServiceAttribute,
  UserReview,
  UserReviewScore,
  UserSignup,
  UserSolution,
  UserStat,
  UserVerification,
  Verification,
  VerificationCategory,
  VerificationStatus,
  VOCElement,
  VOCExperienceCategory,
  VOCFeedback,
  VOCFlag,
  VOCScore,
  WebpageFacebookCredential,
  WebpageMembership,
  WebpageOAuthMembership,
  WebpageRole,
  XJobTitlePricing,
  XJobTitleReviewRule,
  XServiceProfessionalPricing,
}

export default createConnection({
  type: "mssql",
  url: process.env.MSSQLSERVER_URL,
  entities: [
    AccountStatus,
    Address,
    AddressType,
    Alert,
    AlertType,
    Authorization,
    BackgroundCheck,
    Booking,
    BookingStatus,
    BookingType,
    CalendarAvailabilityType,
    CalendarEvent,
    CalendarEventAttendee,
    CalendarEventComment,
    CalendarEventContact,
    CalendarEventExceptionPeriod,
    CalendarEventExceptionPeriodList,
    CalendarEventRecurrencePeriod,
    CalendarEventRecurrencePeriodList,
    CalendarEventType,
    CalendarProviderAttribute,
    CalendarRecurrence,
    CalendarRecurrenceFrequencyType,
    CancellationPolicy,
    CCCUser,
    ClientType,
    Country,
    County,
    ExperienceLevel,
    FieldOfStudy,
    Gender,
    Institution,
    JobTitleLicense,
    JobTitlePlatform,
    LanguageLevel,
    LicenseCertification,
    Message,
    MessageThreadStatus,
    MessageType,
    MessagingThread,
    Municipality,
    OwnerAcknowledgment,
    OwnerStatus,
    OwnerStatusHistory,
    Platform,
    Position,
    PositionBackgroundCheck,
    PositionPricingType,
    PositionRating,
    PostalCode,
    PostingTemplate,
    PostingTemplateQuestion,
    PricingGroup,
    PricingSummary,
    PricingSummaryDetail,
    PricingType,
    PricingVariableDefinition,
    PricingVariableValue,
    ProviderPackage,
    ProviderPackageDetail,
    ProviderPaymentAccount,
    ProviderPaymentPreference,
    ProviderPaymentPreferenceType,
    ProviderServicePhoto,
    ProviderTaxForm,
    Question,
    QuestionType,
    ReferralSource,
    SearchCategory,
    SearchSubcategory,
    SearchSubcategorySolution,
    ServiceAddress,
    ServiceAttribute,
    ServiceAttributeExperienceLevel,
    ServiceAttributeCategory,
    ServiceAttributeLanguageLevel,
    ServiceCategory,
    ServiceCategoryPosition,
    ServiceCategoryPositionAttribute,
    ServiceProfessionalClient,
  ServiceSubcategory,
    Solution,
    Specialization,
    StateProvince,
    TaxEntityType,
    TinType,
    TransportType,
    User,
    UserAlert,
    UserBadge,
    UserEarning,
    UserEarningsEntry,
    UserExternalListing,
    UserFeePayment,
    UserListingSpecialization,
    UserPaymentPlan,
    UserBackgroundCheck,
    UserEducation,
    UserLicenseCertification,
    UserOrganization,
    UserPosting,
    UserPostingQuestionResponse,
    UserPostingReaction,
    UserProfile,
    UserProfilePosition,
    UserProfileServiceAttribute,
    UserReview,
    UserReviewScore,
    UserSignup,
    UserSolution,
    UserStat,
    UserVerification,
    Verification,
    VerificationCategory,
    VerificationStatus,
    VOCElement,
    VOCExperienceCategory,
    VOCFeedback,
    VOCFlag,
    VOCScore,
    WebpageFacebookCredential,
    WebpageMembership,
    WebpageOAuthMembership,
    WebpageRole,
    XJobTitlePricing,
    XJobTitleReviewRule,
    XServiceProfessionalPricing,
  ]
})
