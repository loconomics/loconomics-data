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

import {WebpageRole} from "./WebpageRole"

@Entity("userprofile",{schema:"dbo"})
@Index("UQ__userprof__C9F284560519C6AF",["email"],{unique:true})
export class UserProfile {

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

    @ManyToMany((type)=>WebpageRole, (WebpageRole)=>WebpageRole.userprofiles, {  nullable:false })
    @JoinTable()
    webpageRole: Promise<WebpageRole[]>;

}
