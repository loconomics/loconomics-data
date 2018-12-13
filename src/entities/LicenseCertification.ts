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

@Entity("licensecertification",{schema:"dbo"})
export class LicenseCertification {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"LicenseCertificationID",
        })
    licenseCertificationId: number;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"LicenseCertificationType",
        })
    licenseCertificationType: string;

    @Column("varchar",{
        nullable:true,
        length:4000,
        name:"LicenseCertificationTypeDescription",
        })
    licenseCertificationTypeDescription: string | null;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"LicenseCertificationAuthority",
        })
    licenseCertificationAuthority: string | null;

    @Column("varchar",{
        nullable:true,
        length:2078,
        name:"VerificationWebsiteURL",
        })
    verificationWebsiteUrl: string | null;

    @Column("varchar",{
        nullable:true,
        length:2078,
        name:"HowToGetLicensedURL",
        })
    howToGetLicensedUrl: string | null;

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

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

}
