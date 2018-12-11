import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Users} from "./users";

@Entity("UserEarnings",{schema:"dbo"})
export class UserEarnings {

    @OneToOne((type)=>UserEarnings, (UserEarnings)=>UserEarnings.userEarnings2,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserEarningsID"})
    userEarnings: Promise<UserEarnings | null>;

    @ManyToOne((type)=>Users, (Users)=>Users.userEarningss,{  nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<Users | null>;

    @Column("int",{
        nullable:false,
        name:"PlatformID",
        })
    platformId: number;

    @ManyToOne((type)=>Users, (Users)=>Users.userEarningss2,{  nullable:false })
    @JoinColumn({ name:"ClientID"})
    client: Promise<Users | null>;

    @Column("int",{
        nullable:false,
        name:"JobTitleID",
        })
    jobTitleId: number;

    @Column("decimal",{
        nullable:false,
        precision:10,
        scale:2,
        name:"Amount",
        })
    amount: number;

    @Column("int",{
        nullable:false,
        name:"Minutes",
        })
    minutes: number;

    @Column("datetimeoffset",{
        nullable:false,
        name:"PaidDate",
        })
    paidDate: Date;

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

    @OneToOne((type)=>UserEarnings, (UserEarnings)=>UserEarnings.userEarnings)
    userEarnings2: Promise<UserEarnings | null>;

}
