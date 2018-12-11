import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("PricingVariableDefinition",{schema:"dbo"})
export class PricingVariableDefinition {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PricingVariableID",
        })
    pricingVariableId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PositionID",
        })
    positionId: number;

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PricingTypeID",
        })
    pricingTypeId: number;

    @Column("varchar",{
        nullable:false,
        length:60,
        name:"InternalName",
        })
    internalName: string;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsProviderVariable",
        })
    isProviderVariable: boolean;

    @Column("bit",{
        nullable:false,
        default:"((0))",
        name:"IsCustomerVariable",
        })
    isCustomerVariable: boolean;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"DataType",
        })
    dataType: string;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"VariableLabel",
        })
    variableLabel: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:200,
        name:"VariableLabelPopUp",
        })
    variableLabelPopUp: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:60,
        name:"VariableNameSingular",
        })
    variableNameSingular: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:60,
        name:"VariableNamePlural",
        })
    variableNamePlural: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"NumberIncludedLabel",
        })
    numberIncludedLabel: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:200,
        name:"NumberIncludedLabelPopUp",
        })
    numberIncludedLabelPopUp: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"HourlySurchargeLabel",
        })
    hourlySurchargeLabel: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"MinNumberAllowedLabel",
        })
    minNumberAllowedLabel: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:200,
        name:"MinNumberAllowedLabelPopUp",
        })
    minNumberAllowedLabelPopUp: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"MaxNumberAllowedLabel",
        })
    maxNumberAllowedLabel: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:200,
        name:"MaxNumberAllowedLabelPopUp",
        })
    maxNumberAllowedLabelPopUp: string | null;

    @Column("int",{
        nullable:true,
        name:"CalculateWithVariableID",
        })
    calculateWithVariableId: number | null;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"Active",
        })
    active: boolean;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

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

    @Column("nvarchar",{
        nullable:true,
        name:"MinMaxValuesList",
        })
    minMaxValuesList: string | null;

}
