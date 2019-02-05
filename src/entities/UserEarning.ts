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

import {User} from "./User"

@Entity("UserEarnings",{schema:"dbo"})
export class UserEarning {

    @PrimaryGeneratedColumn({
        name:"UserEarningID",
    })
    userEarningID: number;


    @ManyToOne((type)=>User, (User)=>User.userEarnings,{  nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<User | null>;

    @Column("int",{
        nullable:false,
        name:"PlatformID",
        })
    platformId: number;

    @ManyToOne((type) => User, (User) => User.clientUserEarnings, {  nullable:false })
    @JoinColumn({ name:"ClientID"})
    client: Promise<User | null>;

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

}
