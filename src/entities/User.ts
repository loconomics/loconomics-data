import {
    Column,
    Entity,
    Index,
    JoinColumn,
    JoinTable,
    ManyToMany,
    ManyToOne,
    OneToMany,
    OneToOne,
    PrimaryColumn,
    PrimaryGeneratedColumn,
    RelationId,
} from "typeorm";

import {AccountStatus} from "./AccountStatus"
import {CalendarProviderAttribute} from "./CalendarProviderAttribute"
import {CCCUser} from "./CCCUser"
import {MessagingThread} from "./MessagingThread"
import {OwnerAcknowledgment} from "./OwnerAcknowledgment";
import {OwnerStatus} from "./OwnerStatus";
import {ServiceAddress} from "./ServiceAddress"
import {ServiceProfessionalClient} from "./ServiceProfessionalClient"
import {UserBackgroundCheck} from "./UserBackgroundCheck"
import {UserBadge} from "./UserBadge";
import {UserEarning} from "./UserEarning"
import {UserEarningsEntry} from "./UserEarningsEntry";
import {UserEducation} from "./UserEducation"
import {UserExternalListing} from "./UserExternalListing";
import {UserListingSpecialization} from "./UserListingSpecialization";
import {UserOrganization} from "./UserOrganization"
import {UserPostingReaction} from "./UserPostingReaction";
import {UserProfilePosition} from "./UserProfilePosition"
import {UserSolution} from "./UserSolution";
import {UserStat} from "./UserStat"

