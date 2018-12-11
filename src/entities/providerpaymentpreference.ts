import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("providerpaymentpreference",{schema:"dbo"})
export class Providerpaymentpreference {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ProviderUserID",
        })
    providerUserId: number;

    @Column("int",{
        nullable:false,
        name:"ProviderPaymentPreferenceTypeID",
        })
    providerPaymentPreferenceTypeId: number;

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
        name:"Modifiedby",
        })
    modifiedby: string;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"Verified",
        })
    verified: boolean;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"AccountName",
        })
    accountName: string | null;

    @Column("numeric",{
        nullable:true,
        precision:9,
        scale:0,
        name:"ABANumber",
        })
    abaNumber: number | null;

    @Column("varchar",{
        nullable:true,
        length:64,
        name:"LastThreeAccountDigits",
        })
    lastThreeAccountDigits: string | null;

}
