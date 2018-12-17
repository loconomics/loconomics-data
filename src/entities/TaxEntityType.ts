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

@Entity("taxentitytype",{schema:"dbo"})
export class TaxEntityType {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"TaxEntityTypeID",
        })
    taxEntityTypeId: number;

    @Column("varchar",{
        nullable:true,
        length:75,
        name:"TaxEntityTypeName",
        })
    taxEntityTypeName: string | null;

    @Column("varchar",{
        nullable:true,
        length:300,
        name:"TaxEntityTypeDescription",
        })
    taxEntityTypeDescription: string | null;

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
