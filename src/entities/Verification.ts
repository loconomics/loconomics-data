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

@Entity("verification",{schema:"dbo"})
export class Verification {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"VerificationID",
        })
    verificationId: number;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"VerificationType",
        })
    verificationType: string;

    @Column("varchar",{
        nullable:false,
        length:1000,
        name:"VerificationDescription",
        })
    verificationDescription: string;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"VerificationProcess",
        })
    verificationProcess: string | null;

    @Column("varchar",{
        nullable:true,
        length:15,
        name:"Icon",
        })
    icon: string | null;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("datetime",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetime",{
        nullable:false,
        name:"ModifiedDate",
        })
    modifiedDate: Date;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"ModifiedBy",
        })
    modifiedBy: string | null;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

    @Column("int",{
        nullable:false,
        name:"VerificationCategoryID",
        })
    verificationCategoryId: number;

    @Column("int",{
        nullable:true,
        name:"RankPosition",
        })
    rankPosition: number | null;

    @Column("varchar",{
        nullable:true,
        length:20,
        name:"SummaryGroup",
        })
    summaryGroup: string | null;

}
