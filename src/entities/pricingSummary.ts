import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("pricingSummary",{schema:"dbo"})
export class PricingSummary {

    @OneToOne((type)=>PricingSummary, (PricingSummary)=>PricingSummary.pricingSummary,{ primary:true, nullable:false })
    @JoinColumn({ name:"PricingSummaryID"})
    pricingSummary3: Promise<PricingSummary | null>;

    @OneToOne((type)=>PricingSummary, (PricingSummary)=>PricingSummary.pricingSummary2,{ primary:true, nullable:false })
    @JoinColumn({ name:"PricingSummaryRevision"})
    pricingSummaryRevision: Promise<PricingSummary | null>;

    @Column("int",{
        nullable:true,
        name:"ServiceDurationMinutes",
        })
    serviceDurationMinutes: number | null;

    @Column("int",{
        nullable:true,
        name:"FirstSessionDurationMinutes",
        })
    firstSessionDurationMinutes: number | null;

    @Column("decimal",{
        nullable:true,
        precision:7,
        scale:2,
        name:"SubtotalPrice",
        })
    subtotalPrice: number | null;

    @Column("decimal",{
        nullable:true,
        precision:7,
        scale:2,
        name:"ClientServiceFeePrice",
        })
    clientServiceFeePrice: number | null;

    @Column("decimal",{
        nullable:true,
        precision:7,
        scale:2,
        name:"TotalPrice",
        })
    totalPrice: number | null;

    @Column("decimal",{
        nullable:true,
        default:"((0))",
        precision:7,
        scale:2,
        name:"ServiceFeeAmount",
        })
    serviceFeeAmount: number | null;

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

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

    @Column("datetime",{
        nullable:true,
        name:"CancellationDate",
        })
    cancellationDate: Date | null;

    @Column("decimal",{
        nullable:true,
        precision:7,
        scale:2,
        name:"CancellationFeeCharged",
        })
    cancellationFeeCharged: number | null;

    @Column("decimal",{
        nullable:false,
        default:"((0))",
        precision:5,
        scale:2,
        name:"FirstTimeServiceFeeFixed",
        })
    firstTimeServiceFeeFixed: number;

    @Column("decimal",{
        nullable:false,
        default:"((0))",
        precision:5,
        scale:2,
        name:"FirstTimeServiceFeePercentage",
        })
    firstTimeServiceFeePercentage: number;

    @Column("decimal",{
        nullable:false,
        default:"((0))",
        precision:5,
        scale:2,
        name:"PaymentProcessingFeePercentage",
        })
    paymentProcessingFeePercentage: number;

    @Column("decimal",{
        nullable:false,
        default:"((0))",
        precision:5,
        scale:2,
        name:"PaymentProcessingFeeFixed",
        })
    paymentProcessingFeeFixed: number;

    @Column("decimal",{
        nullable:false,
        default:"((0))",
        precision:5,
        scale:2,
        name:"FirstTimeServiceFeeMaximum",
        })
    firstTimeServiceFeeMaximum: number;

    @Column("decimal",{
        nullable:false,
        default:"((0))",
        precision:5,
        scale:2,
        name:"FirstTimeServiceFeeMinimum",
        })
    firstTimeServiceFeeMinimum: number;

    @OneToOne((type)=>PricingSummary, (PricingSummary)=>PricingSummary.pricingSummary3)
    pricingSummary: Promise<PricingSummary | null>;

    @OneToOne((type)=>PricingSummary, (PricingSummary)=>PricingSummary.pricingSummaryRevision)
    pricingSummary2: Promise<PricingSummary | null>;

}
