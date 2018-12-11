import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("serviceattributecategory",{schema:"dbo"})
export class Serviceattributecategory {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ServiceAttributeCategoryID",
        })
    serviceAttributeCategoryId: number;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"ServiceAttributeCategory",
        })
    serviceAttributeCategory: string | null;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("datetime",{
        nullable:true,
        name:"CreateDate",
        })
    createDate: Date | null;

    @Column("datetime",{
        nullable:true,
        name:"UpdatedDate",
        })
    updatedDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:20,
        name:"ModifiedBy",
        })
    modifiedBy: string | null;

    @Column("bit",{
        nullable:true,
        name:"Active",
        })
    active: boolean | null;

    @Column("int",{
        nullable:true,
        name:"SourceID",
        })
    sourceId: number | null;

    @Column("bit",{
        nullable:true,
        name:"PricingOptionCategory",
        })
    pricingOptionCategory: boolean | null;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"ServiceAttributeCategoryDescription",
        })
    serviceAttributeCategoryDescription: string | null;

    @Column("bit",{
        nullable:false,
        name:"RequiredInput",
        })
    requiredInput: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"SideBarCategory",
        })
    sideBarCategory: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"EligibleForPackages",
        })
    eligibleForPackages: boolean;

    @Column("int",{
        nullable:false,
        default:"((1))",
        name:"DisplayRank",
        })
    displayRank: number;

    @Column("int",{
        nullable:true,
        name:"PositionReference",
        })
    positionReference: number | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"BookingPathSelection",
        })
    bookingPathSelection: boolean;

}
