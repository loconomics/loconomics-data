import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {WebpagesRoles} from "./webpages_Roles";

@Entity("userprofile",{schema:"dbo"})
@Index("UQ__userprof__C9F284560519C6AF",["email"],{unique:true})
export class Userprofile {

    @PrimaryGeneratedColumn({
        name:"UserId",
        })
    userId: number;

    @Column("nvarchar",{
        nullable:false,
        unique: true,
        length:254,
        name:"Email",
        })
    email: string;

    @ManyToMany((type)=>WebpagesRoles, (WebpagesRoles)=>WebpagesRoles.userprofiles,{  nullable:false })
    @JoinTable()
    webpagesRoless: Promise<WebpagesRoles[]>;

}
