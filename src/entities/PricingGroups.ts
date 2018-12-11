import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("PricingGroups",{schema:"dbo"})
export class PricingGroups {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"PricingGroupID",
        })
    pricingGroupId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"InternalGroupName",
        })
    internalGroupName: string;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"SelectionTitle",
        })
    selectionTitle: string;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"SummaryTitle",
        })
    summaryTitle: string;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"DynamicSummaryTitle",
        })
    dynamicSummaryTitle: string;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

}
