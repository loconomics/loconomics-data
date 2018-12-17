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

@Entity("UserReviews",{schema:"dbo"})
export class UserReview {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"BookingID",
        })
    bookingId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"CustomerUserID",
        })
    customerUserId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ProviderUserID",
        })
    providerUserId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("nvarchar",{
        nullable:true,
        length:1000,
        name:"PrivateReview",
        })
    privateReview: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:500,
        name:"PublicReview",
        })
    publicReview: string | null;

    @Column("tinyint",{
        nullable:true,
        name:"Rating1",
        })
    rating1: number | null;

    @Column("tinyint",{
        nullable:true,
        name:"Rating2",
        })
    rating2: number | null;

    @Column("tinyint",{
        nullable:true,
        name:"Rating3",
        })
    rating3: number | null;

    @Column("tinyint",{
        nullable:true,
        name:"Rating4",
        })
    rating4: number | null;

    @Column("bit",{
        nullable:true,
        name:"Answer1",
        })
    answer1: boolean | null;

    @Column("bit",{
        nullable:true,
        name:"Answer2",
        })
    answer2: boolean | null;

    @Column("nvarchar",{
        nullable:true,
        length:1000,
        name:"Answer1Comment",
        })
    answer1Comment: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:1000,
        name:"Answer2Comment",
        })
    answer2Comment: string | null;

    @Column("decimal",{
        nullable:true,
        default:"((0))",
        precision:18,
        scale:5,
        name:"ServiceHours",
        })
    serviceHours: number | null;

    @Column("bigint",{
        nullable:true,
        default:"((0))",
        name:"HelpfulReviewCount",
        })
    helpfulReviewCount: string | null;

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
