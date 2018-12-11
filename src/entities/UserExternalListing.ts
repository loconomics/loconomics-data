import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {UserEarningsEntry} from "./UserEarningsEntry";
import {Users} from "./users";

@Entity("UserExternalListing",{schema:"dbo"})
export class UserExternalListing {

    @PrimaryGeneratedColumn({
        name:"UserExternalListingID",
        })
    userExternalListingId: number;

    @ManyToOne((type)=>Users, (Users)=>Users.userExternalListings,{  nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<Users | null>;

    @Column("int",{
        nullable:false,
        name:"PlatformID",
        })
    platformId: number;

    @Column("nvarchar",{
        nullable:false,
        length:50,
        name:"Title",
        })
    title: string;

    @Column("text",{
        nullable:false,
        name:"JobTitles",
        })
    jobTitles: string;

    @Column("text",{
        nullable:false,
        name:"Notes",
        })
    notes: string;

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

    @OneToMany((type)=>UserEarningsEntry, (UserEarningsEntry)=>UserEarningsEntry.userExternalListing)
    userEarningsEntrys: Promise<UserEarningsEntry[]>;

}
