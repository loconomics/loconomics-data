import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("bookingType",{schema:"dbo"})
export class BookingType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"BookingTypeID",
        })
    bookingTypeId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"BookingTypeName",
        })
    bookingTypeName: string;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"BookingTypeDescription",
        })
    bookingTypeDescription: string | null;

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

}
