import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Userprofilepositions} from "./userprofilepositions";
import {Users} from "./users";

@Entity("accountstatus",{schema:"dbo"})
export class Accountstatus {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"AccountStatusID",
        })
    accountStatusId: number;

    @Column("varchar",{
        nullable:false,
        length:25,
        name:"AccountStatusName",
        })
    accountStatusName: string;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"AccountStatusDescription",
        })
    accountStatusDescription: string | null;

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
        default:"('sys')",
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"Active",
        })
    active: boolean;

    @OneToMany((type)=>Userprofilepositions, (Userprofilepositions)=>Userprofilepositions.status)
    userprofilepositionss: Promise<Userprofilepositions[]>;

    @OneToMany((type)=>Users, (Users)=>Users.accountStatus)
    userss: Promise<Users[]>;

}
