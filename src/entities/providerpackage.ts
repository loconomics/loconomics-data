import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("providerpackage",{schema:"dbo"})
export class Providerpackage {

    @PrimaryGeneratedColumn({
        name:"ProviderPackageID",
        })
    providerPackageId: number;

    @Column("int",{
        nullable:false,
        name:"PricingTypeID",
        })
    pricingTypeId: number;

    @Column("int",{
        nullable:false,
        name:"ProviderUserID",
        })
    providerUserId: number;

    @Column("int",{
        nullable:false,
        name:"PositionID",
        })
    positionId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"ProviderPackageName",
        })
    providerPackageName: string;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"ProviderPackageDescription",
        })
    providerPackageDescription: string | null;

    @Column("decimal",{
        nullable:true,
        precision:7,
        scale:2,
        name:"ProviderPackagePrice",
        })
    providerPackagePrice: number | null;

    @Column("int",{
        nullable:false,
        name:"ProviderPackageServiceDuration",
        })
    providerPackageServiceDuration: number;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"FirstTimeClientsOnly",
        })
    firstTimeClientsOnly: boolean;

    @Column("int",{
        nullable:false,
        default:"((1))",
        name:"NumberOfSessions",
        })
    numberOfSessions: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

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
        length:25,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsAddOn",
        })
    isAddOn: boolean;

    @Column("decimal",{
        nullable:true,
        precision:7,
        scale:2,
        name:"PriceRate",
        })
    priceRate: number | null;

    @Column("nvarchar",{
        nullable:true,
        length:30,
        name:"PriceRateUnit",
        })
    priceRateUnit: string | null;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsPhone",
        })
    isPhone: boolean;

    @Column("int",{
        nullable:false,
        default:"((0))",
        name:"VisibleToClientID",
        })
    visibleToClientId: number;

    @Column("int",{
        nullable:false,
        default:"((0))",
        name:"SolutionID",
        })
    solutionId: number;

}
