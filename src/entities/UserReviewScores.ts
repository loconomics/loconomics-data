import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("UserReviewScores",{schema:"dbo"})
export class UserReviewScores {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"UserID",
        })
    userId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("bigint",{
        nullable:true,
        name:"TotalRatings",
        })
    totalRatings: string | null;

    @Column("decimal",{
        nullable:true,
        precision:18,
        scale:2,
        name:"Rating1",
        })
    rating1: number | null;

    @Column("decimal",{
        nullable:true,
        precision:18,
        scale:2,
        name:"Rating2",
        })
    rating2: number | null;

    @Column("decimal",{
        nullable:true,
        precision:18,
        scale:2,
        name:"Rating3",
        })
    rating3: number | null;

    @Column("decimal",{
        nullable:true,
        precision:18,
        scale:2,
        name:"Rating4",
        })
    rating4: number | null;

    @Column("bigint",{
        nullable:true,
        name:"Answer1",
        })
    answer1: string | null;

    @Column("bigint",{
        nullable:true,
        name:"Answer2",
        })
    answer2: string | null;

    @Column("decimal",{
        nullable:true,
        precision:18,
        scale:2,
        name:"ServiceHours",
        })
    serviceHours: number | null;

    @Column("datetime",{
        nullable:true,
        name:"LastRatingDate",
        })
    lastRatingDate: Date | null;

    @Column("datetime",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetime",{
        nullable:false,
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"ModifiedBy",
        })
    modifiedBy: string;

}
