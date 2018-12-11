import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Users} from "./users";

@Entity("userOrganization",{schema:"dbo"})
export class UserOrganization {

    @OneToOne((type)=>Users, (Users)=>Users.userOrganization,{ primary:true, nullable:false,onDelete: "CASCADE",onUpdate: "CASCADE" })
    @JoinColumn({ name:"userID"})
    user: Promise<Users | null>;

    @Column("nvarchar",{
        nullable:false,
        length:200,
        name:"orgName",
        })
    orgName: string;

    @Column("nvarchar",{
        nullable:true,
        length:400,
        name:"orgDescription",
        })
    orgDescription: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:255,
        name:"orgWebsite",
        })
    orgWebsite: string | null;

    @Column("datetimeoffset",{
        nullable:true,
        name:"updatedDate",
        })
    updatedDate: Date | null;

}