@Entity("users",{schema:"dbo"})
export class User {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"UserID",
        })
    userId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"FirstName",
        })
    firstName: string;

    @Column("varchar",{
        nullable:false,
        length:1,
        name:"MiddleIn",
        })
    middleIn: string;

    @Column("varchar",{
        nullable:false,
        length:145,
        name:"LastName",
        })
    lastName: string;

    @Column("varchar",{
        nullable:false,
        length:145,
        name:"SecondLastName",
        })
    secondLastName: string;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"NickName",
        })
    nickName: string | null;

    @Column("varchar",{
        nullable:true,
        length:4000,
        name:"PublicBio",
        })
    publicBio: string | null;

    @Column("int",{
        nullable:false,
        default:"((-1))",
        name:"GenderID",
        })
    genderId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"PreferredLanguage",
        })
    preferredLanguage: string;

    @Column("nvarchar",{
        nullable:true,
        length:2,
        name:"SignupCountryCode",
        })
    signupCountryCode: string;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsProvider",
        })
    isProvider: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsCustomer",
        })
    isCustomer: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsAdmin",
        })
    isAdmin: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsCollaborator",
        })
    isCollaborator: boolean;

    @Column("varchar",{
        nullable:true,
        length:150,
        name:"Photo",
        })
    photo: string | null;

    @Column("varchar",{
        nullable:true,
        length:20,
        name:"MobilePhone",
        })
    mobilePhone: string | null;

    @Column("varchar",{
        nullable:true,
        length:20,
        name:"AlternatePhone",
        })
    alternatePhone: string | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"CanReceiveSms",
        })
    canReceiveSms: boolean;

    @Column("varchar",{
        nullable:true,
        length:2078,
        name:"ProviderProfileURL",
        })
    providerProfileUrl: string | null;

    @Column("varchar",{
        nullable:true,
        length:2078,
        name:"ProviderWebsiteURL",
        })
    providerWebsiteUrl: string | null;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"SMSBookingCommunication",
        })
    smsBookingCommunication: boolean;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"PhoneBookingCommunication",
        })
    phoneBookingCommunication: boolean;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"LoconomicsMarketingCampaigns",
        })
    loconomicsMarketingCampaigns: boolean;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"ProfileSEOPermission",
        })
    profileSeoPermission: boolean;

    @Column("datetime",{
        nullable:true,
        name:"CreatedDate",
        })
    createdDate: Date | null;

    @Column("datetime",{
        nullable:true,
        name:"UpdatedDate",
        })
    updatedDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"ModifiedBy",
        })
    modifiedBy: string | null;

    @Column("bit",{
        nullable:true,
        name:"Active",
        })
    active: boolean | null;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"LoconomicsCommunityCommunication",
        })
    loconomicsCommunityCommunication: boolean;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"LoconomicsDBMCampaigns",
        })
    loconomicsDbmCampaigns: boolean;

    @ManyToOne((type) => AccountStatus, (AccountStatus) => AccountStatus.user,{  nullable:false })
    @JoinColumn({ name:"AccountStatusID"})
    accountStatus: Promise<AccountStatus | null>;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"CoBrandedPartnerPermissions",
        })
    coBrandedPartnerPermissions: boolean;

    @Column("varchar",{
        nullable:true,
        length:2055,
        name:"MarketingSource",
        })
    marketingSource: string | null;

    @Column("varchar",{
        nullable:true,
        length:64,
        name:"BookCode",
        })
    bookCode: string | null;

    @Column("varchar",{
        nullable:true,
        length:60,
        name:"OnboardingStep",
        })
    onboardingStep: string | null;

    @Column("int",{
        nullable:true,
        name:"BirthMonthDay",
        })
    birthMonthDay: number | null;

    @Column("int",{
        nullable:true,
        name:"BirthMonth",
        })
    birthMonth: number | null;

    @Column("nvarchar",{
        nullable:true,
        length:145,
        name:"BusinessName",
        })
    businessName: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:56,
        name:"AlternativeEmail",
        })
    alternativeEmail: string | null;

    @Column("int",{
        nullable:true,
        name:"ReferredByUserID",
        })
    referredByUserId: number | null;

    @Column("nvarchar",{
        nullable:true,
        length:20,
        name:"SignupDevice",
        })
    signupDevice: string | null;

    @ManyToOne((type)=>OwnerStatus, (OwnerStatus)=>OwnerStatus.userss,{  })
    @JoinColumn({ name:"OwnerStatusID"})
    ownerStatus: Promise<OwnerStatus | null>;

    @Column("datetime",{
        nullable:true,
        name:"OwnerAnniversaryDate",
        })
    ownerAnniversaryDate: Date | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsHipaaAdmin",
        })
    isHipaaAdmin: boolean;

    @Column("bit",{
        nullable:true,
        default:"(CONVERT([bit],(0),(0)))",
        name:"IsContributor",
        })
    isContributor: boolean | null;

    @Column("datetimeoffset",{
        nullable:true,
        name:"TrialEndDate",
        })
    trialEndDate: Date | null;

    @Column("int",{
        nullable:true,
        name:"BirthYear",
        })
    birthYear: number | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsOrganization",
        })
    isOrganization: boolean;

    @OneToOne(
        (type) => CalendarProviderAttribute,
        (CalendarProviderAttribute) => CalendarProviderAttribute.user, {
            onDelete: "CASCADE",
            onUpdate: "CASCADE",
        },
    )
    calendarProviderAttributes: Promise<CalendarProviderAttribute | null>;

    @OneToOne(
        (type) => CCCUser,
        (CCCUser) => CCCUser.user,
    )
    cccUser: Promise<CCCUser | null>;

    @OneToMany((type) => MessagingThread, (MessagingThread) => MessagingThread.customerUser)
    customerMessages: Promise<MessagingThread[]>;

    @OneToMany((type) => MessagingThread, (MessagingThread) => MessagingThread.providerUser)
    providerMessages: Promise<MessagingThread[]>;

    @OneToOne((type)=>OwnerAcknowledgment, (OwnerAcknowledgment)=>OwnerAcknowledgment.user)
    ownerAcknowledgment: Promise<OwnerAcknowledgment | null>;

    @OneToOne((type) => ServiceAddress, (ServiceAddress) => ServiceAddress.user)
    serviceaddress: Promise<ServiceAddress | null>;

    @OneToOne(
        (type) => ServiceProfessionalClient,
        (ServiceProfessionalClient) => ServiceProfessionalClient.serviceProfessionalUser,
    )
    serviceProfessionalClient: Promise<ServiceProfessionalClient | null>;

    @OneToOne((type)=>ServiceProfessionalClient, (ServiceProfessionalClient)=>ServiceProfessionalClient.clientUser)
    serviceProfessionalClient2: Promise<ServiceProfessionalClient | null>;

    @OneToOne((type) => UserBackgroundCheck, (UserBackgroundCheck) => UserBackgroundCheck.user)
    userbackgroundcheck: Promise<UserBackgroundCheck | null>;

    @OneToMany((type)=>UserBadge, (UserBadge)=>UserBadge.user)
    userBadges: Promise<UserBadge[]>;

    @OneToMany((type) => UserEarning, (UserEarning) => UserEarning.user)
    userEarnings: Promise<UserEarning[]>;

    @OneToMany((type) => UserEarning, (UserEarning) => UserEarning.client)
    clientUserEarnings: Promise<UserEarning[]>;

    @OneToOne((type)=>UserEarningsEntry, (UserEarningsEntry)=>UserEarningsEntry.user)
    userEarningsEntry: Promise<UserEarningsEntry | null>;

    @OneToMany((type) => UserEducation, (UserEducation) => UserEducation.user)
    usereducations: Promise<UserEducation[]>;

    @OneToMany((type)=>UserExternalListing, (UserExternalListing)=>UserExternalListing.user)
    userExternalListings: Promise<UserExternalListing[]>;

    @OneToOne((type)=>UserListingSpecialization, (UserListingSpecialization)=>UserListingSpecialization.user)
    userListingSpecialization: Promise<UserListingSpecialization | null>;

    @OneToOne(
        (type) => UserOrganization,
        (UserOrganization) => UserOrganization.user, {
            onDelete: "CASCADE",
            onUpdate: "CASCADE",
        },
    )
    userOrganization: Promise<UserOrganization | null>;

    @OneToOne((type)=>UserPostingReaction, (UserPostingReaction)=>UserPostingReaction.serviceProfessionalUser)
    userPostingReaction: Promise<UserPostingReaction | null>;

    @OneToOne((type) => UserProfilePosition, (UserProfilePosition) => UserProfilePosition.user)
    userprofilepositions: Promise<UserProfilePosition | null>;

    @OneToMany((type)=>UserSolution, (UserSolution)=>UserSolution.user)
    userSolutions: Promise<UserSolution[]>;

    @OneToOne((type) => UserStat, (UserStat) => UserStat.user)
    userStats: Promise<UserStat | null>;

}
