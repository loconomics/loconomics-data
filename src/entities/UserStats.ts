import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Users} from "./users";

@Entity("UserStats",{schema:"dbo"})
export class UserStats {

    @OneToOne((type)=>Users, (Users)=>Users.userStats,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<Users | null>;

    @Column("decimal",{
        nullable:true,
        precision:18,
        scale:2,
        name:"ResponseTimeMinutes",
        })
    responseTimeMinutes: number | null;

    @Column("datetime",{
        nullable:true,
        name:"LastLoginTime",
        })
    lastLoginTime: Date | null;

    @Column("datetime",{
        nullable:true,
        name:"LastActivityTime",
        })
    lastActivityTime: Date | null;

}
