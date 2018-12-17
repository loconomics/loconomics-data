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

@Entity("VOCScores",{schema:"dbo"})
export class VOCScore {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"VOCScoresID",
        })
    vocScoresId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"UserID",
        })
    userId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"VOCElementID",
        })
    vocElementId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"Score",
        })
    score: number;

    @Column("datetime",{
        nullable:false,
        primary:true,
        name:"Date",
        })
    date: Date;

    @Column("int",{
        nullable:true,
        name:"ProviderUserID",
        })
    providerUserId: number | null;

    @Column("int",{
        nullable:true,
        name:"ProviderPositionID",
        })
    providerPositionId: number | null;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"UserDevice",
        })
    userDevice: string | null;

    @Column("int",{
        nullable:false,
        name:"VOCExperienceCategoryID",
        })
    vocExperienceCategoryId: number;

}
