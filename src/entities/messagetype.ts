import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("messagetype",{schema:"dbo"})
@Index("Pk_messagetype",["messageTypeId"],{unique:true})
export class Messagetype {

    @Column("int",{
        nullable:false,
        primary:true,
        unique: true,
        name:"MessageTypeID",
        })
    messageTypeId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"MessageTypeName",
        })
    messageTypeName: string | null;

    @Column("varchar",{
        nullable:true,
        length:200,
        name:"MessageTypeDescription",
        })
    messageTypeDescription: string | null;

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
