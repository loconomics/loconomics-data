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

@Entity("transporttype",{schema:"dbo"})
export class TransportType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"TransportTypeID",
        })
    transportTypeId: number;

    @Column("varchar",{
        nullable:false,
        length:50,
        name:"TransportTypeName",
        })
    transportTypeName: string;

    @Column("varchar",{
        nullable:true,
        length:300,
        name:"TransportTypeDescription",
        })
    transportTypeDescription: string | null;

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
