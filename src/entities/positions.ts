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

import {JobTitleSolution} from "./JobTitleSolution";
import {UserProfilePosition} from "./UserProfilePosition"

@Entity("positions",{schema:"dbo"})
@Index("idx_positions",["positionId"])
export class Positions {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("varchar",{
        nullable:true,
        length:250,
        name:"PositionSingular",
        })
    positionSingular: string | null;

    @Column("varchar",{
        nullable:true,
        length:250,
        name:"PositionPlural",
        })
    positionPlural: string | null;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"Aliases",
        })
    aliases: string | null;

    @Column("varchar",{
        nullable:true,
        length:2000,
        name:"PositionDescription",
        })
    positionDescription: string | null;

    @Column("datetime",{
        nullable:true,
        name:"CreatedDate",
        })
    createdDate: Date | null;

    @Column("datetime",{
        nullable:true,
        name:"UpdatedDate",
        })
    updatedDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:2,
        name:"ModifiedBy",
        })
    modifiedBy: string | null;

    @Column("varchar",{
        nullable:true,
        length:20,
        name:"GovID",
        })
    govId: string | null;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"GovPosition",
        })
    govPosition: string | null;

    @Column("varchar",{
        nullable:true,
        length:2000,
        name:"GovPositionDescription",
        })
    govPositionDescription: string | null;

    @Column("bit",{
        nullable:true,
        name:"Active",
        })
    active: boolean | null;

    @Column("int",{
        nullable:true,
        name:"DisplayRank",
        })
    displayRank: number | null;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"PositionSearchDescription",
        })
    positionSearchDescription: string | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"AttributesComplete",
        })
    attributesComplete: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"StarRatingsComplete",
        })
    starRatingsComplete: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"PricingTypeComplete",
        })
    pricingTypeComplete: boolean;

    @Column("int",{
        nullable:true,
        name:"EnteredByUserID",
        })
    enteredByUserId: number | null;

    @Column("bit",{
        nullable:true,
        name:"Approved",
        })
    approved: boolean | null;

    @Column("int",{
        nullable:false,
        default:"((0))",
        name:"AddGratuity",
        })
    addGratuity: number;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"HIPAA",
        })
    hipaa: boolean;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"SendReviewReminderToClient",
        })
    sendReviewReminderToClient: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"CanBeRemote",
        })
    canBeRemote: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"SuppressReviewOfClient",
        })
    suppressReviewOfClient: boolean;

    @OneToOne((type)=>JobTitleSolution, (JobTitleSolution)=>JobTitleSolution.jobTitle)
    jobTitleSolution: Promise<JobTitleSolution | null>;

    @OneToOne((type) => UserProfilePosition, (UserProfilePosition) => UserProfilePosition.position)
    userprofilepositions: Promise<UserProfilePosition | null>;

}
