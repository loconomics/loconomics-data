import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("VOCExperienceCategory",{schema:"dbo"})
export class VocExperienceCategory {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"VOCExperienceCategoryID",
        })
    vocExperienceCategoryId: number;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"VOCExperienceCategoryName",
        })
    vocExperienceCategoryName: string | null;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"VOCExperienceCategoryDescription",
        })
    vocExperienceCategoryDescription: string | null;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("datetime",{
        nullable:false,
        name:"CreateDate",
        })
    createDate: Date;

    @Column("datetime",{
        nullable:false,
        name:"UpdatedDate",
        })
    updatedDate: Date;

    @Column("varchar",{
        nullable:false,
        length:3,
        name:"ModifiedBy",
        })
    modifiedBy: string;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

}
