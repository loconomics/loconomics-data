import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

import {UserProfilePosition} from "./UserProfilePosition"
import {User} from "./User"

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

    @OneToMany((type) => UserProfilePosition, (UserProfilePosition) => UserProfilePosition.status)
    userprofilepositions: Promise<UserProfilePosition[]>;

    @OneToMany((type)=>User, (User)=>User.accountStatus)
    user: Promise<User[]>;

}
