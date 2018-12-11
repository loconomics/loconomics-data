import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {Servicecategory} from "./servicecategory";

@Entity("servicesubcategory",{schema:"dbo"})
export class Servicesubcategory {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ServiceSubCategoryID",
        })
    serviceSubCategoryId: number;

    @Column("varchar",{
        nullable:true,
        length:45,
        name:"Name",
        })
    name: string | null;

    @Column("varchar",{
        nullable:true,
        length:250,
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

    @Column("bit",{
        nullable:true,
        name:"Active",
        })
    active: boolean | null;

    @ManyToOne((type)=>Servicecategory, (Servicecategory)=>Servicecategory.servicesubcategorys,{  })
    @JoinColumn({ name:"ServiceCategoryID"})
    serviceCategory: Promise<Servicecategory | null>;

    @Column("int",{
        nullable:true,
        name:"Rank",
        })
    rank: number | null;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"RankQuery",
        })
    rankQuery: string | null;

}
