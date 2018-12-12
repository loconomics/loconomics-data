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

import JobTitlePlatform from "./JobTitlePlatform"

@Entity("Platform",{schema:"dbo"})
export default class Platform {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PlatformID",
        })
    platformId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("nvarchar",{
        nullable:false,
        length:20,
        name:"Name",
        })
    name: string;

    @Column("nvarchar",{
        nullable:false,
        length:50,
        name:"ShortDescription",
        })
    shortDescription: string;

    @Column("text",{
        nullable:false,
        name:"LongDescription",
        })
    longDescription: string;

    @Column("text",{
        nullable:false,
        name:"FeesDescription",
        })
    feesDescription: string;

    @Column("text",{
        nullable:false,
        name:"PositiveAspects",
        })
    positiveAspects: string;

    @Column("text",{
        nullable:false,
        name:"NegativeAspects",
        })
    negativeAspects: string;

    @Column("text",{
        nullable:false,
        name:"Advice",
        })
    advice: string;

    @Column("nvarchar",{
        nullable:false,
        length:255,
        name:"SignUpURL",
        })
    signUpUrl: string;

    @Column("nvarchar",{
        nullable:false,
        length:255,
        name:"SignInURL",
        })
    signInUrl: string;

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

    @OneToOne((type)=>JobTitlePlatform, (JobTitlePlatform)=>JobTitlePlatform.platform)
    jobTitlePlatform: Promise<JobTitlePlatform | null>;

}
