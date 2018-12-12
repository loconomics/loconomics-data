import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Institution} from "./institution";
import User from "./User"

@Entity("usereducation",{schema:"dbo"})
export class Usereducation {

    @PrimaryGeneratedColumn({
        name:"UserEducationID",
        })
    userEducationId: number;

    @ManyToOne((type)=>User, (User)=>User.usereducations,{  nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<User | null>;

    @ManyToOne((type)=>Institution, (Institution)=>Institution.usereducations,{  nullable:false })
    @JoinColumn({ name:"InstitutionID"})
    institution: Promise<Institution | null>;

    @Column("varchar",{
        nullable:false,
        length:200,
        name:"DegreeCertificate",
        })
    degreeCertificate: string;

    @Column("varchar",{
        nullable:false,
        length:200,
        name:"FieldOfStudy",
        })
    fieldOfStudy: string;

    @Column("numeric",{
        nullable:true,
        precision:4,
        scale:0,
        name:"FromYearAttended",
        })
    fromYearAttended: number | null;

    @Column("numeric",{
        nullable:true,
        precision:4,
        scale:0,
        name:"ToYearAttended",
        })
    toYearAttended: number | null;

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
        nullable:false,
        length:25,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("datetime",{
        nullable:true,
        name:"VerifiedDate",
        })
    verifiedDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"VerifiedBy",
        })
    verifiedBy: string | null;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

}
