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

@Entity("alerttype",{schema:"dbo"})
export class AlertType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"AlertTypeID",
        })
    alertTypeId: number;

    @Column("varchar",{
        nullable:false,
        length:200,
        name:"AlertTypeName",
        })
    alertTypeName: string;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"AlertTypeDescription",
        })
    alertTypeDescription: string | null;

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

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("int",{
        nullable:false,
        default:"((1))",
        name:"DisplayRank",
        })
    displayRank: number;

}
