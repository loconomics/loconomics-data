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

@Entity("serviceattribute",{schema:"dbo"})
export class ServiceAttribute {

    @Column("int",{
        nullable:false,
        primary:true,
        name:"ServiceAttributeID",
        })
    serviceAttributeId: number;

    @Column("int",{
        nullable:true,
        default:"(NULL)",
        name:"SourceID",
        })
    sourceId: number | null;

    @Column("varchar",{
        nullable:true,
        length:100,
        name:"Name",
        })
    name: string | null;

    @Column("varchar",{
        nullable:true,
        length:2000,
        name:"ServiceAttributeDescription",
        })
    serviceAttributeDescription: string | null;

    @Column("nvarchar",{
        nullable:false,
        length:42,
        name:"language",
        })
    language: string;

    @Column("datetime",{
        nullable:true,
        name:"CreateDate",
        })
    createDate: Date | null;

    @Column("datetime",{
        nullable:true,
        name:"UpdatedDate",
        })
    updatedDate: Date | null;

    @Column("varchar",{
        nullable:true,
        length:45,
        name:"ModifiedBy",
        })
    modifiedBy: string | null;

    @Column("bit",{
        nullable:true,
        name:"Active",
        })
    active: boolean | null;

    @Column("int",{
        nullable:false,
        default:"((1))",
        name:"DisplayRank",
        })
    displayRank: number;

    @Column("int",{
        nullable:true,
        name:"PositionReference",
        })
    positionReference: number | null;

    @Column("int",{
        nullable:true,
        name:"EnteredByUserID",
        })
    enteredByUserId: number | null;

    @Column("bit",{
        nullable:true,
        name:"Approved",
        })
    approved: boolean | null;

}
