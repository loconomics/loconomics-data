import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("backgroundcheck",{schema:"dbo"})
export class Backgroundcheck {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"BackgroundCheckID",
        })
    backgroundCheckId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("varchar",{
        nullable:false,
        length:100,
        name:"BackgroundCheckName",
        })
    backgroundCheckName: string;

    @Column("varchar",{
        nullable:true,
        length:1000,
        name:"BackgroundCheckDescription",
        })
    backgroundCheckDescription: string | null;

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

    @Column("decimal",{
        nullable:true,
        precision:5,
        scale:2,
        name:"BackGroundCheckPrice",
        })
    backGroundCheckPrice: number | null;

}
