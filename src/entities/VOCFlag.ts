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

@Entity("VOCFlag",{schema:"dbo"})
export class VOCFlag {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"VOCFlagID",
        })
    vocFlagId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"VOCFlagName",
        })
    vocFlagName: string;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"VOCFlagNDescription",
        })
    vocFlagNDescription: string | null;

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
