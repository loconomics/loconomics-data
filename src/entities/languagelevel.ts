import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("languagelevel",{schema:"dbo"})
export class Languagelevel {

    @PrimaryGeneratedColumn({
        name:"LanguageLevelID",
        })
    languageLevelId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("varchar",{
        nullable:false,
        length:140,
        name:"LanguageLevelName",
        })
    languageLevelName: string;

    @Column("varchar",{
        nullable:true,
        length:2000,
        name:"LanguageLevelDescription",
        })
    languageLevelDescription: string | null;

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

}
