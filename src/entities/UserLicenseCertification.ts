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

@Entity("UserLicenseCertifications",{schema:"dbo"})
export class UserLicenseCertification {

    @PrimaryGeneratedColumn({
        name:"userLicenseCertificationID",
        })
    userLicenseCertificationId: number;

    @Column("int",{
        nullable:false,
        name:"ProviderUserID",
        })
    providerUserId: number;

    @Column("int",{
        nullable:false,
        name:"PositionID",
        })
    positionId: number;

    @Column("int",{
        nullable:false,
        name:"LicenseCertificationID",
        })
    licenseCertificationId: number;

    @Column("int",{
        nullable:false,
        name:"VerificationStatusID",
        })
    verificationStatusId: number;

    @Column("varchar",{
        nullable:true,
        length:2073,
        name:"LicenseCertificationURL",
        })
    licenseCertificationUrl: string | null;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"LastName",
        })
    lastName: string;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"FirstName",
        })
    firstName: string;

    @Column("varchar",{
        nullable:true,
        length:1,
        name:"MiddleInitial",
        })
    middleInitial: string | null;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"SecondLastName",
        })
    secondLastName: string | null;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"BusinessName",
        })
    businessName: string | null;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"LicenseCertificationNumber",
        })
    licenseCertificationNumber: string | null;

    @Column("datetime",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetime",{
        nullable:true,
        name:"ExpirationDate",
        })
    expirationDate: Date | null;

    @Column("datetime",{
        nullable:true,
        name:"IssueDate",
        })
    issueDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"Comments",
        })
    comments: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"VerifiedBy",
        })
    verifiedBy: string | null;

    @Column("datetime",{
        nullable:true,
        name:"LastVerifiedDate",
        })
    lastVerifiedDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"SubmittedBy",
        })
    submittedBy: string | null;

    @Column("varchar",{
        nullable:true,
        length:255,
        name:"SubmittedImageLocalURL",
        })
    submittedImageLocalUrl: string | null;

}
