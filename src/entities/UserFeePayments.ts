import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("UserFeePayments",{schema:"dbo"})
export class UserFeePayments {

    @PrimaryGeneratedColumn({
        name:"UserFeePaymentID",
        })
    userFeePaymentId: number;

    @Column("int",{
        nullable:false,
        name:"UserID",
        })
    userId: number;

    @Column("varchar",{
        nullable:false,
        length:250,
        name:"PaymentTransactionID",
        })
    paymentTransactionId: string;

    @Column("varchar",{
        nullable:false,
        length:250,
        name:"SubscriptionID",
        })
    subscriptionId: string;

    @Column("datetimeoffset",{
        nullable:false,
        name:"PaymentDate",
        })
    paymentDate: Date;

    @Column("money",{
        nullable:false,
        name:"PaymentAmount",
        })
    paymentAmount: number;

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"PaymentPlan",
        })
    paymentPlan: string;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"PaymentMethod",
        })
    paymentMethod: string;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"PaymentStatus",
        })
    paymentStatus: string;

    @Column("datetimeoffset",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetimeoffset",{
        nullable:false,
        name:"ModifiedDate",
        })
    modifiedDate: Date;

}
