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

import Platform from "./Platform"

@Entity("JobTitlePlatform",{schema:"dbo"})
export default class JobTitlePlatform {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"JobTitleID",
        })
    jobTitleId: number;

    @OneToOne((type)=>Platform, (Platform)=>Platform.jobTitlePlatform,{ primary:true, nullable:false })
    @JoinColumn({ name:"PlatformID"})
    platform: Promise<Platform | null>;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

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
