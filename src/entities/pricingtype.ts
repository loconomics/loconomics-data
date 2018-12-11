import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("pricingtype",{schema:"dbo"})
@Index("Pk_pricingtype",["pricingTypeId"],{unique:true})
export class Pricingtype {

    @Column("int",{
        nullable:false,
        primary:true,
        unique: true,
        name:"PricingTypeID",
        })
    pricingTypeId: number;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"Description",
        })
    description: string | null;

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
        length:50,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"Active",
        })
    active: boolean;

    @Column("int",{
        nullable:false,
        name:"DisplayRank",
        })
    displayRank: number;

}
