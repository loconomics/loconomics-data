import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("Gender",{schema:"dbo"})
export class Gender {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"GenderID",
        })
    genderId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("nvarchar",{
        nullable:false,
        length:16,
        name:"GenderSingular",
        })
    genderSingular: string;

    @Column("nvarchar",{
        nullable:false,
        length:16,
        name:"GenderPlural",
        })
    genderPlural: string;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"SubjectPronoun",
        })
    subjectPronoun: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"ObjectPronoun",
        })
    objectPronoun: string | null;

    @Column("varchar",{
        nullable:true,
        length:25,
        name:"PossesivePronoun",
        })
    possesivePronoun: string | null;

}
