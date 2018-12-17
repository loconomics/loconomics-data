import {
    Column,
    Entity,
    Index,
    JoinColumn,
    JoinTable,
    ManyToMany,
    ManyToOne,
    OneToMany,
    OneToOne,
    PrimaryColumn,
    PrimaryGeneratedColumn,
    RelationId,
} from "typeorm";

@Entity("verificationcategory",{schema:"dbo"})
export class VerificationCategory {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"VerificationCategoryID",
        })
    verificationCategoryId: number;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"VerificationCategoryName",
        })
    verificationCategoryName: string;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"VerificationCategoryDescription",
        })
    verificationCategoryDescription: string | null;

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

    @Column("int",{
        nullable:true,
        name:"RankPosition",
        })
    rankPosition: number | null;

}
