import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("ExperienceLevel",{schema:"dbo"})
export class ExperienceLevel {

    @PrimaryGeneratedColumn({
        name:"ExperienceLevelID",
        })
    experienceLevelId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("varchar",{
        nullable:false,
        length:140,
        name:"ExperienceLevelName",
        })
    experienceLevelName: string;

    @Column("varchar",{
        nullable:true,
        length:140,
        name:"ExperienceLevelDescription",
        })
    experienceLevelDescription: string | null;

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
