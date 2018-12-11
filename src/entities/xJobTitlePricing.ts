import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("xJobTitlePricing",{schema:"dbo"})
export class XJobTitlePricing {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"JobTitlePricingID",
        })
    jobTitlePricingId: number;

    @Column("int",{
        nullable:false,
        name:"JobTitleID",
        })
    jobTitleId: number;

    @Column("int",{
        nullable:false,
        name:"PricingTypeID",
        })
    pricingTypeId: number;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"PricingTypeLabel",
        })
    pricingTypeLabel: string;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"PricingNameDefaultValue",
        })
    pricingNameDefaultValue: string;

    @Column("varchar",{
        nullable:false,
        length:200,
        name:"PricingDescriptionPlaceholder",
        })
    pricingDescriptionPlaceholder: string;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"PricingRateUnitDefaultValue",
        })
    pricingRateUnitDefaultValue: string;

    @Column("varchar",{
        nullable:false,
        length:500,
        name:"PricingHelperLanguagePlaceholder",
        })
    pricingHelperLanguagePlaceholder: string;

    @Column("bit",{
        nullable:false,
        name:"IncludeTaskListOption",
        })
    includeTaskListOption: boolean;

    @Column("bit",{
        nullable:false,
        name:"RecurringEligible",
        })
    recurringEligible: boolean;

    @Column("bit",{
        nullable:false,
        name:"ShowFirstTimeClientsOnlyOption",
        })
    showFirstTimeClientsOnlyOption: boolean;

    @Column("bit",{
        nullable:false,
        name:"ShowExisitingClientsOnlyOption",
        })
    showExisitingClientsOnlyOption: boolean;

    @Column("bit",{
        nullable:false,
        name:"ShowSpecificClientOnlyOption",
        })
    showSpecificClientOnlyOption: boolean;

    @Column("bit",{
        nullable:false,
        name:"ShowSlidingScaleOption",
        })
    showSlidingScaleOption: boolean;

    @Column("bit",{
        nullable:false,
        name:"ShowTradeOption",
        })
    showTradeOption: boolean;

    @Column("bit",{
        nullable:false,
        name:"ShowServiceAreaOption",
        })
    showServiceAreaOption: boolean;

    @Column("bit",{
        nullable:false,
        name:"ShowServiceLocationOption",
        })
    showServiceLocationOption: boolean;

    @Column("bit",{
        nullable:false,
        name:"ShowRemoteLocationOption",
        })
    showRemoteLocationOption: boolean;

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

}
