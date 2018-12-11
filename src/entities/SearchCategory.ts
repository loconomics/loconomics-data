import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";
import {SearchSubCategory} from "./SearchSubCategory";

@Entity("SearchCategory",{schema:"dbo"})
export class SearchCategory {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"SearchCategoryID",
        })
    searchCategoryId: number;

    @Column("nvarchar",{
        nullable:false,
        length:20,
        name:"Name",
        })
    name: string;

    @Column("nvarchar",{
        nullable:true,
        length:100,
        name:"ShortDescription",
        })
    shortDescription: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:300,
        name:"LongDescription",
        })
    longDescription: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:255,
        name:"SmallImage",
        })
    smallImage: string | null;

    @Column("nvarchar",{
        nullable:true,
        length:255,
        name:"BannerImage",
        })
    bannerImage: string | null;

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

    @OneToMany((type)=>SearchSubCategory, (SearchSubCategory)=>SearchSubCategory.searchCategory)
    searchSubCategorys: Promise<SearchSubCategory[]>;

}
