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

@Entity("ProviderPaymentAccount",{schema:"dbo"})
export class ProviderPaymentAccount {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ProviderUserID",
        })
    providerUserId: number;

    @Column("nvarchar",{
        nullable:false,
        length:100,
        name:"MerchantAccountID",
        })
    merchantAccountId: string;

    @Column("nvarchar",{
        nullable:false,
        length:50,
        name:"Status",
        })
    status: string;

    @Column("nvarchar",{
        nullable:true,
        length:400,
        name:"Message",
        })
    message: string | null;

    @Column("nvarchar",{
        nullable:true,
        name:"bt_signature",
        })
    btSignature: string | null;

    @Column("nvarchar",{
        nullable:true,
        name:"bt_payload",
        })
    btPayload: string | null;

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

}
