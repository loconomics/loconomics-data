import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {SearchSubCategory} from "./SearchSubCategory";
import {Solution} from "./Solution";

@Entity("SearchSubCategorySolution",{schema:"dbo"})
export class SearchSubCategorySolution {

    @OneToOne((type)=>SearchSubCategory, (SearchSubCategory)=>SearchSubCategory.searchSubCategorySolution,{ primary:true, nullable:false })
    @JoinColumn({ name:"SearchSubCategoryID"})
    searchSubCategory: Promise<SearchSubCategory | null>;

    @OneToOne((type)=>Solution, (Solution)=>Solution.searchSubCategorySolution,{ primary:true, nullable:false })
    @JoinColumn({ name:"SolutionID"})
    solution: Promise<Solution | null>;

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

}
