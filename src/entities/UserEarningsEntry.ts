import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {ServiceProfessionalClient} from "./ServiceProfessionalClient";
import {UserExternalListing} from "./UserExternalListing";
import {Users} from "./users";

@Entity("UserEarningsEntry",{schema:"dbo"})
export class UserEarningsEntry {

    @OneToOne((type)=>ServiceProfessionalClient, (ServiceProfessionalClient)=>ServiceProfessionalClient.userEarningsEntry,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserID"})
    serviceProfessionalClient: Promise<ServiceProfessionalClient | null>;

    @OneToOne((type)=>Users, (Users)=>Users.userEarningsEntry,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<Users | null>;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"EarningsEntryID",
        })
    earningsEntryId: number;

    @Column("decimal",{
        nullable:false,
        default:"((0))",
        precision:10,
        scale:2,
        name:"Amount",
        })
    amount: number;

    @Column("datetimeoffset",{
        nullable:false,
        name:"PaidDate",
        })
    paidDate: Date;

    @Column("int",{
        nullable:false,
        name:"DurationMinutes",
        })
    durationMinutes: number;

    @ManyToOne((type)=>UserExternalListing, (UserExternalListing)=>UserExternalListing.userEarningsEntrys,{  nullable:false })
    @JoinColumn({ name:"UserExternalListingID"})
    userExternalListing: Promise<UserExternalListing | null>;

    @Column("int",{
        nullable:false,
        name:"JobTitleID",
        })
    jobTitleId: number;

    @ManyToOne((type)=>ServiceProfessionalClient, (ServiceProfessionalClient)=>ServiceProfessionalClient.userEarningsEntrys,{  })
    @JoinColumn({ name:"ClientUserID"})
    clientUser: Promise<ServiceProfessionalClient | null>;

    @Column("datetimeoffset",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetimeoffset",{
        nullable:false,
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("nvarchar",{
        nullable:false,
        length:4,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"Active",
        })
    active: boolean;

    @Column("text",{
        nullable:true,
        name:"Notes",
        })
    notes: string | null;

}
