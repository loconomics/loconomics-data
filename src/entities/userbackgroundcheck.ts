import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {User} from "./User"

@Entity("userbackgroundcheck",{schema:"dbo"})
export class Userbackgroundcheck {

    @OneToOne((type)=>User, (User)=>User.userbackgroundcheck,{ primary:true, nullable:false })
    @JoinColumn({ name:"UserID"})
    user: Promise<User | null>;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"BackgroundCheckID",
        })
    backgroundCheckId: number;

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

    @Column("int",{
        nullable:false,
        name:"StatusID",
        })
    statusId: number;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"Summary",
        })
    summary: string | null;

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

}
