import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {ServiceProfessionalClient} from "./ServiceProfessionalClient"

@Entity("booking",{schema:"dbo"})
export class Booking {

    @PrimaryGeneratedColumn({
        name:"BookingID",
        })
    bookingId: number;

    @Column("int",{
        nullable:true,
        name:"ClientUserID",
        })
    clientUserId: number | null;

    @Column("int",{
        nullable:true,
        name:"ServiceProfessionalUserID",
        })
    serviceProfessionalUserId: number | null;

    @Column("int",{
        nullable:false,
        name:"JobTitleID",
        })
    jobTitleId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("int",{
        nullable:false,
        name:"BookingStatusID",
        })
    bookingStatusId: number;

    @Column("int",{
        nullable:false,
        name:"BookingTypeID",
        })
    bookingTypeId: number;

    @Column("int",{
        nullable:false,
        name:"CancellationPolicyID",
        })
    cancellationPolicyId: number;

    @Column("int",{
        nullable:true,
        name:"ParentBookingID",
        })
    parentBookingId: number | null;

    @Column("int",{
        nullable:true,
        name:"ServiceAddressID",
        })
    serviceAddressId: number | null;

    @Column("int",{
        nullable:true,
        name:"ServiceDateID",
        })
    serviceDateId: number | null;

    @Column("int",{
        nullable:true,
        name:"AlternativeDate1ID",
        })
    alternativeDate1Id: number | null;

    @Column("int",{
        nullable:true,
        name:"AlternativeDate2ID",
        })
    alternativeDate2Id: number | null;

    @Column("int",{
        nullable:false,
        name:"PricingSummaryID",
        })
    pricingSummaryId: number;

    @Column("int",{
        nullable:false,
        name:"PricingSummaryRevision",
        })
    pricingSummaryRevision: number;

    @Column("varchar",{
        nullable:true,
        length:250,
        name:"PaymentTransactionID",
        })
    paymentTransactionId: string | null;

    @Column("varchar",{
        nullable:true,
        length:64,
        name:"PaymentLastFourCardNumberDigits",
        })
    paymentLastFourCardNumberDigits: string | null;

    @Column("varchar",{
        nullable:true,
        length:250,
        name:"paymentMethodID",
        })
    paymentMethodId: string | null;

    @Column("varchar",{
        nullable:true,
        length:250,
        name:"cancellationPaymentTransactionID",
        })
    cancellationPaymentTransactionId: string | null;

    @Column("decimal",{
        nullable:true,
        precision:25,
        scale:2,
        name:"ClientPayment",
        })
    clientPayment: number | null;

    @Column("decimal",{
        nullable:true,
        precision:25,
        scale:2,
        name:"ServiceProfessionalPaid",
        })
    serviceProfessionalPaid: number | null;

    @Column("decimal",{
        nullable:true,
        precision:25,
        scale:2,
        name:"ServiceProfessionalPPFeePaid",
        })
    serviceProfessionalPpFeePaid: number | null;

    @Column("decimal",{
        nullable:true,
        precision:25,
        scale:2,
        name:"LoconomicsPaid",
        })
    loconomicsPaid: number | null;

    @Column("decimal",{
        nullable:true,
        precision:25,
        scale:2,
        name:"LoconomicsPPFeePaid",
        })
    loconomicsPpFeePaid: number | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"InstantBooking",
        })
    instantBooking: boolean;

    @Column("bit",{
        nullable:false,
        name:"FirstTimeBooking",
        })
    firstTimeBooking: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"SendReminder",
        })
    sendReminder: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"SendPromotional",
        })
    sendPromotional: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"Recurrent",
        })
    recurrent: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"MultiSession",
        })
    multiSession: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"PricingAdjustmentApplied",
        })
    pricingAdjustmentApplied: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"PaymentEnabled",
        })
    paymentEnabled: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"PaymentCollected",
        })
    paymentCollected: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"PaymentAuthorized",
        })
    paymentAuthorized: boolean;

    @Column("int",{
        nullable:true,
        name:"AwaitingResponseFromUserID",
        })
    awaitingResponseFromUserId: number | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"PricingAdjustmentRequested",
        })
    pricingAdjustmentRequested: boolean;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"SupportTicketNumber",
        })
    supportTicketNumber: string | null;

    @Column("nvarchar",{
        nullable:false,
        length:400,
        default:"('')",
        name:"MessagingLog",
        })
    messagingLog: string;

    @Column("datetime",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetime",{
        nullable:false,
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("text",{
        nullable:true,
        name:"SpecialRequests",
        })
    specialRequests: string | null;

    @Column("text",{
        nullable:true,
        name:"PreNotesToClient",
        })
    preNotesToClient: string | null;

    @Column("text",{
        nullable:true,
        name:"PostNotesToClient",
        })
    postNotesToClient: string | null;

    @Column("text",{
        nullable:true,
        name:"PreNotesToSelf",
        })
    preNotesToSelf: string | null;

    @Column("text",{
        nullable:true,
        name:"PostNotesToSelf",
        })
    postNotesToSelf: string | null;

    @OneToMany((type)=>ServiceProfessionalClient, (ServiceProfessionalClient)=>ServiceProfessionalClient.createdByBooking)
    serviceProfessionalClients: Promise<ServiceProfessionalClient[]>;

}
