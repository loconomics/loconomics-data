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

@Entity("userverification",{schema:"dbo"})
export class UserVerification {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"UserID",
        })
    userId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"VerificationID",
        })
    verificationId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        default:"((0))",
        name:"PositionID",
        })
    positionId: number;

    @Column("datetime",{
        nullable:false,
        name:"DateVerified",
        })
    dateVerified: Date;

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
        name:"VerifiedBy",
        })
    verifiedBy: string;

    @Column("datetime",{
        nullable:false,
        name:"LastVerifiedDate",
        })
    lastVerifiedDate: Date;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

    @Column("int",{
        nullable:false,
        name:"VerificationStatusID",
        })
    verificationStatusId: number;

    @Column("varchar",{
        nullable:true,
        length:2000,
        name:"Comments",
        })
    comments: string | null;

}
