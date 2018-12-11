import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("PricingVariableValue",{schema:"dbo"})
export class PricingVariableValue {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PricingVariableID",
        })
    pricingVariableId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ProviderPackageID",
        })
    providerPackageId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"UserID",
        })
    userId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PricingEstimateID",
        })
    pricingEstimateId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PricingEstimateRevision",
        })
    pricingEstimateRevision: number;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"Value",
        })
    value: string;

    @Column("decimal",{
        nullable:true,
        precision:7,
        scale:2,
        name:"ProviderNumberIncluded",
        })
    providerNumberIncluded: number | null;

    @Column("decimal",{
        nullable:true,
        precision:7,
        scale:2,
        name:"ProviderMinNumberAllowed",
        })
    providerMinNumberAllowed: number | null;

    @Column("decimal",{
        nullable:true,
        precision:7,
        scale:2,
        name:"ProviderMaxNumberAllowed",
        })
    providerMaxNumberAllowed: number | null;

    @Column("datetime",{
        nullable:false,
        default:"(getdate())",
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetime",{
        nullable:false,
        default:"(getdate())",
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("varchar",{
        nullable:false,
        length:25,
        default:"('sys')",
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
