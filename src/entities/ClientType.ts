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

@Entity("clienttype",{schema:"dbo"})
export class ClientType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ClientTypeID",
        })
    clientTypeId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"ClientTypeName",
        })
    clientTypeName: string;

    @Column("varchar",{
        nullable:true,
        length:500,
        name:"ClientTypeDescription",
        })
    clientTypeDescription: string | null;

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
        nullable:true,
        length:25,
        name:"ModifiedBy",
        })
    modifiedBy: string | null;

    @Column("bit",{
        nullable:false,
        name:"Active",
        })
    active: boolean;

}
