import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {SearchCategory} from "./SearchCategory";
import {SearchSubcategorySolution} from "./SearchSubcategorySolution"

@Entity("SearchSubCategory",{schema:"dbo"})
export class SearchSubCategory {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"SearchSubCategoryID",
        })
    searchSubCategoryId: number;

    @ManyToOne((type)=>SearchCategory, (SearchCategory)=>SearchCategory.searchSubCategorys,{  nullable:false })
    @JoinColumn({ name:"SearchCategoryID"})
    searchCategory: Promise<SearchCategory | null>;

    @Column("nvarchar",{
        nullable:false,
        length:40,
        name:"Name",
        })
    name: string;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"Description",
        })
    description: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:255,
        name:"Image",
        })
    image: string | null;

    @Column("int",{
        nullable:true,
        name:"DisplayRank",
        })
    displayRank: number | null;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("datetimeoffset",{
        nullable:false,
        name:"CreatedDate",
        })
    createdDate: Date;

    @Column("datetimeoffset",{
        nullable:false,
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("nvarchar",{
        nullable:false,
        length:4,
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

    @OneToOne((type) => SearchSubcategorySolution, (SearchSubcategorySolution) => SearchSubcategorySolution.searchSubCategory)
    searchSubcategorySolution: Promise<SearchSubcategorySolution | null>;

}
