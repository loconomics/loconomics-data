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

@Entity("tintype",{schema:"dbo"})
export class TinType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"TINTypeID",
        })
    tinTypeId: number;

    @Column("nvarchar",{
        nullable:false,
        length:10,
        name:"TINTypeAbbr",
        })
    tinTypeAbbr: string;

    @Column("nvarchar",{
        nullable:false,
        length:70,
        name:"TINTypeName",
        })
    tinTypeName: string;

    @Column("nvarchar",{
        nullable:true,
        length:200,
        name:"TINTypeDescription",
        })
    tinTypeDescription: string | null;

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

}
