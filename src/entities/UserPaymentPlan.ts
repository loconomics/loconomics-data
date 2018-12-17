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

@Entity("UserPaymentPlan",{schema:"dbo"})
export class UserPaymentPlan {

    @PrimaryGeneratedColumn({
        name:"UserPaymentPlanID",
        })
    userPaymentPlanId: number;

    @Column("int",{
        nullable:false,
        name:"UserID",
        })
    userId: number;

    @Column("varchar",{
        nullable:false,
        length:250,
        name:"SubscriptionID",
        })
    subscriptionId: string;

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

    @Column("datetimeoffset",{
        nullable:false,
        name:"PaymentPlanLastChangedDate",
        })
    paymentPlanLastChangedDate: Date;

    @Column("datetimeoffset",{
        nullable:true,
        name:"NextPaymentDueDate",
        })
    nextPaymentDueDate: Date | null;

    @Column("money",{
        nullable:true,
        name:"NextPaymentAmount",
        })
    nextPaymentAmount: number | null;

    @Column("datetimeoffset",{
        nullable:false,
        name:"FirstBillingDate",
        })
    firstBillingDate: Date;

    @Column("datetimeoffset",{
        nullable:true,
        name:"SubscriptionEndDate",
        })
    subscriptionEndDate: Date | null;

    @Column("varchar",{
        nullable:false,
        length:250,
        name:"PaymentMethodToken",
        })
    paymentMethodToken: string;

    @Column("datetimeoffset",{
        nullable:true,
        name:"PaymentExpiryDate",
        })
    paymentExpiryDate: Date | null;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"PlanStatus",
        })
    planStatus: string;

    @Column("int",{
        nullable:false,
        default:"((0))",
        name:"DaysPastDue",
        })
    daysPastDue: number;

}
