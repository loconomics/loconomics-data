import {Column,Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId} from "typeorm";

@Entity("addresstype",{schema:"dbo"})
export class Addresstype {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"AddressTypeID",
        })
    addressTypeId: number;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("varchar",{
        nullable:true,
        length:50,
        name:"AddressType",
        })
    addressType: string | null;

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

    @Column("bit",{
        nullable:false,
        name:"UniquePerUser",
        })
    uniquePerUser: boolean;

    @Column("bit",{
        nullable:false,
        default:"((1))",
        name:"Selectable",
        })
    selectable: boolean;

}
