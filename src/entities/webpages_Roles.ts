import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {UserProfile} from "./UserProfile"

@Entity("webpages_Roles",{schema:"dbo"})
@Index("UQ__webpages__8A2B616020EB9E61",["roleName"],{unique:true})
export class WebpagesRoles {

    @PrimaryGeneratedColumn({
        name:"RoleId",
        })
    roleId: number;

    @Column("nvarchar",{
        nullable:false,
        unique: true,
        length:256,
        name:"RoleName",
        })
    roleName: string;

    @ManyToMany((type)=>UserProfile, (UserProfile)=>UserProfile.webpagesRoless)
    userprofiles: Promise<UserProfile[]>;

}
